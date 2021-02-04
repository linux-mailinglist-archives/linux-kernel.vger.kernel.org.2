Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF6AB30FC0C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 19:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239480AbhBDS4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 13:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238820AbhBDSzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 13:55:52 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F583C061786
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 10:55:12 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id l12so4840382wry.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 10:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Z5lY9EzY3p+tNc4fTZ1yzC/M13ykEyZmAgfqdRyvqls=;
        b=QqYJbWMrWsBlPFxWsCq0CbRDCvrcGl79aEqxSyQ1jKdOl4NRz8QU/H6DDQA90dDqh3
         Rq7BNP+DV36q6uNft0NoUesCNmE9T7QJbGA8agou897MPhg0awcbrJP4/sia/y2ALZEu
         ZMHL3hRtPdpO5e3op7CWmKq1OCqUWLs1p/Znt9M4Wg0ScGXsRgQoOYcp41GMsuKBQkla
         3BQZQvGgi1afpIvGY4MBlknZsqu/w/xACPkHiXFcb9f30RQSVIYJskKMgPMowjkCgFM8
         jNdK4PPruyK0aIaqbHM5MZowM7qP89hDwQpz4xaLDsgGTBdJ+oZx78wgGUke9zES/P2r
         F1ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Z5lY9EzY3p+tNc4fTZ1yzC/M13ykEyZmAgfqdRyvqls=;
        b=LWZcI1/fmscUl7fm+MFuAlAt4Emw+YcRD6GfwS54S31FUEtTdhaN35nJmAhuUaZ/BS
         1NR8cWnwCT3kcHMieQCeSMpPU8hczj8YhyxqF9YFEV/K4VFXfG2KBYRPvf8gIXn7Q685
         ZQZibV/WizruXr7PIeG6cZQArxAZF/UuAVk2YWPpS/nunwsMRRlf0F8eER+Djd9YmpK5
         h0EEnXmlFgk31aggkfplpJjvHwwoH8Lao80EmC2ZPRQJffYOYFtlrPvX1MfVzKydLoKQ
         FzpLfAgGZxXqJqFIjxkMOoeRDfnIPLeNVc6Ny4b/z5AHi/43mgOfN9FgnVfW8iUPKt5k
         3MFQ==
X-Gm-Message-State: AOAM531HKefSdYz23vUlxYFm6vGnqlXkcbZzUkt0sHuPbnvsApNeN8vC
        sGP5FlzQMf+EubhWM0QZBednGA==
X-Google-Smtp-Source: ABdhPJz0W8AtuWvK0NhRHzIgRg1okHD57QcG/E/zOoy/cUJzrM9giNm9DorwZAdlMJ4QhXI6l3b+/w==
X-Received: by 2002:adf:b749:: with SMTP id n9mr784310wre.267.1612464911015;
        Thu, 04 Feb 2021 10:55:11 -0800 (PST)
Received: from dell ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id w25sm7135203wmc.42.2021.02.04.10.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 10:55:10 -0800 (PST)
Date:   Thu, 4 Feb 2021 18:55:08 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     "Alessandrelli, Daniele" <daniele.alessandrelli@intel.com>
Cc:     "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "Murphy, Declan" <declan.murphy@intel.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH 06/20] crypto: keembay: ocs-hcu: Fix incorrectly named
 functions/structs
Message-ID: <20210204185508.GQ2789116@dell>
References: <20210204111000.2800436-1-lee.jones@linaro.org>
 <20210204111000.2800436-7-lee.jones@linaro.org>
 <b8425f8b292e0ca268a2f575e9053ed408bc4c6e.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b8425f8b292e0ca268a2f575e9053ed408bc4c6e.camel@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Feb 2021, Alessandrelli, Daniele wrote:

> On Thu, 2021-02-04 at 11:09 +0000, Lee Jones wrote:
> > Fixes the following W=1 kernel build warning(s):
> > 
> >  drivers/crypto/keembay/ocs-hcu.c:107: warning: expecting prototype for struct ocs_hcu_dma_list. Prototype was for struct ocs_hcu_dma_entry instead
> >  drivers/crypto/keembay/ocs-hcu.c:127: warning: expecting prototype for struct ocs_dma_list. Prototype was for struct ocs_hcu_dma_list instead
> >  drivers/crypto/keembay/ocs-hcu.c:610: warning: expecting prototype for ocs_hcu_digest(). Prototype was for ocs_hcu_hash_update() instead
> >  drivers/crypto/keembay/ocs-hcu.c:648: warning: expecting prototype for ocs_hcu_hash_final(). Prototype was for ocs_hcu_hash_finup() instead
> > 
> > Cc: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> > Cc: Declan Murphy <declan.murphy@intel.com>
> > Cc: Herbert Xu <herbert@gondor.apana.org.au>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: linux-crypto@vger.kernel.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> 
> Acked-by: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> 
> 
> Thanks for fixing these.
> 
> For some reason, if the issues are there, I don't get those warnings
> when compiling with W=1; the command I run is:
> 
>    make CROSS_COMPILE=<arm-compiler> ARCH=arm64 -j5 W=4 M=drivers/crypto/keembay

Not sure what would happen with 'W=4'.

Probably nothing, as it only goes up to 3 [0].

> Which command are you running exactly? I'll use it for my next
> submissions.

 rm -rf ../builds/build-arm64/drivers/crypto/
 make -f Makefile -j24 --quiet ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- KBUILD_OUTPUT=../builds/build-arm64 allmodconfig
 make -f Makefile -j24 --quiet ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- KBUILD_OUTPUT=../builds/build-arm64  W=1 drivers/crypto/

Hope that helps.

[0] scripts/Makefile.extrawarn

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
