Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 477223F0A41
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 19:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbhHRR3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 13:29:34 -0400
Received: from mxout03.lancloud.ru ([45.84.86.113]:58840 "EHLO
        mxout03.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhHRR3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 13:29:30 -0400
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru 1B4DC207445A
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: linux-next: Fixes tag needs some work in the i2c tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Wolfram Sang <wsa@the-dreams.de>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Linux Next Mailing List" <linux-next@vger.kernel.org>
References: <20210818074903.2da12b1f@canb.auug.org.au>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <42b3cebf-de30-5677-f98b-7a59543a3004@omp.ru>
Date:   Wed, 18 Aug 2021 20:28:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210818074903.2da12b1f@canb.auug.org.au>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/18/21 12:49 AM, Stephen Rothwell wrote:

[...]
> In commit
> 
>   fcc750e0f4d8 ("i2c: s3c2410: fix IRQ check")
> 
> Fixes tag
> 
>   Fixes: 2bbd681ba2b ("i2c-s3c2410: Change IRQ to be plain integer.")
> 
> has these problem(s):
> 
>   - SHA1 should be at least 12 digits long
>     Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
>     or later) just making sure it is not set (or set to "auto").
>   - Subject does not match target commit subject
>     Just use
> 	git log -1 --format='Fixes: %h ("%s")'
> So:
> 
> Fixes: 2bbd681ba2bf ("i2c: xlp9xx: Driver for Netlogic XLP9XX/5XX I2C controller")

   Sorry for this copypaste blunder. :-/

> Or maybe you meant:
> 
> Fixes: e0d1ec97853f ("i2c-s3c2410: Change IRQ to be plain integer.")

   Yes, this one looks more correct.

   Wolfram, what should we do now?
 
MBR, Sergei
