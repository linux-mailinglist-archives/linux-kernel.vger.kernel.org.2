Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A11242046D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 01:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbhJCXEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 19:04:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34668 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231809AbhJCXEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 19:04:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633302132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ydM58jWNkyMBGo30i2TV4XDTsxAfhfxAZn04m4Gf1Jc=;
        b=WDvpexxUKfajJYhgXnAuZ9TtcIGye0lod8EaKwZiP392Kp7vxNlieDLUGQjonnL4ofSJQy
        nxr5MxYN2fEIzho8L9Ijv4Sugar43V1fOx3y7Guv23hNZT/0naZFOkVBqYWQxHlyDLxuoc
        G7TRM5qE1gzGBMGQJrBGXUovW8KC/5o=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-eOYPqT7zO-Gs-M-KPmMtCQ-1; Sun, 03 Oct 2021 19:02:12 -0400
X-MC-Unique: eOYPqT7zO-Gs-M-KPmMtCQ-1
Received: by mail-qk1-f199.google.com with SMTP id bm12-20020a05620a198c00b00432e14ddb99so22126772qkb.21
        for <linux-kernel@vger.kernel.org>; Sun, 03 Oct 2021 16:02:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ydM58jWNkyMBGo30i2TV4XDTsxAfhfxAZn04m4Gf1Jc=;
        b=fGgaw8Yv1LsBjsp18laUbWjZ+5JBjKsv/7IVjmhj08HhQ8dEQIafTawzT89xD0Jzc+
         +6I5pASPqJWS42N1zhU1PgvPzrEYjg6XrIY+CTLAAvBTVmO+/FiLXQVwVm5/RCZh9sBx
         SrkfjFxZWuNNc6/RzfWvcG/PCmzmSZPODTkCnsvvTEQhQTODyMkAY0YdIGZd9M1A39ir
         jd5qk57Q/lw2it1nZiPl5f8/zU80YxYbOx+xtEHScHMrXT2xjsG4BDl8YWeFp7P07soI
         AQejpwXarmsYR3ONTPN321TLr3uK7Uwza/0Lv3Kw3x/qk+z87WpJNjXKex3PRAaqmZ3v
         CsHw==
X-Gm-Message-State: AOAM533cAjPQkEumnLbAQuYzK6yZAbcqyB8czx0Aa/V0Q2QdsN5eK5fP
        fNtC5bCm4m1xsdnVpgzghJRGc4w8irzwHbg/46qhzuzUv4ljczJbadAkMNYldwh8uSBmK0npL/P
        v+y9oOVXmdY/bJGhCBUXPHDqe
X-Received: by 2002:ac8:4348:: with SMTP id a8mr10498392qtn.262.1633302129921;
        Sun, 03 Oct 2021 16:02:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxdyu/AYvU46F4wEputwC1yP6oucW8rWviCEyPScmbpJ2Ewv4qGAwp6ehXz3pxcUtk2mSVZCg==
X-Received: by 2002:ac8:4348:: with SMTP id a8mr10498359qtn.262.1633302129640;
        Sun, 03 Oct 2021 16:02:09 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id u129sm6637853qkd.127.2021.10.03.16.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 16:02:09 -0700 (PDT)
Date:   Sun, 3 Oct 2021 16:02:06 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Borislav Petkov <bp@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>
Subject: Re: [GIT PULL] objtool/urgent for v5.15-rc4
Message-ID: <20211003230206.hhrrhna52dnhumji@treble>
References: <YVl7RR5NcbPyiXgO@zn.tnic>
 <CAHk-=wh9JzLmwAqA2+cA=Y4x_TYNBZv_OM4eSEDFPF8V_GAPug@mail.gmail.com>
 <CAHk-=wiZwq-0LknKhXN4M+T8jbxn_2i9mcKpO+OaBSSq_Eh7tg@mail.gmail.com>
 <CAHk-=wjtJ532TqnLN+CLqZJXx=MWHjQqi0-fR8PSQ-nGZ_iMvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjtJ532TqnLN+CLqZJXx=MWHjQqi0-fR8PSQ-nGZ_iMvg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 03, 2021 at 12:10:38PM -0700, Linus Torvalds wrote:
> Replying to myself just to add more proper people to the cc.
> 
> I'm also wondering how I could possibly be the only person who saw the warning.
> 
> I don't think I am, and I think that people who signed off on commit
> 24ff65257375 ("objtool: Teach get_alt_entry() about more relocation
> types") and claimed to have "tested" it, clearly didn't actually do
> so.
> 
> PeterZ/Josh/Nathan: see the thread at
> 
>    https://lore.kernel.org/lkml/CAHk-=wiZwq-0LknKhXN4M+T8jbxn_2i9mcKpO+OaBSSq_Eh7tg@mail.gmail.com/
> 
> if you need more context, but I suspect you can figure it out just
> from this email too.

Sorry about that.  I think Peter and I failed to run this through
regression testing.  We can work on tightening up our process.

Definitely *not* Nathan's fault.  His 'Tested-by' only means that this
fixed his particular issue.

> > > Looking at the kvm code, that kvm_fastop_exception thing is some funky sh*t.
> > >
> > > I _think_ the problem is that 'kvm_fastop_exception' is done with bare
> > > asm at the top-level and that triggers some odd interaction with other
> > > section data, but I really don't know.
> >
> > No, it's the fact that it is marked as a global function (why?) that
> > it then causes problems.
> >
> > Now, I don't actually see why it would cause problems (the same way I
> > don't see why it's marked global). But removing that
> >
> >      ".global kvm_fastop_exception \n"
> >
> > works.
> >
> > I suspect it makes the linker do the relocation for us before objtool
> > runs, because now that it's a local name, there is no worry about
> > multiply defined symbols of the same name or anything like that.
> >
> > I also suspect that the reason for the warning is that the symbol type
> > has never been declared, so it's not marked as a STT_FUNC in the
> > relocation information.

Right, basically objtool's complaining that it doesn't know how to
handle the NOTYPE symbol.  But really, any non-object symbol should be
straightforward.  I may just remove these warnings altogether in favor
of something much simpler (something like the patch below).

> > In the meantime, I think the exception handling for kvm
> > divide/multiply emulation is badly broken right now. Hmm?

The warning is harmless, so it doesn't necessarily mean anything's
broken.  That said, I have no idea what's going in that code or why
kvm_fastop_exception() is clearing %esi.


diff --git a/tools/objtool/special.c b/tools/objtool/special.c
index f58ecc50fb10..0217ac3fa7ff 100644
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -58,22 +58,11 @@ void __weak arch_handle_alternative(unsigned short feature, struct special_alt *
 {
 }
 
-static bool reloc2sec_off(struct reloc *reloc, struct section **sec, unsigned long *off)
+static void reloc_to_sec_off(struct reloc *reloc, struct section **sec,
+			     unsigned long *off)
 {
-	switch (reloc->sym->type) {
-	case STT_FUNC:
-		*sec = reloc->sym->sec;
-		*off = reloc->sym->offset + reloc->addend;
-		return true;
-
-	case STT_SECTION:
-		*sec = reloc->sym->sec;
-		*off = reloc->addend;
-		return true;
-
-	default:
-		return false;
-	}
+	*sec = reloc->sym->sec;
+	*off = reloc->sym->offset + reloc->addend;
 }
 
 static int get_alt_entry(struct elf *elf, struct special_entry *entry,
@@ -109,11 +98,7 @@ static int get_alt_entry(struct elf *elf, struct special_entry *entry,
 		WARN_FUNC("can't find orig reloc", sec, offset + entry->orig);
 		return -1;
 	}
-	if (!reloc2sec_off(orig_reloc, &alt->orig_sec, &alt->orig_off)) {
-		WARN_FUNC("don't know how to handle reloc symbol type: %s",
-			   sec, offset + entry->orig, orig_reloc->sym->name);
-		return -1;
-	}
+	reloc_to_sec_off(orig_reloc, &alt->orig_sec, &alt->orig_off);
 
 	if (!entry->group || alt->new_len) {
 		new_reloc = find_reloc_by_dest(elf, sec, offset + entry->new);
@@ -131,11 +116,7 @@ static int get_alt_entry(struct elf *elf, struct special_entry *entry,
 		if (arch_is_retpoline(new_reloc->sym))
 			return 1;
 
-		if (!reloc2sec_off(new_reloc, &alt->new_sec, &alt->new_off)) {
-			WARN_FUNC("don't know how to handle reloc symbol type: %s",
-				  sec, offset + entry->new, new_reloc->sym->name);
-			return -1;
-		}
+		reloc_to_sec_off(new_reloc, &alt->new_sec, &alt->new_off);
 
 		/* _ASM_EXTABLE_EX hack */
 		if (alt->new_off >= 0x7ffffff0)

