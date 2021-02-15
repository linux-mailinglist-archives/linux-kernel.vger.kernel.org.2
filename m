Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD61731C068
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 18:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbhBORXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 12:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232684AbhBOQUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 11:20:35 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F28DC061D7F;
        Mon, 15 Feb 2021 08:15:09 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id k204so8264542oih.3;
        Mon, 15 Feb 2021 08:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MYl5MHCuKdaxafcITDi8WG7AF2FO0FFBQDvNyVshv9k=;
        b=iEAl/WQbHmLE+2j/mBTd6C3do9U8jiebFuVfQgwkXA/ftnbF5+DmAAtzWkod1c8RFk
         LT9mAyH70OvrqvKA4+lvrCr7zm0Y2L6irH2p1H3QuMnp6xhqNNBx1rrA/Vr2NP2nRuFy
         WgR77LLQKAxt9qt9mqM9CXnt3iXFZM1aZo4LuJi68rPHi2GeUlkBbWJ87xKTV9H6kIEq
         8Ei1zvgamm98hzJXpMBV51miqpdglIVtNiCE7sCgxqgEppwHK85gwTa3Px/dIuk0zziY
         KvMR3FyrjaoIevpYtg3rlR+dGAMwM0q++fyEQ8LUmL8Mq0zpX4Hm4V8WYl9eVAjv0LVp
         iD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=MYl5MHCuKdaxafcITDi8WG7AF2FO0FFBQDvNyVshv9k=;
        b=SV5RN1sf18N6tpNdI1+utHpdMAV+DwaWGc94Fhn6G63v78HobWZFrqC5zuVs9IYACC
         7t/+OK4RumB9ZR3roO8cwjsp1DmBrLkCiwqWC6gkRXDX7cvEoCARrRwhzotx+ZyGcVIc
         8gK1cIEar2V5uopmpotbHGOAlYYWzc4ar79Zt54SEklNc+ds4PxUE6vIPqbdzrHUbtP4
         aSFrTV5HK/8EWMI9G0O2Z6bmzXG4sgGXHBrNwjene9Uk9iBrBcbU0owt7iVoadoPlwa3
         Ni88fSKoBWYMPDz7qVhVdK+oMFF44alaItbB40mpweoowxXOnp9RI2IAjxSTzIQNGssz
         W3wg==
X-Gm-Message-State: AOAM530QYB/hac1SUsYEvhK1WKe41QKyE9Zi2gnmBcQ19ky4fDlfgXPm
        XDjd6wK4HXD8Ga0CXhuAxTSDUyPKP/o=
X-Google-Smtp-Source: ABdhPJyBTYHx+n2JRxZGMxTuzwaaoqRQhFJ5BlG7IpXyHG0oOvfJlFPowdFa6gVI0bimxzz035Mpnw==
X-Received: by 2002:aca:1708:: with SMTP id j8mr8776530oii.29.1613405708921;
        Mon, 15 Feb 2021 08:15:08 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a28sm3437281ook.24.2021.02.15.08.15.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Feb 2021 08:15:08 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] scripts/dtc: Update to upstream version
 v1.6.0-51-g183df9e9c2b9
To:     Michal Simek <michal.simek@xilinx.com>,
        Rob Herring <robh@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
References: <20210212033120.GA100407@roeck-us.net>
 <CAL_JsqLm3mHdPg4wkdhoFXNY1JgTJ56dxi3oLqBS_NBrX=rOfw@mail.gmail.com>
 <20210212151725.GA57042@roeck-us.net>
 <CAL_Jsq+e+KdzanMdHYCEoGZn3ybY5_ASN60qiqbOkPWpkbQ6NQ@mail.gmail.com>
 <CAL_JsqL4suDinALfp4v96arJXpWts8pergO1-aenLv+RN9S64Q@mail.gmail.com>
 <20210212225049.GC115630@roeck-us.net>
 <85d6deea-abd9-f7aa-8eb7-9067f6376d49@xilinx.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <06560f35-af85-5a75-80f5-9b2d44feec39@roeck-us.net>
Date:   Mon, 15 Feb 2021 08:15:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <85d6deea-abd9-f7aa-8eb7-9067f6376d49@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/21 7:23 AM, Michal Simek wrote:
[ ... ]

> 
>> I think the problem is here:
>>
>> /* initialize device tree for usage in early_printk */
>>         early_init_devtree(_fdt_start);
>>
>> That probably also explains why enabling earlycon doesn't help.
> 
> Can you please elaborate more on it?
> I see earlycon to be enabled quite early.
> 
> [    0.000000] Ramdisk addr 0x00000000,
> [    0.000000] Compiled-in FDT at (ptrval)

Unless I was missing something, this is where it failed.

> [    0.000000] earlycon: ns16550a0 at MMIO 0x44a01000 (options '115200n8')
> [    0.000000] printk: bootconsole [ns16550a0] enabled
> [    0.000000] cma: Reserved 16 MiB at 0xaec00000
> 
[ ... ]

> 
> Please send the patch. Would be the best as early as possible and I will
> queue it for 5.12.
> 
https://lore.kernel.org/patchwork/patch/1380316/

Guenter
