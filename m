Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFD13F61B0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 17:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238359AbhHXPdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 11:33:25 -0400
Received: from gate.crashing.org ([63.228.1.57]:35656 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238217AbhHXPdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 11:33:24 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 17OFSFBJ017344;
        Tue, 24 Aug 2021 10:28:15 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 17OFSEsh017341;
        Tue, 24 Aug 2021 10:28:14 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Tue, 24 Aug 2021 10:28:13 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/32: Don't use lmw/stmw for saving/restoring non volatile regs
Message-ID: <20210824152813.GG1583@gate.crashing.org>
References: <316c543b8906712c108985c8463eec09c8db577b.1629732542.git.christophe.leroy@csgroup.eu> <20210823184648.GY1583@gate.crashing.org> <9bbc9797-cfc7-1484-90ad-2146ff1a5e18@csgroup.eu> <20210824131600.GF1583@gate.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210824131600.GF1583@gate.crashing.org>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 08:16:00AM -0500, Segher Boessenkool wrote:
> On Tue, Aug 24, 2021 at 07:54:22AM +0200, Christophe Leroy wrote:
> > >On mpccore both lmw and stmw are only N+1 btw.  But the serialization
> > >might cost another cycle here?
> > 
> > That coherent on MPC8xx, that's only 2 cycles.
> > But on the mpc832x which has a e300c2 core, it looks like I have 10 cycles 
> > difference. Is anything wrong ?
> 
> I don't know that core very well, I'll have a look.

So, I don't see any difference between e300c2 and e300c1 (which is 603
basically, for this) that is significant here.  The e300c2 has two
integer units instead of just one, but it still has only one load/store
unit, and I don't see anything else that could matter either.  Huh.


Segher
