Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32ABA4276D6
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 05:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244189AbhJIDOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 23:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbhJIDOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 23:14:44 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3ADC061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 20:12:47 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id a25so27344128edx.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 20:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uZJSKNQy7a8ovN2pCX/SIRQeSc/Um892V8g+28sH3XA=;
        b=lT0XHcI0TpH/LmGXnyBS7lKQ0yndi6kYlSOIR9ohcRIAzMmzV4O7HFw6PRcyAFMJXV
         35ArbQiNBCejnBog+t7kKjHoNrpR9NijO6og5azj8BPmFZm0NWz3j7C/nXtz3AouncSK
         G4fzggKwjqvLs1yoJXXIp4fkMaQOrdwALv6soCcVS1OyJjfH+AF2BFHM26n+9+5sUp4N
         LynSO2PuCTmHyMYlgsTcUcLZCjuTnPVTq+hTyWMMKV2D5FXufSXJxbnjIkAMD3d3Sx4l
         vexDI+c2w4AUuh56kwhKnK7GJsZ29iFUsxr/7pXEExZYf+H/2IbwzQ0UGhTqkxdGi46T
         Xkgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uZJSKNQy7a8ovN2pCX/SIRQeSc/Um892V8g+28sH3XA=;
        b=gevJO8b2Ey3f441uu9H6oGIlfsBX/uFz/+YN9j9JaqPUeU8c9DjwiEmVMj9WwiVQY+
         fwEA5yY/c2vt8NBBN/TFNpi8oK5zBeSUiRJwAx45GICOKhb4jydIFo5Y9iQ7QMPN4SIw
         FAtY6PoD1xIoyn7N57bHR0YqSMboqJcG+RXIZIo6f+TZmvTq/5JCwajxtT90vR9sD7X7
         BRfGTf6CDLTCdYUOrp3DQN+2JjGu1VDwj9X0/tqhyxtCdOQ0qR7tB4FD6t2ZyHJCdnZ+
         Ik00ZW8ex5hVGXZ4ALeWmM6nf0pmlYdhFTuLRqgsnVAPo/r1YHa/CvJJ5HCIqpL3/4/W
         sbsg==
X-Gm-Message-State: AOAM531g5xDKu+HA/4i4RlRN+L86L4Us5zzkxpm/rGFbz8Amu8WlY9kL
        EK8jOGAp+3vhh5qOuIo4xecPxpS8K0oIkYqmrqnC
X-Google-Smtp-Source: ABdhPJz7DRpOEmsUmPDseEn4n8CRah9ndGFAOopm2Qhj5gemkWNxyqyOpPzdRyPlctzBfS8c+Yv4FYyftovwZ39x7uc=
X-Received: by 2002:a17:906:5590:: with SMTP id y16mr8914091ejp.286.1633749165008;
 Fri, 08 Oct 2021 20:12:45 -0700 (PDT)
MIME-Version: 1.0
References: <1632477717-5254-1-git-send-email-john.garry@huawei.com>
 <1632477717-5254-2-git-send-email-john.garry@huawei.com> <20211004113121.GA27373@willie-the-truck>
 <b8b51f52-1a8d-46fe-69ca-0acaf8d399f2@huawei.com>
In-Reply-To: <b8b51f52-1a8d-46fe-69ca-0acaf8d399f2@huawei.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Sat, 9 Oct 2021 11:12:34 +0800
Message-ID: <CACycT3sMT7SxxS9qtZdwSENDk3fNgPHvy5X9iibaRs4na5fNzw@mail.gmail.com>
Subject: Re: [PATCH 1/5] iova: Move fast alloc size roundup into alloc_iova_fast()
To:     John Garry <john.garry@huawei.com>
Cc:     Will Deacon <will@kernel.org>, joro@8bytes.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org,
        virtualization <virtualization@lists.linux-foundation.org>,
        linuxarm@huawei.com, thunder.leizhen@huawei.com,
        baolu.lu@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 9, 2021 at 12:17 AM John Garry <john.garry@huawei.com> wrote:
>
> On 04/10/2021 12:31, Will Deacon wrote:
> > On Fri, Sep 24, 2021 at 06:01:53PM +0800, John Garry wrote:
> >> It really is a property of the IOVA rcache code that we need to alloc a
> >> power-of-2 size, so relocate the functionality to resize into
> >> alloc_iova_fast(), rather than the callsites.
> >>
> >> Signed-off-by: John Garry<john.garry@huawei.com>
> >> ---
> >>   drivers/iommu/dma-iommu.c            | 8 --------
> >>   drivers/iommu/iova.c                 | 9 +++++++++
> >>   drivers/vdpa/vdpa_user/iova_domain.c | 8 --------
> >>   3 files changed, 9 insertions(+), 16 deletions(-)
> > Acked-by: Will Deacon<will@kernel.org>
>
> Cheers
>
>  >
>
> Any chance of an ack from the vdpa guys on the change to their code?
>

Looks good to me.

Reviewed-by: Xie Yongji <xieyongji@bytedance.com>

Thanks,
Yongji
