Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4ED3302D0
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 16:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbhCGP6j convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 7 Mar 2021 10:58:39 -0500
Received: from aposti.net ([89.234.176.197]:34520 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231228AbhCGP6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 10:58:23 -0500
Date:   Sun, 07 Mar 2021 15:58:11 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] clk: Fix doc of clk_get_parent
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     od@zcrc.me, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <ZCWLPQ.PR2X1S4YNGGC1@crapouillou.net>
In-Reply-To: <20210307143013.GE1463@shell.armlinux.org.uk>
References: <20210307140626.22699-1-paul@crapouillou.net>
        <20210307142701.GD1463@shell.armlinux.org.uk>
        <J8SLPQ.MXUB9SDIPWN13@crapouillou.net>
        <20210307143013.GE1463@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le dim. 7 mars 2021 à 14:30, Russell King - ARM Linux admin 
<linux@armlinux.org.uk> a écrit :
> On Sun, Mar 07, 2021 at 02:29:07PM +0000, Paul Cercueil wrote:
>>  Hi,
>> 
>>  Le dim. 7 mars 2021 à 14:27, Russell King - ARM Linux admin
>>  <linux@armlinux.org.uk> a écrit :
>>  > On Sun, Mar 07, 2021 at 02:06:26PM +0000, Paul Cercueil wrote:
>>  > >  On error, or when the passed parameter is NULL, the return 
>> value is
>>  > > NULL
>>  > >  and not a PTR_ERR()-encoded value.
>>  >
>>  > No, the documentation is accurate. The CCF is just an 
>> implementation
>>  > of the API, the file you are modifying is the definitive API
>>  > documentation.
>> 
>>  Well, then the code has to be fixed, because right now it returns 
>> NULL on
>>  error, since the 2.6 days.
> 
> And you consider NULL to be an error? A NULL clock isn't defined to be
> an error by the API.

Fair enough. Ignore my patch then.

Cheers,
-Paul


