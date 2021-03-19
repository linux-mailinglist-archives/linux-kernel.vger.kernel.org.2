Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C553341BAC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 12:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbhCSLmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 07:42:16 -0400
Received: from gate.crashing.org ([63.228.1.57]:46589 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229821AbhCSLmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 07:42:09 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 12JBbiIL004557;
        Fri, 19 Mar 2021 06:37:44 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 12JBbeiG004554;
        Fri, 19 Mar 2021 06:37:40 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Fri, 19 Mar 2021 06:37:40 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     David Laight <David.Laight@ACULAB.COM>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Jann Horn <jannh@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Subject: Re: [PATCH mm] kfence: fix printk format for ptrdiff_t
Message-ID: <20210319113740.GL16691@gate.crashing.org>
References: <20210303121157.3430807-1-elver@google.com> <CAG_fn=W-jmnMWO24ZKdkR13K0h_0vfR=ceCVSrYOCCmDsHUxkQ@mail.gmail.com> <c1fea2e6-4acf-1fff-07ff-1b430169f22f@csgroup.eu> <20210316153320.GF16691@gate.crashing.org> <3f624e5b-567d-70f9-322f-e721b2df508b@csgroup.eu> <6d4b370dc76543f2ba8ad7c6dcdfc7af@AcuMS.aculab.com> <001a139e-d4fa-2fd7-348f-173392210dfd@csgroup.eu> <4f7becfe2b6e4263be83b5ee461b5732@AcuMS.aculab.com> <e4577151-bc73-5033-a9ed-114dd0c1aaaf@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4577151-bc73-5033-a9ed-114dd0c1aaaf@csgroup.eu>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 10:38:43AM +0100, Christophe Leroy wrote:
> Yes it seems to be wrong. It was changed by commit d27dfd3887 ("Import 
> pre2.0.8"), so that's long time ago. Before that it was an 'int' for ppc32.
> 
> gcc provides ptrdiff_t in stddef.h via __PTRDIFF_TYPE__
> gcc defined __PTRDIFF_TYPE__ as 'int' at build time.

(On 32-bit PowerPC Linux.)

> Should we fix it in arch/powerpc/include/uapi/asm/posix_types.h ?

I think so, yes.

> Anyway 
> 'long' and 'int' makes no functionnal difference on 32 bits so there should 
> be no impact for users if any.

Except that long and int are different types, which causes errors like
what you have here.  There may be similar fallout from changing it back.


Segher
