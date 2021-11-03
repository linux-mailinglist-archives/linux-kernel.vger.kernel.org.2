Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A329E443DCB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 08:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbhKCHqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 03:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231985AbhKCHqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 03:46:31 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1C3C061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 00:43:54 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id b2-20020a1c8002000000b0032fb900951eso3829478wmd.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 00:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ClKuP8tpWpUknWlqku1MtPOSrXJ/D/OoFdlpIIkXVR8=;
        b=dbNGWgs8fET68NobNr6n8pcDdNKfY/jPjt3XP2pCjvJGU6gK9nJhHWeKNyoMiwwEJY
         S8A4TDlscSKLoSXKKc0mZ86OW1tPWizq9DN21jR0u4f1C3x1kPbcDuY14PZpf4EhosD1
         0gsrxvsxQkkZhiIpeyJ+E+FovlkV8bFjn0uV9XFmBQ6twZ8n60repSUho4/epZVwnXVK
         BQbgBwpkiK5b/KoC7Ago/H439Vj30m2HABtuH2fMbHDZdmqEiwRDa6U7/kDGMFfEJDFF
         kkk3ggxEzDvjr0B/oC1k4pfKkqWe3Eeq/rFbJpLJBtYO+/gLt+aY1CPbv4VGiIO75kdg
         U3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ClKuP8tpWpUknWlqku1MtPOSrXJ/D/OoFdlpIIkXVR8=;
        b=P2itP25Q0qNhHw+mFKWuVBO8Z+bJP5eqmpvWh/u5zCGErmNxj0XMxyAhNE6Rg1KhbP
         gAHrZwsu9v6+op5IpEqhfSMtVb98eNkEEvTpPrU5x8GDukYH0ycSSOD9lUin1f+FOQqA
         IeDwas98iVZ3PWxUf13xW4EB+w7uDuVK/zP3NoptgiMfIDLk6K/GuYkJbvQxLFcPfZzy
         +2hD6JFG479BuuBAQKinYLc7z2BD8GrJe7NgwfPhuJox1mzE00f2wZQP1Z3QTsf/PZl5
         r2ZilbPc83sX6kxn/TWh/dYzLPorF+bE2euDpHSM+y4Sbg0KscnYJqbsOaK0Ejfyubfz
         7G/g==
X-Gm-Message-State: AOAM532hM1r2mfXDrvE5bDn4bSgc/SNPBBu6/gV360Tnx39olBTxoxOR
        DWH1AapsTVH1Uj/BLglCkABhRQS+iEBkOQ==
X-Google-Smtp-Source: ABdhPJwpvPvRu2f3cAb5Rp9w93Klt/tdpQWD1EFjzvldLeAQIVOLSfYijN2eqqTE8kSGNPTNLyJNXA==
X-Received: by 2002:a1c:2541:: with SMTP id l62mr13529661wml.11.1635925433583;
        Wed, 03 Nov 2021 00:43:53 -0700 (PDT)
Received: from google.com ([95.148.6.174])
        by smtp.gmail.com with ESMTPSA id w15sm1161593wrk.77.2021.11.03.00.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 00:43:53 -0700 (PDT)
Date:   Wed, 3 Nov 2021 07:43:51 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Paul Burton <paul.burton@mips.com>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/9] Remove unused headers <linux/jz4740-adc.h> and
 <linux/power/jz4740-battery.h>
Message-ID: <YYI9t2Ng1Uppkiav@google.com>
References: <20211102220203.940290-1-corbet@lwn.net>
 <20211102220203.940290-2-corbet@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211102220203.940290-2-corbet@lwn.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Nov 2021, Jonathan Corbet wrote:

> Commit ff71266aa490 ("mfd: Drop obsolete JZ4740 driver") removed the last
> file to include <linux/jz4740-adc.h> but left the header file itself
> behind.  Nothing uses it, remove it now.
> 
> Similarly, aea12071d6fc ("power/supply: Drop obsolete JZ4740 driver")
> deleted the last use of <linux/power/jz4740-battery.h>, so remove that one
> too.
> 
> Cc: Paul Cercueil <paul@crapouillou.net>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Paul Burton <paul.burton@mips.com>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
>  include/linux/jz4740-adc.h           | 33 ----------------------------
>  include/linux/power/jz4740-battery.h | 15 -------------

It appears as though there are still references to both of these
*devices* in the kernel tree.  Should those be removed also?

>  2 files changed, 48 deletions(-)
>  delete mode 100644 include/linux/jz4740-adc.h
>  delete mode 100644 include/linux/power/jz4740-battery.h

Patch looks fine though.

Let me know if you want me to take it in via MFD.  Otherwise:

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
