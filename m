Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A38732A0DC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1576750AbhCBEcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 23:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444369AbhCBClX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 21:41:23 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA124C06178A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 18:40:38 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d12so10309649pfo.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 18:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wKdwd3EXr+qvpaNjnApPgsZ1TqeT6YoEl+a2s3Vhn8E=;
        b=YLHSoiLWPHQmyEziMFZ16E0wMzPhXE5clX+FEfrB+iWvQUJbgPYIcXQaAm+BJi24DM
         rfnprmnCSGouek1FuZnLUJ/F0dT7Xs3/3ZPlxjFM41iHJliWQfYjyV94mJjlKofORkzG
         7z5svMOIcJnXfMsIyidc+My/DbzTsm+DUw6jG8J1VLfXhOFvyBJg+SwwSLhn1N7XAbz0
         OePa2vq1nTFXKuFsernooCHMZeblpl4TUluZ3mJ5Cso/bIroVYhmIZWwj+CbOg2b20p9
         IjHWWUQrxLLjjxl+gUmEIITNXHOKHRLwRGSmnT5eD4rsYlFyeK3wV5RNOrw+eb+8tPvr
         4INA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wKdwd3EXr+qvpaNjnApPgsZ1TqeT6YoEl+a2s3Vhn8E=;
        b=moy7a2IjsT9+xmEtKs+L1YtvX66PaiPTx+3LufR3xsMJqepIn2z2Af0sIY2Z4GRW0J
         cLBE4/TLkLS6GdzPck9Mxqsmbec4STqxNpAOBbRZYjGukIl8IJi132wbNvpQzzSaeTYa
         b0YbXY+5YEzt0TaWfluNegt2BovOVZmfL75cB3bUcZrEvKHdsR8dbq/42bTeDlE/82K/
         1K7scuu14Kvj7/vs76E00iwQAYGJJlALD1R1HyFyy2MrsVzlZryGrP3Exqg0t0ro8iaa
         vBNL3Pqea+GYg7XC0P3nSgezuoVyBPlPKjSPCfEbebhVsGhOntFlvOlaa2yNewPjKVI9
         0Gyw==
X-Gm-Message-State: AOAM531/CQaLxEWoLgDyFFlxs8j48F5h4qvhhW/sFAWnzM7jtNVzhaAc
        jtlstX+C85WrJfPt6QxfuygqZA==
X-Google-Smtp-Source: ABdhPJyCbgfEJFceqNMao5ob7MSKXqnTjEuUCVngShm+uQB228TBN4s1f2hgMsTg4qi2bVs96rCJEg==
X-Received: by 2002:a63:389:: with SMTP id 131mr16203398pgd.316.1614652838045;
        Mon, 01 Mar 2021 18:40:38 -0800 (PST)
Received: from google.com ([2620:15c:201:2:85f9:f0dd:5527:51b4])
        by smtp.gmail.com with ESMTPSA id o21sm795708pjp.42.2021.03.01.18.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 18:40:37 -0800 (PST)
Date:   Mon, 1 Mar 2021 18:40:32 -0800
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [x86, build] 6dafca9780:
 WARNING:at_arch/x86/kernel/ftrace.c:#ftrace_verify_code
Message-ID: <YD2loOkd/AYqKPB6@google.com>
References: <20210301074027.GD12822@xsang-OptiPlex-9020>
 <CABCJKuc8H83b_8_Ccp+Cb7O9x5oEu6sPNq63sjGcAJcgiwy0bw@mail.gmail.com>
 <20210301184524.7aa05ac1@gandalf.local.home>
 <CABCJKudQme=bcNJtNCORUpBnVA_Pkr2Zk_3Nu2EsfnuoE7LJ3g@mail.gmail.com>
 <20210301201526.65ce7f1c@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210301201526.65ce7f1c@oasis.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2021 at 08:15:26PM -0500, Steven Rostedt wrote:
> On Mon, 1 Mar 2021 16:03:51 -0800
> Sami Tolvanen <samitolvanen@google.com> wrote:
> > 
> > >                 ret = ftrace_verify_code(rec->ip, old);
> > > +
> > > +               if (__is_defined(CC_USING_NOP_MCOUNT) && ret && old_nop) {
> > > +                       /* Compiler could have put in P6_NOP5 */
> > > +                       old = P6_NOP5;
> > > +                       ret = ftrace_verify_code(rec->ip, old);
> > > +               }
> > > +  
> > 
> > Wouldn't that still hit WARN(1) in the initial ftrace_verify_code()
> > call if ideal_nops doesn't match?
> 
> That was too quickly written ;-)
> 
> Take 2:
> 
> [ with fixes for setting p6_nop ]

Thanks, I tested this with the config from the build bot, and I can
confirm that it fixes the issue for me.

I also tested a quick patch to disable the __fentry__ conversion in
objtool, and it seems to work too, but it's probably a good idea to
fix the issue with CC_USING_NOP_MCOUNT in any case.

diff --git a/Makefile b/Makefile
index f9b54da2fca0..536fea073d5b 100644
--- a/Makefile
+++ b/Makefile
@@ -863,9 +863,6 @@ ifdef CONFIG_FTRACE_MCOUNT_USE_CC
     endif
   endif
 endif
-ifdef CONFIG_FTRACE_MCOUNT_USE_OBJTOOL
-  CC_FLAGS_USING	+= -DCC_USING_NOP_MCOUNT
-endif
 ifdef CONFIG_FTRACE_MCOUNT_USE_RECORDMCOUNT
   ifdef CONFIG_HAVE_C_RECORDMCOUNT
     BUILD_C_RECORDMCOUNT := y
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 068cdb41f76f..497e00c1cb69 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1047,21 +1047,9 @@ static int add_call_destinations(struct objtool_file *file)
 			insn->type = INSN_NOP;
 		}
 
-		if (mcount && !strcmp(insn->call_dest->name, "__fentry__")) {
-			if (reloc) {
-				reloc->type = R_NONE;
-				elf_write_reloc(file->elf, reloc);
-			}
-
-			elf_write_insn(file->elf, insn->sec,
-				       insn->offset, insn->len,
-				       arch_nop_insn(insn->len));
-
-			insn->type = INSN_NOP;
-
+		if (mcount && !strcmp(insn->call_dest->name, "__fentry__"))
 			list_add_tail(&insn->mcount_loc_node,
 				      &file->mcount_loc_list);
-		}
 
 		/*
 		 * Whatever stack impact regular CALLs have, should be undone

Sami
