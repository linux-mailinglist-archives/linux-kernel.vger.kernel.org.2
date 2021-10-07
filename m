Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A271E424BDD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 04:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbhJGCsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 22:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbhJGCsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 22:48:15 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB18C061746;
        Wed,  6 Oct 2021 19:46:22 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id p1so4035851pfh.8;
        Wed, 06 Oct 2021 19:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=IpVh1IYfpzKfR6GkSU+3lboEb+0mbcf/l+spamR+b4w=;
        b=qUqtdUagXGAHjJ02iK3EMfeQQVQwbLTfNID8omD0ZiAPu6CSf3U3Hub+uP53ewURUY
         HShMwL8OiIp1x1Z/xPUraEDuIWFQi4OIqZi6hXbo6pbXXrlpohC3u2r/tM1f7h2wavk4
         tj33wD82910933jV6FPkEiv0xW8psa2+sKnso4MtRvBFTvOqx7eDFLxDAKasxS025rQC
         UNZt5jEiU/XUnLiIkebPOE7rLHZK3BOogYPCBEUrB5yxk5K+8u8ArXY72L9+y8H3vgRI
         SjxdRwBT5ON7qIvRxaFOUfbpeoiXaI8aMH3qUGUCSPYrqZRDDWLN5vhxzgW3/lm2odmA
         CgRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IpVh1IYfpzKfR6GkSU+3lboEb+0mbcf/l+spamR+b4w=;
        b=kfoQjQjK8DA7IGY9nA7o78EY6oipkJD/XvvxEnVXzKkZr3prvUYHbBR9Q5SK5gxa1Z
         zIqkgSg5FksTSX3NxjEmvvRVy5LhQ7kZ638/DkaG/ZAznupbSpUypBhnRqjYI3umpL7u
         7xbuAfInd5CwTtIlbU8nQw42t6LsRwohDL1hJoMaXOevkgTSwlrTjTvVrg2m0M7e+BET
         +bSoeuCKz5WIOM/ZYmH9Nw/+M8d5ZeTe7Cy4C8+7ADrg2z9PLwkmPThIqlF/Dq+ok/7Y
         72igykPo0w3fsmo3BPPcnlhktH52T/QWKKQ/6vVjkbub7bi+SWGKS0y020EPocOpRbAt
         Zbtw==
X-Gm-Message-State: AOAM530duHzJNZ5hxn7mPvFuXe7lQoEY5EIh+hKGRhSzCd80o454c4Fh
        /o7N7n/6v7D1MKB5bYCcILc=
X-Google-Smtp-Source: ABdhPJwl5RGXpQauISnEDl9qOpBhvRuE7gS6xNbt6Ro1NKjU7GGs7xBeC94oFMrkiB25zWuCItbO/A==
X-Received: by 2002:aa7:8439:0:b0:44c:80da:fc39 with SMTP id q25-20020aa78439000000b0044c80dafc39mr1806612pfn.47.1633574781962;
        Wed, 06 Oct 2021 19:46:21 -0700 (PDT)
Received: from [192.168.1.121] (99-44-17-11.lightspeed.irvnca.sbcglobal.net. [99.44.17.11])
        by smtp.gmail.com with ESMTPSA id t6sm22435915pfh.63.2021.10.06.19.46.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Oct 2021 19:46:21 -0700 (PDT)
Message-ID: <99b43bbf-b63e-d684-dd61-3087e9f22dc4@gmail.com>
Date:   Wed, 6 Oct 2021 19:46:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH 0/9] Dynamic DT device nodes
Content-Language: en-US
To:     Zev Weiss <zev@bewilderbeest.net>, openbmc@lists.ozlabs.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Joel Stanley <joel@jms.id.au>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Andrew Jeffery <andrew@aj.id.au>,
        Frank Rowand <frowand.list@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Kees Cook <keescook@chromium.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Daniel Axtens <dja@axtens.net>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org
References: <20211007000954.30621-1-zev@bewilderbeest.net>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20211007000954.30621-1-zev@bewilderbeest.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/6/2021 5:09 PM, Zev Weiss wrote:
> Hello,
> 
> This patch series is in some ways kind of a v2 for the "Dynamic
> aspeed-smc flash chips via 'reserved' DT status" series I posted
> previously [0], but takes a fairly different approach suggested by Rob
> Herring [1] and doesn't actually touch the aspeed-smc driver or
> anything in the MTD subsystem, so I haven't marked it as such.
> 
> To recap a bit of the context from that series, in OpenBMC there's a
> need for certain devices (described by device-tree nodes) to be able
> to be attached and detached at runtime (for example the SPI flash for
> the host's firmware, which is shared between the BMC and the host but
> can only be accessed by one or the other at a time).  To provide that
> ability, this series adds support for a new common device-tree
> property, a boolean "dynamic" that indicates that the device may come
> and go at runtime.  When present on a node, the sysfs file for that
> node's "status" property is made writable, allowing userspace to do
> things like:
> 
>    $ echo okay > /sys/firmware/devicetree/.../status
>    $ echo reserved > /sys/firmware/devicetree/.../status
> 
> to activate and deactivate a dynamic device.

This is a completely drive by comment here, but cannot you already 
achieve what you want today by making the SPI-NOR to be loaded as a 
module, probe it when you need it from the BMC, and unbind or rmmod the 
drive when you need it on the server/host attached to the BMC?

Looking at [0] there appears to be enough signaling visible by the BMC's 
user-space that it ought to be possible?

Assuming that there may be multiple flash chips and you somehow need to 
access one in order to complete the BMC device boot, but not the other 
one(s), you could imagine unbinding the spi-nor driver from the ones you 
don't want to drive and wait until you have appropriate signaling made 
available to your or is there a risk of racing with the host in doing so?
-- 
Florian
