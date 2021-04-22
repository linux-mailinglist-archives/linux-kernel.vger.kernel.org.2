Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96E44367BAC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 10:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235214AbhDVIDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 04:03:15 -0400
Received: from lb1-smtp-cloud9.xs4all.net ([194.109.24.22]:39877 "EHLO
        lb1-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234773AbhDVIDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 04:03:12 -0400
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud9.xs4all.net with ESMTPA
        id ZUIDlprgEvTEDZUIGlY6UV; Thu, 22 Apr 2021 10:02:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s2;
        t=1619078556; bh=+pgdnF6NtFF13QUMmRd77qhpnGZ809oqHX1kCx8LHFY=;
        h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=lvckZB/C55diAxCz3XN10QU3VnlEllTuiIPjS1evpimHZ0AnLkqvED7uVUVv7M1uh
         Cgi+U40m2rUW7Uxr7fB3DTYmcshGdB+v7XN/DHrnqs8FJcv95rn3pZ3XelWoAO1NE+
         qr5BZ1+M+uHPf0yUmViS3RiEHpz1/fGfR5G6i2AzPfr2z2UDl/U1gqqLnSu3VJiXnK
         Osm+L/dTvwN8a1UFLRLGZ4cCycG4mbXKc5X0Mv+cjxYOraH+cB4csle3v4g36xcXAW
         OaFMIOKqo8fDVatTme9RcmGaKqSze69c70N+YNQid8NsJBc8F5IeqAs/wskhfzh99T
         yJdAe4MgX/mCA==
Subject: Re: [PATCH 002/190] Revert "media: st-delta: Fix reference count leak
 in delta_run_work"
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Aditya Pakki <pakki001@umn.edu>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-3-gregkh@linuxfoundation.org>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
Message-ID: <b6e00864-f28a-ee9a-ea53-d1a8aa8c42fb@xs4all.nl>
Date:   Thu, 22 Apr 2021 10:02:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210421130105.1226686-3-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfBLP/5uM+gPtKxDPIisxjU+Yq3cDrQ6MSQBZIDo0Na2nQ1T/+beb3ALLPDXJvbNOhLlv2dcvfR+HQ3wpgaBHRtDM2cE3H1cylW+FNItjFtox//LSUAgL
 LUDt+m2/rDs9EKeAgZDv3LknLV+4Rd8dUY1mN7ngZm/5Lh8Xq/NEUBU9KjGUjmPU+9Q3DZg37NvuRmKRhfRqw/mNuNJjvgY2X0f7q2ikyG7qTl84tNkmOvG1
 1SRGEafpZ4uevpG19Xol+njnoter0lhFpiULaynBkf/lKXn5Lkk6KCbe2GGGKc/4dPAH7p7qR2VmOpuGnt//Iw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

I re-reviewed all the patches in this series where I was CCed.

These are all good and fix real bugs and should be re-reverted:

[PATCH 002/190] Revert "media: st-delta: Fix reference count leak in delta_run_work"
[PATCH 003/190] Revert "media: sti: Fix reference count leaks"
[PATCH 004/190] Revert "media: exynos4-is: Fix several reference count leaks due to pm_runtime_get_sync"
[PATCH 005/190] Revert "media: exynos4-is: Fix a reference count leak due to pm_runtime_get_sync"
[PATCH 006/190] Revert "media: exynos4-is: Fix a reference count leak"
[PATCH 008/190] Revert "media: stm32-dcmi: Fix a reference count leak"
[PATCH 009/190] Revert "media: s5p-mfc: Fix a reference count leak"
[PATCH 010/190] Revert "media: camss: Fix a reference count leak."
[PATCH 011/190] Revert "media: platform: fcp: Fix a reference count leak."
[PATCH 012/190] Revert "media: rockchip/rga: Fix a reference count leak."
[PATCH 013/190] Revert "media: rcar-vin: Fix a reference count leak."
[PATCH 014/190] Revert "media: rcar-vin: Fix a reference count leak."
[PATCH 052/190] Revert "media: media/saa7146: fix incorrect assertion in saa7146_buffer_finish"
[PATCH 056/190] Revert "media: davinci/vpfe_capture.c: Avoid BUG_ON for register failure"
[PATCH 057/190] Revert "media: saa7146: Avoid using BUG_ON as an assertion"
[PATCH 058/190] Revert "media: cx231xx: replace BUG_ON with recovery code"
[PATCH 102/190] Revert "media: video-mux: fix null pointer dereferences"
[PATCH 183/190] Revert "media: isif: fix a NULL pointer dereference bug"

This one can be dropped since it actually contains a bug, I'm fairly certain
that was unintentional:

[PATCH 007/190] Revert "media: ti-vpe: Fix a missing check and reference count leak"

I'll reply to that one separately.

This one can be dropped since it is not necessary:

[PATCH 073/190] Revert "media: rcar_drif: fix a memory disclosure"

The V4L2 core already zeroes this. Other drivers that use fmt.sdr also
memset this, but that should be dropped in those drivers as well. I'll
make a patch for that.

Regards,

	Hans

On 21/04/2021 14:57, Greg Kroah-Hartman wrote:
> This reverts commit 57cc666d36adc7b45e37ba4cd7bc4e44ec4c43d7.
> 
> Commits from @umn.edu addresses have been found to be submitted in "bad
> faith" to try to test the kernel community's ability to review "known
> malicious" changes.  The result of these submissions can be found in a
> paper published at the 42nd IEEE Symposium on Security and Privacy
> entitled, "Open Source Insecurity: Stealthily Introducing
> Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> of Minnesota) and Kangjie Lu (University of Minnesota).
> 
> Because of this, all submissions from this group must be reverted from
> the kernel tree and will need to be re-reviewed again to determine if
> they actually are a valid fix.  Until that work is complete, remove this
> change to ensure that no problems are being introduced into the
> codebase.
> 
> Cc: Aditya Pakki <pakki001@umn.edu>
> Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/media/platform/sti/delta/delta-v4l2.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/media/platform/sti/delta/delta-v4l2.c b/drivers/media/platform/sti/delta/delta-v4l2.c
> index c691b3d81549..2503224eeee5 100644
> --- a/drivers/media/platform/sti/delta/delta-v4l2.c
> +++ b/drivers/media/platform/sti/delta/delta-v4l2.c
> @@ -954,10 +954,8 @@ static void delta_run_work(struct work_struct *work)
>  	/* enable the hardware */
>  	if (!dec->pm) {
>  		ret = delta_get_sync(ctx);
> -		if (ret) {
> -			delta_put_autosuspend(ctx);
> +		if (ret)
>  			goto err;
> -		}
>  	}
>  
>  	/* decode this access unit */
> 

