Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46C6C44C126
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 13:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbhKJMXn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 10 Nov 2021 07:23:43 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:36664 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231559AbhKJMXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 07:23:39 -0500
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-63-Hf5nL1S3PWykdAp6sUJCkw-1; Wed, 10 Nov 2021 12:20:49 +0000
X-MC-Unique: Hf5nL1S3PWykdAp6sUJCkw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.24; Wed, 10 Nov 2021 12:20:47 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.024; Wed, 10 Nov 2021 12:20:47 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Peter Zijlstra' <peterz@infradead.org>
CC:     Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "linux-toolchains@vger.kernel.org" <linux-toolchains@vger.kernel.org>
Subject: RE: [PATCH 20/22] x86,word-at-a-time: Remove .fixup usage
Thread-Topic: [PATCH 20/22] x86,word-at-a-time: Remove .fixup usage
Thread-Index: AQHX1a3cTPOCK2YRr06RWvi0T9RbLav8lJ+ggAAG/oCAAA66wA==
Date:   Wed, 10 Nov 2021 12:20:47 +0000
Message-ID: <2734a37ebed2432291345aaa8d9fd47e@AcuMS.aculab.com>
References: <20211105171023.989862879@infradead.org>
 <20211105171821.654356149@infradead.org>
 <20211108164711.mr2cqdcvedin2lvx@treble>
 <YYlshkTmf5zdvf1Q@hirez.programming.kicks-ass.net>
 <CAKwvOdkFZ4PSN0GGmKMmoCrcp7_VVNjau_b0sNRm3MuqVi8yow@mail.gmail.com>
 <YYov8SVHk/ZpFsUn@hirez.programming.kicks-ass.net>
 <CAKwvOdn8yrRopXyfd299=SwZS9TAPfPj4apYgdCnzPb20knhbg@mail.gmail.com>
 <20211109210736.GV174703@worktop.programming.kicks-ass.net>
 <f6dbe42651e84278b44e44ed7d0ed74f@AcuMS.aculab.com>
 <YYuogZ+2Dnjyj1ge@hirez.programming.kicks-ass.net>
In-Reply-To: <YYuogZ+2Dnjyj1ge@hirez.programming.kicks-ass.net>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra
> Sent: 10 November 2021 11:10
> 
> On Wed, Nov 10, 2021 at 10:46:42AM +0000, David Laight wrote:
> > From: Peter Zijlstra
> > > Sent: 09 November 2021 21:08
> > ...
> > >
> > > GCC does the same, but I wanted to have the exception stuff be in
> > > .text.cold, but alas it doesn't do that. I left the attribute because of
> > > it's descriptive value.
> > >
> > > >  Unless the cold attribute is helping move
> > > > ("shrink-wrap"?) the basic block to a whole other section
> > > > (.text.cold.)?
> > >
> > > I was hoping it would do that, but it doesn't on gcc-11.
> >
> > Wouldn't moving part of a function to .text.cold (or .text.unlikely)
> > generate the same problems with the stack backtrace code as the
> > .text.fixup section you are removing had??
> 
> GCC can already split a function into func and func.cold today (or
> worse: func, func.isra.N, func.cold, func.isra.N.cold etc..).
> 
> I'm assuming reliable unwind and livepatch know how to deal with this.

They'll have 'proper' function labels at the top - so backtrace
stands a chance.
Indeed you (probably) want it to output "func.irsa.n.cold" rather
than just "func" to help show which copy it is in.

I guess that livepatch will need separate patches for each
version of the function - which might be 'interesting' if
all the copies actually need patching at the same time.
You'd certainly want a warning if there seemed to be multiple
copies of the function.

I'm waiting for the side-channel attack caused by detecting
timing differences caused by TLB misses when speculatively
executing code in the .cold/.unlikely sections.
ISTR recent x86 cpu speculate unknown conditional branches
'randomly' - rather than (say) assuming backwards taken.
So you can't (easily) stop speculative execution into the 'cold'
text.

I don't know if speculative execution will load TLB,
it would speed a lot of code up - with the same downsides
as evicting code from the L1-cache.
A 'half-way house' would be to do the page table walk, but
hold the read value 'pending' the code being needed.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

