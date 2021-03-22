Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 128F334496E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 16:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbhCVPmI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 22 Mar 2021 11:42:08 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:51176 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230034AbhCVPmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 11:42:04 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-81-2QDzD-rpMcmpMMzi0vifRw-1; Mon, 22 Mar 2021 15:41:58 +0000
X-MC-Unique: 2QDzD-rpMcmpMMzi0vifRw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Mon, 22 Mar 2021 15:41:56 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.012; Mon, 22 Mar 2021 15:41:56 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Peter Zijlstra' <peterz@infradead.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "jgross@suse.com" <jgross@suse.com>,
        "mbenes@suse.com" <mbenes@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 03/14] x86/retpoline: Simplify retpolines
Thread-Topic: [PATCH v2 03/14] x86/retpoline: Simplify retpolines
Thread-Index: AQHXHBuOjMKa9Pnfuk6RUu8GKds+rKqLhqcggAQ9ywCAACWHIA==
Date:   Mon, 22 Mar 2021 15:41:56 +0000
Message-ID: <b8e8cea6ac884c04b8c9e7a479fd2208@AcuMS.aculab.com>
References: <20210318171103.577093939@infradead.org>
 <20210318171919.580212227@infradead.org>
 <f7a36237052f4c09ad101431653038a5@AcuMS.aculab.com>
 <YFhkRN8dxHqItHy8@hirez.programming.kicks-ass.net>
In-Reply-To: <YFhkRN8dxHqItHy8@hirez.programming.kicks-ass.net>
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
> Sent: 22 March 2021 09:33
> 
> On Fri, Mar 19, 2021 at 05:18:14PM +0000, David Laight wrote:
> > From: Peter Zijlstra
> > > Sent: 18 March 2021 17:11
> > >
> > > Due to commit c9c324dc22aa ("objtool: Support stack layout changes
> > > in alternatives"), it is possible to simplify the retpolines.
> > >
> > ...
> > > Notice that since the longest alternative sequence is now:
> > >
> > >    0:   e8 07 00 00 00          callq  c <.altinstr_replacement+0xc>
> > >    5:   f3 90                   pause
> > >    7:   0f ae e8                lfence
> > >    a:   eb f9                   jmp    5 <.altinstr_replacement+0x5>
> > >    c:   48 89 04 24             mov    %rax,(%rsp)
> > >   10:   c3                      retq
> > >
> > > 17 bytes, we have 15 bytes NOP at the end of our 32 byte slot. (IOW,
> > > if we can shrink the retpoline by 1 byte we can pack it more dense)
> >
> > I'm intrigued about the lfence after the pause.
> > Clearly this is for very warped cpu behaviour.
> > To get to the pause you have to be speculating past an
> > unconditional call.
> 
> Please read up on retpoline... That's the speculation trap. The warped
> CPU behaviour is called Spectre-v2.

There is 'warped' and 'very warped' :-)
Most of Spectre-v2 (don't search for Spectra v2 by mistake) is avoiding
the indirect branch prediction - which I knew.

I think the 'pause' is only executed is the cpu speculates through
the mov and retq; rather the speculating past the 'call' - which
some ARM cpu seem to do.

> For others, the obvious alternative is the below; and possibly we could
> then also remove the loop.

Another alternative is 'hlt' with the loop (rather than int3).

> The original retpoline, as per Paul's article has: 1: pause; jmp 1b;.
> That is, it lacks the LFENCE we have and would also fit 16 bytes.

Yes. Just 'jmps .' ought to be enough to block any side effects
of speculative execution.
Adding 'pause' is 'a good idea' for any spin loop.

There might be another lurking performance issue.
Skylake increased the execution time of pause from ~10 to ~140 clocks.
Reading between the lines I suspect this applies to speculatively
executed pause.
If that happens on a regular basis it might be noticeable.
So it may even be best to remove the pause!

As you say, the original retpoline lacked the lfence.
The only 'load' instruction in that sequence is the 'retq'.
It has to be said that given all (normal) loads are executed
in program order and all (normal) stores are also executed
in program order I've never actually seen what either
lfence or sfence actually do for you.
(mfence synchronises reads and writes - so may be useful.)
The (pre spectre) copies of the intel pdf's I have don't say
anything about lfence being any kind of a barrier against
speculative memory reads.

If the retpoline doesn't fit in 16 bytes it is almost certainly
(probably) worth putting the called label at offset 16.
This would mean that there is only one 16-byte code block
read from the call target.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

