Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 245963ED7EE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 15:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbhHPNu3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 16 Aug 2021 09:50:29 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:50509 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236788AbhHPNuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 09:50:05 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 2187024000A;
        Mon, 16 Aug 2021 13:49:31 +0000 (UTC)
Date:   Mon, 16 Aug 2021 15:49:31 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: Linux 5.14-rc6
Message-ID: <20210816154931.17bc2e29@xps13>
In-Reply-To: <CAHk-=wiWo3sRhEm69XprffzNpvcDOiK=X56G1H5A4Of4LdwaKQ@mail.gmail.com>
References: <CAHk-=wi8=9QbNFFZ1PwZ=J-3w6LkhF68_rEns-mN1DCJrYo1qQ@mail.gmail.com>
        <20210816024656.GA212454@roeck-us.net>
        <CAHk-=wiWo3sRhEm69XprffzNpvcDOiK=X56G1H5A4Of4LdwaKQ@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Linus Torvalds <torvalds@linux-foundation.org> wrote on Sun, 15 Aug
2021 16:58:59 -1000:

> On Sun, Aug 15, 2021 at 4:47 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > Failed tests:
> >arm:z2:pxa_defconfig:nodebug:nocd:nofs:nonvme:noscsi:notests:novirt:nofdt:flash8,384k,2:rootfs  
> 
> Miquel? Guenter has been reporting this failure since -rc1. It's rc6
> now. The fix has been discussed, and is available since early July -
> so why isn't this getting sent to me, and why do we still have that
> known failure going on?

Indeed, I applied this fix on our mtd/fixes branch (pulled in -next)
exactly a month ago and got pretty busy/off since then. I'm catching
up, sorry for the delay.

The fixes branch is ready anyway, I'll send it to you very shortly.

Thanks,
Miquèl
