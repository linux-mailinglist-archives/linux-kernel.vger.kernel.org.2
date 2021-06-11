Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80AAA3A404C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 12:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbhFKKjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 06:39:35 -0400
Received: from m12-15.163.com ([220.181.12.15]:35466 "EHLO m12-15.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230179AbhFKKje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 06:39:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=+94bq
        vDRtgaYfMyS91tqMXIwyIsPwzEVqO05JA2x8ZU=; b=XUVwYHbEeZBEQzOK2f5h3
        rK489g7nRTbZk1fcw1u3//P3DiocYzMWHNupBJ8fVCBNFQXMSx5MMCh1n5lj51Xw
        8uCd0HnSehyExLDpD5ZNsZMDxdd8rEtJtMyIhXgh8QBIcLaP+clEviEMEB4MZT2n
        aie4QNy5dCT6K45vmFjvLY=
Received: from localhost (unknown [218.17.89.111])
        by smtp11 (Coremail) with SMTP id D8CowAC3zNG+PMNgp5KoAA--.1637S2;
        Fri, 11 Jun 2021 18:36:55 +0800 (CST)
Date:   Fri, 11 Jun 2021 18:36:46 +0800
From:   Chunyou Tang <tangchunyou@163.com>
To:     Steven Price <steven.price@arm.com>
Cc:     tangchunyou <tangchunyou@163.icubecorp.cn>,
        tomeu.vizoso@collabora.com, airlied@linux.ie,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        alyssa.rosenzweig@collabora.com, tangchunyou@icubecorp.cn
Subject: Re: [PATCH] modified: gpu/drm/panfrost/panfrost_gpu.c
Message-ID: <20210611183646.0000770f@163.com>
In-Reply-To: <d1304645-f2bf-8cea-2b60-24e0a3936ed7@arm.com>
References: <20210609063850.2060-1-tangchunyou@163.com>
        <78a2488a-71d5-548a-e221-7786f788509c@arm.com>
        <20210610210659.00003155@163.com>
        <d1304645-f2bf-8cea-2b60-24e0a3936ed7@arm.com>
Organization: icube
X-Mailer: Claws Mail 3.10.1 (GTK+ 2.16.6; i586-pc-mingw32msvc)
MIME-Version: 1.0
Content-Type: text/plain; charset=GB18030
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: D8CowAC3zNG+PMNgp5KoAA--.1637S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAry7tw4fGF13AF4rJry5urg_yoW5uw47pr
        yDAF1YyF1kXr1jqa1q9w1xKFyYvayrJFy8WF1DCrW5tFsIgFn8tFsFya409Fy8ur48X3Wj
        vw4Iyry7Wa15Z3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j4XdUUUUUU=
X-Originating-IP: [218.17.89.111]
X-CM-SenderInfo: 5wdqwu5kxq50rx6rljoofrz/1tbipQ6uUVUMer-nlQABs7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

于 Fri, 11 Jun 2021 11:10:16 +0100
Steven Price <steven.price@arm.com> 写道:

> On 10/06/2021 14:06, Chunyou Tang wrote:
> > Hi Steven,
> 
> Hi Chunyou,
> 
> For some reason I'm not directly receiving your emails (only via the
> list) - can you double check your email configuration?
> 
> >>> The GPU exception fault status register(0x3C),the low 8 bit is the
> >>> EXCEPTION_TYPE.We can see the description at P3-78 in spec.
> > 
> > 	You can see the spec
> > 	<arm_heimdall_technical_reference_manual_100612_0001_00_en.pdf>.
> 
> Thanks - please include that in the commit message - there are many
> TRMs (one for each GPU) so without the information about exactly which
> specification the page number is pretty useless. Sadly this
> documentation isn't public which would be even better but I don't
> think there are any public specs for this information.
> 
> >> However this change is correct - panfrost_exception_name() should
> >> be taking only the lower 8 bits. Even better though would be to to
> >> report the full raw fault information as well as the high bits can
> >> contain useful information:
> >>
> >> 	dev_warn(pfdev->dev, "GPU Fault 0x%08x (%s) at
> >> 0x%016llx\n", fault_status,
> >> 		 panfrost_exception_name(pfdev, fault_status &
> >> 0xFF), address);
> > 
> > So I change it according to what you said?
> 
> Yes, please send a v2.
> 
> Thanks,
> 
> Steve
> 
> > 于 Thu, 10 Jun 2021 11:41:52 +0100
> > Steven Price <steven.price@arm.com> 写道:
> > 
> >> The subject should have the prefix "drm/panfrost" and should
> >> mention what the patch is changing (not just the filename).
> >>
> >> On 09/06/2021 07:38, ChunyouTang wrote:
ok
> >>> From: tangchunyou <tangchunyou@163.icubecorp.cn>
> >>>
> >>> The GPU exception fault status register(0x3C),the low 8 bit is the
> >>> EXCEPTION_TYPE.We can see the description at P3-78 in spec.
> >>
> >> Nit: When referring to a spec it's always good to mention the name
> >> - I'm not sure which specification you found this in.
> >>
> >>>
> >>> Signed-off-by: tangchunyou <tangchunyou@163.icubecorp.cn>
> >>> ---
> >>>  drivers/gpu/drm/panfrost/panfrost_gpu.c | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.c
> >>> b/drivers/gpu/drm/panfrost/panfrost_gpu.c index
> >>> 2aae636f1cf5..1fffb6a0b24f 100644 ---
> >>> a/drivers/gpu/drm/panfrost/panfrost_gpu.c +++
> >>> b/drivers/gpu/drm/panfrost/panfrost_gpu.c @@ -33,7 +33,7 @@ static
> >>> irqreturn_t panfrost_gpu_irq_handler(int irq, void *data) address
> >>> |= gpu_read(pfdev, GPU_FAULT_ADDRESS_LO); 
> >>>  		dev_warn(pfdev->dev, "GPU Fault 0x%08x (%s) at
> >>> 0x%016llx\n",
> >>> -			 fault_status & 0xFF,
> >>> panfrost_exception_name(pfdev, fault_status),
> >>> +			 fault_status & 0xFF,
> >>> panfrost_exception_name(pfdev, fault_status & 0xFF),
> >>
> >> However this change is correct - panfrost_exception_name() should
> >> be taking only the lower 8 bits. Even better though would be to to
> >> report the full raw fault information as well as the high bits can
> >> contain useful information:
> >>
> >> 	dev_warn(pfdev->dev, "GPU Fault 0x%08x (%s) at
> >> 0x%016llx\n", fault_status,
> >> 		 panfrost_exception_name(pfdev, fault_status &
> >> 0xFF), address);
> >>
> >> Thanks,
> >>
> >> Steve
> >>
> >>>  			 address);
> >>>  
> >>>  		if (state & GPU_IRQ_MULTIPLE_FAULT)
> >>>
> > 
> > 

