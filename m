Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5C031526F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 16:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbhBIPNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 10:13:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbhBIPNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 10:13:17 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466BDC061786
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 07:12:37 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612883555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jWkC5nvDedOQcOGLRZAcnUf5BoS6QiBKxlVWMLT7CHM=;
        b=QGqKYYWnMA3mU43y2z7xvEqbZJbKvxBwkXGsBXae4OM90NZ3eGQqXWDM+E0OMOpsEBCzlh
        VJl5V67Wv3K8g73t9MZCDH8biIf1lXbgq3O6g6VrhR4Jr0P4kFiYOu3szJuxSb3kf9YToK
        nz6m5DusbGscbbWu5LyFha9CC4yH1AkTfqjBW+RdGUXF0Rd6wyWQZhZ5wSAja9MokHNo5C
        yuxYSGToLrJdbfSNLhjxEioTUe4sJsKFONt8x52y9KatkS4o37xnzSjfOKDwWrxMCOsB8I
        i9rrkxldIw4aEl+WUtFAaHl/Bly9+OBhVLWIABEh2Kj3oEhRWH2qyJYLpbG4Kg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612883555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jWkC5nvDedOQcOGLRZAcnUf5BoS6QiBKxlVWMLT7CHM=;
        b=Cpkjvk2fNjX4Xz21a2VIDvEz8oMpKWvUynhgIyef9vNg4bOneDvTt78kMOq+YLuwL1ZwLJ
        on4hL77BsZcwcgBQ==
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [patch 05/12] x86/irq: Provide macro for inlining irq stack switching
In-Reply-To: <20210208204209.yccd76j7sp2zbv37@treble>
References: <20210204204903.350275743@linutronix.de> <20210204211154.618389756@linutronix.de> <20210208204209.yccd76j7sp2zbv37@treble>
Date:   Tue, 09 Feb 2021 16:12:33 +0100
Message-ID: <87zh0db7ha.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 08 2021 at 14:42, Josh Poimboeuf wrote:
> On Thu, Feb 04, 2021 at 09:49:08PM +0100, Thomas Gleixner wrote:
>>  #ifdef CONFIG_X86_64
>> +
>> +#ifdef CONFIG_UNWINDER_FRAME_POINTER
>> +# define IRQSTACK_CALL_CONSTRAINT	, ASM_CALL_CONSTRAINT
>> +#else
>> +# define IRQSTACK_CALL_CONSTRAINT
>> +#endif
>
> Is this really needed?  i.e. does ASM_CALL_CONSTRAINT actually affect
> code generation with !FRAME_POINTER?

The problem is that if the asm inline is the first operation in a
function some compilers insert the asm inline before setting up the
frame pointer.

That's actualy irrelevant here as the compiler cannot reorder against
the C code leading to the asm inline. So we can probably replace it with
a big fat comment.

Thanks,

        tglx






