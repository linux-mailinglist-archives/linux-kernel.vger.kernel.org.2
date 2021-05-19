Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA5EC3883DE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 02:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239083AbhESApi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 20:45:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23995 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234097AbhESApg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 20:45:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621385057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YwTV7Kjj6RrOTTD0I2CX5CsxsnrWqAGskz6Ldbn+/74=;
        b=RS0RNR4bDnHEOBFwj+nl3ddPEEmaaAHi0sy/D371KwVKffmY44TDSCRAntcAyJhPqrdYPT
        uMMD7K6M9QHFN+73dQg7ZFVerRPMEvnHEu+hi6tfs/6SZbU+Ivo8Vp0nbCM4hCBrEr2d99
        E/zH6Ipbynhh9GRsvaaezgnjbWpRVw4=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-YQfHGrdEPrm_H5L3n5yqaw-1; Tue, 18 May 2021 20:44:15 -0400
X-MC-Unique: YQfHGrdEPrm_H5L3n5yqaw-1
Received: by mail-qv1-f71.google.com with SMTP id e2-20020ad442a20000b02901f3586a14easo1329046qvr.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 17:44:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YwTV7Kjj6RrOTTD0I2CX5CsxsnrWqAGskz6Ldbn+/74=;
        b=qty+8LSk3VKE5ebBfJETpzY6ayPZp3oIiA84LFUeIuVwRdyazEmetXhnRMf+wJA/L/
         B4LjoOn5yzia0/r2zMowTpr1tOr7R39E7Z0EZvE/XHGhVC3KY86uITTm3L9hgadToo47
         aB7fYNkrjLSGah09InNccR1CZR7/SP/1zcCfWzbhsjgTs+ATwwL0BgNHc20hE+MFIYgD
         aN6T3Kn71HeBZTgiX0ZQJ5mLnwFwMXnd9O5H8pWs00a6C/BsYaXrsymMmdCo78o6OONo
         4WB+8LvuK/mlaFk1s3gLC6g3O7Sa9v4GDC9xxFuvh6lfa046I0tSF6hD2pk6AhqzQ9wL
         Aoag==
X-Gm-Message-State: AOAM532r/oeViyMe6KIcTIvBge9eSFnZ+nh3wBBrMFPh1bnigoP2DsCn
        ixlwRVulozfi9fmLSjbbz77B0iqXMZ+P7EcKog+8FExy+4NXjeTqVOgDE2mmXem9O2TeT+59vDt
        xXZRL9q4+QJnRkO8fgd904Sbo
X-Received: by 2002:ac8:57d3:: with SMTP id w19mr7985512qta.75.1621385054693;
        Tue, 18 May 2021 17:44:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/Q1QiH+3hhEaWnwd9y0dfF8Sdg6/iOfxvq1qK25qepn9oxe5obi9OdahD47I+lnDGQNYZ4A==
X-Received: by 2002:ac8:57d3:: with SMTP id w19mr7985479qta.75.1621385054364;
        Tue, 18 May 2021 17:44:14 -0700 (PDT)
Received: from treble ([68.52.236.68])
        by smtp.gmail.com with ESMTPSA id k2sm12508513qtg.68.2021.05.18.17.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 17:44:14 -0700 (PDT)
Date:   Tue, 18 May 2021 19:44:11 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        willy@infradead.org, masahiroy@kernel.org, michal.lkml@markovi.net
Subject: Re: [tip: objtool/core] jump_label, x86: Allow short NOPs
Message-ID: <20210519004411.xpx4i6qcnfpyyrbj@treble>
References: <20210506194158.216763632@infradead.org>
 <162082558708.29796.10992563428983424866.tip-bot2@tip-bot2>
 <20210518195004.GD21560@worktop.programming.kicks-ass.net>
 <20210518202443.GA48949@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210518202443.GA48949@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 10:24:43PM +0200, Peter Zijlstra wrote:
> OK, willy followed up on IRC, and it turns out there's a kbuild
> dependency missing; then objtool changes we don't rebuild:
> 
>   arch/x86/entry/vdso/vma.o
> 
> even though we should, this led to an unpatched 2 byte jump-label and
> things went sideways. I'm not sure I understand the whole build
> machinery well enough to know where to begin chasing this.
> 
> Now, this file is mighty magical, due to:
> 
> arch/x86/entry/vdso/Makefile:OBJECT_FILES_NON_STANDARD  := y
> arch/x86/entry/vdso/Makefile:OBJECT_FILES_NON_STANDARD_vma.o    := n
> 
> Maybe that's related.

I'm not exactly thrilled that objtool now has the power to easily brick
a system :-/  Is it really worth it?

Anyway, here's one way to fix it.  Maybe Masahiro has a better idea.

From f88b208677953bc445db08ac46b6e4259217bb8a Mon Sep 17 00:00:00 2001
Message-Id: <f88b208677953bc445db08ac46b6e4259217bb8a.1621384807.git.jpoimboe@redhat.com>
From: Josh Poimboeuf <jpoimboe@redhat.com>
Date: Tue, 18 May 2021 18:59:15 -0500
Subject: [PATCH] kbuild: Fix objtool dependency for
 'OBJECT_FILES_NON_STANDARD_<obj> := n'

"OBJECT_FILES_NON_STANDARD_vma.o := n" has a dependency bug.  When
objtool source is updated, the affected object doesn't get re-analyzed
by objtool.

Peter's new variable-sized jump label feature relies on objtool
rewriting the object file.  Otherwise the system can fail to boot.  That
effectively upgrades this minor dependency issue to a major bug.

The problem is that variables in prerequisites are expanded early,
during the read-in phase.  The '$(objtool_dep)' variable indirectly uses
'$@', which isn't yet available when the target prerequisites are
evaluated.

Use '.SECONDEXPANSION:' which causes '$(objtool_dep)' to be expanded in
a later phase, after the target-specific '$@' variable has been defined.

Fixes: b9ab5ebb14ec ("objtool: Add CONFIG_STACK_VALIDATION option")
Fixes: ab3257042c26 ("jump_label, x86: Allow short NOPs")
Reported-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 scripts/Makefile.build | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 949f723efe53..34d257653fb4 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -268,7 +268,8 @@ define rule_as_o_S
 endef
 
 # Built-in and composite module parts
-$(obj)/%.o: $(src)/%.c $(recordmcount_source) $(objtool_dep) FORCE
+.SECONDEXPANSION:
+$(obj)/%.o: $(src)/%.c $(recordmcount_source) $$(objtool_dep) FORCE
 	$(call if_changed_rule,cc_o_c)
 	$(call cmd,force_checksrc)
 
@@ -349,7 +350,7 @@ cmd_modversions_S =								\
 	fi
 endif
 
-$(obj)/%.o: $(src)/%.S $(objtool_dep) FORCE
+$(obj)/%.o: $(src)/%.S $$(objtool_dep) FORCE
 	$(call if_changed_rule,as_o_S)
 
 targets += $(filter-out $(subdir-builtin), $(real-obj-y))
-- 
2.31.1

