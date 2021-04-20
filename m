Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCB8366128
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 22:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbhDTUuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 16:50:24 -0400
Received: from elvis.franken.de ([193.175.24.41]:33889 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233675AbhDTUuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 16:50:23 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1lYxJe-00067O-00; Tue, 20 Apr 2021 22:49:50 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id B1323C07C1; Tue, 20 Apr 2021 22:49:29 +0200 (CEST)
Date:   Tue, 20 Apr 2021 22:49:29 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ata: pata_rb532: Add OF support and make COMPILE_TESTable
Message-ID: <20210420204929.GA16205@alpha.franken.de>
References: <20210420140422.88253-1-tsbogend@alpha.franken.de>
 <712b5cfa-3c68-3048-41c7-07a65c506ce1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <712b5cfa-3c68-3048-41c7-07a65c506ce1@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 07:09:26PM +0300, Sergei Shtylyov wrote:
> Hello!
> 
> On 4/20/21 5:04 PM, Thomas Bogendoerfer wrote:
> 
> > Add OF support for switching RB532 do device tree possible.
> 
>    I couldnb't parse that. :-)

no wonder ;-) I'll rephrase in v2.

> 
> > By removing
> > the not needed asm/mach-rc32434/rb.h include the driver could be
> > compile tested now.
> 
>   I think it's a separte issue worth its own patch.

Jens, do you want this in an extra patch ?

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
