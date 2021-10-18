Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 837BE43119A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 09:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbhJRHxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 03:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbhJRHxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 03:53:34 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6456BC06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 00:51:23 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id r18so39626252wrg.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 00:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0eS+nh6u4YxbES6EE1omllVHgreREODM6XTD9kz5628=;
        b=selpIOhusGKyPNN3rjPEBBx6lbHWPLCPgRHAfcssgm3rP9kmIPxHeE5gclDlJY8v/m
         np3RYei65RQqS7O06w2qb4l8/ugUjieJRmXsgXorf+vCqY4TU0Bc7d9TFhp59ABVkJXm
         k9AQWmb3Xdh2mpmXsUdjCi5HvFayv5OOr/fhIVL/IfOMjTd9+U2uciAkXD3vscvkwQkG
         e2asDtqNK/0xEJiseST4lgDs96mtDsKdcl6cysN1sECSUoat79tkUqbK0FxukpktcwZW
         L+1Em47GbUYjP8RDriCx8IkzXC2F4HrHVpKh4kxKDFn+otaYfKXksv3W5v+yE6eMTCN9
         +oXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0eS+nh6u4YxbES6EE1omllVHgreREODM6XTD9kz5628=;
        b=0nkDPNYnHYg5DZaaGtYkRZ+XxII42BXF5qHRXMOhd85nepBKi1R8gQQ+92rSbMBH9G
         LgAzAwV3jt1eHLXOhqghr0h9t22bPfRbRPOrG4ru1KEF9CZyMTDf/zXjWfL9OG4bhhoW
         QAuhirk9+3Qz3CWkSOQ0GA0bSk/8xQ6EwUQO+XTZI8zlDxcEacj1+3nJMD7XqOTm5ctc
         RYYVbj2CmbPg33T5QVdDnjdPWvRfAXHpb0GpvZnkDg1DPam0X3cXRRTh3cxAY3g8cOqo
         UXYi28J9uDbjm+nV7STpJAQVTUJER/xRbSnMFNCaywHZ8K5qZDh7zT/VDWu2hvNwS92D
         FeeQ==
X-Gm-Message-State: AOAM531DPYAXwQJOG9C9ZIGgM9NFw8a00nbOBRKyek8Z3ASpHMJmquWQ
        qTJSlnvw4GWC2rPyXFaz6yVVOQ==
X-Google-Smtp-Source: ABdhPJyxHeAzEcoNz+uJVzN/yN5Zt0oyr+xgVCXOJuoDiA3OC43+Mq83MkT+qWHZoIJL8BOALAB/Ww==
X-Received: by 2002:a5d:62cc:: with SMTP id o12mr33791137wrv.324.1634543481756;
        Mon, 18 Oct 2021 00:51:21 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:b2b3:1133:5bdb:b2f2? ([2a01:e34:ed2f:f020:b2b3:1133:5bdb:b2f2])
        by smtp.googlemail.com with ESMTPSA id y5sm11448182wrq.85.2021.10.18.00.51.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 00:51:21 -0700 (PDT)
Subject: Re: [PATCH v3 00/17] clocksource/arm_arch_timer: Add basic ARMv8.6
 support
To:     Marc Zyngier <maz@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Shier <pshier@google.com>,
        Raghavendra Rao Ananta <rananta@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Oliver Upton <oupton@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel-team@android.com
References: <20211010114306.2910453-1-maz@kernel.org>
 <20211011110243.GB4068@willie-the-truck> <87mtnfptni.wl-maz@kernel.org>
 <2cf7b564-63c2-ac6c-a083-f7ac2caab6fc@linaro.org>
 <877decotwi.wl-maz@kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <d0c55386-2f7f-a940-45bb-d80ae5e0f378@linaro.org>
Date:   Mon, 18 Oct 2021 09:51:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <877decotwi.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/10/2021 11:57, Marc Zyngier wrote:
> Hi Daniel,
> 
> On Sat, 16 Oct 2021 22:59:33 +0100,
> Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>>
>> Hi Marc,
>>
>>
>> On 11/10/2021 15:39, Marc Zyngier wrote:
>>
>> [ ... ]
>>
>>> Thanks for that. All addressed now. I'll repost the series once we've
>>> addressed the question below.
>>>
>>>> How do you want to merge this series? It would be nice to have the arch
>>>> bits in the arm64 tree, if possible, as we'll be tripping over the cpucaps
>>>> stuff otherwise.
>>>
>>> I think we should keep the series together, as asm/arch_timer.h gets a
>>> beating all over the place, and there is no chance the arm64 bits at
>>> the end can apply (let alone work) on their own.
>>>
>>> So either Daniel would ack the series for it to go via arm64, or
>>> create a stable branch with the first 13 patches that would go in both
>>> the clocksource and arm64 trees.
>>>
>>> Daniel, any preference?
>>
>> yes, I prefer a stable branch for this series.
>>
>> https://git.linaro.org/people/daniel.lezcano/linux.git/log/?h=timers/drivers/armv8.6_arch_timer
>>
> 
> OK, this branch is now slightly outdated, since I have reworked it at
> Will's request. -rc5 is also too recent a base for arm64, which is
> usually based on -rc3.
> 
> I'll repost a new series today or tomorrow and provide tags for both
> you and Will to pull from.

Ok, thanks. I've updated the branch accordingly.

Let me know if everything is fine, so I can prepare a PR for the 'tip' tree.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
