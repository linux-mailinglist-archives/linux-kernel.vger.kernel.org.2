Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25249446762
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 17:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234112AbhKEQ5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 12:57:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49547 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233629AbhKEQ5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 12:57:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636131264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KWf7Y26e8fQ50BZ0na/FvqGmJlcd4C7t9JxaVykzc3E=;
        b=XOfNkx0GKho2MmvT1Cln7o3vemmKnfMXFf/BZCJ2Aaz42afZ6VaOsC4YVWjhREkplvtM1R
        8xh9mpnpAw+X2ec5RGMxFC87P807CsZGeqJJ4vS4eZQIzIqmmDV0hT1W2Wd+K9Z620AFw5
        9qQC94u6I23IzHfsQTwXzIpmtk9hDuE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-587-sKFoMrcTMaCq6z7UkZC41w-1; Fri, 05 Nov 2021 12:54:23 -0400
X-MC-Unique: sKFoMrcTMaCq6z7UkZC41w-1
Received: by mail-qv1-f71.google.com with SMTP id z8-20020a0cd788000000b00384d92a0f11so8885764qvi.17
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 09:54:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KWf7Y26e8fQ50BZ0na/FvqGmJlcd4C7t9JxaVykzc3E=;
        b=5jkZ4SY409r9Mhqh7CMnjBv9oRLIUGvJ/GHwO8ClCTTmZbHqP0dXW1bfvwKj/S4xrr
         xyNqlPgjmDQ/lPxtNzPA8wzxzJA7v43Z1bDBEAi7ROW8jMbWmISmRZUvBrzB92nCHLCC
         OsVtYEI/LM5jOcoyvcPv/a3R72UGRyGUqHNv8latJVyA1zTMkjYnFtWXLN7jeSJCKOzO
         a/zYLIjblzNThzQKORTT9tQJgVtCelMh2lFw2lwr/M334eNEka40B2ksn8LSO2Ags6f/
         8YYcft401WlBKvh7khz1I6JuIftF/+mKg7vYSxnS41af0L1lItI9qmUaI3ZMN1WQWy0x
         /Syw==
X-Gm-Message-State: AOAM532X7DRU/Zw9G8nv3dNsOea2vWf7+U6qjw2ggYAUvIYYcwerfSrw
        fNpKa7vq6H3y34woRn2aQPFMc3NwjL9rBWFQme6U/TG8mGEVveJEBPhg+CK2l5uvT22xQD+2+Mq
        D4zR/np0Yer+gq4oB4mea4vr7
X-Received: by 2002:a05:6214:2426:: with SMTP id gy6mr18624527qvb.66.1636131262652;
        Fri, 05 Nov 2021 09:54:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxfsghymY0TVhIl08EK7EwTd30SFNMtqdxcooK8SU6fA8hP2ZG1xWweKr4uzWarKaJy4BzfuQ==
X-Received: by 2002:a05:6214:2426:: with SMTP id gy6mr18624512qvb.66.1636131262396;
        Fri, 05 Nov 2021 09:54:22 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::a])
        by smtp.gmail.com with ESMTPSA id y9sm5936183qko.74.2021.11.05.09.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 09:54:21 -0700 (PDT)
Date:   Fri, 5 Nov 2021 09:54:18 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Miroslav Benes <mbenes@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] compiler.h: Avoid using inline asm operand modifiers
Message-ID: <20211105165418.ucsrpk53dv5kgu6k@treble>
References: <cover.thread-1a26be.your-ad-here.call-01621428935-ext-2104@work.hours>
 <patch-1.thread-1a26be.git-930d1b44844a.your-ad-here.call-01621428935-ext-2104@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <patch-1.thread-1a26be.git-930d1b44844a.your-ad-here.call-01621428935-ext-2104@work.hours>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 03:03:08PM +0200, Vasily Gorbik wrote:
> The expansion of annotate_reachable/annotate_unreachable on s390 will
> result in a compiler error if the __COUNTER__ value is high enough.
> For example with "i" (154) the "%c0" operand of annotate_reachable
> will be expanded to -102:
> 
>         -102:
>         .pushsection .discard.reachable
>         .long -102b - .
>         .popsection
> 
> This is a quirk of the gcc backend for s390, it interprets the %c0
> as a signed byte value. Avoid using operand modifiers in this case
> by simply converting __COUNTER__ to string, with the same result,
> but in an arch assembler independent way.
> 
> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>

Hi Vasily,

This patch causes these macros to break with Clang and
CONFIG_TRACE_BRANCH_PROFILING.

I get a lot of warnings like

  arch/x86/kernel/traps.o: warning: objtool: handle_xfd_event()+0x134: unreachable instruction

Without an asm input, 'volatile' is ignored for some reason and Clang
feels free to move the reachable() annotation away from its intended
location.

I wonder if we could go back to the original approach of providing
__COUNTER__ as an input to the asm, but then mask it to < 128.

Does this work on s390?

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 3d5af56337bd..42935500a712 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -115,24 +115,18 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
  * The __COUNTER__ based labels are a hack to make each instance of the macros
  * unique, to convince GCC not to merge duplicate inline asm statements.
  */
-#define __stringify_label(n) #n
-
-#define __annotate_reachable(c) ({					\
-	asm volatile(__stringify_label(c) ":\n\t"			\
+#define annotate_reachable() ({						\
+	asm volatile("%c0:\n\t"						\
 		     ".pushsection .discard.reachable\n\t"		\
-		     ".long " __stringify_label(c) "b - .\n\t"		\
-		     ".popsection\n\t");				\
+		     ".long %c0b - .\n\t"				\
+		     ".popsection\n\t" : : "i" (__COUNTER__ & 0x7f));	\
 })
-#define annotate_reachable() __annotate_reachable(__COUNTER__)
-
-#define __annotate_unreachable(c) ({					\
-	asm volatile(__stringify_label(c) ":\n\t"			\
+#define annotate_unreachable() ({					\
+	asm volatile("%c0:\n\t"						\
 		     ".pushsection .discard.unreachable\n\t"		\
-		     ".long " __stringify_label(c) "b - .\n\t"		\
-		     ".popsection\n\t");				\
+		     ".long %c0b - .\n\t"				\
+		     ".popsection\n\t" : : "i" (__COUNTER__ & 0x7f));	\
 })
-#define annotate_unreachable() __annotate_unreachable(__COUNTER__)
-
 #define ASM_UNREACHABLE							\
 	"999:\n\t"							\
 	".pushsection .discard.unreachable\n\t"				\

