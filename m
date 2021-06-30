Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25EAD3B81ED
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 14:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234574AbhF3MU5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 30 Jun 2021 08:20:57 -0400
Received: from aposti.net ([89.234.176.197]:54396 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234537AbhF3MUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 08:20:55 -0400
Date:   Wed, 30 Jun 2021 13:18:14 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 6/6] clk: ingenic: Add support for the JZ4760
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        list@opendingux.net,
        =?UTF-8?b?5ZGo55Cw5p2w?= <zhouyanjie@wanyeetech.com>
Message-Id: <EUKIVQ.JY7MPI8PMAKC3@crapouillou.net>
In-Reply-To: <162484860391.2516444.9536343468022864909@swboyd.mtv.corp.google.com>
References: <20210530164923.18134-1-paul@crapouillou.net>
        <20210530164923.18134-7-paul@crapouillou.net>
        <162484860391.2516444.9536343468022864909@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you Stephen.

-Paul


Le dim., juin 27 2021 at 19:50:03 -0700, Stephen Boyd 
<sboyd@kernel.org> a écrit :
> Quoting Paul Cercueil (2021-05-30 09:49:23)
>>  Add the CGU code and the compatible string to the TCU driver to 
>> support
>>  the JZ4760 SoC.
>> 
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
> 
> Applied to clk-next


