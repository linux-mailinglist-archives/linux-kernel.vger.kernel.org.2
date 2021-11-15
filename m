Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBF2451D16
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 01:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234752AbhKPAZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 19:25:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244889AbhKPAVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 19:21:20 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63A9C0337C5;
        Mon, 15 Nov 2021 14:55:10 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id h24so14136500pjq.2;
        Mon, 15 Nov 2021 14:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=h8mwC+d4QFHQpJNSGAlWP8/9bYmJ7cMAeS2IPbzMTgQ=;
        b=Qy4kfsxQQIJ83pPLnGP+x52ZcDGeq0d1/5m+1il30OUK50oo8cjqyHXxsLC7VaBy9g
         qP6VJRvOnToiS5iaeXYDdbOGq4ucbM2k9UQE59leS7eFCzicgKKrw5U0gXrh0eDIy9Tf
         cS8jrIu6KcA2Z7i2Ldsx5eHTjE/X1xAYl3oOQ5GOArzzg/vBFTdm4pSA9c/oOl0GtyCO
         CcVLhNY5+Pcjly47OML5ZDWY5I7MSF6UErJzoyd3xxkh7UToklQd00pmSzcUW8LFWd4C
         M2LUlyFVIgMrieSaF2yWb34zMiB9tI0xAIvOB2YeP5+GXG3yvyjW+UrJQRyHdDNfiK4t
         U4AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h8mwC+d4QFHQpJNSGAlWP8/9bYmJ7cMAeS2IPbzMTgQ=;
        b=JqbgMkRvbgD+pO75zn+30Jj6Xfl/NY4CSYsgPPDwC5R9sIUPrYsk+Q3N5lsf2CuJOY
         VwsTPNSIHh19rkbcVssQZlFHHk1cio38UEpV7Ez2VvHTYB6yfk8qzKfMNoFePMVr739J
         iiGwgxtUm7Zk8aKcktx10fk6SMflfTitBOWim4UuRUYiM4UvvU9q78DxRVgXUK4RsUCe
         Yb5BHvHB5q/87UrtUMogUKKB68ZF0Q6cl6k4vdEuKJXK1M/mV2UGziz9lJ9/2ok+KMPI
         j6zdF2ZTOtab55Ubtq/9gwPlqOiBQ+f7HpDxfXpa6sHQUpvDzajRXa5TZnff1CPYuMRI
         KiWg==
X-Gm-Message-State: AOAM532US/IUmAvCZUhPOjYL+5UY81vEipjXOhQPdj7+F/PCbpQss9Zo
        EXXw+XniqHOFgN2l360Qh/U=
X-Google-Smtp-Source: ABdhPJxiOLMAUa/Qn//xvGZCMUSVTcRvv2iJ2fc4TRb4gxDGAwLuf8bsLmNDQdoktUGSxID+g9hUEw==
X-Received: by 2002:a17:90a:d3c3:: with SMTP id d3mr69609638pjw.209.1637016910276;
        Mon, 15 Nov 2021 14:55:10 -0800 (PST)
Received: from localhost ([103.99.179.247])
        by smtp.gmail.com with ESMTPSA id e15sm15559680pfc.134.2021.11.15.14.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 14:55:09 -0800 (PST)
Date:   Tue, 16 Nov 2021 06:55:05 +0800
From:   Calvin Zhang <calvinzhang.cool@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Calvin Zhang <calvinzhang.cool@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] of: make MAX_RESERVED_REGIONS configurable
Message-ID: <YZLlSd9vPXpQFz5b@debian>
References: <20211115073240.3476043-1-calvinzhang.cool@gmail.com>
 <CAL_JsqLtG4m6hqKc0TJs+e8ZBRZSGgOAoumnvg7u_D46i5D_AA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqLtG4m6hqKc0TJs+e8ZBRZSGgOAoumnvg7u_D46i5D_AA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 08:05:45AM -0600, Rob Herring wrote:
>On Mon, Nov 15, 2021 at 1:33 AM Calvin Zhang <calvinzhang.cool@gmail.com> wrote:
>>
>> MAX_RESERVED_REGIONS has changed several times. Max reserved regions
>> count grows bigger as more SOC subsystems require reserved regions.
>>
>> Add a Kconfig for it so that when properly configured, the static
>> reserved_mem array consumes less memory on systems with few reserved
>> regions.
>
>Please read prior discussions:
>
>https://lore.kernel.org/all/?q=of+MAX_RESERVED_REGIONS
>
>And these 2 in particular:
>
>https://lore.kernel.org/all/CAL_JsqJQcWsguwfehAoaRf4o-2VqXxSzKzTqg7s4+N1bp=6V5Q@mail.gmail.com/
>https://lore.kernel.org/all/CAL_JsqLGvUYQmCGXLgSO+6kFj2i87dpaTbMGbyu5oMt=eeu35A@mail.gmail.com/
>
OK. I will try to make the array dynamic.

Thanks,
Calvin
