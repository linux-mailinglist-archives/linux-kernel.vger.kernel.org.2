Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD4F443D9E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 08:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbhKCHVG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 3 Nov 2021 03:21:06 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:45032 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231985AbhKCHVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 03:21:03 -0400
Received: by mail-ed1-f41.google.com with SMTP id j21so5707446edt.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 00:18:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=qv+pF49xTGEYmz10QrzOthr2BtBRYPpW3XmhKeT1sqQ=;
        b=LWNJprtji5dFBvFsFP7Le7hHNIJT0Fb11ssMBW4sIirPe7+fMJPeI+zzd5PAKYIx4n
         UZ2Wgw4VPmKKwiKQvdPpvTrvoTFcj4SMb+tPLKb/8ZylIOmNzBK+TyXYjmskB4WPGGZD
         YCQfeTglQVgBe4+s4g33SZV7cWPf3m3jHJX2tburKPLem1/vzXpTmWEkdZqflqlwcDHO
         JL0TZj9Hl1rsWXxNRbCMomgMQefr0F1Cz/KIGkKJgxrNlL4Tzv9Ov0R1Ym1JAvAQSUwK
         WD3csc8VePve2JWgR/GVNygu0Irg4NpA9fz7DWv2lOjgJBB1rDyHjeCoSluv3k4z9JCw
         O2Cg==
X-Gm-Message-State: AOAM530DO0VnpI1ii05bsKPqUcpkHH48bwofg0vhWvrUw66rEKffMhAE
        C7tYBM23xW7fQErEHDH+HjwX5yCU2hs=
X-Google-Smtp-Source: ABdhPJzhIUkUd+mdOxn44a7rALVofsmJce1fsyCPknef/Sc15wws6ew2FyMb0meTiQLwliFMut210w==
X-Received: by 2002:a17:907:72d4:: with SMTP id du20mr53564699ejc.324.1635923906445;
        Wed, 03 Nov 2021 00:18:26 -0700 (PDT)
Received: from [10.9.0.6] ([46.166.133.199])
        by smtp.gmail.com with ESMTPSA id g26sm725471edt.13.2021.11.03.00.18.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Nov 2021 00:18:26 -0700 (PDT)
Date:   Wed, 03 Nov 2021 10:18:22 +0300
In-Reply-To: <YYENAKB0igNFnFmK@hirez.programming.kicks-ass.net>
References: <163572864256.3357115.931779940195622047.tglx@xen13> <163572864563.3357115.8793939214537874196.tglx@xen13> <CAHk-=wgNzL3AaVNruwLv=kcGXi1EbJN9CZC6GoRY66t6WFcfGg@mail.gmail.com> <YYDwJORywW2FjprP@hirez.programming.kicks-ass.net> <YYD/bpLabfumrvL+@hirez.programming.kicks-ass.net> <YYENAKB0igNFnFmK@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: Stackleak vs noinstr (Was: [GIT pull] objtool/core for v5.16-rc1)
To:     Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
From:   Alexander Popov <alex.popov@linux.com>
Message-ID: <A4522E50-B426-4588-A1F8-B27DB579C100@linux.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On November 2, 2021 1:03:44 PM GMT+03:00, Peter Zijlstra <peterz@infradead.org> wrote:
>On Tue, Nov 02, 2021 at 10:05:50AM +0100, Peter Zijlstra wrote:
>> On Tue, Nov 02, 2021 at 09:00:36AM +0100, Peter Zijlstra wrote:
>> > On Mon, Nov 01, 2021 at 01:44:39PM -0700, Linus Torvalds wrote:
>> 
>> > >     do_machine_check()+0x27: call to stackleak_track_stack ...
>> > >     do_syscall_64()+0x9: call to stackleak_track_stack ...
>> > >     do_int80_syscall_32()+0x9: call to stackleak_track_stack ...
>> > >     exc_general_protection()+0x22: call to stackleak_track_stack
>...
>> > >     fixup_bad_iret()+0x20: call to stackleak_track_stack ...
>> > >     .entry.text+0x10e6: call to stackleak_erase ...
>> > >     .entry.text+0x143: call to stackleak_erase ...
>> > >     .entry.text+0x17d9: call to stackleak_erase ...
>> > > 
>> > > most seem to be about the stackleak thing,
>> > 
>> > Right, I recently ran into this and hacen't yet had time to look
>into
>> > it. I suspect my normal build box doesn't have the GCC plugin crud
>> > enabled or somesuch.
>> > 
>> > I think the GCC stackleak plugin needs fixing, specifically it
>needs a
>> > function attribute such that it will not emit instrumentation in
>noinstr
>> > functions. I'll go chase down the developer of that thing.
>> 
>> Alexander, is there any way to make this plugin grow a function
>> attribute which we can add to noinstr ? There's a strict requirement
>the
>> compiler doesn't add extra code to noinstr functions these days.
>> 
>> We'll 'soon' be running noinstr C code before switching to kernel
>page
>> tables even.
>
>Using my pre-release GCC-12 compiler (the only one I have with plugin
>crud enabled apparently), the below seems to work.
>
>Having the plugin gate on section name seems a lot hacky, but given
>it's
>already doing that, one more doesn't hurt.

Hello Peter!

Yes, this is a correct approach.

But I'm not sure about removing NOKPROBE_SYMBOL and notrace for stackleak_erase. Does the code in noinstr.text disable all those?

Best regards,
Alexander

>---
>diff --git a/kernel/stackleak.c b/kernel/stackleak.c
>index ce161a8e8d97..135866ca8878 100644
>--- a/kernel/stackleak.c
>+++ b/kernel/stackleak.c
>@@ -48,7 +48,7 @@ int stack_erasing_sysctl(struct ctl_table *table, int
>write,
> #define skip_erasing()	false
> #endif /* CONFIG_STACKLEAK_RUNTIME_DISABLE */
> 
>-asmlinkage void notrace stackleak_erase(void)
>+asmlinkage noinstr void stackleak_erase(void)
> {
>	/* It would be nice not to have 'kstack_ptr' and 'boundary' on stack
>*/
> 	unsigned long kstack_ptr = current->lowest_stack;
>@@ -102,7 +102,6 @@ asmlinkage void notrace stackleak_erase(void)
> 	/* Reset the 'lowest_stack' value for the next syscall */
> 	current->lowest_stack = current_top_of_stack() - THREAD_SIZE/64;
> }
>-NOKPROBE_SYMBOL(stackleak_erase);
> 
>void __used __no_caller_saved_registers notrace
>stackleak_track_stack(void)
> {
>diff --git a/scripts/gcc-plugins/stackleak_plugin.c
>b/scripts/gcc-plugins/stackleak_plugin.c
>index e9db7dcb3e5f..07688a1c686b 100644
>--- a/scripts/gcc-plugins/stackleak_plugin.c
>+++ b/scripts/gcc-plugins/stackleak_plugin.c
>@@ -446,6 +446,8 @@ static bool stackleak_gate(void)
> 			return false;
> 		if (!strncmp(TREE_STRING_POINTER(section), ".meminit.text", 13))
> 			return false;
>+		if (!strncmp(TREE_STRING_POINTER(section), ".noinstr.text", 13))
>+			return false;
> 	}
> 
> 	return track_frame_size >= 0;
