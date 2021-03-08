Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09DFF330AC3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 11:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbhCHKB2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 8 Mar 2021 05:01:28 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:40339 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231522AbhCHKB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 05:01:26 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-126-UoBJENP0MXWJd9ek_G47xg-1; Mon, 08 Mar 2021 10:01:21 +0000
X-MC-Unique: UoBJENP0MXWJd9ek_G47xg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 8 Mar 2021 10:01:20 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 8 Mar 2021 10:01:20 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Peter Zijlstra' <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: "struct perf_sample_data" alignment
Thread-Topic: "struct perf_sample_data" alignment
Thread-Index: AQHXEZrQ+54heyJXCUKE4zwwZZ2YcKp5304Q
Date:   Mon, 8 Mar 2021 10:01:20 +0000
Message-ID: <f768c4e8085b45889971d623aeded560@AcuMS.aculab.com>
References: <CAHk-=wgQWHDUFjzmAazg8WN0BR7nOyHmduj-MV1GWWDUu+UKCQ@mail.gmail.com>
 <YEHtjioucovbxbRt@hirez.programming.kicks-ass.net>
In-Reply-To: <YEHtjioucovbxbRt@hirez.programming.kicks-ass.net>
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
> What I remember is that since perf_sample_data is fairly large,
> unconditionally initializing the whole thing is *slow* (and
> -fauto-var-init=zero will hurt here).

That will hurt everywhere.
I can also imagine it hiding bugs and making people
shrink on-stack arrays to the point where they either overrun
or cause an unexpected error or string truncation.

Initialising to zero is a bad choice if the aim is to
avoid leaking stack.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

