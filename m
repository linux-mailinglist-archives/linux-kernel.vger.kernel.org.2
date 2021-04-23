Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48C38368F17
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 10:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241550AbhDWIu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 04:50:29 -0400
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:19814 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbhDWIu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 04:50:28 -0400
Received: from [192.168.1.18] ([86.243.172.93])
        by mwinf5d05 with ME
        id w8pq2400Q21Fzsu038pqH9; Fri, 23 Apr 2021 10:49:51 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 23 Apr 2021 10:49:51 +0200
X-ME-IP: 86.243.172.93
Subject: Re: [PATCH 0/4] clk: mvebu: Fix some error handling paths + do some
 clean-up
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        gregory.clement@bootlin.com, thomas.petazzoni@free-electrons.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <cover.1619157996.git.christophe.jaillet@wanadoo.fr>
 <20210423092700.6a857460@windsurf>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <dd6f8b77-ac24-0339-0b38-4f62b004dc9c@wanadoo.fr>
Date:   Fri, 23 Apr 2021 10:49:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210423092700.6a857460@windsurf>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 23/04/2021 à 09:27, Thomas Petazzoni a écrit :
> Hello,
> 
> On Fri, 23 Apr 2021 08:24:52 +0200
> Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:
> 
>> Also, I wonder if the drivers in drivers/clk/mvebu are used by anyone.
>> In order to compile-test the changes, I also had to change the 'bool' in Kconfig
>> by 'bool "blah"'. Without this change, it was not possible to set
>> CONFIG_MVEBU_CLK_CPU required by Makefile.
> 
> CONFIG_MVEBU_CLK_CPU is selected by ARMADA_370_CLK and ARMADA_XP_CLK,
> which themselves are selected by MACH_ARMADA_370 and MACH_ARMADA_XP
> respectively.

Hi, thanks for the clarification.

Usually, only slightly modifying dependencies in Kconfig is enough for 
me to trigger a built, even if I don't have the correct toolchain for 
this architecture. In this case, the tweak I had to do was "spurious" 
and Kconfig "looked strange" to me, hence my comment.

Glad to here that this code is still alive. So, my patches may make 
sense :).

CJ

> 
> So unless I'm missing something, this code is definitely reachable and
> compiled. You can use the mvebu_v7_defconfig of ARM32, and the code
> will be built.
> 
> Best regards,
> 
> Thomas
> 

