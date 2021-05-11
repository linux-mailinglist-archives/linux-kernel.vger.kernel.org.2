Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D282837A6D6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 14:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbhEKMhW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 11 May 2021 08:37:22 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:34740 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230436AbhEKMhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 08:37:19 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-102-AdSWJMpLMF6zU1JX4ZDi6A-1; Tue, 11 May 2021 13:36:08 +0100
X-MC-Unique: AdSWJMpLMF6zU1JX4ZDi6A-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Tue, 11 May 2021 13:36:06 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.015; Tue, 11 May 2021 13:36:06 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Stephen Boyd' <swboyd@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexei Starovoitov" <ast@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Baoquan He <bhe@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Young <dyoung@redhat.com>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Ingo Molnar <mingo@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Rasmus Villemoes" <linux@rasmusvillemoes.dk>,
        Sasha Levin <sashal@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vivek Goyal <vgoyal@redhat.com>, Will Deacon <will@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        peter enderborg <peter.enderborg@sony.com>
Subject: RE: [PATCH v6 00/13] Add build ID to stacktraces
Thread-Topic: [PATCH v6 00/13] Add build ID to stacktraces
Thread-Index: AQHXRf4HnT90HedmH0WFx6bjKadex6reN/jQ
Date:   Tue, 11 May 2021 12:36:06 +0000
Message-ID: <b30f6d396edf4db5974a2b90364b6314@AcuMS.aculab.com>
References: <20210511003845.2429846-1-swboyd@chromium.org>
In-Reply-To: <20210511003845.2429846-1-swboyd@chromium.org>
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

From: Stephen Boyd
> Sent: 11 May 2021 01:39
> 
> This series adds the kernel's build ID[1] to the stacktrace header
> printed in oops messages, warnings, etc. and the build ID for any module
> that appears in the stacktrace after the module name. The goal is to
> make the stacktrace more self-contained and descriptive by including the
> relevant build IDs in the kernel logs when something goes wrong. This
> can be used by post processing tools like script/decode_stacktrace.sh
> and kernel developers to easily locate the debug info associated with a
> kernel crash and line up what line and file things started falling apart
> at.
> 
> To show how this can be used I've included a patch to
> decode_stacktrace.sh that downloads the debuginfo from a debuginfod
> server. 
...
> Here's an example lkdtm stacktrace on arm64.
> 
>  WARNING: CPU: 4 PID: 3255 at drivers/misc/lkdtm/bugs.c:83 lkdtm_WARNING+0x28/0x30 [lkdtm]
>  Modules linked in: lkdtm rfcomm algif_hash algif_skcipher af_alg xt_cgroup uinput xt_MASQUERADE
>  CPU: 4 PID: 3255 Comm: bash Not tainted 5.11 #3 aa23f7a1231c229de205662d5a9e0d4c580f19a1
>  Hardware name: Google Lazor (rev3+) with KB Backlight (DT)
...
>  x1 : ffffff93fef15788 x0 : ffffffe3622352e0
>  Call trace:
>   lkdtm_WARNING+0x28/0x30 [lkdtm ed5019fdf5e53be37cb1ba7899292d7e143b259e]
>   direct_entry+0x16c/0x1b4 [lkdtm ed5019fdf5e53be37cb1ba7899292d7e143b259e]
>   full_proxy_write+0x74/0xa4

Is there any way to get it to print each module ID only once?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

