Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F55945A618
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 15:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234897AbhKWO5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 09:57:06 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:21365 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230160AbhKWO5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 09:57:04 -0500
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-230-Obos0rq9Nm6L33LDx2QS0Q-1; Tue, 23 Nov 2021 14:53:54 +0000
X-MC-Unique: Obos0rq9Nm6L33LDx2QS0Q-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.26; Tue, 23 Nov 2021 14:53:53 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.026; Tue, 23 Nov 2021 14:53:53 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Alexander Potapenko' <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>
CC:     Peter Collingbourne <pcc@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Masahiro Yamada" <masahiroy@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        "YiFei Zhu" <yifeifz2@illinois.edu>,
        Colin Ian King <colin.king@canonical.com>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        David Hildenbrand <david@redhat.com>,
        Xiaofeng Cao <caoxiaofeng@yulong.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Thomas Cedeno <thomascedeno@google.com>,
        Marco Elver <elver@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Evgenii Stepanov <eugenis@google.com>
Subject: RE: [PATCH v2 2/5] uaccess-buffer: add core code
Thread-Topic: [PATCH v2 2/5] uaccess-buffer: add core code
Thread-Index: AQHX4FO7JaSecNwuc0aRaquxZ2rIO6wRMnPg
Date:   Tue, 23 Nov 2021 14:53:53 +0000
Message-ID: <1dab2edad29b482e8b7965a373ed0dea@AcuMS.aculab.com>
References: <20211123051658.3195589-1-pcc@google.com>
 <20211123051658.3195589-3-pcc@google.com>
 <CACT4Y+aoiT+z+3CMBNmO0SwXBXpfDCsHY7pPLf54S8V=c-a8ag@mail.gmail.com>
 <CAG_fn=VN001yOZ_kN3rOENKYvEioRkc0J0ZZYtLKKshK4X2yfg@mail.gmail.com>
In-Reply-To: <CAG_fn=VN001yOZ_kN3rOENKYvEioRkc0J0ZZYtLKKshK4X2yfg@mail.gmail.com>
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

RnJvbTogQWxleGFuZGVyIFBvdGFwZW5rbw0KPiBTZW50OiAyMyBOb3ZlbWJlciAyMDIxIDEwOjIw
DQouLi4NCj4gU28gaWYgdWFjY2VzcyBsb2dnaW5nIGlzIG1lYW50IGZvciBwcm9kdWN0aW9uIHVz
ZSwgaXQgc2hvdWxkIGJlDQo+IHBvc3NpYmxlIHRvIGxvY2sgdGhlIGZlYXR1cmUgZG93biBmcm9t
IHVud2FudGVkIHVzZXJzLg0KDQpJc24ndCB0aGUgY29uZGl0aW9uYWwgZm9yIGxvZ2dpbmcgZXZl
cnkgZ2V0X3VzZXIoKSBhbmQgcHV0X3VzZXIoKQ0KZ29pbmcgdG8gY29tcGxldGVseSBraWxsIHBl
cmZvcm1hbmNlPw0KDQpJJ20gbm90IHN1cmUgSSdkIHdhbnQgdGhpcyBjb2RlIGNvbXBpbGVkIGlu
dG8gYW55IGtlcm5lbCBJIHVzZS4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBM
YWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBU
LCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

