Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 162103CECF8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 22:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382682AbhGSRjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 13:39:47 -0400
Received: from gate.crashing.org ([63.228.1.57]:36742 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354624AbhGSQaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 12:30:22 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 16JH4N2o028857;
        Mon, 19 Jul 2021 12:04:23 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 16JH4Mln028856;
        Mon, 19 Jul 2021 12:04:22 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Mon, 19 Jul 2021 12:04:22 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Salah Triki <salah.triki@gmail.com>, herbert@gondor.apana.org.au,
        linux-kernel@vger.kernel.org, paulus@samba.org,
        linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        davem@davemloft.net
Subject: Re: [PATCH] replace if with min
Message-ID: <20210719170422.GO1583@gate.crashing.org>
References: <20210712204546.GA1492390@pc> <20210719181205.Horde.xU8C00MIRgjqhZQ3-RrANw8@messagerie.c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210719181205.Horde.xU8C00MIRgjqhZQ3-RrANw8@messagerie.c-s.fr>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 19, 2021 at 06:12:05PM +0200, Christophe Leroy wrote:
> Salah Triki <salah.triki@gmail.com> a �crit�:
> >Replace if with min in order to make code more clean.

> >--- a/drivers/crypto/nx/nx-842.c
> >+++ b/drivers/crypto/nx/nx-842.c
> >@@ -134,8 +134,7 @@ EXPORT_SYMBOL_GPL(nx842_crypto_exit);
> > static void check_constraints(struct nx842_constraints *c)
> > {
> > 	/* limit maximum, to always have enough bounce buffer to decompress 
> > 	*/
> >-	if (c->maximum > BOUNCE_BUFFER_SIZE)
> >-		c->maximum = BOUNCE_BUFFER_SIZE;
> >+	c->maximum = min(c->maximum, BOUNCE_BUFFER_SIZE);
> 
> For me the code is less clear with this change, and in addition it  
> slightly changes the behaviour. Before, the write was done only when  
> the value was changing. Now you rewrite the value always, even when it  
> doesn't change.

In both cases the compiler can decide to either write it more often than
strictly needed, depending on what it thinks best (and it usually has
better estimates than the programmer).  The behaviour is identical (and
the generated machine code is as well, in my testing).

The field name "maximum" is not the best choice, which makes the code
read a bit funny ("the min of max"), but the comment makes things pretty
clear.


Segher
