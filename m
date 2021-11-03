Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9080C443FE0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 11:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbhKCKQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 06:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbhKCKQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 06:16:37 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62844C061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 03:14:01 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id r8so2713908wra.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 03:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=pCceS9s/gJU6l+nLmyLJ8QrzjDchYjqWQDtBOUYN92E=;
        b=oYeil0EPYT4PPrSkKh7FN07mWjRiW3E9Fbu4LQInvYDaG5dDHOKt6pCLJdQtGZFkb4
         YbJLeUVi0g6nObiyEY5hqNGWZ3/6xfHZe/5uzmaUqXvJsCmouoWeLhRCkFP608Qpze03
         e3svWuFMZ3pvbcefhaXnDwx3I2aF+1FU4bc9qDpkU0/vFIz/1TtZRaFFhBvXJyKER0zY
         juzEuv72udtTtTShBe0Z3HGPQz1XYKIO3tJH8jcMTtOaeVAcMeQPe7Sgg3ekEfJyoMHu
         bR5kv1DnMFe6hpPCDT89ZqN5oKl8TJsqvy3czjDNL4XQ0l6epsmTo4BdX7+veZCOdnzV
         Sohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pCceS9s/gJU6l+nLmyLJ8QrzjDchYjqWQDtBOUYN92E=;
        b=X6lyTBl8m4p/dhhNIy/REnlUcKGpwtULb1MmW5mrKVY5/u+dUmTJoVSWMmwe/4S0Lz
         sWo+lmSK/FxJ1IANMHM3eTfPiwjuJb+dZATa57hL6ZDVLJnUYxBiMPyQYlNOLyNYkr5u
         7L2hhPTtua4mKhx849oBAF4MOVcEMzS1xRIXujWsYcjHdRwvXDiCUoi96AfvRZKIClc2
         WSDZEbXU+8uiRtLjJ/JOl63I1YKycahNnnAhaMdCHb04GKjYSvfw2GjUc7ZvlTNAP4y2
         LN/eC8S6MW6rRrsRRLDATiw6vbbAnrYrgTrHecgPEaayrwDo9ZBiGDPcIb7UVfuEyY8m
         aufg==
X-Gm-Message-State: AOAM531YBEvclvy08uKVjJ258j10P4tCHB5mlu03/Tvp3jK8jog6/a/8
        Agrs9TMffrZTL+2R5MK411RIB7M/eRkxUg==
X-Google-Smtp-Source: ABdhPJwk08hzWJAhY3tFD9f1tGZCVdznhtcbYcacx01zsi/zVPyrps5Uw+LRDx6ZbS3SXiV9MB5Czw==
X-Received: by 2002:a05:6000:1acd:: with SMTP id i13mr2897152wry.398.1635934439976;
        Wed, 03 Nov 2021 03:13:59 -0700 (PDT)
Received: from google.com ([95.148.6.174])
        by smtp.gmail.com with ESMTPSA id z14sm1549575wrp.70.2021.11.03.03.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 03:13:59 -0700 (PDT)
Date:   Wed, 3 Nov 2021 10:13:57 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        Paul Burton <paul.burton@mips.com>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/9] Remove unused headers <linux/jz4740-adc.h> and
 <linux/power/jz4740-battery.h>
Message-ID: <YYJg5WaO+Ogd3chz@google.com>
References: <20211102220203.940290-1-corbet@lwn.net>
 <20211102220203.940290-2-corbet@lwn.net>
 <YYI9t2Ng1Uppkiav@google.com>
 <8YOZ1R.5Y4XRHLJDAGS@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8YOZ1R.5Y4XRHLJDAGS@crapouillou.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Nov 2021, Paul Cercueil wrote:

> Hi Lee,
> 
> Le mer., nov. 3 2021 at 07:43:51 +0000, Lee Jones <lee.jones@linaro.org> a
> écrit :
> > On Tue, 02 Nov 2021, Jonathan Corbet wrote:
> > 
> > >  Commit ff71266aa490 ("mfd: Drop obsolete JZ4740 driver") removed
> > > the last
> > >  file to include <linux/jz4740-adc.h> but left the header file itself
> > >  behind.  Nothing uses it, remove it now.
> > > 
> > >  Similarly, aea12071d6fc ("power/supply: Drop obsolete JZ4740
> > > driver")
> > >  deleted the last use of <linux/power/jz4740-battery.h>, so remove
> > > that one
> > >  too.
> > > 
> > >  Cc: Paul Cercueil <paul@crapouillou.net>
> > >  Cc: Lee Jones <lee.jones@linaro.org>
> > >  Cc: Paul Burton <paul.burton@mips.com>
> > >  Cc: Sebastian Reichel <sre@kernel.org>
> > >  Cc: linux-pm@vger.kernel.org
> > >  Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> > >  ---
> > >   include/linux/jz4740-adc.h           | 33
> > > ----------------------------
> > >   include/linux/power/jz4740-battery.h | 15 -------------
> > 
> > It appears as though there are still references to both of these
> > *devices* in the kernel tree.  Should those be removed also?
> 
> These files were for older drivers that were since then replaced by newer
> drivers; JZ47xx SoCs are still officially supported and maintained.

Okay, great.

Thanks for the explanation Paul.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
