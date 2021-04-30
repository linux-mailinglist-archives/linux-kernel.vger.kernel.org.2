Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7BA37016C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 21:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbhD3Tp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 15:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbhD3Tp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 15:45:26 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69916C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 12:44:38 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id i13so2211470pfu.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 12:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=2TLq4e6kvET2xht98betGHvp/vebBRLyAaxh+3CTBLo=;
        b=GnxY/quB8BUkeEn2JWmikGfrGIjVGHMjD8cHIEu0s8SPMnOzf/N4Uup7cCPCUqoqbP
         Pfg+L/76ea7FFxgmZ/U6pA96+PaylsvPKdtVweBq8jtBzOutQ/BTX/C9AUKxJlF4mzjg
         fCr4OMyLAwRROj24e57RKvlVu0kxYvnGZ/QSTd7FnI1HnKEZqqKOMxKlL+KaKZrl5DAs
         dcHLIBiJ7RQ4pzySFKib5zPWz9XH/yZGgB7YSzqPEdnMYjf9L6GOFbc/cP/uhcSuBKcQ
         wi1si8jk3HP2/bl2UPOTReRcYLe5zn5akvCnejvse6AkHVRykjkXcfaJUvJYgwnGtJ7M
         nrlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=2TLq4e6kvET2xht98betGHvp/vebBRLyAaxh+3CTBLo=;
        b=ZnpZbYvbQUdTBbmGPyjyXBRpWuKt8svZ78Db8lPaOS6nhZAueG0qhp3dxnU/cBed8Q
         m7JoEpBzb3BFIFFh9+fUOy+THffGCDUMTdkbK6p7It7zu70/YpCC2X0X7g0tjp0hm9Om
         DUUyqNJZ1iP8281of3uTVK1M1va76i6cW0GpIzuG6h8Xxe4ybsL6WrYWDHvCNi7eCsbR
         y8bjaCumCSAkRlZ9t1IbSIXFqD5YsIN2mOzREW9jldPHWUNyBNpO6eFu4WN/rQa4iF14
         Q+LgqbWPB99w8TXydm0DD0ktB9uMfOYvJWksXFHuiCHaZroexlP/A8yHM9sqV/5l8y58
         DTBg==
X-Gm-Message-State: AOAM530udmCjJUyqaPKVnIcPjeO1qmmJ0WxaagI3wg9JfrP6QpO4/VJt
        rb9cNXeEnG028zh3bWWVwq0T/A==
X-Google-Smtp-Source: ABdhPJxq071PjYbmf0SF7onwhFr4uux4Yjyk5sPaoJd4hloG6xFLZf+5ajKHb3QPtjge4qxDhJMyrA==
X-Received: by 2002:a63:5963:: with SMTP id j35mr6056738pgm.281.1619811877688;
        Fri, 30 Apr 2021 12:44:37 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id o4sm2935314pfk.15.2021.04.30.12.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 12:44:37 -0700 (PDT)
Date:   Fri, 30 Apr 2021 12:44:37 -0700 (PDT)
X-Google-Original-Date: Fri, 30 Apr 2021 12:44:35 PDT (-0700)
Subject:     Re: [PATCH] RISC-V: insn: Use a raw spinlock to protect TEXT_POKE*
In-Reply-To: <20210430073431.1bc4946d@oasis.local.home>
CC:     Anup Patel <Anup.Patel@wdc.com>, changbin.du@gmail.com,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, peterz@infradead.org, jpoimboe@redhat.com,
        jbaron@akamai.com, ardb@kernel.org,
        Atish Patra <Atish.Patra@wdc.com>, akpm@linux-foundation.org,
        rppt@kernel.org, mhiramat@kernel.org, zong.li@sifive.com,
        guoren@linux.alibaba.com, wangkefeng.wang@huawei.com,
        0x7f454c46@gmail.com, chenhuang5@huawei.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     rostedt@goodmis.org
Message-ID: <mhng-dbd1fd8c-37f7-4b60-a61e-3f8d22e5baf0@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Apr 2021 04:34:31 PDT (-0700), rostedt@goodmis.org wrote:
> On Fri, 30 Apr 2021 04:06:35 +0000
> Anup Patel <Anup.Patel@wdc.com> wrote:
>
>> This patch only takes care of ftrace path.
>>
>> The RISC-V instruction patching is used by RISC-V jump label implementation
>> as well and will called from various critical parts of core kernel.
>>
>> The RAW spinlock approach allows same instruction patching to be used
>> for kprobes, ftrace, and jump label.
>
> So what path hits this outside of stop machine?

I didn't actually dig through all the usages of jump_label, I just saw a 
handful in places where it's generally not sane to assume that sleeping 
is safe -- for example, thoughout kernel/sched.  If you think it's OK to 
rely on users of the static branch stuff (IIUC the only jump_label user 
in the kernel?) to know that it can sleep then I'm fine keeping the 
text_mutex call in jump_label and adding one to ftrace (I'm fine with 
something generic, but it's simple to do in arch/riscv).

IMO if the static branch stuff can be expected to sleep it'd be good to 
call that out in the documentation, and I'd like to audit the uses 
before committing to that.  I'm happy to do that, we can just take the 
lock in arch/riscv's frace code for now to get around the lockdep 
assertion failure -- IIUC that's indicating a real bug, as nothing in 
ftrace avoids concurrency with jump_label and kprobes.
