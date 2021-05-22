Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4FF938D426
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 09:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhEVHSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 03:18:36 -0400
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:33459 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230028AbhEVHSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 03:18:33 -0400
Received: from [192.168.1.18] ([86.243.172.93])
        by mwinf5d71 with ME
        id 7jH62500A21Fzsu03jH7Ri; Sat, 22 May 2021 09:17:07 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 22 May 2021 09:17:07 +0200
X-ME-IP: 86.243.172.93
Subject: Re: [PATCH 0/4] clk: mvebu: Fix some error handling paths + do some
 clean-up
To:     arnd@arndb.de, gregkh@linuxfoundation.org,
        mihai.carabas@oracle.com, andriy.shevchenko@linux.intel.com,
        pizhenwei@bytedance.com, pbonzini@redhat.com,
        bobo.shaobowang@huawei.com, linqiheng@huawei.com
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <cover.1619157996.git.christophe.jaillet@wanadoo.fr>
From:   Marion & Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <f0a5488e-3877-3763-dc7a-1b54d2f5bf65@wanadoo.fr>
Date:   Sat, 22 May 2021 09:17:07 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <cover.1619157996.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 22/05/2021 à 08:51, Christophe JAILLET a écrit :
> This serie fixes some (unlikely) error handlings paths.
>
> The 4th patch is completely speculative. When I compile-tested the changes,
> I had to remove this line in order for it to compile.
> As it works fine (at least for me) without it, I wonder if it is needed at all.
>
>
> Also, I wonder if the drivers in drivers/clk/mvebu are used by anyone.
> In order to compile-test the changes, I also had to change the 'bool' in Kconfig
> by 'bool "blah"'. Without this change, it was not possible to set
> CONFIG_MVEBU_CLK_CPU required by Makefile.
>
> I don't know if I did something wrong, if it is an issue only on my environment
> or if something got broken at some time in the build chain but it looks
> spurious.
>
> If I'm right and that these drivers never compile and no-one noticed it,
> maybe removing them is better than fixing some unlikely issues and style.
> If these drivers should stay, Kconfig may need some love from someone.
>
> Christophe JAILLET (4):
>    clk: mvebu: Fix a memory leak in an error handling path
>    clk: mvebu: Fix a another memory leak in an error handling path
>    clk: mvebu: Fix a checkpatch warning
>    clk: mvebu: Remove an unneeded include
>
>   drivers/clk/mvebu/clk-cpu.c | 22 +++++++++++++---------
>   1 file changed, 13 insertions(+), 9 deletions(-)

NAK, wrong cover letter sent

Sorry for the noise.

CJ


