Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2EE31EDED
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 19:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbhBRSD7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 18 Feb 2021 13:03:59 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:57350 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232533AbhBRPaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 10:30:21 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-36-PKrX5I6tNO2MkP4XFBpMfg-1; Thu, 18 Feb 2021 15:28:36 +0000
X-MC-Unique: PKrX5I6tNO2MkP4XFBpMfg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 18 Feb 2021 15:28:35 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 18 Feb 2021 15:28:35 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Dmitry V. Levin'" <ldv@altlinux.org>,
        "David S. Miller" <davem@davemloft.net>
CC:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Anatoly Pugachev <matorola@gmail.com>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] sparc: make copy_thread honor pid namespaces
Thread-Topic: [PATCH] sparc: make copy_thread honor pid namespaces
Thread-Index: AQHXBZd//RPPXGWEKk+rLobcOpszAqpeCBzA
Date:   Thu, 18 Feb 2021 15:28:35 +0000
Message-ID: <05247c8b0e31420a9e6e7a43831212ff@AcuMS.aculab.com>
References: <20210217080000.GA25861@altlinux.org>
In-Reply-To: <20210217080000.GA25861@altlinux.org>
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

From: Dmitry V. Levin
> Sent: 17 February 2021 08:00
> 
> On sparc, fork and clone syscalls have an unusual semantics of
> returning the pid of the parent process to the child process.

Isn't that just broken?
The application expects fork() to return 0 in the child.
libc would have to do horrid things to convert the result.

It could be comparing against the saved 'current pid' in
order to save a system call for the first ppid() call.
But that isn't ever going to work if it is possible to
create a child in a different pid namespace.

FWIW the test program ought to use syscall() to get the pid
and ppid - rather than relying on any optimisations in libc.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

