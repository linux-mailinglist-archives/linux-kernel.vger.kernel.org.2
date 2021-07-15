Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 763953CA782
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 20:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239128AbhGOSzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 14:55:11 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:34986
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239370AbhGOSum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 14:50:42 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id 411BD408B3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 18:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1626374866;
        bh=BDtq/bE7D6tv68aPIsRH6XGY2g0R3D1k7jrQYW796Vc=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=GBFPyJ8q22AhW7avRDSOKvzo4Ax6cDrIvi7gIFLhijzfDrhDh6wxBHEl1FTjutP6e
         29WFgxEsCvxuDQLZf39M3Eo3mBa3fcURwVG+z6ExpAfBqFWyYPeXQOUgpYgUTPTgaI
         g+H8AJL019KOI987A7OOKJa7m2ZtuMhQ5woDHMELCKgt7aPJ11H8bwB5c/kmlOLlsi
         cGh5cF6M4Boag54NeuNOfm5q0/w42V624nSpj1NbOJJ7NVOm0YyNtwT2h0MN3uC7rC
         d3qA6GT/pzOT+WsTs2hsLYR31I2ISOEUmbe5yLi+oIyNPNcemEi3eySUgsuUfs7oqx
         HI8QJe0L2iMsw==
Received: by mail-ed1-f69.google.com with SMTP id v4-20020a50a4440000b02903ab1f22e1dcso3604122edb.23
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 11:47:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BDtq/bE7D6tv68aPIsRH6XGY2g0R3D1k7jrQYW796Vc=;
        b=uOam4K0+HaNOE07XJE6FtD5MA6+HnHVwpZpjj19PUm9sppaNPI4LXyCuYTOAsOO9Vw
         mrTvcCvQdjYgQ/9QlJLa2ZahJks0usPwzxx69CprJiDuz1uklilocI1GrlDEUo3kzQT3
         5xY3juPA9abVhBVsklaQqFLi5fD3CoUsvaweRjVuvqQjyXKqdrG2Q09HeiOuBnw62JjT
         k3nCYsE0h42yjBl2NdO/7s688YvbrUk/e/Robu/anVZiIXLUNzUP+yOKxgkS3makGafY
         x2qgWT3QMg63/++ogBP9qSwyP1yLbu/EFlavUOzBG3CB/o5paxJHRun9tFudNnnLUNyA
         GQuA==
X-Gm-Message-State: AOAM530r9KITvvyR3rhjokKVhDFGK4rWmg5I3BSo6KvUCeaPN0M70xMN
        vEkYGespe8tq286N6ubRRUpxKjzeXf8LZQczDljXkcqDjiE88ehoJ/UbdmTAbFc4AtdO7g4oXez
        B6CHdveSTcvaWolIs3Jac/Qq6gDoBaXNWhyibH+fd9w==
X-Received: by 2002:a17:906:b796:: with SMTP id dt22mr7124049ejb.448.1626374866022;
        Thu, 15 Jul 2021 11:47:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx6J9EsYOyF8uIEK6SstxMZ6C01PfUQPWo5oEFXjzSzIcfkZKr2Xrv4CwXrwXHXu2ltkmRjLw==
X-Received: by 2002:a17:906:b796:: with SMTP id dt22mr7124035ejb.448.1626374865850;
        Thu, 15 Jul 2021 11:47:45 -0700 (PDT)
Received: from [192.168.3.211] (xdsl-188-155-177-222.adslplus.ch. [188.155.177.222])
        by smtp.gmail.com with ESMTPSA id v13sm2110746ejh.62.2021.07.15.11.47.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 11:47:45 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] arm64: dts: exynos7: Add cpu cache information
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org
Cc:     linux-samsung-soc@vger.kernel.org
References: <CGME20210622130203epcas5p48a3111fc6586b1bfe0bd3cb90f783ce0@epcas5p4.samsung.com>
 <20210622130551.67446-1-alim.akhtar@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <8d18cafc-6d88-bef5-075d-b5436f0c5862@canonical.com>
Date:   Thu, 15 Jul 2021 20:47:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210622130551.67446-1-alim.akhtar@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/06/2021 15:05, Alim Akhtar wrote:
> This patch adds cpu caches information to its dt
> nodes so that the same is available to userspace
> via sysfs.
> This SoC has 48/32 KB I/D cache for each cores
> and 2MB of L2 cache.
> 
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---
> Changes since v1:
> * no change in this patch
> * changes as per Krzysztof's review comments in patch 2/2
> 
>  arch/arm64/boot/dts/exynos/exynos7.dtsi | 35 +++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 

Thanks applied with fixes:
1. Title prefix as exynos,
2. Proper wrapping length of commit message (please use wrapping as in
coding style),
3. "This patch" -> imperative mode as in coding style.


Best regards,
Krzysztof
