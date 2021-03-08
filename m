Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47889330F3C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 14:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbhCHNc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 08:32:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbhCHNcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 08:32:18 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42895C06174A;
        Mon,  8 Mar 2021 05:32:18 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id 2so16088537ljr.5;
        Mon, 08 Mar 2021 05:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Eep1QcznjPuYsexkb4E/ZfaTf97lrmmqC3yW5OUegjs=;
        b=B/1bmCGRRuXpC7NVzINvwDzAHg6sA1EMBkFPT7WvGyiqa+mVp833/AI2mt2mMVvE1r
         +xHxG+jrJiBiJIgKz7XcYLlUEtql21p9EFVk3jI2ZBO9mJaZDTBsLGKQbzWa7Alpp5dx
         QaeaQmKryyHF0JtOd2QTxfBUWFPlIxyH/1h4gnG6U8H3Mue/MrIFlB23ihn0TNZ/10lr
         SUqPnTUgH3e/iE/pa3wBbISmNE9PpsqZ7X1EefLH9pOuOh06EePyOYevCnMbqTA0LsSL
         avel9J8MwYfMLpzUWuuu4jVHRKnwDnD0KSzShHXsfF+LjNvvEKhub+Vo4x9owjsXcIPU
         u8MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Eep1QcznjPuYsexkb4E/ZfaTf97lrmmqC3yW5OUegjs=;
        b=uUCZkTfIqdXt/vO8Lth4v9SOHQ+jJaWwLqp3DOCFEHibEYz9f1KXu/dQB5oHhJvKse
         QDLE8t3VERt7Dh9Fi5uh3LlyUnImUc20RVMAFNLdYr5Sf7Pk9Y2PNPMmsx+JY0fdHogy
         FUUnBYPhaip5bQnE8wH1OFUXJbD1qHUPgKiSy+IRtrWD/8uIfRfaILFSrot8Xc/rXBCI
         zp/fmcaPIX0lI62XDqutptd3VgsU+SEV1T586y0+rYErXnwrzTdo80lkqwSh7dUeDz+x
         JhW3ieJYoa3nnPQpw1P6BFMyCOW0T9Zx+y2x+dNo+zJyJPSYPnEeDrm8of8/omx7A/vc
         MVOQ==
X-Gm-Message-State: AOAM533lHFaQGITV+Rc3tUCFCS9623lTlISiamjl0MuXjVGNfKSUskXs
        J0n+BDeDQkkQsmW/xYJHgSE=
X-Google-Smtp-Source: ABdhPJzScDlDq/qIK+QD1GR7aQMtVguQKejzQ1InCUAPUJ0aH0u6GnQJBEb0iN9THzJ0dmsdgfqZQg==
X-Received: by 2002:a2e:8e78:: with SMTP id t24mr14312383ljk.161.1615210336796;
        Mon, 08 Mar 2021 05:32:16 -0800 (PST)
Received: from localhost.localdomain (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id i22sm1499138ljg.37.2021.03.08.05.32.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Mar 2021 05:32:16 -0800 (PST)
Subject: Re: [PATCH v2 3/3] dt-bindings: mtd: Document use of nvmem-partitions
 compatible
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Richard Weinberger <richard@nod.at>, devicetree@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
References: <20210216212638.28382-1-ansuelsmth@gmail.com>
 <20210216212638.28382-4-ansuelsmth@gmail.com>
 <ee596471-db9b-43e4-c085-9bd938101587@gmail.com>
 <YEUHsoC4V+H6PCHL@Ansuel-xps.localdomain>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Message-ID: <6e1ef2eb-adb4-4341-f671-0d21fadda3e9@gmail.com>
Date:   Mon, 8 Mar 2021 14:32:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YEUHsoC4V+H6PCHL@Ansuel-xps.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.03.2021 18:04, Ansuel Smith wrote:
> On Mon, Mar 08, 2021 at 10:48:32AM +0100, Rafał Miłecki wrote:
>> On 16.02.2021 22:26, Ansuel Smith wrote:
>>> Document nvmem-partitions compatible used to treat mtd partitions as a
>>> nvmem provider.
>>
>> I'm just wondering if "nvmem-partitions" is accurate enough. Partitions
>> bit sounds a bit ambiguous in the mtd context.
>>
>> What do you think about "mtd-nvmem-cells" or just "nvmem-cells"?
> 
> I read somewhere that mtd is not so standard so "nvmem-cells" should be the
> right compatible.
> To sum up, with v2 I should change the compatible name and just push the
> 2 and 3 patch. (waiting your fix to be accepted) Correct?

I'm also quite sure you're fine to send V2 now, if you just let
maintainers know (e.g. in a comment below a --- tear line) that it
depends on the:
[PATCH] mtd: parsers: ofpart: limit parsing of deprecated DT syntax

In other words: you don't need to wait for my patch to get accepted.
