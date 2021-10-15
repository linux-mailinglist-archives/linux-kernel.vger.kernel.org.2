Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C122F42EBF6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 10:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236902AbhJOIYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 04:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235291AbhJOIYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 04:24:32 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158C9C06176F
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 01:20:14 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id p16so38576503lfa.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 01:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=Yb3HRm3oltP3XN7Taes5SxDk4wxAVFugt/p8AK8wgzs=;
        b=K+UoKmUZl3LD1tzbci1tODI/iS9OAxFRbSNNe1HnFh9chxf9M1Ow63WxXxe4Pa6+Hd
         mD4QVe/+ovtWZQDe4avouXINgZ3VsgE1mjaIiyrdmRH7qRyTgIUf7jv9rM39Bp+aS9z7
         52P+804g9Etn/0cBHNctewEyQm9lKrnXbWdi4Wv0UMywCp+M2buTx2G8gRDqaMeRnB1b
         GUy5pamHAkroDnRI6eVVU7dH6drYX2s2SaoVr6rEb/uC+st7OeKwoJUX30H8TWRS+cts
         Lm41/UhVs/SwxpXjLM92RZPBxZjLtf5kr5y8WxOigw9XXR8u+OMhy4o51sJwJ4/ka2Bs
         Jkeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Yb3HRm3oltP3XN7Taes5SxDk4wxAVFugt/p8AK8wgzs=;
        b=4pdbMMF7RA7X1yD4B9xz+Y43/OjElDcxJJON36XHxt/FRy7/1wUB96Is9IQ3LcFIEM
         WzT8gWk5Yy/6HnW9W87O6t2/4kkSihCQDWnCRtZXfYoKcxDNC/UqQ0enyZLc0usP8q/D
         C6HuJt+DKT/9xCAR0En5AS5knmVAeGkCalk85HCcQWu43R/jrepx6JyfMZN89FbNUH7N
         5pxvH42aKBrtE2lDrp/1ZhbJUm0Wg5piTRqk5ffRCT4oiHLLdnBRzw2mRZxxM9zqp1k3
         EA19ye5KKrlqnt0cRuYGIm7qagD9e6bPSq+YRxS/00XOiM2zO44EdBY76WIfXSfeRggu
         6j7w==
X-Gm-Message-State: AOAM5320P/743CWBCKHqPm2J6SXvRJcy9iNS0glVzI2dUgSOAzpRw0S7
        Z5iKF7EOj97+WNzyxW3VCCo=
X-Google-Smtp-Source: ABdhPJx+MvNfzbsbRhDUhkBZZhohsDMc1q4txWILKVW5xKXb6c/kvA9oZJmVbGvNCKbyrvVcUFY7TA==
X-Received: by 2002:a05:651c:24b:: with SMTP id x11mr11237016ljn.272.1634286012430;
        Fri, 15 Oct 2021 01:20:12 -0700 (PDT)
Received: from [192.168.26.149] (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id s17sm479927lfe.10.2021.10.15.01.20.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Oct 2021 01:20:11 -0700 (PDT)
Message-ID: <c28ba2f5-cfd7-aef4-526d-bf0679298b5d@gmail.com>
Date:   Fri, 15 Oct 2021 10:20:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:94.0) Gecko/20100101
 Thunderbird/94.0
Subject: Re: nvmem: Defining cells on mtd created by mtdparts
To:     Sven Eckelmann <sven@narfation.org>,
        openwrt-devel@lists.openwrt.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Michael Walle <michael@walle.cc>,
        Adrian Schmutzler <dev@schmutzler.it>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-mtd@lists.infradead.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel@vger.kernel.org
References: <18728084.NGlc0Rocea@sven-desktop>
 <14722734.oMan5NXi5u@sven-desktop>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <14722734.oMan5NXi5u@sven-desktop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.10.2021 09:06, Sven Eckelmann wrote:
> On Sunday, 10 October 2021 14:53:13 CEST Sven Eckelmann wrote:
> [...]
>> Since there are most likely more devices out there which use mtdparts, I would
>> guess that there might already be a strategy out there which can be used to
>> define the nvmem-provider for mtdparts defined partitions. At least I saw that
>> Bartosz Golaszewski added all the mtd devices automatically as nvmem provider
>> in c4dfa25ab307 ("mtd: add support for reading MTD devices via the nvmem
>> API"). So there might also be something for nvmem-cells to find the correct
>> mtd instead of relying on the fixed-partitions registration + of_node (which
>> doesn't exist because it comes from mtdparts and not devicetree).
> 
> Ansuel Smith just proposed in OpenWrt [1] a workaround. It basically adds a
> minimal fixed-partitions parser to the mtd cmdlinepart parser (responsible for
> the mtdparts=) that tries to find the matching (size + offset) fixed-partition
> from the devicetree. The code in mtd_device_parse_register
> (add_mtd_partitions -> add_mtd_device -> mtd_nvmem_add) will then
> automatically take care of the rest.

I like the idea of connecting cmdline specified partitions (mtdparts=)
with DT. That will help devices that use DT at least.

One thing I'm not sure about is criteria. Ansuel in his patch
[PATCH] drivers: mtd: parsers: add nvmem support to cmdlinepart
https://gist.github.com/Ansuel/35abba1f5663ea3d9bd8eded01e8d95b
requires a matching name, offset & size.

I guess above may work for partitions that stay static like a
bootloader. What if someone wants to describe more dynamic partition
(firmware?). Should we reduce criteria to allow matching just by a
name?
