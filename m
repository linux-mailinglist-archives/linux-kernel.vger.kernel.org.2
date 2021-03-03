Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 826DF32BEBB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575355AbhCCReq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 3 Mar 2021 12:34:46 -0500
Received: from mail.kingsoft.com ([114.255.44.146]:46068 "EHLO
        mail.kingsoft.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S238859AbhCCORJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 09:17:09 -0500
X-AuditID: 0a580157-f39ff7000005df43-be-603f796e2583
Received: from mail.kingsoft.com (localhost [10.88.1.32])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-1-NODE-87) with SMTP id E5.5F.57155.E697F306; Wed,  3 Mar 2021 19:56:30 +0800 (HKT)
Received: from alex-virtual-machine (172.16.253.254) by KSBJMAIL2.kingsoft.cn
 (10.88.1.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 3 Mar 2021
 20:24:02 +0800
Date:   Wed, 3 Mar 2021 20:24:02 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     Andy Lutomirski <luto@amacapital.net>
CC:     "Luck, Tony" <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        <yangfeng1@kingsoft.com>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, <yaoaili@kingsoft.com>
Subject: Re: [PATCH v3] x86/fault: Send a SIGBUS to user process always for
 hwpoison page access.
Message-ID: <20210303202402.384265a3@alex-virtual-machine>
In-Reply-To: <59469ECC-5316-4074-98EF-52FFF7940818@amacapital.net>
References: <8d0c76f97f35499f91a2b82d3e7c024d@intel.com>
        <59469ECC-5316-4074-98EF-52FFF7940818@amacapital.net>
Organization: kingsoft
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL2.kingsoft.cn
 (10.88.1.32)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsXCFcGooJtXaZ9g0PBYzOLzhn9sFi82tDNa
        TNsobnF51xw2i3tr/rNarF7bwGpxftdaVotLBxYwWVxsPMBocbz3AJPF5k1TmS3eXLjHYvFj
        w2NWB16P7619LB733/xl8di8Qstj8Z6XTB6bVnWyeWz6NInd4925c+we804Gery4upHF4/2+
        q2wenzfJeZxo+cIawBPFZZOSmpNZllqkb5fAldHTvIW54AJXxY1T/9kbGNdxdDFyckgImEjc
        3TiVvYuRi0NIYDqTRP/WHmYI5yWjxM5vfSxdjBwcLAIqEtO+GYE0sAmoSuy6N4sVxBYR0JR4
        OWU+C0g9s8BLZoltb2YxgySEBZIlzkx6wAhi8wpYSXS0bQGLcwo4SRyfs5EJxBYSKJD42dLI
        AmLzC4hJ9F75zwRxkb1E25ZFUL2CEidnPgGrYQZa1rr9NzuErS2xbOFrZog5ihKHl/xih+hV
        kjjSPYMNwo6VWDbvFesERuFZSEbNQjJqFpJRCxiZVzGyFOemG25ihERi+A7GeU0f9Q4xMnEw
        HmKU4GBWEuEVf2mbIMSbklhZlVqUH19UmpNafIhRmoNFSZy3xck+QUggPbEkNTs1tSC1CCbL
        xMEp1cDEOucYx61ojSWTj4aHpl34o8HWONfo3R3TpMPSU7/7rzD4djQ/fxfnG7c9Rc82Vi5Y
        rXH/nqnchyAe33mbn0hvrzn9bP4K7f8XahYssNdQt/jX7Kr4d13x4SfMC3hyJ0yYuLLU6bXn
        68mvDkbU8/BJBu264h1mHet4dOnH/2Z6xatSW++/m8tbt6n80q003xkMieZbbZfu4N2z+nz1
        dc7qXz+23f839/jcyb+dznyT7TjaP03Llsvv5N6dG6f4OjltP+NabZaZLVKxh+3uGj2+DdOd
        zA/NSPdL2pcnvV6CVX2rsthWIxWOzhLmkJNf6/ekz6jL++08/4FL2wfFs3nvEud0zP+pfcU/
        5PYKs42u1kosxRmJhlrMRcWJAEUw0kwzAwAA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Mar 2021 11:09:36 -0800
Andy Lutomirski <luto@amacapital.net> wrote:

> > On Mar 1, 2021, at 11:02 AM, Luck, Tony <tony.luck@intel.com> wrote:
> > 
> > ﻿  
> >> 
> >> Some programs may use read(2), write(2), etc as ways to check if
> >> memory is valid without getting a signal.  They might not want
> >> signals, which means that this feature might need to be configurable.  
> > 
> > That sounds like an appalling hack. If users need such a mechanism
> > we should create some better way to do that.
> >   
> 
> Appalling hack or not, it works. So, if we’re going to send a signal to user code that looks like it originated from a bina fide architectural recoverable fault, it needs to be recoverable.  A load from a failed NVDIMM page is such a fault. A *kernel* load is not. So we need to distinguish it somehow.

Sorry for my previous mis-understanding, and i have some questions: 
if programs use read,write to check if if memory is valid, does it really want to cover the poison case? 
When for such a case, an error is returned,  can the program realize it's hwposion issue not other software error and process correctly?

if this is the proper action, the original posion flow in current code from read and write need to change too.

-- 
Thanks!
Aili Yao
