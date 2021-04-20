Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE4363660F2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 22:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233978AbhDTUeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 16:34:00 -0400
Received: from elvis.franken.de ([193.175.24.41]:33872 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233660AbhDTUd7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 16:33:59 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1lYx3m-00062P-00; Tue, 20 Apr 2021 22:33:26 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 25FC6C06A8; Tue, 20 Apr 2021 22:28:03 +0200 (CEST)
Date:   Tue, 20 Apr 2021 22:28:03 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irqchip: Add support for IDT 79rc3243x interrupt
 controller
Message-ID: <20210420202803.GA16142@alpha.franken.de>
References: <20210420123441.24179-1-tsbogend@alpha.franken.de>
 <a8ca9b028f454ec6deca6387742c2713@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8ca9b028f454ec6deca6387742c2713@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 06:34:59PM +0100, Marc Zyngier wrote:
> On 2021-04-20 13:34, Thomas Bogendoerfer wrote:
> > IDT 79rc3243x SoCs have rather simple interrupt controllers connected
> > to the MIPS CPU interrupt lines. Each of them has room for up to
> > 32 interrupts.
> > 
> > Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> 
> Is there a DT binding for this irqchip? The code looks fine, but
> it'd be good if the binding was merged at the same time as the driver.

I'll write one and send a v2.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
