Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B89F368F66
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 11:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241808AbhDWJbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 05:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbhDWJbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 05:31:21 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DDFC061574
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 02:30:45 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id j5so46699899wrn.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 02:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=zIHUzlGF+VoE2WXSZQ7n1A/DCDfETqtAPKegvW3ficY=;
        b=IVIyAJFTv1gmnavCkYVIgE0fd9cn4mpUiABUnvYl4QVOYwuX2dBJ54p3DfOhmw2yjV
         v6Rt+RPPLfLTc2PXLknN16a6kRr7OHCzV/D5ZC1KTKuiKbNlUiW1mUAZtU0DZD3gPfXZ
         r3yLpF1RIFSXXDJlNmKPxdqbh6CAfhPL1J2EgzqCOAxXaopSOWp3NhcoCwmzW2JimEGw
         jwx3g3/T8LZBcYgpQys1FVG8RtPiFTY0DbJkvBHgFaGnigVMXAU5fjLkiyl034nP1Bs/
         x6xK0SqjbREO7H3sK9+DxZuomzNdx4d+F1Iswz7BvhZfRfrBE0PxdGeg+NyOKYiUfNdt
         pjxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zIHUzlGF+VoE2WXSZQ7n1A/DCDfETqtAPKegvW3ficY=;
        b=EiJQWEcwWenWEI7Z9TAQJmrmnXvDEY7Ym0m+KNsyTASmc8iR8ElQ4QRRVpRN2iVyLX
         DxeHS+dzzMQmJ+pR+lQRQSPA01hBlEXQ/HKbwLcunArrwJ/8M+DRmAdOvgDfP8Ewl+V4
         nYswuPAzA+BT9DIuGZ6Bj2fOagGQi7UchljjrrOiVZWa4XXu2UYQkWNYCDTcl1zHUXxU
         t2VRCYUFRhPgUMymP+GL2SJtYoFTykSy0Hm62mlAfd4JphbGGA8GHQT8Gjy6qbDqrVOZ
         fa+e4O4dF506Mkr58U+we+ZU7oEon3k1g5Bl5yx8krDpGX290X6+eKQ0IbVnbOokSXZy
         s7xQ==
X-Gm-Message-State: AOAM532tVXabBdmbv9mPorJVO+kAp2ORQaie9njUhsDsXo+J29/uu+GO
        66V0FLYpVzV3Axu0kg3Q8Ql/fFDLuRIxRA==
X-Google-Smtp-Source: ABdhPJyxcHf3paY2MhbsKqIr5hoerQddsUB0QWpSSllmdwxjyrjeSD2FudXIsv9Segh0Zovb3LTK5w==
X-Received: by 2002:a05:6000:144d:: with SMTP id v13mr3488992wrx.73.1619170244464;
        Fri, 23 Apr 2021 02:30:44 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id j12sm8060114wro.29.2021.04.23.02.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 02:30:44 -0700 (PDT)
Date:   Fri, 23 Apr 2021 10:30:42 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>
Subject: Re: [PATCH 165/190] Revert "mfd: mc13xxx: Fix a missing check of a
 register-read failure"
Message-ID: <20210423093042.GE6446@dell>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-166-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210421130105.1226686-166-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Apr 2021, Greg Kroah-Hartman wrote:

> This reverts commit 9e28989d41c0eab57ec0bb156617a8757406ff8a.
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
> Cc: Kangjie Lu <kjlu@umn.edu>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/mfd/mc13xxx-core.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
> index 1abe7432aad8..b2beb7c39cc5 100644
> --- a/drivers/mfd/mc13xxx-core.c
> +++ b/drivers/mfd/mc13xxx-core.c
> @@ -271,9 +271,7 @@ int mc13xxx_adc_do_conversion(struct mc13xxx *mc13xxx, unsigned int mode,
>  
>  	mc13xxx->adcflags |= MC13XXX_ADC_WORKING;
>  
> -	ret = mc13xxx_reg_read(mc13xxx, MC13XXX_ADC0, &old_adc0);
> -	if (ret)
> -		goto out;
> +	mc13xxx_reg_read(mc13xxx, MC13XXX_ADC0, &old_adc0);
>  
>  	adc0 = MC13XXX_ADC0_ADINC1 | MC13XXX_ADC0_ADINC2 |
>  	       MC13XXX_ADC0_CHRGRAWDIV;

Thanks for bringing this commit to my attention.

The associated LWN article was an interesting read and I have to say,
I was very disappointed to hear about the actions of these so called
researchers.

Upon re-review of the original commit, this one does appear valid.

Do I need to conduct anymore due diligence or can I drop this patch?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
