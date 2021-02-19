Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9FB31F690
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 10:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbhBSJaH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 19 Feb 2021 04:30:07 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:35731 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229524AbhBSJaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 04:30:03 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-49-gBzBo3n-MJCTw_rt9xe6Ig-1; Fri, 19 Feb 2021 09:28:21 +0000
X-MC-Unique: gBzBo3n-MJCTw_rt9xe6Ig-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 19 Feb 2021 09:28:21 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 19 Feb 2021 09:28:21 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Peter Zijlstra' <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "pjt@google.com" <pjt@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "r.marek@assembler.cz" <r.marek@assembler.cz>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "jikos@kernel.org" <jikos@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Subject: RE: [RFC PATCH] x86/retpolines: Prevent speculation after RET
Thread-Topic: [RFC PATCH] x86/retpolines: Prevent speculation after RET
Thread-Index: AQHXBi5g7piH/x085kS63Daiz9b9tKpfMjCw
Date:   Fri, 19 Feb 2021 09:28:21 +0000
Message-ID: <bed0382c5588439284b36e47fbac4321@AcuMS.aculab.com>
References: <20210218165938.213678824@infradead.org>
 <20210218184639.GF4214@zn.tnic>
 <20210218190231.GA59023@worktop.programming.kicks-ass.net>
In-Reply-To: <20210218190231.GA59023@worktop.programming.kicks-ass.net>
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
> Sent: 18 February 2021 19:03
> 
> On Thu, Feb 18, 2021 at 07:46:39PM +0100, Borislav Petkov wrote:
> > Both vendors speculate after a near RET in some way:
> >
> > Intel:
> >
> > "Unlike near indirect CALL and near indirect JMP, the processor will not
> > speculatively execute the next sequential instruction after a near RET
> > unless that instruction is also the target of a jump or is a target in a
> > branch predictor."
> 
> Right, the way I read that means it's not a problem for us here.

They got a lawyer to write that sentence :-)
What on earth is that 'unless' clause about?
Either:
1) The instructions might be speculatively executed for some entirely
   different reason.
or:
2) The cpu might use the BTB to determine the instruction that follows the
   RET - and so might happen to execute the instruction that follows it.

I can't manage to read it in any way that suggests that the cpu will
ignore the fact it is a RET and start executing the instruction that
follows.
(Unlike some ARM cpus which do seem to do that.)

> > AMD:
> >
> > "Some AMD processors when they first encounter a branch do not stall
> > dispatch and use the branches dynamic execution to determine the target.
> > Therefore, they will speculatively dispatch the sequential instructions
> > after the branch. This happens for near return instructions where it is
> > not clear what code may exist sequentially after the return instruction.

Sounds like the conditional branch prediction (and the BTB?) get used for RET
instructions when the 'return address stack' is invalid.

> > This behavior also occurs with jmp/call instructions with indirect
> > targets. Software should place a LFENCE or another dispatch serializing
> > instruction after the return or jmp/call indirect instruction to prevent
> > this sequential speculation."
> >
> > The AMD side doesn't really need the LFENCE because it'll do LFENCE;
> > JMP/CALL <target> due to X86_FEATURE_RETPOLINE_AMD, before it reaches
> > the RET.
> 
> It never reached the RET.
> 
> So all in all, I really don't see why we'd need this.

I read that as implying that some AMD cpu can sometimes treat the RET as
a conditional branch and so speculatively assume it isn't taken.
So you need an LFENCE (or ???) following the RET at the end of every function.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

