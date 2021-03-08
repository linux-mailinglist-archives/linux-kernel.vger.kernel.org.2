Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5DB9331812
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 21:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbhCHUDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 15:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbhCHUCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 15:02:32 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A341C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 12:02:32 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id t1so16595596eds.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 12:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3t+/FGTFmIQyffd5lnhNae0bF0FU3qV628NjTAJ6fqE=;
        b=gfrGxsctj7ZgdCnjBxZzvzOU616fh/vzNa6UCLMa0GN0zjbz5QSFtF6qTKVMimAaoI
         QhKxVI51bWGOap7MLvgcUlqAIi4le1i+TDXZDDSs1NALQfBw6biPjSEzE79xNFPda7fe
         IQYUh3fImXPDcH/e/yq2x1VfZ0L0zDngwciu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3t+/FGTFmIQyffd5lnhNae0bF0FU3qV628NjTAJ6fqE=;
        b=HjU2X9EG9fNQt2HW9DpMgUnLGr0eUTWOMeTIMxOAwz8mOTrtug/Cx1VLeqX4/Xz7Ks
         Az8aaQ+o6Dd6aomjCRqoJy6UeayQaahj6OQvc59/eQrwRouiyb1NrQdxTlJuD3nuxC+U
         Kc8yUepZqdZAjoduf+YAy7dJxUbyRbYFU2mPviSunqXBwN8flFEvqWljL8n8FYU+ty5Z
         6J0Gd6An9QXIck2isgtviy3Ysia1Jvp/4jdmtmLGisMN/uIgzrGj/pyfDI4UwfAWfeKv
         YwJLqA8w70ho8dlpw5XjDpml0GWhRhrTuGP32fIqS5gy4sARbgZoDvPCWu6S/sJDlSeE
         hq2Q==
X-Gm-Message-State: AOAM531vPZ7ZKn0VqwkhL63Lw3Xsje1SYImirhshp7Uvq219m7KQGUVx
        Um4QgH9m62G+X+jCrt6DGRQVRdAeQCq3Owv9
X-Google-Smtp-Source: ABdhPJz/N2WXkp/XWbteDUOpmfs9kTJ7J7qctEPtW6OeYiZrs1L3DFi1SC7Cg9aRy5AoqQKH3np2jA==
X-Received: by 2002:a05:6402:b2d:: with SMTP id bo13mr292159edb.120.1615233751171;
        Mon, 08 Mar 2021 12:02:31 -0800 (PST)
Received: from [192.168.1.149] ([80.208.71.141])
        by smtp.gmail.com with ESMTPSA id jj16sm7158657ejc.19.2021.03.08.12.02.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Mar 2021 12:02:30 -0800 (PST)
Subject: Re: [PATCH 1/2] dt-bindings: misc: add binding for generic ripple
 counter
To:     Rob Herring <robh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, linux-clk@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
References: <20210226141411.2517368-1-linux@rasmusvillemoes.dk>
 <20210226141411.2517368-2-linux@rasmusvillemoes.dk>
 <20210308172153.GA2505339@robh.at.kernel.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <12be138b-631a-4f82-aae9-6bbdc7bc2bcf@rasmusvillemoes.dk>
Date:   Mon, 8 Mar 2021 21:02:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210308172153.GA2505339@robh.at.kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2021 18.21, Rob Herring wrote:
> On Fri, Feb 26, 2021 at 03:14:10PM +0100, Rasmus Villemoes wrote:
>> While a ripple counter can not usually be interfaced with (directly)
>> from software, it may still be a crucial component in a board
>> layout. To prevent its input clock from being disabled by the clock
>> core because it apparently has no consumer, one needs to be able to
>> represent that consumer in DT.
> 
> I'm okay with this as it is describing h/w, but we already 
> 'protected-clocks' property which should work.

Hm. Unless
https://lore.kernel.org/lkml/20200903040015.5627-2-samuel@sholland.org/
gets merged, I don't see how this would work out-of-the-box.

Note that I sent a completely different v2, which made the gpio-wdt the
clock consumer based on feedback from Guenter and Arnd, but that v2
isn't suitable for our case because it post-poned handling of the
watchdog till after i2c is ready, which is too late. Somewhat similar to
https://lore.kernel.org/lkml/20210222171247.97609-2-sebastian.reichel@collabora.com/
it seems.

>> +
>> +Required properties:
>> +- compatible: Must be "linux,ripple-ctr".
> 
> Nothing linux specific about this.

True, but I was following the lead of the existing gpio-wdt binding. Is
there some other "vendor" name one can and should use for completely
generic and simple components like these? "generic"?

Rasmus
