Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEE7732BE30
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385232AbhCCRJJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 3 Mar 2021 12:09:09 -0500
Received: from mail.kingsoft.com ([114.255.44.146]:46060 "EHLO
        mail.kingsoft.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S239436AbhCCMwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 07:52:37 -0500
X-AuditID: 0a580155-713ff700000550c6-8a-603f7f0a80d2
Received: from mail.kingsoft.com (localhost [10.88.1.32])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-2-NODE-85) with SMTP id A7.FF.20678.A0F7F306; Wed,  3 Mar 2021 20:20:26 +0800 (HKT)
Received: from alex-virtual-machine (172.16.253.254) by KSBJMAIL2.kingsoft.cn
 (10.88.1.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 3 Mar 2021
 20:51:29 +0800
Date:   Wed, 3 Mar 2021 20:51:29 +0800
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
Message-ID: <20210303205129.0a66f7a7@alex-virtual-machine>
In-Reply-To: <20210303202402.384265a3@alex-virtual-machine>
References: <8d0c76f97f35499f91a2b82d3e7c024d@intel.com>
        <59469ECC-5316-4074-98EF-52FFF7940818@amacapital.net>
        <20210303202402.384265a3@alex-virtual-machine>
Organization: kingsoft
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL2.kingsoft.cn
 (10.88.1.32)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEIsWRmVeSWpSXmKPExsXCFcGooMtVb59gcGCtscXnDf/YLF5saGe0
        mLZR3OLyrjlsFvfW/Ge1WL22gdXi/K61rBaXDixgsrjYeIDR4njvASaLzZumMlu8uXCPxeLH
        hsesDrwe31v7WDzuv/nL4rF5hZbH4j0vmTw2repk89j0aRK7x7tz59g95p0M9HhxdSOLx/t9
        V9k8Pm+S8zjR8oU1gCeKyyYlNSezLLVI3y6BK2Pt0fOsBVf4KuY+ec3awLiLu4uRk0NCwERi
        YfNH1i5GLg4hgelMEksPN7NAOC8ZJd607GEHqWIRUJHY3PYPzGYTUJXYdW8WK4gtIqAp8XLK
        fLAGZoGXzBLb3sxiBkkICyRLnJn0gBHE5hWwkrg+aztYnFPAWuL/zsmMEBsWMkqsWv4ZrIhf
        QEyi98p/Joib7CXatiyCahaUODnzCQuIzQy0rXX7b3YIW1ti2cLXYEOFBBQlDi/5xQ7RqyRx
        pHsGG4QdK7Fs3ivWCYzCs5CMmoVk1CwkoxYwMq9iZCnOTTfaxAiJxtAdjDOaPuodYmTiYDzE
        KMHBrCTCK/7SNkGINyWxsiq1KD++qDQntfgQozQHi5I479StJglCAumJJanZqakFqUUwWSYO
        TqkGpsfd12fLxHJpMbzk/3x7dUjrXD5Bjmlc/nrmfPu6BFJ3KS86KZd53kCuJiXJbbuQ4DHF
        HTvTd5u0NMVXhHrnTEk8crG6OGjLRm/ZZ8t3KR77l5rH4P1i3dEN58P4/EXKmo/r6me3iHun
        tnDVzWJd6CO+Qq771uKZFkGre3blyxX9dWky9flZUXX48cTMOY9dom5Mtk5wMg+rXiS50sd1
        z+KC66y7NBZd+mv0sEBAWEziVqGG7YV75oyL//6XKrkwed6GmXF7s6x+iqfd23el5bKM43Hu
        xwea2C6F+n09ebfM0eVwMYvVkVybOYITKye5/t79quJjmPaZ56yZhVxLLrSz3uESu6848+tB
        lc81SizFGYmGWsxFxYkAdcD1LDUDAAA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Mar 2021 20:24:02 +0800
Aili Yao <yaoaili@kingsoft.com> wrote:

> On Mon, 1 Mar 2021 11:09:36 -0800
> Andy Lutomirski <luto@amacapital.net> wrote:
> 
> > > On Mar 1, 2021, at 11:02 AM, Luck, Tony <tony.luck@intel.com> wrote:
> > > 
> > > ﻿    
> > >> 
> > >> Some programs may use read(2), write(2), etc as ways to check if
> > >> memory is valid without getting a signal.  They might not want
> > >> signals, which means that this feature might need to be configurable.    
> > > 
> > > That sounds like an appalling hack. If users need such a mechanism
> > > we should create some better way to do that.
> > >     
> > 
> > Appalling hack or not, it works. So, if we’re going to send a signal to user code that looks like it originated from a bina fide architectural recoverable fault, it needs to be recoverable.  A load from a failed NVDIMM page is such a fault. A *kernel* load is not. So we need to distinguish it somehow.  
> 
> Sorry for my previous mis-understanding, and i have some questions: 
> if programs use read,write to check if if memory is valid, does it really want to cover the poison case? 
> When for such a case, an error is returned,  can the program realize it's hwposion issue not other software error and process correctly?
> 
> if this is the proper action, the original posion flow in current code from read and write need to change too.
> 

Sorry, another question:
  When programs use read(2), write(2) as ways to check if memory is valid, does it really want to check if the user page the program provided is valid, not the destination or disk space valid?
  the patch will not affect this purpose as it's only valid for user page which program provide to write or some syscall similiar parameter.

-- 
Thanks!
Aili Yao
