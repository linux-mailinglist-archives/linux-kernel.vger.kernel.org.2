Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D92FA34FE5E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 12:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235107AbhCaK4z convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 31 Mar 2021 06:56:55 -0400
Received: from mail.kingsoft.com ([114.255.44.146]:51582 "EHLO
        mail.kingsoft.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S235065AbhCaK4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 06:56:43 -0400
X-AuditID: 0a580155-f55ff70000015057-86-60645566c9eb
Received: from mail.kingsoft.com (localhost [10.88.1.79])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-2-NODE-85) with SMTP id FF.F3.20567.66554606; Wed, 31 Mar 2021 18:56:38 +0800 (HKT)
Received: from alex-virtual-machine (172.16.253.254) by KSBJMAIL4.kingsoft.cn
 (10.88.1.79) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 31 Mar
 2021 18:56:38 +0800
Date:   Wed, 31 Mar 2021 18:56:37 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     Oscar Salvador <osalvador@suse.de>,
        "HORIGUCHI =?UTF-8?B?TkFPWUE=?=( =?UTF-8?B?5aCA5Y+j44CA55u05Lmf?=)" 
        <naoya.horiguchi@nec.com>, "david@redhat.com" <david@redhat.com>
CC:     "tony.luck@intel.com" <tony.luck@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "inux-edac@vger.kernel.org" <inux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "yangfeng1@kingsoft.com" <yangfeng1@kingsoft.com>,
        <yaoaili@kingsoft.com>
Subject: Re: [PATCH] mm,hwpoison: return -EBUSY when page already poisoned
Message-ID: <20210331185637.76f863e2@alex-virtual-machine>
In-Reply-To: <20210225113930.GA7227@localhost.localdomain>
References: <20210224151619.67c29731@alex-virtual-machine>
        <20210224103105.GA16368@linux>
        <20210225114329.4e1a41c6@alex-virtual-machine>
        <20210225112818.GA10141@hori.linux.bs1.fc.nec.co.jp>
        <20210225113930.GA7227@localhost.localdomain>
Organization: kingsoft
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL4.kingsoft.cn
 (10.88.1.79)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsXCFcHor5sWmpJg8KxL2WLO+jVsFp83/GOz
        +Lr+F7PFtI3iFrcPrGG0uLxrDpvFvTX/WS0uHVjAZHGx8QCjxZlpRRabN01ltnhz4R6LxY8N
        j1kdeD2+t/axeCze85LJY9OqTjaPTZ8msXu8O3eO3ePEjN8sHi+ubmTxeL/vKpvH5tPVHp83
        yXmcaPnCGsAdxWWTkpqTWZZapG+XwJUxu+EXU8FKvoqZV9cwNTAu4u5i5OSQEDCRePz3DSOI
        LSQwnUmi9ZFsFyMXkP2KUWLP2152kASLgKrEjYdtYDYbkL3r3ixWkCIRgQ2MEh9fTmMEcZgF
        ZrJINO5pYQKpEhbwkvhyfy3YWF4BK4mjuz+CxTmB7FXrp7NCrPjMKDFzQR8bSIJfQEyi98p/
        Joib7CXatiyCahaUODnzCQuIzSygKdG6/Tc7hK0tsWzha2aIuxUlDi/5xQ7RqyRxpHsGG4Qd
        K9F04BbbBEbhWUhGzUIyahaSUQsYmVcxshTnphttYoTEYOgOxhlNH/UOMTJxMB5ilOBgVhLh
        FT6QmCDEm5JYWZValB9fVJqTWnyIUZqDRUmc9/uDpAQhgfTEktTs1NSC1CKYLBMHp1QDk/Cd
        cO+p56Y4R8w+8uauOueqTaGv4zxKpm58LpN5KYfD9dGe02WTbbcncvbsrd29PW3NioJ/36c7
        1gmvaK/zF00udKi4ssh9TZ5Hn8Yc8x1z172ePH2v7IIm/Zxb7NtvVgpw6bx/3RM5vZllWf6h
        puD7DPvk/v799c189mO9uObXcrNf1BbucM3qSa1t/eH4eeGqs4+ZHyezMZ6aG/MnbufcECON
        D/9jOO+0PJVvU8hY1F/S+pWniu1QsqL+vv3Vv3rvrNGIupTzKbgo8k5e4dHNG2e93+hkuaBi
        yo3PK1ZkVK9ZyS24c/fuxcr6Jy2iDua+aou687rfesWz2rgf3y+GL8yuFRT0e6l+k31rjakS
        S3FGoqEWc1FxIgBKt0PeMAMAAA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Feb 2021 12:39:30 +0100
Oscar Salvador <osalvador@suse.de> wrote:

> On Thu, Feb 25, 2021 at 11:28:18AM +0000, HORIGUCHI NAOYA(堀口 直也) wrote:
> > Hi Aili,
> > 
> > I agree that this set_mce_nospec() is not expected to be called for
> > "already hwpoisoned" page because in the reported case the error
> > page is already contained and no need to resort changing cache mode.  
> 
> Out of curiosity, what is the current behavour now?
> Say we have an ongoing MCE which has marked the page as HWPoison but
> memory_failure did not take any action on the page yet.
> And then, we have another MCE, which ends up there.
> set_mce_nospec might clear _PAGE_PRESENT bit.
> 
> Does that have any impact on the first MCE?
> 
> > It seems to me that memory_failure() does not return MF_XXX.  But yes,
> > returning some positive value for the reported case could be a solution.  
> 
> No, you are right. I somehow managed to confuse myself.
> I see now that MF_XXX return codes are filtered out in page_action.
> 
> > We could use some negative value (error code) to report the reported case,
> > then as you mentioned above, some callers need change to handle the
> > new case, and the same is true if you use some positive value.
> > My preference is -EHWPOISON, but other options are fine if justified well.  
> 
> -EHWPOISON seems like a good fit.
> 

Hi Oscar, david:

Long away fron this topic, but i noticed today I made a stupid mistake that EHWPOISON is already
been declared, so we should better return EHWPOISON for this case.

Really sorry for this!

As the patch is still under review, I will post a new version for this, if I change this, may I add
your review tag here please?

-- 
Thanks!
Aili Yao
