Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4658C32F0EB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 18:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbhCERNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 12:13:49 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:48507 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230053AbhCERNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 12:13:36 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mtapsc-1-9u1wbWfNOlK990iK9I15eQ-1; Fri, 05 Mar 2021 17:13:27 +0000
X-MC-Unique: 9u1wbWfNOlK990iK9I15eQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 5 Mar 2021 17:13:27 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 5 Mar 2021 17:13:27 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Nick Desaulniers' <ndesaulniers@google.com>,
        Josh Don <joshdon@google.com>
CC:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        "Mel Gorman" <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Clement Courbet <courbet@google.com>,
        Oleg Rombakh <olegrom@google.com>,
        Bill Wendling <morbo@google.com>
Subject: RE: [PATCH v2] sched: Optimize __calc_delta.
Thread-Topic: [PATCH v2] sched: Optimize __calc_delta.
Thread-Index: AQHXER0S0FxH/KQD/0qlH7RDSaPhE6p1opJQ
Date:   Fri, 5 Mar 2021 17:13:26 +0000
Message-ID: <b28c85f973f34bc192b5b5e95f43a7fb@AcuMS.aculab.com>
References: <YD9dUkGhlRT8vvcy@hirez.programming.kicks-ass.net>
 <20210303224653.2579656-1-joshdon@google.com>
 <CAKwvOdmijctJfM3gNfwEVjaQyp3LZkhnAwgsT7EBhsSBJyfLAA@mail.gmail.com>
In-Reply-To: <CAKwvOdmijctJfM3gNfwEVjaQyp3LZkhnAwgsT7EBhsSBJyfLAA@mail.gmail.com>
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
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBIaSBKb3NoLCBUaGFua3MgZm9yIGhlbHBpbmcgZ2V0IHRoaXMgcGF0Y2ggYWNyb3NzIHRoZSBm
aW5pc2ggbGluZS4NCj4gV291bGQgeW91IG1pbmQgdXBkYXRpbmcgdGhlIGNvbW1pdCBtZXNzYWdl
IHRvIHBvaW50IHRvDQo+IGh0dHBzOi8vYnVncy5sbHZtLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MjAx
OTc/DQoNCklzIGl0IHdvcnRoIGFuIGF1ZGl0IG9mIGFsbCB0aGUgYXNtKCkgY29uc3RyYWludHMN
CmFuZCBwb3RlbnRpYWxseSBjaGFuZ2luZyBhbGwgdGhlICJtciIgdG8gInIiIGZvciBjbGFuZz8N
Cg0KVGhlIGV4cGxpY2l0ICdsb2FkIGludG8gYSByZWdpc3Rlcicgd29uJ3QgbWFrZSBtdWNoDQpk
aWZmZXJlbmNlIGV2ZW4gaWYgYSBkaXJlY3QgIm0iIG9wZXJhbmQgY291bGQgYmUgdXNlZCBvbiB4
ODYuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkg
Um9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlv
biBObzogMTM5NzM4NiAoV2FsZXMpDQo=

