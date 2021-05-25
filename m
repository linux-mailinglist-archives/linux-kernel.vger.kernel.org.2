Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 391D238F9CE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 07:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbhEYFKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 01:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbhEYFKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 01:10:11 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CBBC061756
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 22:08:41 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id k14so41785844eji.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 22:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PsgdBBVw2A+NbDcJdCN642vC7Yq/ZcBHRQhxnHO/dtM=;
        b=uwVlvNr+1QmUX1D9u3UJxq6sQbrzK10U5N1K62NWGPpmtL6jKXtEN54niNiEspZJBv
         cRLCQRGsNI94JsItN3tKJ5W+cDcgQNAEy2FZ/NRgima/wDEGHEgHPEkWvabmDEd3ZrQK
         YY7NJo2L5REGVFcW+zXSu3fWbr9rHBKvvGOvtbQ3eWHfQSGqslMHCifK8/dWY5SpNuPM
         M0Lqxgh7L/xBVvvuTyC9+IbKcRChMxLDsn2SN7dKiyj40qEZ4G7VfCpdb2hw+PdAwn91
         Mke+dLWA/dvFgWNMHpYn0dbMxHpe0gCQzQx/u2gZSCDm9cBXRk1Hhvb2ud8UNjuYdOAh
         9K9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PsgdBBVw2A+NbDcJdCN642vC7Yq/ZcBHRQhxnHO/dtM=;
        b=mG3TIwfmgaMJ5ycA2hVNlVrawXZaXQwlJtAU0u3uuL3KzRsmEL+FdAzPmoMz9CH7W+
         rFZRhMr55SdpclCUALspe95PEPsDOO0Jn4kYCjJ9OuuMxOgFJNDkOeRhQEtYCHdKyWUf
         mXV5ZIY4cXFTwv1PFg+e/wQO6cCLM+jJtZ12YXwIfnS2/trDgREoPw4XFYJltvOehCwX
         kXJ/Ec4xErGKC9FHMVaqdV4yDla2v7kaliWlNJqfhNokWvYXCgUIp3fN7HVV76yoOa3c
         nTZqnsOswXtFc5vwPsEPsozRBFxHyg+2BEKmVe/fFP3cHbK+BGs3CAEGEGg4K2biWRDj
         85eA==
X-Gm-Message-State: AOAM533UiqY3YE/wmmaT0WSxwjTDtyTvyYe/nOoqEtH8/7RK00wM9rfJ
        8nhh4I2NteNnfrCVMrtvd3f0Pcw09V3+wBd1FWET
X-Google-Smtp-Source: ABdhPJxs5I3rJV2qxB2VX2e2J7Skie8nzyHZIGcIp5PfqE3CVEi7Py1Q1rj5/UivHgHWePx1+81zM9QGpYRaGw+PWdc=
X-Received: by 2002:a17:906:edaf:: with SMTP id sa15mr26746054ejb.174.1621919319919;
 Mon, 24 May 2021 22:08:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210517090836.533-1-xieyongji@bytedance.com> <20210517090836.533-18-xieyongji@bytedance.com>
 <20210517193641-mutt-send-email-mst@kernel.org> <3cda643a-1363-65bf-be84-f6dea6714477@redhat.com>
In-Reply-To: <3cda643a-1363-65bf-be84-f6dea6714477@redhat.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Tue, 25 May 2021 13:08:29 +0800
Message-ID: <CACycT3vzpYRpFsBxCo+huG+wGE5TtD_N3A7wZf-yc_+cCfjzyw@mail.gmail.com>
Subject: Re: Re: [RFC PATCH 17/17] virtio_ring: Add validation for used length
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>, amit@kernel.org,
        arei.gonglei@huawei.com, airlied@linux.ie, kraxel@redhat.com,
        dan.j.williams@intel.com,
        Johannes Berg <johannes@sipsolutions.net>,
        Ohad Ben Cohen <ohad@wizery.com>, bjorn.andersson@linaro.org,
        David Hildenbrand <david@redhat.com>, vgoyal@redhat.com,
        miklos@szeredi.hu, Stefano Garzarella <sgarzare@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 9:31 AM Jason Wang <jasowang@redhat.com> wrote:
>
>
> =E5=9C=A8 2021/5/18 =E4=B8=8A=E5=8D=887:39, Michael S. Tsirkin =E5=86=99=
=E9=81=93:
> > On Mon, May 17, 2021 at 05:08:36PM +0800, Xie Yongji wrote:
> >> This adds validation for used length (might come
> >> from an untrusted device) when it will be used by
> >> virtio device driver.
> >>
> >> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> >> ---
> >>   drivers/virtio/virtio_ring.c | 22 +++++++++++++++++++---
> >>   1 file changed, 19 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring=
.c
> >> index d999a1d6d271..7d4845d06f21 100644
> >> --- a/drivers/virtio/virtio_ring.c
> >> +++ b/drivers/virtio/virtio_ring.c
> >> @@ -68,11 +68,13 @@
> >>   struct vring_desc_state_split {
> >>      void *data;                     /* Data for callback. */
> >>      struct vring_desc *indir_desc;  /* Indirect descriptor, if any. *=
/
> >> +    u32 in_len;                     /* Total length of writable buffe=
r */
> >>   };
> >>
> >>   struct vring_desc_state_packed {
> >>      void *data;                     /* Data for callback. */
> >>      struct vring_packed_desc *indir_desc; /* Indirect descriptor, if =
any. */
> >> +    u32 in_len;                     /* Total length of writable buffe=
r */
> >>      u16 num;                        /* Descriptor list length. */
> >>      u16 last;                       /* The last desc state in a list.=
 */
> >>   };
> >
> > Hmm for packed it's aligned to 64 bit anyway, so we are not making it
> > any worse. But for split this pushes struct size up by 1/3 increasing
> > cache pressure.
>
>
> We can eliminate this by validating through virtio device driver instead
> of virtio core.
>
> E.g for virtio-net we know the rx buffer size so there's no need to
> store in twice in the core.
>

I see. I have sent the new fix just now.

Thanks,
Yongji
