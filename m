Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7389430999E
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 02:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbhAaBUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 20:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232412AbhAaBUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 20:20:20 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97557C061574
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 17:19:40 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id t25so9509744pga.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 17:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=g4cGb0A8UugopWEPcP4EL7ZThXZunWx6+RyJ/ItBnVA=;
        b=FwhoT8kCZ1KxHunWg5EYP4MwyaoEUK38RNJajFVXEAj4w/h3H/3vJD+BJIDlc13SDh
         9vfdmcb88Bifl4cps/BjcG0D/5cPiKVbflUAtrqVxZepCAfC/42o9K19sxBUI1Xz6j7Z
         TJfAGZmNPfT51XixOWC6KIuxtqdmBqYoKAMGgEEk1bCgIqil/4yk8tGxsv0Cu8FW6xNP
         Ko9gdhXuNGXEfO1okQCel9Rpqgp2AwSw9oogPfIZffM7XLQYZC+n23GWutpIJc8hRzy0
         Mo2IB6V1mUXsABiMjbSWrr4nXhJh1o0F/h5SieEpbg6xCOLKa//1olvzhi3sYb0sJ9kD
         Y2EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=g4cGb0A8UugopWEPcP4EL7ZThXZunWx6+RyJ/ItBnVA=;
        b=bZOVjrZkN6JrS92nWbb7z9uAMVui3WQwL7ERkC6pB4FocwB4FuH+XJi4q5Dvi4WrPw
         17NdMRESMOhD9234sSsJLJe/14Y+sSXohocJNdnxg9k3v24DhgZnv+r1DtBnqh97ToOg
         r1TujG9Va3Z97A0EC2OWZfOpRJ+0rr4DZmtsdybaDvNRwnpfhx92NgjYCS7ChA5lL0TI
         xNmR4cytce6Zhd3YukFe3Z9uLXtR8vi5j2UFiAwEnGC2Mc83dnExvqyeBv3nmR5lIqVo
         F1r4hb1+5q704Z4cESJS0ZjA57Dk0gv9IKlszDgMTSBqz0NafZFsthBP4YgnL/EwZQvn
         s1fA==
X-Gm-Message-State: AOAM531yA1nanPIAfxCc5SEIcEwyEBo2c0ncYI6jS857wJsfE4dc8H5a
        XHehLT8c4u7Ov24OAWbuvZo=
X-Google-Smtp-Source: ABdhPJx1mpPAHVecMervxdlGvY7c+PtaaFUFgH5DZRqKy83FJFVnEiO4+nXeMoY3GM4dB9FWmJeyYw==
X-Received: by 2002:a63:3403:: with SMTP id b3mr10899592pga.308.1612055980026;
        Sat, 30 Jan 2021 17:19:40 -0800 (PST)
Received: from [192.168.88.245] (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id p7sm12625366pfn.52.2021.01.30.17.19.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jan 2021 17:19:38 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [RFC 01/20] mm/tlb: fix fullmm semantics
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <CALCETrXsbaHJ+riUjWUJyrAaSyoFmRs17q=6ytf3vC2uYNL0sQ@mail.gmail.com>
Date:   Sat, 30 Jan 2021 17:19:36 -0800
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>, X86 ML <x86@kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <E0013E72-E192-4405-A78D-5D41069ECF76@gmail.com>
References: <20210131001132.3368247-1-namit@vmware.com>
 <20210131001132.3368247-2-namit@vmware.com>
 <CALCETrXsbaHJ+riUjWUJyrAaSyoFmRs17q=6ytf3vC2uYNL0sQ@mail.gmail.com>
To:     Andy Lutomirski <luto@kernel.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Jan 30, 2021, at 5:02 PM, Andy Lutomirski <luto@kernel.org> wrote:
> 
> On Sat, Jan 30, 2021 at 4:16 PM Nadav Amit <nadav.amit@gmail.com> wrote:
>> From: Nadav Amit <namit@vmware.com>
>> 
>> fullmm in mmu_gather is supposed to indicate that the mm is torn-down
>> (e.g., on process exit) and can therefore allow certain optimizations.
>> However, tlb_finish_mmu() sets fullmm, when in fact it want to say that
>> the TLB should be fully flushed.
> 
> Maybe also rename fullmm?

Possible. How about mm_torn_down?

I should have also changed the comment in tlb_finish_mmu().
