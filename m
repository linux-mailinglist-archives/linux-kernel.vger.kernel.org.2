Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4876030A2B4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 08:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbhBAHbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 02:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbhBAHbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 02:31:41 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF849C061573
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 23:31:00 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id x9so3563283plb.5
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 23:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=7Wf2cF3e9k78cMqXqvh0XRPIL3bx/v81G3vSujturaQ=;
        b=gFXIhpd6zrAtV68bLKBOirmY30iP6XeWOd2pMFptBGFPOx2izYqJfFNyH/+5L1GSFa
         GIValQNF77bIxo0Fz1GaAeR7sDwS/nRDQcJIPns7LpVlbBcWOcwx9DXPCyNlvBz+Usyi
         Qc/jpgxXc5NTSkT8FjSu9Aq5x4n6cm4d0GAzMMDh/skFKEM10SA28x20bOv7KSokkfMW
         INCwOiSrScbxhbXzJLQeWWYtt0r7JpLRzjw61PJRfsWNAEF+uFk9yoCuRhKtDdMkyRUU
         JzEQmoJT8PjykTdjCHdSgDSzptfgU8cFHYL2k1B6pF5x5tVA9OkMKxXYFF3Alfp+TxGP
         opBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=7Wf2cF3e9k78cMqXqvh0XRPIL3bx/v81G3vSujturaQ=;
        b=leyo+TVqepGEqZCBwpb02hWP5M9qaIglvWbiohc1iICnNmiPLQaEdJJfDtAeMoUdra
         csswYfPaSo88Ae7aae4v+bp80NAurKR0ea+H3R34h0why1twRA3z3ONb7S1P75XGF/VW
         ZcrB6eAOy0NwgdghNMpU0k3eIfBsFAs8e3xBhy2e6ZnNHzdqqUIYBR/JaAw2nIXziSHG
         uYaRcPoeu47kwW5PH4qzFp0lQFXlSd//006J9SyZtZSOq4ycZIDTatMKW7JmDMgq/CEg
         dJlHUEeOld16py/6Rhvx4YXEWE6blm1UMMOEXSzOnOVXrrzRK3X9y+HqGHe7mAb9ZuF5
         AbGQ==
X-Gm-Message-State: AOAM530QK+mDZVgdU0DmI/EFDYwB7C0yGjvGGXSLRzd9ukbqGf0eKQeu
        VaQptF0SmYCm3IRWxPi/AbM=
X-Google-Smtp-Source: ABdhPJz0ZqAE366h/178v/KlQ+Tc6wTwuG1a9cdJ+MYsq8EY5/qjVIeXswPLwymf4UsOEkyq+uSmfw==
X-Received: by 2002:a17:90a:ca8f:: with SMTP id y15mr863895pjt.119.1612164659920;
        Sun, 31 Jan 2021 23:30:59 -0800 (PST)
Received: from [192.168.88.245] (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id l13sm14950502pjh.2.2021.01.31.23.30.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Jan 2021 23:30:59 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [RFC 01/20] mm/tlb: fix fullmm semantics
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <CALCETrU8DCiu7Rfqr_z-aj_pFzTid3qkaN9g-Biq_A+99NVpdQ@mail.gmail.com>
Date:   Sun, 31 Jan 2021 23:30:57 -0800
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>, X86 ML <x86@kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <4A2E5039-D8EA-4689-8147-4F12338CFBBE@gmail.com>
References: <20210131001132.3368247-1-namit@vmware.com>
 <20210131001132.3368247-2-namit@vmware.com>
 <CALCETrXsbaHJ+riUjWUJyrAaSyoFmRs17q=6ytf3vC2uYNL0sQ@mail.gmail.com>
 <E0013E72-E192-4405-A78D-5D41069ECF76@gmail.com>
 <CALCETrU8DCiu7Rfqr_z-aj_pFzTid3qkaN9g-Biq_A+99NVpdQ@mail.gmail.com>
To:     Andy Lutomirski <luto@kernel.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Jan 30, 2021, at 6:57 PM, Andy Lutomirski <luto@kernel.org> wrote:
> 
> On Sat, Jan 30, 2021 at 5:19 PM Nadav Amit <nadav.amit@gmail.com> wrote:
>>> On Jan 30, 2021, at 5:02 PM, Andy Lutomirski <luto@kernel.org> wrote:
>>> 
>>> On Sat, Jan 30, 2021 at 4:16 PM Nadav Amit <nadav.amit@gmail.com> wrote:
>>>> From: Nadav Amit <namit@vmware.com>
>>>> 
>>>> fullmm in mmu_gather is supposed to indicate that the mm is torn-down
>>>> (e.g., on process exit) and can therefore allow certain optimizations.
>>>> However, tlb_finish_mmu() sets fullmm, when in fact it want to say that
>>>> the TLB should be fully flushed.
>>> 
>>> Maybe also rename fullmm?
>> 
>> Possible. How about mm_torn_down?
> 
> Sure.  Or mm_exiting, perhaps?

mm_exiting indeed sounds better.
