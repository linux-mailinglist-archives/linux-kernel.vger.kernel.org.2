Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2E083A9CB5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 15:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbhFPNzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 09:55:22 -0400
Received: from verein.lst.de ([213.95.11.211]:54500 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233727AbhFPNyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 09:54:53 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3F37767357; Wed, 16 Jun 2021 15:52:42 +0200 (CEST)
Date:   Wed, 16 Jun 2021 15:52:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jens Axboe <axboe@kernel.dk>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org
Subject: Re: remove the legacy ide driver v2
Message-ID: <20210616135241.GB30671@lst.de>
References: <20210616134658.1471835-1-hch@lst.de> <c5b74922-2c2d-c7bb-5302-65e675debdfe@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5b74922-2c2d-c7bb-5302-65e675debdfe@physik.fu-berlin.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 03:51:07PM +0200, John Paul Adrian Glaubitz wrote:
> Hi Christoph!
> 
> On 6/16/21 3:46 PM, Christoph Hellwig wrote:
> > libata mostly covers all hardware supported by the legacy ide driver.
> > There are three mips drivers that are not supported, but the linux-mips
> > list could not identify any users of those.  There also are two m68k
> > drivers that do not have libata equivalents, which might or might not
> > have users, so we'll need some input and possibly help from the m68k
> > community here.
> 
> I think the m68k drivers are being addressed at the moment. But Geert will
> know more about the current status.

Actually they are, and the patches are in the libata tree.  I just forgot
to update the cover letter.
