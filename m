Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAA063277E3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 07:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbhCAG5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 01:57:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbhCAG5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 01:57:08 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B119EC061756
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 22:56:28 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id s16so9249473plr.9
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 22:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T5dHTAB5KVLsF+Zkl0pxw75mdTE6mZ9uUArY/XRtpJg=;
        b=dAVYjO8lDrbgJYoU6W0xdsFr0ZpZidvtQMr7lm5EJOR1KA5dqmM+0i1YW8HgyURTTH
         TemL6YnJ6hxKXrs80Z37IZTDJwJeCjlJj2GNVZyr/JMJzEtsF07aUYP6iRbWwxdLcT8+
         Ww/6wzL9keLO7uIi5SYdVriqVIwulazH0At35bl3AcOLvVgNpeowNpTd9kgxS5TgvScP
         5WM/JIiUtda5QIod8cU3NL/5P4GkNtdHKYC/xxCt2LxBONfGGR3gLqUog1QI0ou1s1PH
         +NIupK1SFHo8johHgO94azwYxJKms9kOF/hvFfjB6zuZ1SRBrQmMOhPbmBpfHF4iR31t
         N8NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T5dHTAB5KVLsF+Zkl0pxw75mdTE6mZ9uUArY/XRtpJg=;
        b=ZpA8wG6Vc7mbrALsnNS0WGAH54Za75vHoL9JJoCrDFExrHnUl4sD6+LZKlhglTuCtg
         0r3H4F8Vsm9kb0J4fqMB/kt8pUUdWF26YPe6K+EPAW0EB+OOAIIIk1vtvOnTM0QhVjp7
         2fJQNmNf/GI6V1Zt4IeqqquzXSHAL7n6A3hoS4DLa+1CZNny18X+PVnky7htwTTU54Ie
         DREyW9cYi4IFCO0moxHmh7G98hvyZPYv+Ki62yRO/b06ZgKo/FSr+ff4Dw+6UDkEmTb7
         E+o+4lFCJnApHOMfyFfhnLI+JdkDCjf9Fn6duTH4xvH5FVRtMgKJlVPHOj9jArRpqoYU
         LZIA==
X-Gm-Message-State: AOAM531JKOj80zcNXMe/DhX18ALlwxJr0wp0yM2Ks6snKuKrnkvMngXJ
        SSGY//9Irv2gxI9P8LJdObFOBA==
X-Google-Smtp-Source: ABdhPJzcsuR/3zc+q7gnIbMxLcKeElPaJb2qwlW0b4VrP2MxAWQ1qwZitz+UcL9BFNU/pHhk83NASw==
X-Received: by 2002:a17:90a:fb8e:: with SMTP id cp14mr3644183pjb.52.1614581788251;
        Sun, 28 Feb 2021 22:56:28 -0800 (PST)
Received: from localhost ([122.171.124.15])
        by smtp.gmail.com with ESMTPSA id m6sm2560912pff.197.2021.02.28.22.56.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Feb 2021 22:56:27 -0800 (PST)
Date:   Mon, 1 Mar 2021 12:26:25 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        anmar.oueja@linaro.org, Bill Mills <bill.mills@linaro.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        devicetree@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V8 0/4] dt: Add fdtoverlay rule and statically build
 unittest
Message-ID: <20210301065625.rgo2xvr7ol2vycyf@vireshk-i7>
References: <cover.1613127681.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1613127681.git.viresh.kumar@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-02-21, 16:48, Viresh Kumar wrote:
> Hi,
> 
> This patchset adds a generic rule for applying overlays using fdtoverlay
> tool and then updates unittests to get built statically using the same.
> 
> V7->V8:
> - Patch 1 is new.
> - Platforms need to use dtb-y += foo.dtb instead of overlay-y +=
>   foo.dtb.
> - Use multi_depend instead of .SECONDEXPANSION.
> - Use dtb-y for unittest instead of overlay-y.
> - Rename the commented dtb filess in unittest Makefile as .dtbo.
> - Improved Makefile code (I am learning a lot every day :)

Ping!

-- 
viresh
