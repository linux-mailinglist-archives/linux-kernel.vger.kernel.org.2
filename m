Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1776B43BA4A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 21:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232924AbhJZTJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 15:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbhJZTJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 15:09:07 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86062C061570
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 12:06:43 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id t7so438399pgl.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 12:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=EJh7ZcC2grrGO9nq0Nd8wB/2nJ7WWNVSIfZil/98gt8=;
        b=GjyKWLQJUKh8TkQ6X6zqdLjL711sDfJFgFpKn6UiAKnJvgxgOKP8W03app1FZUphoj
         XmeMtGlSohmdCVCBRgRsyOqOku3kGYDs/r+IyOCr2Het3vGy7cZxLL/EsgI7kbN7Ptrj
         kcOFHTywLCsCpFHDeALTx7m4HUaa/McdUF634Ua50ZNZN8QFSFx1vHo4LKSk4QWd/4uG
         b5m1/PF+F0MC3Q+kmBQlOyC7O14YCmZZcEs4xEc5nwfrxSLL67jyF1k37JG6NYNraGEZ
         GtZpVTbul5Bdfxkeam3h9oN/cXhlazLB+WD0dNPuF4gLqjHn6M6meqvLvpstQSBSpIEv
         Bf3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=EJh7ZcC2grrGO9nq0Nd8wB/2nJ7WWNVSIfZil/98gt8=;
        b=bg3bQ91yP0ylFHsFyvcaol7Tx4jR+f7/j119mYmhFOZ+p//2a2x7jR6sseF2+eGvPS
         eFQ0K1VQrES7CpDV+x+fc7ZEzZVTb3KiT+ebDemB1kAGuXSVsLt0L+b/uU/K0z7tmWZR
         v69kWS9szA3jeNlXOzZ04iGSUze9vqZXoKiTnMM+K38CirEul0abuelh3uG2O32Axq95
         vsJVdA4FyBaQV9hge1gFC9/3opQxX6EzKen5H93ec5rOoqnY3NGBrom/zHo2GxGYpWIs
         eEBW1NTgGYjVveJra7msQk8r2Jmt2rc6JinCrwSZNWI6jv2u2uf39Ddfjn24D9Cr2amU
         PZOA==
X-Gm-Message-State: AOAM531oF+OcWoPde6NMkGB6hFjI6/XaWEOUD+YwUQkavwX111W0KxaT
        AKdBnmigXcMOlwNzlyYN8fQ=
X-Google-Smtp-Source: ABdhPJzzPpdTpGuVeS0gC+5ijhnpjBOIJ70BbFzpBC6srcahv8VsxXgZTBY/f1tPPjPuPg+Oj97chA==
X-Received: by 2002:a63:fb18:: with SMTP id o24mr20405269pgh.8.1635275202596;
        Tue, 26 Oct 2021 12:06:42 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id h35sm7895669pgh.71.2021.10.26.12.06.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Oct 2021 12:06:42 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH v2 2/5] mm: avoid unnecessary flush on change_huge_pmd()
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <435f41f2-ffd4-0278-9f26-fbe2c2c7545c@intel.com>
Date:   Tue, 26 Oct 2021 12:06:40 -0700
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8BC74789-FF33-403F-B5D7-19034CAC7EE6@gmail.com>
References: <20211021122112.592634-1-namit@vmware.com>
 <20211021122112.592634-3-namit@vmware.com>
 <c415820a-aebb-265c-7f47-e048ee429102@intel.com>
 <E38AEB97-DE1B-4C91-A959-132EC24812AE@vmware.com>
 <29E7E8A4-C400-40A5-ACEC-F15C976DDEE0@gmail.com>
 <435f41f2-ffd4-0278-9f26-fbe2c2c7545c@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 26, 2021, at 11:44 AM, Dave Hansen <dave.hansen@intel.com> =
wrote:
>=20
> On 10/26/21 10:44 AM, Nadav Amit wrote:
>>> "If software on one logical processor writes to a page while =
software on
>>> another logical processor concurrently clears the R/W flag in the
>>> paging-structure entry that maps the page, execution on some =
processors may
>>> result in the entry=E2=80=99s dirty flag being set (due to the write =
on the first
>>> logical processor) and the entry=E2=80=99s R/W flag being clear (due =
to the update
>>> to the entry on the second logical processor). This will never occur =
on a
>>> processor that supports control-flow enforcement technology (CET)=E2=80=
=9D
>>>=20
>>> So I guess that this optimization can only be enabled when CET is =
enabled.
>>>=20
>>> :(
>> I still wonder whether the SDM comment applies to present bit vs =
dirty
>> bit atomicity as well.
>=20
> I think it's implicit.  =46rom "4.8 ACCESSED AND DIRTY FLAGS":
>=20
> 	"Whenever there is a write to a linear address, the processor
> 	 sets the dirty flag (if it is not already set) in the paging-
> 	 structure entry"
>=20
> There can't be a "write to a linear address" without a Present=3D1 =
PTE.
> If it were a Dirty=3D1,Present=3D1 PTE, there's no race because there =
might
> not be a write to the PTE at all.
>=20
> There's also this from the "4.10.4.3 Optional Invalidation" section:
>=20
> 	"no TLB entry or paging-structure cache entry is created with
> 	 information from a paging-structure entry in which the P flag
> 	 is 0."
>=20
> That means that we don't have to worry about the TLB doing something
> bonkers like caching a Dirty=3D1 bit from a Present=3D0 PTE.
>=20
> Is that what you were worried about?

Thanks Dave, but no - that is not my concern.

To make it very clear - consider the following scenario, in which
a volatile pointer p is mapped using a certain PTE, which is RW
(i.e., *p is writable):

  CPU0				CPU1
  ----				----
  x =3D *p
  [ PTE cached in TLB;=20
    PTE is not dirty ]
				clear_pte(PTE)
  *p =3D x
  [ needs to set dirty ]

Note that there is no TLB flush in this scenario. The question
is whether the write access to *p would succeed, setting the
dirty bit on the clear, non-present entry.

I was under the impression that the hardware AD-assist would
recheck the PTE atomically as it sets the dirty bit. But, as I
said, I am not sure anymore whether this is defined architecturally
(or at least would work in practice on all CPUs modulo the=20
Knights Landing thingy).

