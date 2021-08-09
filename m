Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93D253E41A5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 10:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234027AbhHIIeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 04:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233794AbhHIIeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 04:34:21 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5326FC0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 01:34:01 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id i4so2832337wru.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 01:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=o64k6URbjnsGLsLYFBqolTH4MtMcklgUE4Tf5PdPVug=;
        b=s3ep9NCza0FhQHnz6E2j2n1lYCjrMfV+4RKP08lfeF8TJYttk+HzgCXUQGraF9oOM4
         gdzLyVzsfDy8NAY9l9xc+xmMw2hWenipf4H6fyqioVUJJXvdUbtWtmr+AXxaa42nTcFP
         lRgH1esBC58pkW26LImsnLtHEqJefeksvjR94W3srZpXq/sVjhXHr+oPyJkn8LcCoJw1
         wXJ+NUCk2LYTQ9fjmcBB20kDXvJB3bimYxpqnMdn+BJv6ixcakvOkC6Nz9v7Ku9Z+5XF
         2tzdH+GfiW9Lv2FWnkdPNEwmD1+9aNEa9BD1nblP3kbH6Pck+tO2R1uLUPjxO75j7cN8
         uXog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=o64k6URbjnsGLsLYFBqolTH4MtMcklgUE4Tf5PdPVug=;
        b=tNxOMFrzsqYS60ObIiNH7eHdIloolqKQQoVuIFeBs9ZsGdrLHF5pJRLaBZDMyc+5mu
         ah2atMXCa+uVDkQTd/lSxeuRuDbt8ZViPT6gxtKT+l58xFEuGSKq4ms9wqxDMywV4Zoe
         RPW8XHcaOQvIM8y9ohfjVUywarqnMJaowoiuVEdJmA1PqCbT8keGfNx+yuMr156Sbxua
         1P2GM6OTZ2beoG7k1VIwMIvGOvRk4z2TeyHGK/9uctxfiVeFLsQE0hwGpQINyVksCDBC
         QRPczAP3eEWaEkWjEoAvj8px02Hns098qClsHWlmHTgtjcwUVtQERkHTFmGT9N8mnYzF
         cqiA==
X-Gm-Message-State: AOAM5339dAvM2vuYMuA4xi38ZugbJl09NJK1QnY1jr47eJY5BoU4SiOi
        DL+DAv55wF4I0jT5bS6li7I72w==
X-Google-Smtp-Source: ABdhPJxZzeEU/zjbiAqjqFzQa1KsWybz2fuObNORpAwX7a2AmtB49mjZyfYM5kVRRpqySmJ0mEV2Xg==
X-Received: by 2002:a5d:66d1:: with SMTP id k17mr24513987wrw.251.1628498039938;
        Mon, 09 Aug 2021 01:33:59 -0700 (PDT)
Received: from google.com ([95.146.142.85])
        by smtp.gmail.com with ESMTPSA id e3sm18939963wrw.51.2021.08.09.01.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 01:33:59 -0700 (PDT)
Date:   Mon, 9 Aug 2021 09:33:57 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        phone-devel@vger.kernel.org
Subject: Re: [PATCH 2/2] mfd: db8500-prcmu: Handle missing FW variant
Message-ID: <YRDodVD62RCS1jNR@google.com>
References: <20210801233314.3150754-1-linus.walleij@linaro.org>
 <20210801233314.3150754-2-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210801233314.3150754-2-linus.walleij@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Aug 2021, Linus Walleij wrote:

> There was an "unknown" firmware variant turning up in the wild
> causing problems in the clock driver. Add this missing variant
> and clarify that varian 11 and 15 are Samsung variants, as this
> is now very well known from released products.
> 
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Cc: phone-devel@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Clock maintainers: could you please ACK this so Lee can take
> this into the MFD tree? The chances of merge collisions are
> zero, this code changes very seldom.
> ---
>  drivers/clk/ux500/u8500_of_clk.c | 3 ++-
>  drivers/mfd/db8500-prcmu.c       | 6 ++++--
>  include/linux/mfd/dbx500-prcmu.h | 3 ++-
>  3 files changed, 8 insertions(+), 4 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
