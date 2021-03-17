Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 654C033F14A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 14:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbhCQNh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 09:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbhCQNhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 09:37:21 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660D2C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 06:37:20 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id x4so2995356lfu.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 06:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TCF4Kh7ADb+Bz11O1u+sivsCwsZTWsBP00YSZC7pLGg=;
        b=VMIhJPax6q4bA5xP71+MGggLVSGZ3UkWmRRMLcWuco5kt01H5JQ3h5uMq/6p9rTVWW
         zkoN31CDkfgBpRbqGtqZuJ//zQb/ClEfIj2DCdat1EsAg5L3MEg6rWYlRsEzGcaVaxyw
         nstpsAENnm06Z8aR2Ab6ScU5WH7krovOj+iLsKrPmhpVUGyqk05f7TeGHRkOzgLfhMAG
         ELwDENRvHGU5E5roUtutaQtONDudb993fFoLBsh9wB9g0TnhnGMuC4gQsSNLb/2msK4o
         OYT1Nn7y9NspieL2okGYsLJVop5zWZy5goSykpaMV3/WQSLopd6P+jKbR/sGseXJYXkD
         FdvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TCF4Kh7ADb+Bz11O1u+sivsCwsZTWsBP00YSZC7pLGg=;
        b=dBW4bGNjnPMxcvisy0IfWLyYMBrf0dFf7LM2Xdre4DP9fr9gTBTsv2qJMJ5mQTD1hI
         SrR83BwWQMI4IdHyPgbn4pmLdSaviw5l37uQ6/MKTVwlkmWG4d8I/A8wf/jfmikl3vbj
         J+hHsMEZbmf03Jy6CGXLnJfK4T0x6YyNE8H8glBImA4UkjGA+HUJCBBe3fG07TwPPGtr
         6h/mdLJ0VsJ81ZTeHcfzraFKxF0hMx4358YluCHUKMogsuJ9fcRUBC723NhLFoRQ+QRN
         3w3fGbymD1lRUpuxoBmudf4sgrkA5U7FBYqE4S6RnlcaILukThxpNTnEs/cjlYoEof2V
         jrfQ==
X-Gm-Message-State: AOAM532O1O6TbLx/4jHPx1+VlZC114W4I37/TTK30/aqewP8Ow5cd2sl
        7nDrIgKGkpctFVpi2Udvux0J5lIDEZtFI+rf08+5Ff8sK5VDWpNm
X-Google-Smtp-Source: ABdhPJyadCWk8HoYUb+pZwBxTVrtWpHfF7InRJ2hFFz3iqcIDtcmJsVA415D9IIVmqk4e2NjrptZrmZXkXoi1fr/FuU=
X-Received: by 2002:a05:6512:308a:: with SMTP id z10mr2375482lfd.84.1615988238862;
 Wed, 17 Mar 2021 06:37:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210315142345.GB4401@xsang-OptiPlex-9020> <CAFA6WYNMHAqqmNfncmJm3+BUYCktXouRtV_udSxQb7eifPmX+Q@mail.gmail.com>
 <20210317030101.GB22345@xsang-OptiPlex-9020> <CAFA6WYMb-C2L7DmGnhWgxjuuvP=qxPA4-s4q+knxH+iWXypHmw@mail.gmail.com>
 <YFHAsgNhe8c3ZHQN@hirez.programming.kicks-ass.net> <YFHE9CjanDAD4l5M@hirez.programming.kicks-ass.net>
 <YFHFjarVo7HAP7pg@hirez.programming.kicks-ass.net> <CAFA6WYNs-rQLUGPMwc-p0q_KRvR16rm-x55gDqw828c7-C1qeA@mail.gmail.com>
 <YFH6BR61b5GK8ITo@hirez.programming.kicks-ass.net>
In-Reply-To: <YFH6BR61b5GK8ITo@hirez.programming.kicks-ass.net>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 17 Mar 2021 19:07:07 +0530
Message-ID: <CAFA6WYNr8SR=20LKJD0+AyrVXLY2CqQPqRE_60EestYv9L5AcA@mail.gmail.com>
Subject: Re: [PATCH] objtool,static_call: Don't emit static_call_site for .exit.text
To:     Peter Zijlstra <peterz@infradead.org>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Oliver Sang <oliver.sang@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, jbaron@akamai.com,
        lkp@lists.01.org, kbuild test robot <lkp@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Mar 2021 at 18:16, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Mar 17, 2021 at 05:25:48PM +0530, Sumit Garg wrote:
> > Thanks Peter for this fix. It does work for me on qemu for x86. Can
> > you turn this into a proper fix patch? BTW, feel free to add:
>
> Per the below, the original patch ought to be fixed as well, to not use
> static_call() in __exit.

Okay, fair enough.

Jarkko,

Can you please incorporate the following change to the original patch as well?

diff --git a/security/keys/trusted-keys/trusted_core.c
b/security/keys/trusted-keys/trusted_core.c
index ec3a066a4b42..bef52d1ebe5e 100644
--- a/security/keys/trusted-keys/trusted_core.c
+++ b/security/keys/trusted-keys/trusted_core.c
@@ -41,7 +41,7 @@ DEFINE_STATIC_CALL_NULL(trusted_key_unseal,
                        *trusted_key_sources[0].ops->unseal);
 DEFINE_STATIC_CALL_NULL(trusted_key_get_random,
                        *trusted_key_sources[0].ops->get_random);
-DEFINE_STATIC_CALL_NULL(trusted_key_exit, *trusted_key_sources[0].ops->exit);
+static void (*trusted_key_exit)(void);
 static unsigned char migratable;

 enum {
@@ -328,8 +328,7 @@ static int __init init_trusted(void)
                                   trusted_key_sources[i].ops->unseal);
                static_call_update(trusted_key_get_random,
                                   trusted_key_sources[i].ops->get_random);
-               static_call_update(trusted_key_exit,
-                                  trusted_key_sources[i].ops->exit);
+               trusted_key_exit = trusted_key_sources[i].ops->exit;
                migratable = trusted_key_sources[i].ops->migratable;

                ret = static_call(trusted_key_init)();
@@ -349,7 +348,8 @@ static int __init init_trusted(void)

 static void __exit cleanup_trusted(void)
 {
-       static_call(trusted_key_exit)();
+       if (trusted_key_exit)
+               trusted_key_exit();
 }

 late_initcall(init_trusted);

-Sumit

>
> ---
> Subject: objtool,static_call: Don't emit static_call_site for .exit.text
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Wed Mar 17 13:35:05 CET 2021
>
> Functions marked __exit are (somewhat surprisingly) discarded at
> runtime when built-in. This means that static_call(), when used in
> __exit functions, will generate static_call_site entries that point
> into reclaimed space.
>
> Simply skip such sites and emit a WARN about it. By not emitting a
> static_call_site the site will remain pointed at the trampoline, which
> is also maintained, so things will work as expected, albeit with the
> extra indirection.
>
> The WARN is so that people are aware of this; and arguably it simply
> isn't a good idea to use static_call() in __exit code anyway, since
> module unload is never a performance critical path.
>
> Reported-by: Sumit Garg <sumit.garg@linaro.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Tested-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  tools/objtool/check.c |   32 ++++++++++++++++++++------------
>  1 file changed, 20 insertions(+), 12 deletions(-)
>
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -850,6 +850,22 @@ static int add_ignore_alternatives(struc
>         return 0;
>  }
>
> +static inline void static_call_add(struct instruction *insn,
> +                                  struct objtool_file *file)
> +{
> +       if (!insn->call_dest->static_call_tramp)
> +               return;
> +
> +       if (!strcmp(insn->sec->name, ".exit.text")) {
> +               WARN_FUNC("static_call in .exit.text, skipping inline patching",
> +                         insn->sec, insn->offset);
> +               return;
> +       }
> +
> +       list_add_tail(&insn->static_call_node,
> +                     &file->static_call_list);
> +}
> +
>  /*
>   * Find the destination instructions for all jumps.
>   */
> @@ -888,10 +904,7 @@ static int add_jump_destinations(struct
>                 } else if (insn->func) {
>                         /* internal or external sibling call (with reloc) */
>                         insn->call_dest = reloc->sym;
> -                       if (insn->call_dest->static_call_tramp) {
> -                               list_add_tail(&insn->static_call_node,
> -                                             &file->static_call_list);
> -                       }
> +                       static_call_add(insn, file);
>                         continue;
>                 } else if (reloc->sym->sec->idx) {
>                         dest_sec = reloc->sym->sec;
> @@ -950,10 +963,7 @@ static int add_jump_destinations(struct
>
>                                 /* internal sibling call (without reloc) */
>                                 insn->call_dest = insn->jump_dest->func;
> -                               if (insn->call_dest->static_call_tramp) {
> -                                       list_add_tail(&insn->static_call_node,
> -                                                     &file->static_call_list);
> -                               }
> +                               static_call_add(insn, file);
>                         }
>                 }
>         }
> @@ -2746,10 +2756,8 @@ static int validate_branch(struct objtoo
>                         if (dead_end_function(file, insn->call_dest))
>                                 return 0;
>
> -                       if (insn->type == INSN_CALL && insn->call_dest->static_call_tramp) {
> -                               list_add_tail(&insn->static_call_node,
> -                                             &file->static_call_list);
> -                       }
> +                       if (insn->type == INSN_CALL)
> +                               static_call_add(insn, file);
>
>                         break;
>
