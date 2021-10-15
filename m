Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B65542FBD3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 21:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242660AbhJOTQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 15:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233027AbhJOTQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 15:16:54 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7211CC061570;
        Fri, 15 Oct 2021 12:14:47 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id e12so28152829wra.4;
        Fri, 15 Oct 2021 12:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Ipq9+EXyzEcuYpTRY9Y+kbIGH9VBg09BZhdAzkrItDs=;
        b=BaMsZ0P8JjX8c/KxJ4EEt776Nycim34n7F/GGvMD4m/eFCMqRR9Dmh8m14t4LfOCpT
         2QH3cv3BIXptAbJCDpKNwxqCL1dc/Qctd9kU8fI2OL8jONdzFOBOOauUCq/t+ELn11Y0
         DHNB1bTA2KgImdvTNZBjh8e/kUETMexHz8MjF2hAUuPNgfNgeRLHjzRC4hRbzqHjFekp
         NOfjm+4WYJtqylL4fPUHLdusRx87sbkOvJhDoHsT6eRr6CO5XHGF2OTScSaxiRWEICCu
         Yj3Cx8b1NotgDAyQFcMvYqAX+YQ9jN0u7hKtRlat3JpxqgnZYdXTaQ0RmpVtWK3BQcXF
         0aSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Ipq9+EXyzEcuYpTRY9Y+kbIGH9VBg09BZhdAzkrItDs=;
        b=dtknBXULTABM2Br1sWkJOaH0FAKZi9gUAzTFBotrd8ageY7UQhbVuo6nDAmBO1/Hk+
         Wd7uKnDrPtByfcXGyW3ifZ2MPQbBgCylYQVEh4NJaie+xT+WRyUGmrrWSrRygMqzVc+5
         5ICuG5TlgcbjHfueopb3HXwo/bACRT0vrBQ/EfB7XaryZuc2Wpvq5Ht6wYeu2wTOdBZg
         QOoo2Oiv8Wuk4Vk4oOaJVVusjrbyKjr2neRD+DQ3QHpbWzjdmEW3OGPSGV4ptG06C3rc
         iJHcFlH+fmnWzWyFmJs0r2KMvLMnYXC7BQZMqmLhIm3VG7WYBo5jbtzov+vcCrafee6m
         O6Xw==
X-Gm-Message-State: AOAM533CnSc6W1EXynbQngAtgB5R3wGJOngcZZ2g9vGE8Pyv7Cqm1F9Z
        aWRl69EshKoUL/U5z4tMrg==
X-Google-Smtp-Source: ABdhPJzlSx3ML0KPYsDAoukcZigA6bbc8nXm4srhmSlX/Q2c7HlWx2kZykU6xA2UUQiOP5CXvcJ3Jg==
X-Received: by 2002:a5d:598a:: with SMTP id n10mr16579781wri.81.1634325286039;
        Fri, 15 Oct 2021 12:14:46 -0700 (PDT)
Received: from [192.168.200.23] (ip5b435a69.dynamic.kabel-deutschland.de. [91.67.90.105])
        by smtp.gmail.com with ESMTPSA id b19sm11512430wmj.9.2021.10.15.12.14.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Oct 2021 12:14:45 -0700 (PDT)
Subject: Re: [PATCH v1 1/6] clk: divider: Implement and wire up
 .determine_rate by default
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-clk@vger.kernel.org, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
References: <20210702225145.2643303-1-martin.blumenstingl@googlemail.com>
 <20210702225145.2643303-2-martin.blumenstingl@googlemail.com>
 <4eb964ac-4fff-b59d-2660-2f84d8af5901@gmail.com>
 <CAFBinCAVtd8gmcuvGU79-85CqhSU8a3mBCa_jweeZBd59u+amQ@mail.gmail.com>
 <CAFBinCAT-FxcHpt=NCt4g-OfzEUhvxh8TNRcY2hb5kdxna0Uyw@mail.gmail.com>
From:   Alex Bee <knaerzche@gmail.com>
Message-ID: <67995168-e0fc-0916-7c34-3efedf4bad00@gmail.com>
Date:   Fri, 15 Oct 2021 21:14:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAFBinCAT-FxcHpt=NCt4g-OfzEUhvxh8TNRcY2hb5kdxna0Uyw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Am 14.10.21 um 23:34 schrieb Martin Blumenstingl:
> On Thu, Oct 14, 2021 at 2:11 PM Martin Blumenstingl
> <martin.blumenstingl@googlemail.com> wrote:
> [...]
>>> Reverting this commit makes it work again: Unless there is a quick and
>>> obvious fix for that, I guess this should be done for 5.15 - even if the
>>> real issue is somewhere else.
>> Reverting this patch is fine from the Amlogic SoC point of view.
>> The main goal was to clean up / improve the CCF code.
>> Nothing (that I am aware of) is going to break in Amlogic land if we
>> revert this.
> Unfortunately only now I realized that reverting this patch would also
> require reverting the other five patches in this series (since they
> depend on this one).
Indeed, that whole series would need have to reverted, which is clear 
(to me) when looking at the patches.
> For this reason I propose changing the order of the checks in
> clk-composite.c - see the attached patch (which I can send as a proper
> one once agreed that this is the way to go forward)

Yes, your patch papers over the actual issue (no best parent-selection 
in case determine_rate is used) and fixes it for now - as expected.

But it is not a long-term solution, as we will be at the same point, as 
soon as round_rate gets removed from clk-divider. For me, who is 
semi-knowledged in clock-framework, it was relatively hard to figure out 
what was going on. "I'll do this later" has often been heard here.

Though, I don't fully follow why moving the priority of determine_rate 
lower would have been necessary anyways: from what I understand 
determine_rate is expected to be the future-replacement of round_rate 
everywhere and should be preferred.

I guess it's up to the maintainers on how to proceed.

Alex

> Off-list Alex also suggested that I should use rate_ops.determine_rate
> if available.
> While I agree that this makes sense in general my plan is to do this
> in a follow-up patch.
> Changing the order of the conditions is needed anyways and it *should*
> fix the issue reported here (but I have no way of testing that
> unfortunately).
>
> Alex, it would be great if you (or someone with Rockchip boards) could
> test the attached patch and let me know if it fixes the reported
> problem.
>
>
> Best regards,
> Martin
