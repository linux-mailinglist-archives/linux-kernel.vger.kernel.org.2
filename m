Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 263BF40BEB8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 06:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbhIOEJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 00:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbhIOEJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 00:09:39 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1C6C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 21:08:21 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id k23-20020a17090a591700b001976d2db364so1272921pji.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 21:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CQDNNNFEo1X3i4ZbWhtXjvPLmTOQuS2HCDWIbVD2T9k=;
        b=ZhFEJREKfFheqoxU3Yuv65eBxZoE6XDInKedcwQtq/qCcAAOvHlm6ZKydu7I94PYL2
         UVXNGpOFirKknWbmqfzzfdSWdVtT3NMXIulWDhTI9gFXDzKh7SMtfsTMGPkSkuFEYgeb
         055LPaGzuBBw9GKNuUNmOLVtbOZZzQU4rr3UGDcpGjF9sYKZbrAYSo0+fWfbBg5DcWev
         5ALFWGzqTsz6daJ7gWjTFDX1B+y/DsNE/9YUaCCYVCVLJv758hcffSe13MtCM3yEb+6z
         v35aDUDQ1+WjjoSlJgkfiHF1btNWkUK7QeuUCRdP69thJe6VF813nOn8eNbzE392lQpf
         2oLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CQDNNNFEo1X3i4ZbWhtXjvPLmTOQuS2HCDWIbVD2T9k=;
        b=ght+7BMA0WQvQ5oc8cEseqFA3OgfJXViaAUPRTHj+TiBYKT92uyRiinqTvcPH8pO7G
         I1SKuLioHti+gRXDWKYA+Q8b3MLB48E3wNxoD1ooajCcHUCax/WrBof04+eB6NiVlHnj
         /giUYB39lMGgnbHF0lqqXo69upiQpzxMeC2yDJyh067YARzZojsFfdSBONKp6iZIvnGB
         3ImutP0G0do0bcRHO+R+UGNwB2if7Jbhwu8CNZHZ9DcbILjIsiJoZJLCJszwaNxWjTwo
         GQ9Rg+lbMaQgLWof2ku5VcahxboBKPQRQ8srcJc6wnk+fhr5tcHSAdVFkQt5Z3Z1QYUQ
         q97g==
X-Gm-Message-State: AOAM5319TALvnmmwoY5QGxS+E4Mbo2rhY++/cO8AGLvb0wwf9MRuKLzc
        sFgWEiAH6zayCkVD6wxneiTrmwrP2MqVdZEREyV0YQ==
X-Google-Smtp-Source: ABdhPJz6jSy3QNZ774ZvbFCFT/locOJKKFJeswe7GHvEF4/9SaC8NfwBZ1lNaqgJ2388QzKNtHhAWeVE3LX4MRmizIA=
X-Received: by 2002:a17:90b:3b84:: with SMTP id pc4mr6086447pjb.220.1631678900879;
 Tue, 14 Sep 2021 21:08:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210903050914.273525-1-kjain@linux.ibm.com> <20210903050914.273525-2-kjain@linux.ibm.com>
 <CAPcyv4jSL2cDxGiXEtyyce3eNEE_QUnnMjuLXb3iCwO8_7a7LQ@mail.gmail.com> <d7f8bf51-059f-4496-37c4-6516a703e209@linux.ibm.com>
In-Reply-To: <d7f8bf51-059f-4496-37c4-6516a703e209@linux.ibm.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 14 Sep 2021 21:08:10 -0700
Message-ID: <CAPcyv4hE4rh5R+8zy3X4gDJeuPzQ0oQHmHbe_pppgWB2_RjfAg@mail.gmail.com>
Subject: Re: [RESEND PATCH v4 1/4] drivers/nvdimm: Add nvdimm pmu structure
To:     kajoljain <kjain@linux.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        maddy@linux.ibm.com, Santosh Sivaraj <santosh@fossix.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        atrajeev@linux.vnet.ibm.com, Thomas Gleixner <tglx@linutronix.de>,
        rnsastry@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 9, 2021 at 12:56 AM kajoljain <kjain@linux.ibm.com> wrote:
>
>
>
> On 9/8/21 3:29 AM, Dan Williams wrote:
> > Hi Kajol,
> >
> > Apologies for the delay in responding to this series, some comments below:
>
> Hi Dan,
>     No issues, thanks for reviewing the patches.
>
> >
> > On Thu, Sep 2, 2021 at 10:10 PM Kajol Jain <kjain@linux.ibm.com> wrote:
> >>
> >> A structure is added, called nvdimm_pmu, for performance
> >> stats reporting support of nvdimm devices. It can be used to add
> >> nvdimm pmu data such as supported events and pmu event functions
> >> like event_init/add/read/del with cpu hotplug support.
> >>
> >> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> >> Reviewed-by: Madhavan Srinivasan <maddy@linux.ibm.com>
> >> Tested-by: Nageswara R Sastry <rnsastry@linux.ibm.com>
> >> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> >> ---
> >>  include/linux/nd.h | 43 +++++++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 43 insertions(+)
> >>
> >> diff --git a/include/linux/nd.h b/include/linux/nd.h
> >> index ee9ad76afbba..712499cf7335 100644
> >> --- a/include/linux/nd.h
> >> +++ b/include/linux/nd.h
> >> @@ -8,6 +8,8 @@
> >>  #include <linux/ndctl.h>
> >>  #include <linux/device.h>
> >>  #include <linux/badblocks.h>
> >> +#include <linux/platform_device.h>
> >> +#include <linux/perf_event.h>
> >>
> >>  enum nvdimm_event {
> >>         NVDIMM_REVALIDATE_POISON,
> >> @@ -23,6 +25,47 @@ enum nvdimm_claim_class {
> >>         NVDIMM_CCLASS_UNKNOWN,
> >>  };
> >>
> >> +/* Event attribute array index */
> >> +#define NVDIMM_PMU_FORMAT_ATTR         0
> >> +#define NVDIMM_PMU_EVENT_ATTR          1
> >> +#define NVDIMM_PMU_CPUMASK_ATTR                2
> >> +#define NVDIMM_PMU_NULL_ATTR           3
> >> +
> >> +/**
> >> + * struct nvdimm_pmu - data structure for nvdimm perf driver
> >> + *
> >> + * @name: name of the nvdimm pmu device.
> >> + * @pmu: pmu data structure for nvdimm performance stats.
> >> + * @dev: nvdimm device pointer.
> >> + * @functions(event_init/add/del/read): platform specific pmu functions.
> >
> > This is not valid kernel-doc:
> >
> > include/linux/nd.h:67: warning: Function parameter or member
> > 'event_init' not described in 'nvdimm_pmu'
> > include/linux/nd.h:67: warning: Function parameter or member 'add' not
> > described in 'nvdimm_pmu'
> > include/linux/nd.h:67: warning: Function parameter or member 'del' not
> > described in 'nvdimm_pmu'
> > include/linux/nd.h:67: warning: Function parameter or member 'read'
> > not described in 'nvdimm_pmu'
> >
> > ...but I think rather than fixing those up 'struct nvdimm_pmu' should be pruned.
> >
> > It's not clear to me that it is worth the effort to describe these
> > details to the nvdimm core which is just going to turn around and call
> > the pmu core. I'd just as soon have the driver call the pmu core
> > directly, optionally passing in attributes and callbacks that come
> > from the nvdimm core and/or the nvdimm provider.
>
> The intend for adding these callbacks(event_init/add/del/read) is to give
> flexibility to the nvdimm core to add some common checks/routines if required
> in the future. Those checks can be common for all architecture with still having the
> ability to call arch/platform specific driver code to use its own routines.
>
> But as you said, currently we don't have any common checks and it directly
> calling platform specific code, so we can get rid of it.
> Should we remove this part for now?

Yes, lets go direct to the perf api for now and await the need for a
common core wrapper to present itself.

>
>
> >
> > Otherwise it's also not clear which of these structure members are
> > used at runtime vs purely used as temporary storage to pass parameters
> > to the pmu core.
> >
> >> + * @attr_groups: data structure for events, formats and cpumask
> >> + * @cpu: designated cpu for counter access.
> >> + * @node: node for cpu hotplug notifier link.
> >> + * @cpuhp_state: state for cpu hotplug notification.
> >> + * @arch_cpumask: cpumask to get designated cpu for counter access.
> >> + */
> >> +struct nvdimm_pmu {
> >> +       const char *name;
> >> +       struct pmu pmu;
> >> +       struct device *dev;
> >> +       int (*event_init)(struct perf_event *event);
> >> +       int  (*add)(struct perf_event *event, int flags);
> >> +       void (*del)(struct perf_event *event, int flags);
> >> +       void (*read)(struct perf_event *event);
> >> +       /*
> >> +        * Attribute groups for the nvdimm pmu. Index 0 used for
> >> +        * format attribute, index 1 used for event attribute,
> >> +        * index 2 used for cpusmask attribute and index 3 kept as NULL.
> >> +        */
> >> +       const struct attribute_group *attr_groups[4];
> >
> > Following from above, I'd rather this was organized as static
> > attributes with an is_visible() helper for the groups for any dynamic
> > aspects. That mirrors the behavior of nvdimm_create() and allows for
> > device drivers to compose the attribute groups from a core set and /
> > or a provider specific set.
>
> Since we don't have any common events right now, Can I use papr
> attributes directly or should we create dummy events for common thing and
> then merged it with papr event list.

Just use papr events directly.
