Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF023DD154
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 09:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbhHBHkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 03:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbhHBHkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 03:40:41 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B06C06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 00:40:30 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id d8so20289172wrm.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 00:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Sx9QXrg4ZNFSGE92YcBO2jMOLGSWdnZV3pnibrZPh18=;
        b=tjPY7t2oR2UaAFYwIndaYLJrxtKaLgx0xJHGU690X/w0JyP0SJVTWiDBbUtaidytVs
         Ba7i1xxBjGDw/FYNL0WWyTKW7N/jYfcO5MhIiE9KgX8mpzZkotAX7dZHhm35ebvLaM+s
         FoNIkvTQc/nctsx1iucIKw9tk+C+SCjF4iEEjoQhwQt5EXRAz5BXWAathnoIRYbBmknp
         hd81KqsKFs3D6GQ4zPiMvs/PtYoYQ53Ug3qkukoCn1MQzjryBW6EMvl6o7O/uif8FhkD
         lR+8adTcSJq1Q+pb8tP8j8RaOjfbrnZ4NR3hesMGtXobwidLlf04R7UadvEdISDLoBVp
         acVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Sx9QXrg4ZNFSGE92YcBO2jMOLGSWdnZV3pnibrZPh18=;
        b=K/arYlhl8wV2QGe04R4bGMF4Z7vuAfHvngnUCpEXeWddsqd7nzVzCY8KXj4XCPG8IC
         hA5OZnkLNWMJ+2P38A619rtBZHjXmMVlKT1wfbsUE50HW8S5vMfqNUizvNcctZokmXv1
         mHZvR0GxAbGca0qZy2jnMPB1KhItAkCrLsP6mkibqvUm3ePkjO5xN5g67n+AZHdOkgsj
         pHMCjjcqpLtI/dkgoZ12fDY5c3yk8mkc37bjFAHgTBe2vPHX+N+T40LhL2+wLz37rLdU
         Hnt4S6TJSFYqll8yf0kc7dQUOrDLHzgOZJsViWzhdKmx17wbkDVFRfef46LZMqBkyUi4
         HzlA==
X-Gm-Message-State: AOAM530o8q0RDnqRBKWMcByS5b8ezG70ojd1RF5AfdrPG9AeaeckC4Sy
        CSNg6Ld+m1SBKPADqVd5jIG3zA==
X-Google-Smtp-Source: ABdhPJwzsCg4tOXIFL2wAorTekhNfCSV3oJxRI6RVF//Uj3BHQ5IEzgTt52YzmGvSSSOzWlDua+sxA==
X-Received: by 2002:a05:6000:1867:: with SMTP id d7mr8862526wri.393.1627890029108;
        Mon, 02 Aug 2021 00:40:29 -0700 (PDT)
Received: from google.com ([109.180.115.228])
        by smtp.gmail.com with ESMTPSA id o22sm2087782wmq.3.2021.08.02.00.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 00:40:28 -0700 (PDT)
Date:   Mon, 2 Aug 2021 08:40:26 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh@kernel.org>, Icenowy Zheng <icenowy@aosc.io>,
        Samuel Holland <samuel@sholland.org>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ondrej Jirman <megous@megous.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v9 01/11] dt-bindings: mfd: axp20x: Add AXP305 compatible
 (plus optional IRQ)
Message-ID: <YQehakgWk/sp92to@google.com>
References: <20210802003952.19942-1-andre.przywara@arm.com>
 <20210802003952.19942-2-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210802003952.19942-2-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Aug 2021, Andre Przywara wrote:

> The AXP305 PMIC used on many boards with the H616 SoC seems to be fully
> compatible to the AXP805 PMIC, so add the proper chain of compatible
> strings.
> 
> Also at least on one board (Orangepi Zero2) there is no interrupt line
> connected to the CPU, so make the "interrupts" property optional.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/mfd/axp20x.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
