Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9D3359320
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 05:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbhDIDiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 23:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233192AbhDIDiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 23:38:11 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE63C061761;
        Thu,  8 Apr 2021 20:37:25 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id nh5so2204920pjb.5;
        Thu, 08 Apr 2021 20:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AjoDWdy7uigSAOeBTzYfInfamNFP4DVUXaPENdJokEw=;
        b=rD4fSwMmMCEX0HS4ejc3Hb6gpSc2m4ArhR6ghHvQgmR1y8U0MmfK8RZt3uZHt+Sz9u
         xBUGni9BVfero8kyHmkusbHh0b9QdGhDYAkmO6TSq9uQTe2afYbEecnlOtUBpbBzgOWp
         CLwdNmFQoATJ5HmsU5Zh+8f2KkEvNJyLNL0RErVrwHDGYCrcnI4V4Fy2IN+WuAUbrALN
         oPClTLBaOY7HLrZNvHdOfMLKxVLwqqDTzTaFoD8gixhoa2NGBpVRWucKJX+RloxXqMKK
         v6PBS6sv1ZDIlLMMva3oNTf6BM7BUn/WgRZaYvsAACq5F02VPDSd/n30FEO045W/x4qF
         PpJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AjoDWdy7uigSAOeBTzYfInfamNFP4DVUXaPENdJokEw=;
        b=d+T7ufFh2dHRc/0CLGjuy8tTbnjsiLbSvwLzOx8BTLEy1Ox4ug4M62WeKy/nn5dZUb
         K4rB4TMuc9Te0Z/du7m6FH63dMaDVCr9nlmLF6edAmDB2JBfGut+1mvmOQo1tKUfH0mR
         0LmPnMm/F9+kZuiSt9XYx1MPsSNslbF99Wp5nYwaQO/Hd3RL0J6eqojwXCeA6G+4MFnn
         afa1zt/r+wbfpM9vaMUZP4zABlJv6mFtJf/ZzZ43YMY/FKrtXVzMVGEpSxquMzCrZYs8
         0i8z9DXQlXCoVVDTl4T0VF0wHpIOw0GYJJ4XUw3byvsLYzPm61v0jz1fYH2KuE4pvkpv
         wGSg==
X-Gm-Message-State: AOAM531VuPHl082HfKYrUHTshaXCghr0HJ/H93wA4KO4GShphBOgdqvO
        Si975gPiBAxoIgAgbN68yyM=
X-Google-Smtp-Source: ABdhPJy0STsNx2IrHuB6ju6EIrKalhe8t5PRpma4+erIvzt8MdGCtvZkjE7bziGAHp+e6K3DmVaSkQ==
X-Received: by 2002:a17:902:a716:b029:e8:ba45:ea0f with SMTP id w22-20020a170902a716b02900e8ba45ea0fmr11062085plq.63.1617939444981;
        Thu, 08 Apr 2021 20:37:24 -0700 (PDT)
Received: from [10.230.29.202] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id v126sm711637pfv.138.2021.04.08.20.37.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Apr 2021 20:37:24 -0700 (PDT)
Subject: Re: New 'make dtbs_check W=1' warnings
To:     Arnd Bergmann <arnd@kernel.org>, DTML <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Cc:     Linus Walleij <linusw@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Tony Lindgren <tony@atomide.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        SoC Team <soc@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Gregory Clement <gregory.clement@bootlin.com>
References: <CAK8P3a1L8rWpR5b66v6Su8-m7-scA0wZQr_g_4KnV4dnrky6ZA@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <632cbdec-e477-212c-f5a8-81151915fdeb@gmail.com>
Date:   Thu, 8 Apr 2021 20:37:21 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1L8rWpR5b66v6Su8-m7-scA0wZQr_g_4KnV4dnrky6ZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/8/2021 8:08 AM, Arnd Bergmann wrote:
> Greetings to all Arm platform maintainers,
> 
> I've just gone through the DT merges I've received so far and, with a
> little help from Rob,
> managed to run 'make dtbs_check W=1' before and after, to see what
> warnings we get.
> The good news is that the number of warnings is going down, but
> unfortunately there
> is still an unmanageable amount of remaining warnings, and some new
> ones crept in.
> 
> I'm still working on my tooling for this, to catch these better, but
> ideally I think we should
> try to not introduce new warnings. I think some platforms are already
> clean, and I did
> not see any new warnings for mvebu, samsung and broadcom. There were a lot of
> warnings from .dtsi files, and I probably did an incomplete job at
> deduplicating those.

There are definitively a ton of warnings for Broacom DTS files, a number
of those warnings exist because the bindings were not converted to YAML.
Rafal, do you think you could help me with taking care of the
BCM5301X/4908 warnings?
-- 
Florian
