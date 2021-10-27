Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54F7043D09E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 20:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243517AbhJ0SZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 14:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236888AbhJ0SZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 14:25:14 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3515C061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 11:22:47 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 205so6156431ljf.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 11:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2PjuNeHqkEC+TnHGw+HkK8UIEzWJEETPPBQlrocuPTU=;
        b=lLMbuFSOE+jF05Bi6R4jcYzGGMqVatV0odlAiYllsUoS+qAXv+ZpDMJuO5RzvOZQdR
         D5tjHrdYUtdnoQJ2rdnv/Enk+JCyKcnZYsLwSvVUd2I146BN/2hQLFX930ofc0g8kChC
         LJLBtzwRRmFlnqrm6RLIGt7FmuYCoS3sn+evJa3IP7AyvkYRDCV58BO4FURlVuUuyFZD
         3WHotNhKoHU90flIseiCDMZliZTbAy9pi6BHt0mF+npdL26WjVvhqge51TReCgfRK65U
         YtNs40Mn+uDoVgm3W0QrcKs/y6Ne4Cg7ShmPQayK69U5W0XAoyiwEvLGrevriNMj3FH1
         pOeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2PjuNeHqkEC+TnHGw+HkK8UIEzWJEETPPBQlrocuPTU=;
        b=zByH6+jdiQwQmTvowmAL/fyNiY+C9358r0/mjjW2XK15924E+7UcV8wLCAqK7j7D8V
         tK4JwEU58WdmhrcQstfjAJSzxri+CM+9KqXlEpCLD1J2X3ktZf3I6E4xI/s/zbPh1KqL
         0tsPDd08I7gWhnTZizYaecFSoua4cMkRMbzv3RP/0UdB65Zhf4sqF38+utN0tm2YbiDF
         4ExoX0Jvlla8eywdrPJZLpVnvMbJ41UDSNuT1A+ifH9hB4KDzYPz9efPckPLph34YUWg
         2z6Pn+bY9+/eDtb+calYkd4nSxSUbNl9ZFI/Hix/39iAHs746zUuE4hvht5UYwKwgIr+
         0xPw==
X-Gm-Message-State: AOAM532Od+1cn95xBS/HaDo63cw9q4tKJP9nzu0wWXbjceEP89tlv8RZ
        UZTXtITRkj2sBg/bxgVw2PclsjdeoQhhmpuvcNbqBw==
X-Google-Smtp-Source: ABdhPJzTT0dOmYBCYBy1pf627CzSQYcktFnt+YBoCzZGxCnrzYDdLm3N9GGUHg1utxfan0QOSwZl3MzUHr4ArxOXuMA=
X-Received: by 2002:a05:651c:c3:: with SMTP id 3mr4927747ljr.355.1635358966211;
 Wed, 27 Oct 2021 11:22:46 -0700 (PDT)
MIME-Version: 1.0
References: <20211026173822.502506-1-pasha.tatashin@soleen.com>
 <20211026173822.502506-2-pasha.tatashin@soleen.com> <CAMZfGtVS2ZRAsd9HLODoLa1vVp0XCcBOTXjsmpoWwDcdGaADvQ@mail.gmail.com>
In-Reply-To: <CAMZfGtVS2ZRAsd9HLODoLa1vVp0XCcBOTXjsmpoWwDcdGaADvQ@mail.gmail.com>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 27 Oct 2021 14:22:08 -0400
Message-ID: <CA+CK2bA1mj3B8Y47r8KG7oYCNn63WsjUZeyAdOkThjixxqxGPQ@mail.gmail.com>
Subject: Re: [RFC 1/8] mm: add overflow and underflow checks for page->_refcount
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-m68k@lists.linux-m68k.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        william.kucharski@oracle.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        schmitzmic@gmail.com, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, weixugc@google.com,
        Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I found some atomic_add/dec are replaced with atomic_add/dec_return,

I am going to replace -return variants with -fetch variants, potentially -fetch

> those helpers with return value imply a full memory barrier around it, but
> others without return value do not. Do you have any numbers to show
> the impact? Maybe atomic_add/dec_return_relaxed can help this.

The generic variant uses  arch_cmpxchg() for all atomic variants
without any extra barriers. Therefore, on platforms that use generic
implementations there won't be performance differences except for an
extra branch that checks results when VM_BUG_ON is enabled.

On x86 the difference between the two is the following

atomic_add:
   lock add %eax,(%rsi)

atomic_fetch_add:
   lock xadd %eax,(%rsi)

atomic_fetch_add_relaxed:
   lock xadd %eax,(%rsi)

No differences between relaxed and non relaxed variants. However, we
used lock xadd instead of lock add. I am not sure if the performance
difference is going to be different.

Pasha
