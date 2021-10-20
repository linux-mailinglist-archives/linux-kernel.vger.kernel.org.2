Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36FA24350CC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 18:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbhJTQ7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 12:59:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50903 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229771AbhJTQ7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 12:59:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634749021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4wSvmizuMO2m4fT0eDjoslMhMT4OHvvAsI38HO+Btc8=;
        b=GRfVsFo40gTsTcmJ4o/7fOVLMhLi1vZpC5iu5rvAvneOWjOX+440WGA5h/3vIvkg2VZbJ3
        YCUsOK30w98OGjERNuz5VqVlqpVwfdN8wVRxngCOWNxHdHGOfiM4vhmV0+tyOFQamW8n3y
        E9FDw/loTC/g/SoXUB/FHgEc2j0n1Fw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-9jFM-v80OVSEvlA5Jv-m_A-1; Wed, 20 Oct 2021 12:56:59 -0400
X-MC-Unique: 9jFM-v80OVSEvlA5Jv-m_A-1
Received: by mail-qv1-f71.google.com with SMTP id q9-20020ad45749000000b00382b7c83aa1so3276009qvx.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 09:56:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4wSvmizuMO2m4fT0eDjoslMhMT4OHvvAsI38HO+Btc8=;
        b=e5Lsedl5wyAPdKL7cdNLptuc07PnTjwEMQvvp9skw8wJh8CHPf5gQ6ef0wIZfBQfz4
         /WHWmC0fNo6+b85zBlpCt8MtT15Vs6jvCnrqt+6MlfLaEJfo7IDQG3IGEccc6dUd4WBl
         qSIyOEyJFAtxR5b76cnskk/RofAcegE+qFx9M2JNcpCwAn3GzwTUrXmsGuQ7PAMvCtme
         F9LfaJcT1zd0LEbVXIEyw7y3wF2vbpvR7AKhQuugGI4zunaATP1CY8IOI8kKonxqy23K
         sr1N1ighxRMjLPUa83JA2JjH+KAY9FS6g+oBzjiLAJIt6R4V8fgQ9SmwSTpGijw+nbpp
         71bg==
X-Gm-Message-State: AOAM532KCMjc2Xwnv16ncWN2qk7ENGuKhu1ErJ4WI/Q+7BQ45bWtD2gC
        3OAUWx/JZs8X/mjIqRFqKKYsQWgk1USGRzFzcDqo3xQzdC9gBGUPiGqUl9tz9pkUYXSDDMTeIi2
        KXC7ggTU7phUt0xTTgqzM0pQA
X-Received: by 2002:a37:94c1:: with SMTP id w184mr189648qkd.103.1634749019196;
        Wed, 20 Oct 2021 09:56:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxuB7ZB29rEUhk1IGJJz1Cdh16+W0LK1O6KQNrcOCufE4DPH1nlHKLmJk+ZSquOxDFpnwQInQ==
X-Received: by 2002:a37:94c1:: with SMTP id w184mr189627qkd.103.1634749018955;
        Wed, 20 Oct 2021 09:56:58 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id 101sm1179629qta.17.2021.10.20.09.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 09:56:58 -0700 (PDT)
Date:   Wed, 20 Oct 2021 09:56:55 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, alexei.starovoitov@gmail.com,
        ndesaulniers@google.com
Subject: Re: [PATCH v2 14/14] bpf,x86: Respect X86_FEATURE_RETPOLINE*
Message-ID: <20211020165655.632slp4ujsajis4j@treble>
References: <20211020104442.021802560@infradead.org>
 <20211020105843.345016338@infradead.org>
 <YW/4/7MjUf3hWfjz@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YW/4/7MjUf3hWfjz@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 01:09:51PM +0200, Peter Zijlstra wrote:
> Alexei; could the above not be further improved with something like the
> below?
> 
> Despite several hours trying and Song helping, I can't seem to run
> anything bpf, that stuff is cursed. So I've no idea if the below
> actually works, but it seems reasonable.

The below fix gets it to run with test_verififer.

I do like it, it does seem less fiddly and more robust against future
changes, though it probably needs a comment for 'out_label' clarifying
it only works because this function is always called at least twice for
a given bpf_tail_call emission.

---

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 08f32c9fceaa..c9230c5bbca5 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -457,7 +457,7 @@ static void emit_bpf_tail_call_indirect(u8 **pprog, bool *callee_regs_used,
 	EMIT3(0x39, 0x56,                         /* cmp dword ptr [rsi + 16], edx */
 	      offsetof(struct bpf_array, map.max_entries));
 
-	offset = out_label - (prog - start) + 2;
+	offset = out_label - (prog - start + 2);
 	EMIT2(X86_JBE, offset);                  /* jbe out */
 
 	/*
@@ -467,7 +467,7 @@ static void emit_bpf_tail_call_indirect(u8 **pprog, bool *callee_regs_used,
 	EMIT2_off32(0x8B, 0x85, tcc_off);         /* mov eax, dword ptr [rbp - tcc_off] */
 	EMIT3(0x83, 0xF8, MAX_TAIL_CALL_CNT);     /* cmp eax, MAX_TAIL_CALL_CNT */
 
-	offset = out_label - (prog - start) + 2;
+	offset = out_label - (prog - start + 2);
 	EMIT2(X86_JA, offset);                   /* ja out */
 	EMIT3(0x83, 0xC0, 0x01);                  /* add eax, 1 */
 	EMIT2_off32(0x89, 0x85, tcc_off);         /* mov dword ptr [rbp - tcc_off], eax */
@@ -482,7 +482,7 @@ static void emit_bpf_tail_call_indirect(u8 **pprog, bool *callee_regs_used,
 	 */
 	EMIT3(0x48, 0x85, 0xC9);                  /* test rcx,rcx */
 
-	offset = out_label - (prog - start) + 2;
+	offset = out_label - (prog - start + 2);
 	EMIT2(X86_JE, offset);                   /* je out */
 
 	*pprog = prog;

