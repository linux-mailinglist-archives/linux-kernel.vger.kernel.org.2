Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5416634DCAF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 01:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbhC2X7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 19:59:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:46516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229483AbhC2X6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 19:58:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7CD356198F
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 23:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617062316;
        bh=y4/nQ2NJ15kfnjgQeIFt//HT+JMrIM7YsLMqYRqzpGU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fDnpp2fR9OY3noYzv8O2MY9W6zCrarGCV0aAhW8LZPlY744osQ/EHR5Olfrr9007/
         VGUxnCNMDBHEQBUPKrMf0GwfuMzIEUw+nf+AvbwGdMJCHbz2fVzsnyqYmoeuY+6H+e
         w06TUAMAGQnUgLN0yu8g5jIn1TvyHaYPYDgrnJurkeTLFICiivhkxepLk9ruCc1FMs
         UZd3QeGbhxTh/ioI4dC2BAjizFIMJGJhbQRZHr122jdsKpa0XOVbNJGT+aWx8iEGnA
         AsWFsvY4FmsP5RneVyjhPGsrQ5YUtHU0KOILQVKac1mKOWBHEimgPmxoQwhd95N4th
         /t9x9M5ny69UQ==
Received: by mail-ej1-f53.google.com with SMTP id e14so21998940ejz.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 16:58:36 -0700 (PDT)
X-Gm-Message-State: AOAM531/DwpDqqBMBoo3JBswABykJ0BDbGdkglXiCmHjVtiORM3jX/ww
        D51ekY0tAYHcUeXryUcrIiZzyDRWtWURTgYU4nWEjw==
X-Google-Smtp-Source: ABdhPJym+UtibdP6gMYUb+Pa8SZM9AYZuLZDL197dyiKxOqqwQCvbi23cE5HZ2wrhE/M6kweXYxeZ3oodND5pHjYPCw=
X-Received: by 2002:a17:906:130c:: with SMTP id w12mr30845572ejb.253.1617062315080;
 Mon, 29 Mar 2021 16:58:35 -0700 (PDT)
MIME-Version: 1.0
References: <837afe840f5826bf7fcba07a5e483d7e2283db34.1617059703.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <377A7B0B-9959-4AFC-A575-7AC20FEE6077@amacapital.net> <10834a17-cae4-d0e3-c82b-f69da7f9141a@linux.intel.com>
 <YGJl93hlKngWLGwz@google.com>
In-Reply-To: <YGJl93hlKngWLGwz@google.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 29 Mar 2021 16:58:23 -0700
X-Gmail-Original-Message-ID: <CALCETrVzdq7eQu6RfJd0+yuJ+Q9Q6NykVb+x_jiNwLW2-mrh0w@mail.gmail.com>
Message-ID: <CALCETrVzdq7eQu6RfJd0+yuJ+Q9Q6NykVb+x_jiNwLW2-mrh0w@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] x86/tdx: Handle MWAIT, MONITOR and WBINVD
To:     Sean Christopherson <seanjc@google.com>
Cc:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 4:42 PM Sean Christopherson <seanjc@google.com> wro=
te:
>
> On Mon, Mar 29, 2021, Kuppuswamy, Sathyanarayanan wrote:
> >
> >
> > On 3/29/21 4:23 PM, Andy Lutomirski wrote:
> > >
> > > > On Mar 29, 2021, at 4:17 PM, Kuppuswamy Sathyanarayanan <sathyanara=
yanan.kuppuswamy@linux.intel.com> wrote:
> > > >
> > > > =EF=BB=BFIn non-root TDX guest mode, MWAIT, MONITOR and WBINVD inst=
ructions
> > > > are not supported. So handle #VE due to these instructions
> > > > appropriately.
> > >
> > > Is there something I missed elsewhere in the code that checks CPL?
> > We don't check for CPL explicitly. But if we are reaching here, then we
> > executing these instructions with wrong CPL.
>
> No, if these instructions take a #VE then they were executed at CPL=3D0. =
 MONITOR
> and MWAIT will #UD without VM-Exit->#VE.  Same for WBINVD, s/#UD/#GP.

Dare I ask about XSETBV?
