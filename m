Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 847CD3321B8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 10:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbhCIJNA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 9 Mar 2021 04:13:00 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:47683 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229639AbhCIJMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 04:12:45 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-65-IhmyWhliOq6NmMDXu6s74g-1; Tue, 09 Mar 2021 09:12:42 +0000
X-MC-Unique: IhmyWhliOq6NmMDXu6s74g-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 9 Mar 2021 09:12:41 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 9 Mar 2021 09:12:40 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>,
        Marco Elver <elver@google.com>
CC:     Petr Mladek <pmladek@suse.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Timur Tabi <timur@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: RE: [PATCH 2/2] lib/vsprintf: reduce space taken by no_hash_pointers
 warning
Thread-Topic: [PATCH 2/2] lib/vsprintf: reduce space taken by no_hash_pointers
 warning
Thread-Index: AQHXFEobJ7Swwp6RcU2yBDODqe2J7ap7X8pg
Date:   Tue, 9 Mar 2021 09:12:40 +0000
Message-ID: <d8113f0273494e76b7b10c9d81d7997e@AcuMS.aculab.com>
References: <20210305194206.3165917-1-elver@google.com>
 <20210305194206.3165917-2-elver@google.com> <YEX5fyB16dF6N4Iu@alley>
 <CAMuHMdUDqcWfE67g2ah-JyL3H9-G_5nrtQLyq0A3OXTKPFXv6w@mail.gmail.com>
 <YEZdo0L8otuEJZNW@alley>
 <CANpmjNOS86kLPexXBZPwRB9=Ej6RHycJXCw_Z7cskMC+Jwb1Ag@mail.gmail.com>
 <YEZupyBiJD1zoLTi@smile.fi.intel.com>
In-Reply-To: <YEZupyBiJD1zoLTi@smile.fi.intel.com>
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

...
> On Mon, Mar 08, 2021 at 07:23:34PM +0100, Marco Elver wrote:
> > On Mon, 8 Mar 2021 at 18:23, Petr Mladek <pmladek@suse.com> wrote:
> 
> > > -       pr_warn("**********************************************************\n");
> > > -       pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
> > > -       pr_warn("**                                                      **\n");
> > > -       pr_warn("** This system shows unhashed kernel memory addresses   **\n");
> > > -       pr_warn("** via the console, logs, and other interfaces. This    **\n");
> > > -       pr_warn("** might reduce the security of your system.            **\n");
> > > -       pr_warn("**                                                      **\n");
> > > -       pr_warn("** If you see this message and you are not debugging    **\n");
> > > -       pr_warn("** the kernel, report this immediately to your system   **\n");
> >
> > While we're here: This paragraph can be shortened by saying what
> > kernel/trace/trace.c says ("..., report this immediately to your
> > vendor!") which avoids the "administrator! <lots of wasted spaces>".
> 
> Aren't we discussed that and the point was that kernel configuration option is
> in administrator's realm?
> 
> > > -       pr_warn("** administrator!                                       **\n");
> > > -       pr_warn("**                                                      **\n");
> > > -       pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
> > > -       pr_warn("**********************************************************\n");

If you actually want anyone to notice it you need to splat it out
when root logs in - not just hidden in the middle of the boot messages.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

