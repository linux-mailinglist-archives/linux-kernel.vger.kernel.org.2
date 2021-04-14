Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77CC135F0FA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 11:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236036AbhDNJoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 05:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233065AbhDNJoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 05:44:08 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4226C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 02:43:45 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id y204so8856750wmg.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 02:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LzwkGbnxl9M8rDSBY6BJKN+53l2qgIFSzWD8Wt6PTAM=;
        b=VDb5ntFrW4CbbZ4al2ton8uH8H+Ji9ae1UW1cDXmcdAQ2YAN6KqblLyk7YWINZssOx
         IXfdyl4RZNjwCFFHUXhgwr1F1bm2td6ygV4VnrsY83Lu/XQjnCgwWjPUB2qFar5uxbAu
         vfCfXZRF63H/LMHkACrH6LkkIG1cnLuiqB4gdEVC2B6Rt5Lx36exzozjGuDLvj/apE/8
         UoxKOBPnucPDXGXzrQYxXEzNuWiGw3cdp2gMyOgPUEgZgilxY4k7yx7w+WLrEJEJz2ZH
         qdzEACgV45vsEX+9kTcsfkVUrrh1z7FKTxR5bfE3c+t8Thk2Yca+NDuapIMCrMbrpR4T
         3Ggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LzwkGbnxl9M8rDSBY6BJKN+53l2qgIFSzWD8Wt6PTAM=;
        b=EweIwlDf1DcEysEtqjbS/72hzMNBtC60Y1BnhY3x7qpdGGcW19Cd0Tzh7tald1KhTI
         TxXe/hBaKBMrlgoxdJuGPa/F29/puSWsphufF/CBU2NEJ/Q1K2KkCkHehfa9lYoUY0n8
         xTklq6j0swEgSYjApyZe7WT46+LJ+xBdqHXL506jDsISf8MIqD50jQxY9SCVJ5TsAINp
         /otMHwAdIsZvOjeBDDcNdN/4h7bHh4rwuRitRQYIRbp89yRUHc34IwHqRPYS+VxNRo0Y
         N9ExTPc6Uli5gSo2PF2rSNzLKLgQZPaCfsuL/jYeaCuYbRwfR8OfFfpr8Xv2D89aBlJY
         8RbQ==
X-Gm-Message-State: AOAM533dE/66J7H99jSCB0c2IZ0F0Jd4GxUAF0dc8Tfn/v5QtcDs1fnS
        gQD+reqosopefs1mHvIlKn5RO0AbxNA=
X-Google-Smtp-Source: ABdhPJyUCG2524rkdwi3qb1gkGBWdJylcW2D7K73f5wxMe+5J3U+SWG6+drsu5Cz+1Zc30DATRd1/A==
X-Received: by 2002:a1c:9d94:: with SMTP id g142mr2202789wme.154.1618393424733;
        Wed, 14 Apr 2021 02:43:44 -0700 (PDT)
Received: from agape.jhs ([5.171.25.35])
        by smtp.gmail.com with ESMTPSA id q19sm4713030wmc.44.2021.04.14.02.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 02:43:44 -0700 (PDT)
Date:   Wed, 14 Apr 2021 11:43:41 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     julia.lawall@inria.fr, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] staging: rtl8723bs: replace DBG_871X_SEL_NL with
 netdev_dbg()
Message-ID: <20210414094340.GB3931@agape.jhs>
References: <cover.1618325614.git.fabioaiuto83@gmail.com>
 <a798262b8e1dacf225dd42f2863243c543667d5f.1618325614.git.fabioaiuto83@gmail.com>
 <YHanGdS1Kc/4zq4q@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHanGdS1Kc/4zq4q@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 10:26:01AM +0200, Greg KH wrote:
> > -	DBG_871X_SEL_NL(sel, "%10s %16s %8s %10s %11s %14s\n",
> > -			"TH_L2H_ini", "TH_EDCCA_HL_diff", "IGI_Base",
> > -			"ForceEDCCA", "AdapEn_RSSI", "IGI_LowerBound");
> > -	DBG_871X_SEL_NL(sel, "0x%-8x %-16d 0x%-6x %-10d %-11u %-14u\n",
> > -			(u8)odm->TH_L2H_ini,
> > -			odm->TH_EDCCA_HL_diff,
> > -			odm->IGI_Base,
> > -			odm->ForceEDCCA,
> > -			odm->AdapEn_RSSI,
> > -			odm->IGI_LowerBound
> > -	);
> > +	netdev_dbg(adapter->pnetdev, "%10s %16s %8s %10s %11s %14s\n",
> > +		   "TH_L2H_ini", "TH_EDCCA_HL_diff", "IGI_Base", "ForceEDCCA",
> > +		   "AdapEn_RSSI", "IGI_LowerBound");netdev_dbg(adapter->pnetdev,
> > +							       "0x%-8x %-16d 0x%-6x %-10d %-11u %-14u\n",
> > +							       (u8)odm->TH_L2H_ini,
> > +							       odm->TH_EDCCA_HL_diff,
> > +							       odm->IGI_Base,
> > +							       odm->ForceEDCCA,
> > +							       odm->AdapEn_RSSI,
> > +							       odm->IGI_LowerBound);
> 
> Something went wrong with this change :(

thanks Greg, I sent an example to Julia, that reproduce the problem.
As soon as it gets fixed I will send you a v2.

fabio
