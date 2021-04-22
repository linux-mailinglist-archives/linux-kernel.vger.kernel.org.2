Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC586367BCB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 10:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235299AbhDVILb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 04:11:31 -0400
Received: from lb3-smtp-cloud9.xs4all.net ([194.109.24.30]:55361 "EHLO
        lb3-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230241AbhDVIL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 04:11:29 -0400
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud9.xs4all.net with ESMTPA
        id ZUQElpw6jvTEDZUQIlY8h8; Thu, 22 Apr 2021 10:10:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s2;
        t=1619079054; bh=8kyOPDFzV84gIkuQU/t2tvaUohuSFAK3jUaF4CU9b/U=;
        h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=dvlQUUXtYdtenntirLyCwNSiUIRYkLnhztSDiV7w2HcBlR2rtloQzKFHwypzjmNOG
         6uZ2HOKT4LcCrzXI+RiLNyYH0iG0pWYS0bVXRtirHmSHZ80dUYC/hmAWiYLRmvVMEG
         mSxMCML5gAs7wuCMrYKZwkSDy6jMIE+rxNOPW7u0PtBSkAVhYXTJduVVBXFKht271Y
         DEX6sgxmQcPve3f46+ierYNRY52iZuAMJ6VdVuuvOSQlaacIJYVqmsOc7EVz7vMatC
         viARG6VWqQtk/OmKpKoeT4Vm5CaMtH1+e9nF3+wyj09tjEtx0ZXQ603go6KWfzY54F
         5juNsl90xk1zA==
Subject: Re: [PATCH 007/190] Revert "media: ti-vpe: Fix a missing check and
 reference count leak"
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Qiushi Wu <wu000273@umn.edu>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-8-gregkh@linuxfoundation.org>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
Message-ID: <01927b51-7d17-112a-a0fd-eae3efafd769@xs4all.nl>
Date:   Thu, 22 Apr 2021 10:10:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210421130105.1226686-8-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfB9V70GtQtyyKPJOBKGE9hXrFZDmDh99QEXMnHEye0jh/omMosMErkhjOIpip18YzVGMGCszIwrK7ObDcgEPMxfyZ5jtdTDXgc5vADKOlJ6kQFhUrv/k
 b7uNATmj6hWK3N4zxtrwsE248oyavxt2MaV7aEUodDL55yW9usbuz5dmVJDYT9x7BfpPqNC0yo2G9AhLpZQnkVu+SOHCzPr2sNWuAIYZRuAhnXyqEk9Hjmxu
 JuA5QCOk02Llui7p3k6QF4kS7irWCtHOwHJJ7kNtsarPr7Y4u/EItgVhx9NSMBm4xGkRTzL5Pa9gkCynXpFDaB5VBjNyMLh6zVIkXXXgJxhstVjK7xZu63UZ
 u3Zn497a
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/04/2021 14:58, Greg Kroah-Hartman wrote:
> This reverts commit 7dae2aaaf432767ca7aa11fa84643a7c2600dbdd.
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
> Cc: Qiushi Wu <wu000273@umn.edu>
> Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/media/platform/ti-vpe/vpe.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/media/platform/ti-vpe/vpe.c b/drivers/media/platform/ti-vpe/vpe.c
> index 10251b787674..c7a0a7c19ca6 100644
> --- a/drivers/media/platform/ti-vpe/vpe.c
> +++ b/drivers/media/platform/ti-vpe/vpe.c
> @@ -2473,8 +2473,6 @@ static int vpe_runtime_get(struct platform_device *pdev)
>  
>  	r = pm_runtime_get_sync(&pdev->dev);
>  	WARN_ON(r < 0);
> -	if (r)

This should have been: if (r < 0)

I missed that as a reviewer, and I don't think it was intentional either
since I couldn't find any clear documentation in pm_runtime_get_sync()
that it can return 0 or 1 as success. After going through a few wrapper
functions you end up in rpm_resume() in drivers/base/power/runtime.c
which doesn't document the return code.

So keep this reverted and I'll make a new patch for this later.

I've CC-ed Rafael and Pavel: it would be really nice if someone can
document the return code from rpm_resume() in drivers/base/power/runtime.c.

I just discovered that it is documented in Documentation/power/runtime_pm.rst,
but if you just look at the code then you'll miss this.

Regards,

	Hans

> -		pm_runtime_put_noidle(&pdev->dev);
>  	return r < 0 ? r : 0;
>  }
>  
> 

