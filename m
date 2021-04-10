Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6136935ABD7
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 10:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbhDJIPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 04:15:48 -0400
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:25148 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhDJIPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 04:15:47 -0400
Received: from belgarion ([90.11.64.244])
        by mwinf5d03 with ME
        id qwFG2400R5GBUJa03wFRLb; Sat, 10 Apr 2021 10:15:30 +0200
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Sat, 10 Apr 2021 10:15:30 +0200
X-ME-IP: 90.11.64.244
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, soc@kernel.org
Subject: Re: [PATCH] ARM: pxa: mainstone: avoid -Woverride-init warning
In-Reply-To: <161727243811.583633.1536328285829233051.b4-ty@arndb.de> (Arnd
        Bergmann's message of "Thu, 1 Apr 2021 12:23:29 +0200")
References: <20210323130849.2362001-1-arnd@kernel.org>
        <161727243811.583633.1536328285829233051.b4-ty@arndb.de>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/26 (gnu/linux)
X-URL:  http://belgarath.falguerolles.org/
Date:   Sat, 10 Apr 2021 10:15:15 +0200
Message-ID: <87im4utv1o.fsf@belgarion.home>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@kernel.org> writes:

> From: Arnd Bergmann <arnd@arndb.de>
>
> On Tue, 23 Mar 2021 14:08:27 +0100, Arnd Bergmann wrote:
>> The default initializer at the start of the array causes a warning
>> when building with W=1:
>> 
>> In file included from arch/arm/mach-pxa/mainstone.c:47:
>> arch/arm/mach-pxa/mainstone.h:124:33: error: initialized field overwritten [-Werror=override-init]
>>   124 | #define MAINSTONE_IRQ(x)        (MAINSTONE_NR_IRQS + (x))
>>       |                                 ^
>> arch/arm/mach-pxa/mainstone.h:133:33: note: in expansion of macro 'MAINSTONE_IRQ'
>>   133 | #define MAINSTONE_S0_CD_IRQ     MAINSTONE_IRQ(9)
>>       |                                 ^~~~~~~~~~~~~
>> arch/arm/mach-pxa/mainstone.c:506:15: note: in expansion of macro 'MAINSTONE_S0_CD_IRQ'
>>   506 |         [5] = MAINSTONE_S0_CD_IRQ,
>>       |               ^~~~~~~~~~~~~~~~~~~
>> 
>> [...]
>
> Applied to arm/fixes.
Too late, but ...
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

-- 
Robert
