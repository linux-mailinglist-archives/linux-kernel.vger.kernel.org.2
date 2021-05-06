Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6C5374FD4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 09:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233174AbhEFHMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 03:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbhEFHM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 03:12:29 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B58BC061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 00:11:31 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so2960025pjv.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 00:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=9ypg5c6MOAqzsS7CxmmS3kas8+OOs5J41FOXrsXLyMA=;
        b=pimC6SNQfwwV1A/7teF0rBbZCIvJBHIk3nI/FTZW1rIMK42e57LWtDVFrOfDkpOak3
         fEEMsW/FcsRwrQv/fixflPyhTT11olpZ4NT2ajJjbjFGAxE6s/IfcPz9aDjdac1NmZwp
         zGTRkKDJpPClTcCijZ0/rIX00y9sqlPljv6+v9BMMOp4HJpk4C6fAIT2JxzF+HC60J/u
         tAGQFRPj6Q46OpuFhQeO7DGhN+4eNwJmePKtJXUEMsm3D78LA968Y5LnqBzgnbVOd1WC
         7YxPcbAgO434kLHeYHt9qpBqnNPtqfA//iK8NO7pYRFHZ05w6aAQX9J/7cJVv+9DXx5M
         g+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=9ypg5c6MOAqzsS7CxmmS3kas8+OOs5J41FOXrsXLyMA=;
        b=I5NHxqpwxIYCJpySp3ozOvv4pNNa2ss8wM4uWhhI/TQwIkQdIZ6qeHIhKuA6BfRPZJ
         MOcBrxpKRAwIJjUNIp+u4ooE0vaS6jXr8FBR3X2XCTZjjewXYmfZmWyRXoC5x7GEy90F
         lsytvDMtUx4LNB10SOrKDoC4zyGkXkow42w/AUBrtEpEWqq3zJAPFKNAXxNx5y063ESd
         0KY5NDJZiS2eqRTo26N9Ff0XGm2iTg1XoVLPdJaLgZD9Wx4dqfbkzXrE1Uj4UBVxd+yQ
         6PzdmuesKMXq1vPTa0ikJuoHlbWHOUYofdigKgJIIYywnqsR2VB+BCHSsxy/IQ3caLqe
         hM7A==
X-Gm-Message-State: AOAM530yYsogngH33aioS3lymHGD1qkvMgnAj0EhA2DeCC0M8F6KrSs/
        HFNzUPYkQpwhAH30c/wjAdp9og==
X-Google-Smtp-Source: ABdhPJxf2ZuzWR6KCVivm+jms8uWGnTwz+EWrQxN7mdrJPcJcT/JJmRO4O91kbQ4LJDaH+BA+OuwSw==
X-Received: by 2002:a17:90a:6345:: with SMTP id v5mr9278882pjs.139.1620285090692;
        Thu, 06 May 2021 00:11:30 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id g18sm1275741pfb.178.2021.05.06.00.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 00:11:30 -0700 (PDT)
Date:   Thu, 06 May 2021 00:11:30 -0700 (PDT)
X-Google-Original-Date: Thu, 06 May 2021 00:02:03 PDT (-0700)
Subject:     Re: [PATCH] RISC-V: insn: Use a raw spinlock to protect TEXT_POKE*
In-Reply-To: <mhng-dbd1fd8c-37f7-4b60-a61e-3f8d22e5baf0@palmerdabbelt-glaptop>
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
Message-ID: <mhng-08581a54-f9c8-4119-97bb-a9be86f19e41@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Apr 2021 12:44:37 PDT (-0700), Palmer Dabbelt wrote:
> On Fri, 30 Apr 2021 04:34:31 PDT (-0700), rostedt@goodmis.org wrote:
>> On Fri, 30 Apr 2021 04:06:35 +0000
>> Anup Patel <Anup.Patel@wdc.com> wrote:
>>
>>> This patch only takes care of ftrace path.
>>>
>>> The RISC-V instruction patching is used by RISC-V jump label implementation
>>> as well and will called from various critical parts of core kernel.
>>>
>>> The RAW spinlock approach allows same instruction patching to be used
>>> for kprobes, ftrace, and jump label.
>>
>> So what path hits this outside of stop machine?
>
> I didn't actually dig through all the usages of jump_label, I just saw a
> handful in places where it's generally not sane to assume that sleeping
> is safe -- for example, thoughout kernel/sched.  If you think it's OK to
> rely on users of the static branch stuff (IIUC the only jump_label user
> in the kernel?) to know that it can sleep then I'm fine keeping the
> text_mutex call in jump_label and adding one to ftrace (I'm fine with
> something generic, but it's simple to do in arch/riscv).
>
> IMO if the static branch stuff can be expected to sleep it'd be good to
> call that out in the documentation, and I'd like to audit the uses
> before committing to that.  I'm happy to do that, we can just take the
> lock in arch/riscv's frace code for now to get around the lockdep
> assertion failure -- IIUC that's indicating a real bug, as nothing in
> ftrace avoids concurrency with jump_label and kprobes.

Turns out I'd actually opened the wrong thread and was looking at a 
stack trace from a bur reported a year ago, which is why nothing I was 
saying here makes any sense.  That bug has already been fixed, I have a 
proper fix for this one.  It turns out to be almost exactly the same as 
something Steven suggested in this thread.
