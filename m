Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 474EF40986F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 18:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345517AbhIMQLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 12:11:10 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:42113 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344663AbhIMQLH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 12:11:07 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 18DG9jti002589;
        Mon, 13 Sep 2021 18:09:45 +0200
Date:   Mon, 13 Sep 2021 18:09:45 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     David Laight <David.Laight@aculab.com>
Cc:     Douglas Gilbert <dgilbert@interlog.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: how many memset(,0,) calls in kernel ?
Message-ID: <20210913160945.GA2456@1wt.eu>
References: <1c4a94df-fc2f-1bb2-8bce-2d71f9f1f5df@interlog.com>
 <20210912045608.GB16216@1wt.eu>
 <88976a40175c491fb5e3349f6686ad67@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88976a40175c491fb5e3349f6686ad67@AcuMS.aculab.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 04:03:09PM +0000, David Laight wrote:
> >   36:   b9 06 00 00 00          mov    $0x6,%ecx
> >   3b:   4c 89 e7                mov    %r12,%rdi
> >   3e:   f3 ab                   rep stos %eax,%es:(%rdi)
> > 
> > The last line does exactly "memset(%rdi, %eax, %ecx)". Just two bytes
> > for some code that modern processors are even able to optimize.
> 
> Hmmm I'd bet that 6 stores will be faster on ~everything.
> 'modern' processors do better than some older ones [1], but 6
> writes isn't enough to get into the really fast paths.
> So you'll still take a few cycles of setup.

The exact point is, here it's up to the compiler to decide thanks to
its builtin what it considers best for the target CPU. It already
knows the fixed size and the code is emitted accordingly. It may
very well be a call to the memset() function when the size is large
and a power of two because it knows alternate variants are available
for example.

The compiler might even decide to shrink that area if other bytes
are written just after the memset(), leaving only holes touched by
memset().

Willy
