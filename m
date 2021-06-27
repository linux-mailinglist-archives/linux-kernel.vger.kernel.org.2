Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4EA3B52F4
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jun 2021 12:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbhF0LAV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 27 Jun 2021 07:00:21 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:40900 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229702AbhF0LAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 07:00:20 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-263-7lwpbNj6OtqYhchRB1BMHg-1; Sun, 27 Jun 2021 11:57:49 +0100
X-MC-Unique: 7lwpbNj6OtqYhchRB1BMHg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Sun, 27 Jun
 2021 11:57:48 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.018; Sun, 27 Jun 2021 11:57:48 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Marcos Del Sol Vives' <marcos@orca.pet>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] x86: add NOPL and CMOV emulation
Thread-Topic: [PATCH v3] x86: add NOPL and CMOV emulation
Thread-Index: AQHXaozP8c4yxHibnUSLg8MhMaAkx6snr31w
Date:   Sun, 27 Jun 2021 10:57:48 +0000
Message-ID: <4b8e1393929b47d29a996f07cd332c65@AcuMS.aculab.com>
References: <YNWAwVfzSdML/WhO@hirez.programming.kicks-ass.net>
 <20210626130313.1283485-1-marcos@orca.pet>
In-Reply-To: <20210626130313.1283485-1-marcos@orca.pet>
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

From: Marcos Del Sol Vives
> Sent: 26 June 2021 14:03
> 
> NOPL and CMOV are a set of instructions that were introduced to the
> x86 architecture with the i686 ISA in 1995, first implemented in the
> Intel Pentium Pro and Pentium II processors.
> 
> While virtually all desktop and server systems are modern enough to
> support these instructions, in the embedded market things are a little
> bit different: DM&P is still manufacturing their i586-only Vortex86
> SoCs, and many embedded devices still in use are stuck on legacy SoCs
> that either are i586-only (AMD Elan, AMD Geode GX1) or implement i686
> but lack the NOPL instructions (Transmeta devices, AMD Geode LX).
> 
> This is a problem because most modern Linux distributions, such as
> Debian and all its derivatives, have started compiling targeting i686,
> leaving old embedded devices using binary distributions without an
> easy upgrade path.
> 
> This ultimately results in most of these embedded devices running
> years old, insecure and obsolete installations, and this itself can be
> seen on the DM&P's own supported OS page where the newest supported
> desktop Linux distro is Ubuntu 18.04, already three years old.
> 
> The emulation of these instructions thus allow upgrading to newer
> distributions just by replacing the kernel, keeping all precompiled
> binaries intact.
...

Does this really help?
1) Trapping and emulating the instructions will be slow.
2) All 64bit cpus support these instructions - so these must be 32bit.
   I believe the main distributions are about to drip 32bit support.

It also has to be said that using Ubuntu in an embedded device
is about as sensible as running windows.
There is far too much 'crud' running that you don't need and
is only likely to result in security breaches.

Much better is something based on busybox+buildroot where you
have (almost) complete control of the system userspace and
can easily build a kernel that only has support for the required
hardware from one of the LTS kernel trees.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

