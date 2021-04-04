Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9F23539BA
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 22:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbhDDU2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 16:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbhDDU2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 16:28:41 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B50C0613E6
        for <linux-kernel@vger.kernel.org>; Sun,  4 Apr 2021 13:28:36 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id o20-20020a05600c4fd4b0290114265518afso1921744wmq.4
        for <linux-kernel@vger.kernel.org>; Sun, 04 Apr 2021 13:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p4Z+wpe/vlKTP8y/0b+d0+U+PvDT/FlgjYt5lTllbW4=;
        b=NWlntXXj0Z1wwNIlEqKpTd+qYBTsIkNjs+EELfp9hGpc3vKDTi0VLBCsZfeGileN53
         cwgNJ6P1EXl1kXYhCinsy8dI3ocFgYwrz+KJmWB2ROn041jIYe15UnfLuyf8NXr/Oe98
         7oIDHCOTfYeeXJCEK7+HEcQWLBEQqW1ie76EblqdwLwPGPaO/cUd+OkXpg1hxMKcD3SF
         i2X0P1KSxWv53mU/jQFPmlB/lTfH694GSLTc5lCvu3KLOroGQ/9qi/zCO5eu6+6lrdTz
         ww2ZC3fOc7I25sBX+K+e8SarGHkNb1OMthUEqjQlVZsILILcPpCVJndCGGFQ+ywb4Jxu
         GqpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p4Z+wpe/vlKTP8y/0b+d0+U+PvDT/FlgjYt5lTllbW4=;
        b=AA4hcDrTjrFfhXuuwCVHD3CasfexmcUS1bnAKrXuGTMA+P8MJZVyUvUAC4QtLycnI2
         OXUx5H8SV44f8AxoTjXMG/ymq+j1R98LPQ4jiy39PVf1hTWupKByGaVaT33nGr3p/Y7T
         MPd1EJ3mqLKh+NUC7xyv2gEOpT3Pif9zsWQpqnRfKC5APamTZaJ1f9ALwhYbntdzPJzE
         8R63cmK3URNFoG+WJi1jFU+R//DOd6hbxUavYUl+JOGYDtWLPqx+zrslKzo7Tadbqeh4
         89hit1iAY6IEU+hiJEN479TTOecmzbgOip8mLPJfQdeYsVAJH19VBW5T3QTGTxYGFY/i
         RiTg==
X-Gm-Message-State: AOAM531y+JJRKQAP3vdH8RnT0eAwBR+AAdJcZ0a3YCSqs17VDQ0ZKAOo
        mRibrgng/5yocqhdil/DNS+T+A==
X-Google-Smtp-Source: ABdhPJzyhdDpLRNsqZ9OZoNfAvSvJhyGUY7UxDjuu2c41Xlv9nxAeDBSy8Bq2XWJNBulCTrYeu6eDA==
X-Received: by 2002:a05:600c:4fc8:: with SMTP id o8mr12314827wmq.87.1617568114719;
        Sun, 04 Apr 2021 13:28:34 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:6d68:6b9a:7a3c:4a9f? ([2a01:e34:ed2f:f020:6d68:6b9a:7a3c:4a9f])
        by smtp.googlemail.com with ESMTPSA id f7sm19957499wmq.11.2021.04.04.13.28.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Apr 2021 13:28:34 -0700 (PDT)
Subject: Re: [PATCH 05/14] dt-bindings: timer: nuvoton,npcm7xx: Add
 wpcm450-timer
To:     =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
        openbmc@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>
References: <20210320181610.680870-1-j.neuschaefer@gmx.net>
 <20210320181610.680870-6-j.neuschaefer@gmx.net>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <623f26fa-38f3-c7fc-a857-126d93a0e886@linaro.org>
Date:   Sun, 4 Apr 2021 22:28:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210320181610.680870-6-j.neuschaefer@gmx.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/03/2021 19:16, Jonathan Neuschäfer wrote:
> Add a compatible string for WPCM450, which has essentially the same
> timer controller.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
