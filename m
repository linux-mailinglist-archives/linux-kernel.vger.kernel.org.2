Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8B24428862
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 10:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234825AbhJKINY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 04:13:24 -0400
Received: from foss.arm.com ([217.140.110.172]:35246 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231300AbhJKINX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 04:13:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 60E7813A1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 01:11:23 -0700 (PDT)
Received: from mail-pl1-f177.google.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 496CF3FA35
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 01:11:23 -0700 (PDT)
Received: by mail-pl1-f177.google.com with SMTP id f21so2010048plb.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 01:11:23 -0700 (PDT)
X-Gm-Message-State: AOAM533ziykEARnb1Pqr4KjgiUjjEBDSTwWEc5xmP6b+VMtsKJUGqnYp
        +/+spGn5mdpoV9qE5AeSVu3MYVu++nq81rCxUCI=
X-Google-Smtp-Source: ABdhPJxpgWkq2JXuhyC5cSUsG8YBYjnxKFd9JFYfb0AdYL4fS13p9K2CJ10dWF5pg4KXSn5b2Uhp22eVuQguQX4tG9g=
X-Received: by 2002:a17:90a:46c2:: with SMTP id x2mr29707698pjg.207.1633939878591;
 Mon, 11 Oct 2021 01:11:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210423095147.27922-1-vivek.gautam@arm.com> <20210423095147.27922-4-vivek.gautam@arm.com>
 <YUoCTV6WYxxE10qj@myrica>
In-Reply-To: <YUoCTV6WYxxE10qj@myrica>
From:   Vivek Gautam <vivek.gautam@arm.com>
Date:   Mon, 11 Oct 2021 13:41:15 +0530
X-Gmail-Original-Message-ID: <CAFp+6iEM7K8YOnQ4vSNoM+HuHQ-7pr=G3aui-77dGipyJ0+RjQ@mail.gmail.com>
Message-ID: <CAFp+6iEM7K8YOnQ4vSNoM+HuHQ-7pr=G3aui-77dGipyJ0+RjQ@mail.gmail.com>
Subject: Re: [PATCH RFC v1 03/11] iommu/virtio: Handle incoming page faults
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>, mst@redhat.com,
        Will Deacon <will.deacon@arm.com>,
        open list <linux-kernel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean,


On Tue, Sep 21, 2021 at 9:33 PM Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> On Fri, Apr 23, 2021 at 03:21:39PM +0530, Vivek Gautam wrote:
> > Redirect the incoming page faults to the registered fault handler
> > that can take the fault information such as, pasid, page request
> > group-id, address and pasid flags.
> >
> > Signed-off-by: Vivek Gautam <vivek.gautam@arm.com>
> > ---
> >  drivers/iommu/virtio-iommu.c      | 80 ++++++++++++++++++++++++++++++-
> >  include/uapi/linux/virtio_iommu.h |  1 +
> >  2 files changed, 80 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> > index c970f386f031..fd237cad1ce5 100644
> > --- a/drivers/iommu/virtio-iommu.c
> > +++ b/drivers/iommu/virtio-iommu.c
> > @@ -37,6 +37,13 @@
> >  /* Some architectures need an Address Space ID for each page table */
> >  DEFINE_XARRAY_ALLOC1(viommu_asid_xa);
> >
> > +struct viommu_dev_pri_work {
> > +     struct work_struct              work;
> > +     struct viommu_dev               *dev;
> > +     struct virtio_iommu_fault       *vfault;
> > +     u32                             endpoint;
> > +};
> > +
> >  struct viommu_dev {
> >       struct iommu_device             iommu;
> >       struct device                   *dev;
> > @@ -49,6 +56,8 @@ struct viommu_dev {
> >       struct list_head                requests;
> >       void                            *evts;
> >       struct list_head                endpoints;
> > +     struct workqueue_struct         *pri_wq;
> > +     struct viommu_dev_pri_work      *pri_work;
>
> IOPF already has a workqueue, so the driver doesn't need one.
> iommu_report_device_fault() should be fast enough to be called from the
> event handler.

Sure, will call iommu_report_device_fault() directly from
viommu_fault_handler().

>
> >
> >       /* Device configuration */
> >       struct iommu_domain_geometry    geometry;
> > @@ -666,6 +675,58 @@ static int viommu_probe_endpoint(struct viommu_dev *viommu, struct device *dev)
> >       return ret;
> >  }
> >
> > +static void viommu_handle_ppr(struct work_struct *work)
> > +{
> > +     struct viommu_dev_pri_work *pwork =
> > +                             container_of(work, struct viommu_dev_pri_work, work);
> > +     struct viommu_dev *viommu = pwork->dev;
> > +     struct virtio_iommu_fault *vfault = pwork->vfault;
> > +     struct viommu_endpoint *vdev;
> > +     struct viommu_ep_entry *ep;
> > +     struct iommu_fault_event fault_evt = {
> > +             .fault.type = IOMMU_FAULT_PAGE_REQ,
> > +     };
> > +     struct iommu_fault_page_request *prq = &fault_evt.fault.prm;
> > +
> > +     u32 flags       = le32_to_cpu(vfault->flags);
> > +     u32 prq_flags   = le32_to_cpu(vfault->pr_evt_flags);
> > +     u32 endpoint    = pwork->endpoint;
> > +
> > +     memset(prq, 0, sizeof(struct iommu_fault_page_request));
>
> The fault_evt struct is already initialized

Right, I will remove this line.

>
> > +     prq->addr = le64_to_cpu(vfault->address);
> > +
> > +     if (prq_flags & VIRTIO_IOMMU_FAULT_PRQ_F_LAST_PAGE)
> > +             prq->flags |= IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE;
> > +     if (prq_flags & VIRTIO_IOMMU_FAULT_PRQ_F_PASID_VALID) {
> > +             prq->flags |= IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
> > +             prq->pasid = le32_to_cpu(vfault->pasid);
> > +             prq->grpid = le32_to_cpu(vfault->grpid);
> > +     }
> > +
> > +     if (flags & VIRTIO_IOMMU_FAULT_F_READ)
> > +             prq->perm |= IOMMU_FAULT_PERM_READ;
> > +     if (flags & VIRTIO_IOMMU_FAULT_F_WRITE)
> > +             prq->perm |= IOMMU_FAULT_PERM_WRITE;
> > +     if (flags & VIRTIO_IOMMU_FAULT_F_EXEC)
> > +             prq->perm |= IOMMU_FAULT_PERM_EXEC;
> > +     if (flags & VIRTIO_IOMMU_FAULT_F_PRIV)
> > +             prq->perm |= IOMMU_FAULT_PERM_PRIV;
> > +
> > +     list_for_each_entry(ep, &viommu->endpoints, list) {
> > +             if (ep->eid == endpoint) {
> > +                     vdev = ep->vdev;

I have a question here though -
Is endpoint-ID unique across all the endpoints available per 'viommu_dev' or
per 'viommu_domain'?
If it is per 'viommu_domain' then the above list is also incorrect.
As you pointed to in the patch [1] -
[PATCH RFC v1 02/11] iommu/virtio: Maintain a list of endpoints served
by viommu_dev
I am planning to add endpoint ID into a static global xarray in
viommu_probe_device() as below:

        vdev_for_each_id(i, eid, vdev) {
                ret = xa_insert(&viommu_ep_ids, eid, vdev, GFP_KERNEL);
                if (ret)
                        goto err_free_dev;
        }

and replace the above list traversal as below:

                xa_lock_irqsave(&viommu_ep_ids, flags);
                xa_for_each(&viommu_ep_ids, eid, vdev) {
                        if (eid == endpoint) {
                                ret =
iommu_report_device_fault(vdev->dev, &fault_evt);
                                if (ret)
                                        dev_err(vdev->dev, "Couldn't
handle page request\n");
                        }
                }
                xa_unlock_irqrestore(&viommu_ep_ids, flags);

But using a global xarray would also be incorrect if the endpointsID are global
across 'viommu_domain'.

I need to find the correct 'viommu_endpoint' to call iommu_report_device_fault()
with the correct device.

> > +                     break;
> > +             }
> > +     }
> > +
> > +     if ((prq_flags & VIRTIO_IOMMU_FAULT_PRQ_F_PASID_VALID) &&
> > +         (prq_flags & VIRTIO_IOMMU_FAULT_PRQ_F_NEEDS_PASID))
> > +             prq->flags |= IOMMU_FAULT_PAGE_RESPONSE_NEEDS_PASID;
> > +
> > +     if (iommu_report_device_fault(vdev->dev, &fault_evt))
> > +             dev_err(vdev->dev, "Couldn't handle page request\n");
>
> An error likely means that nobody registered a fault handler, but we could
> display a few more details about the fault that would help debug the
> endpoint

Sure, will add more debug info to this log.

>
> > +}
> > +
> >  static int viommu_fault_handler(struct viommu_dev *viommu,
> >                               struct virtio_iommu_fault *fault)
> >  {
> > @@ -679,7 +740,13 @@ static int viommu_fault_handler(struct viommu_dev *viommu,
> >       u32 pasid       = le32_to_cpu(fault->pasid);
> >
> >       if (type == VIRTIO_IOMMU_FAULT_F_PAGE_REQ) {
> > -             dev_info(viommu->dev, "Page request fault - unhandled\n");
> > +             dev_info_ratelimited(viommu->dev,
> > +                                  "Page request fault from EP %u\n",
> > +                                  endpoint);
>
> That's rather for debugging the virtio-iommu driver, so should be
> dev_dbg() (or removed entirely)

I will remove this log.

>
> > +
> > +             viommu->pri_work->vfault = fault;
> > +             viommu->pri_work->endpoint = endpoint;
> > +             queue_work(viommu->pri_wq, &viommu->pri_work->work);
> >               return 0;
> >       }
> >
> > @@ -1683,6 +1750,17 @@ static int viommu_probe(struct virtio_device *vdev)
> >               goto err_free_vqs;
> >       }
> >
> > +     viommu->pri_work = kzalloc(sizeof(*viommu->pri_work), GFP_KERNEL);
> > +     if (!viommu->pri_work)
> > +             return -ENOMEM;
> > +
> > +     viommu->pri_work->dev = viommu;
> > +
> > +     INIT_WORK(&viommu->pri_work->work, viommu_handle_ppr);
> > +     viommu->pri_wq = create_singlethread_workqueue("viommu-pri-wq");
> > +     if (!viommu->pri_wq)
> > +             return -ENOMEM;
> > +
> >       viommu->map_flags = VIRTIO_IOMMU_MAP_F_READ | VIRTIO_IOMMU_MAP_F_WRITE;
> >       viommu->last_domain = ~0U;
> >
> > diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_iommu.h
> > index accc3318ce46..53aa88e6b077 100644
> > --- a/include/uapi/linux/virtio_iommu.h
> > +++ b/include/uapi/linux/virtio_iommu.h
> > @@ -302,6 +302,7 @@ struct virtio_iommu_req_invalidate {
> >  #define VIRTIO_IOMMU_FAULT_F_READ            (1 << 0)
> >  #define VIRTIO_IOMMU_FAULT_F_WRITE           (1 << 1)
> >  #define VIRTIO_IOMMU_FAULT_F_EXEC            (1 << 2)
> > +#define VIRTIO_IOMMU_FAULT_F_PRIV            (1 << 3)
>
> Should go in the previous patch. (I'd also prefer 'privileged' because in
> this context 'priv' is easily read as 'private')

Sure, will move this to the previous patch.

Thanks & regards
Vivek

[1] https://lore.kernel.org/all/YUoBW13+CvIljUgc@myrica/#t

[snip]
