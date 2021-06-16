Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED60B3A9CEB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 16:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233759AbhFPOGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 10:06:40 -0400
Received: from verein.lst.de ([213.95.11.211]:54549 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233722AbhFPOGd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 10:06:33 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 551C368B05; Wed, 16 Jun 2021 16:04:24 +0200 (CEST)
Date:   Wed, 16 Jun 2021 16:04:24 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jens Axboe <axboe@kernel.dk>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: [PATCH 5/6] m68k: use libata instead of the legacy ide driver
Message-ID: <20210616140424.GA32014@lst.de>
References: <20210616134658.1471835-1-hch@lst.de> <20210616134658.1471835-6-hch@lst.de> <CAMuHMdUbEBO28w3XKOvSKUk3XUaesOqxEfL+8i4W0Thu10pNTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUbEBO28w3XKOvSKUk3XUaesOqxEfL+8i4W0Thu10pNTw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 04:03:38PM +0200, Geert Uytterhoeven wrote:
> Hi Christoph,
> 
> On Wed, Jun 16, 2021 at 3:50 PM Christoph Hellwig <hch@lst.de> wrote:
> > Switch the m68 defconfigs from the deprecated ide subsystem to use libata
> > instead.  The gayle and buddha and falcon drivers are enabled for libata,
> > while support for the q40 and macide drivers is lost.
> 
> I guess you forgot to update the last sentence, too?
> These are now handled by the falcon and generic platform libata drivers.

Indeed.

> With the above fixed:
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks!
