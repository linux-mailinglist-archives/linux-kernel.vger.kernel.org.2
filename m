Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00B6B33388E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 10:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbhCJJRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 04:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232592AbhCJJQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 04:16:53 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735A4C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 01:16:53 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id i9so6613865wml.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 01:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=JPOBl9P3KFSa2LmIeuoWAo+fvTi1QvEirIxt/aByX7U=;
        b=KqbJFjYczFN10ej4wMdnONCmHz8Pd4AtS2ymDClPEma35pdT9jz3gdIIK9QmslnpoU
         V+dvE75EWP1ynPq6XLrNRBnu+qDlJnTHRGTGYnjMh+9wfgEEbM9aT7t+ZEIVgYTQ7Vkv
         5B7yST0ucUj2phB78thRofwXFc3R5Id6OTiinR1QSLIyJnn94U1qODL5PWE6bbJDDrEu
         BHjmsk6qkgsdq7jWm9SXG80AclfQji4IkReAF5AFdoMC0A74jCX2S31niuDO6Fpy7238
         9QTlI/T/ALqgEShNskD6jqSU6u8HWqlUZy69S2x641W9++EBRC06HAsPoP9phOQtukmF
         4Vsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JPOBl9P3KFSa2LmIeuoWAo+fvTi1QvEirIxt/aByX7U=;
        b=f9GT1hv77P0CzUjCnwoSdh6LcRk9SbRpcAAewEOvUiOUpnLl/OB+PUKF6dFnbd8YYq
         pW9Ct2eS9UZ1FESWF9PfLQoHsa2CY04EdMF4wUD6KncOJaSl54NSAcoaNUPP1m5tjmi8
         esRsgaZhyyzA8lLM2UED6ky5hMENtqs2teL2+sMOxdkWywYOlNlywqRMnnjIa0Y19mLC
         RqbM14zr8VTEePOe6sGujuPN9EvbNx2BuJbNFiiRey7CEhAWje/RATB471sMRy6Q6JiG
         vC+760ouXxuzpUwF5rcpWdz4yjbaESLZxtkOukyG+R/zjtyijgf1+KGESchdXXpX4a8n
         7hoA==
X-Gm-Message-State: AOAM532KfrjNgYHUU8VHAgC4k7qQA/Kq6pJEJygu9mH5nQYSdSJO+x6t
        uHT8wRosVdSTPFPdKq8X/BlWryTpHBDgVQ==
X-Google-Smtp-Source: ABdhPJztFGaIWVzbo7sxNmal0IEZoNLVB9r4cdVS1754OHJpf08c979J6JeHF+ujyO7TQUwy+cy97w==
X-Received: by 2002:a7b:c4c1:: with SMTP id g1mr2267550wmk.145.1615367812203;
        Wed, 10 Mar 2021 01:16:52 -0800 (PST)
Received: from dell ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id q15sm28766951wrx.56.2021.03.10.01.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 01:16:51 -0800 (PST)
Date:   Wed, 10 Mar 2021 09:16:50 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     linux-kernel@vger.kernel.org, trix@redhat.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com,
        lgoncalv@redhat.com, hao.wu@intel.com
Subject: Re: [PATCH v3 1/4] mfd: intel-m10-bmc: Fix the register access range
Message-ID: <20210310091650.GK4931@dell>
References: <1614578385-26955-1-git-send-email-yilun.xu@intel.com>
 <1614578385-26955-2-git-send-email-yilun.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1614578385-26955-2-git-send-email-yilun.xu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Mar 2021, Xu Yilun wrote:

> This patch fixes the max register address of MAX 10 BMC. The range
> 0x20000000 ~ 0x200000fc are for control registers of the QSPI flash
> controller, which are not accessible to host.
> 
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Reviewed-by: Tom Rix <trix@redhat.com>
> ---
> v2: no change.
> v3: no change, rebased to 5.12-rc1
> ---
>  include/linux/mfd/intel-m10-bmc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
