Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50FEA305026
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237107AbhA0DrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:47:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42259 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388493AbhAZXXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 18:23:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611703315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FFsgQkQMHGcNuO7prFnbNLIMkPeBzSiQZrxd3POXfNg=;
        b=Kihxvzlqq1MbbO//yqVeXlI28T68f/yMLOkgQLQGqwxAr3EC59yoyeuZIJ9ki1NeL6VLbk
        Jt72GxB8vjukeVG2vsZFYMp/hZYK+W1K1tKwmbwafkvMCQgb0tR2ZI4vaM8cYi9a2x9fZj
        ZO4KoaXtLKXLUPD2GTa81ZV4ukjrg8Q=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-FULe_4PcNkW4omGXIUXR1Q-1; Tue, 26 Jan 2021 18:21:53 -0500
X-MC-Unique: FULe_4PcNkW4omGXIUXR1Q-1
Received: by mail-qt1-f197.google.com with SMTP id l15so4725091qtp.21
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 15:21:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=FFsgQkQMHGcNuO7prFnbNLIMkPeBzSiQZrxd3POXfNg=;
        b=X+Xl6oDUcpd+jU53fmLSObuMm0YCm3QHxOMfydAufEy5/oto4sLZZNgN7kdOKkzZ6d
         4PNf59lvOszjbVR1iT//XZxXXT1fut1RthY88k/nrWsYP325REMoa9jFr26HG2jbJj1m
         W9x/GJXxLnZt+rWiDGiWMipnbea4C/JzgNsWSzmGLp3YjVEUeE+HiwLyUaXnAjQdGDFm
         oDipbSExO4GmsQrMxUrS9o1X/Z/KSn5/0UMsWBS8qo4SdDWBaFAwpEnZyJxjlccMCmVS
         0ZVTnAml/b9BAbQjn3hZuENQLlWfpUcZGejvQolQxxAHI9BfcukjRU2uRbvIbM5tFWcT
         KltA==
X-Gm-Message-State: AOAM532f0LtmQZ4VVIQ5L3bB70VbeWvibSYVmepQMmHEicT4sWXDCooG
        GZcW65HzYx5EHKY6YbF9ziQnB+GQw4u4gJBxJOQ97yh3nQYwOlezy/BgjFfMXXwnkxsDRzwFfpL
        52ObpiOLXyORAu2wlw4sT+sjX
X-Received: by 2002:a0c:c384:: with SMTP id o4mr8011135qvi.21.1611703313445;
        Tue, 26 Jan 2021 15:21:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyQwxGlyfMcY1NOcyyinpE4uDbuVGu0DgI2XyVdUzWX/kxECSPbaveR0jaQIYaDyMXFFNGuVg==
X-Received: by 2002:a0c:c384:: with SMTP id o4mr8011119qvi.21.1611703313228;
        Tue, 26 Jan 2021 15:21:53 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id c12sm154500qtq.76.2021.01.26.15.21.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 15:21:52 -0800 (PST)
Subject: Re: [PATCH v2 0/3] clk: clk-axiclgen: add support for ZynqMP
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        lars@metafoo.de, linux-fpga@vger.kernel.org, mdf@kernel.org
References: <20210126110826.24221-1-alexandru.ardelean@analog.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <eba46db2-b528-0f6f-7e23-f61fa3e265b2@redhat.com>
Date:   Tue, 26 Jan 2021 15:21:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210126110826.24221-1-alexandru.ardelean@analog.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/26/21 3:08 AM, Alexandru Ardelean wrote:
> Previous set:
>  https://lore.kernel.org/linux-clk/20201221144224.50814-1-alexandru.ardelean@analog.com/
>
> Changelog v1 -> v2:
> * split patch 'clk: axi-clkgen: add support for ZynqMP (UltraScale)'
>   into:
>    - clk: axi-clkgen: remove ARCH dependency in Kconfig
>    - clk: clk-axiclkgen: add ZynqMP PFD and VCO limits
> * essentially removed the 'adi,zynq-axi-clkgen-2.00.a' compat string
> * removed architecture dependency on build for driver; the driver should
>   be usable also on PCIe setups
>
> Alexandru Ardelean (3):
>   clk: axi-clkgen: remove ARCH dependency in Kconfig
>   clk: clk-axiclkgen: add ZynqMP PFD and VCO limits
>   dt-bindings: clock: adi,axi-clkgen: add compatible string for ZynqMP
>     support
>
>  .../devicetree/bindings/clock/adi,axi-clkgen.yaml     |  1 +
>  drivers/clk/Kconfig                                   |  1 -
>  drivers/clk/clk-axi-clkgen.c                          | 11 +++++++++++
>  3 files changed, 12 insertions(+), 1 deletion(-)

This whole set looks fine.

Reviewed-by: Tom Rix <trix@redhat.com>

