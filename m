Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 149833685E7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 19:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238606AbhDVRaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 13:30:16 -0400
Received: from elvis.franken.de ([193.175.24.41]:37204 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238241AbhDVRaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 13:30:12 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1lZd8x-00008X-00; Thu, 22 Apr 2021 19:29:35 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id B8B33C0960; Thu, 22 Apr 2021 19:15:54 +0200 (CEST)
Date:   Thu, 22 Apr 2021 19:15:54 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] irqchip: Add support for IDT 79rc3243x interrupt
 controller
Message-ID: <20210422171554.GA14257@alpha.franken.de>
References: <20210422145330.73452-1-tsbogend@alpha.franken.de>
 <87mttqicj4.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mttqicj4.wl-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 04:06:55PM +0100, Marc Zyngier wrote:
> On Thu, 22 Apr 2021 15:53:28 +0100,
> Thomas Bogendoerfer <tsbogend@alpha.franken.de> wrote:
> > 
> > IDT 79rc3243x SoCs have rather simple interrupt controllers connected
> > to the MIPS CPU interrupt lines. Each of them has room for up to
> > 32 interrupts.
> > 
> > Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> > ---
> > Changes in v4:
> >   - changed comaptible string to idt,32434-pic
> 
> I have dropped v3 from irq/irqchip-next and picked v4, but please send

thanks

> patches on top of that version if you have further changes.

sure will do.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
