Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 912953A5AC8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 00:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbhFMW2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 18:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbhFMW2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 18:28:37 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06926C061574
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 15:26:34 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id k8so574827lja.4
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 15:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RxQzyytN9Xv/POFiz8Y3R+utq4RPK0XbvLC7geKBN54=;
        b=eI/+uvMTqWinqnHgENJVOiH6LZbpPCrFa2vhgarfRXuzeG+COM4dVsEynMvTS6y/6Q
         LOq6njwdgJIYMLCwnwLTwRKUsWbB0E78FSxFRLi7qu5gVFnqwsbqt3rxLFr58x4618EA
         f3HhTPMdbHBxITRJM9ZQoRDK+/EXfCFm4KkTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RxQzyytN9Xv/POFiz8Y3R+utq4RPK0XbvLC7geKBN54=;
        b=GU579sLZ5mgT7mutvGbU2dBYitxNTaTqOAARRsMUsUXASBqI2KZpFp3xalgkyW/EC4
         aq+0k/KQ7usD3+D0m5wlyddHUNYcvox132TQ1BIO0shlw3bhrcR1O1UZ2OqOLUMdiGmD
         6Yy8LJA/VutWFuZ2wmk7xt5E/Ah12w7oE8bYyp07eZIQso/sN/R6QgOZVi0wG7GMraCW
         eHdDMs/sPBNS6kW25QZVtDAy/hMYwMrnSoUSpH/YBKZ4eDQgfbbasveY1jI8xDbrmUq0
         vev7UvyH6Hd3hq0nmMwXlssj5cPSDN98GxoZb1k7RcPPeuBLfQbitA7bQsnFqUPEOu7O
         44nA==
X-Gm-Message-State: AOAM5319+2Mtn995tcokEAyZa76RiDsCyYNT0Ei6KKN1a8GvDcB1g9tb
        YhionYbn4zRFV0MECaDxflJA/w4LOp3VFX1YkuY=
X-Google-Smtp-Source: ABdhPJyn0txMyylAGQM0FN6H/6qhovrX+m/uYjggCCYVz6SAq2w2p1BRhlbfQpJyDJlMzXCoOo16lg==
X-Received: by 2002:a2e:8ec2:: with SMTP id e2mr10840274ljl.446.1623623192961;
        Sun, 13 Jun 2021 15:26:32 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id e4sm1574544ljf.82.2021.06.13.15.26.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Jun 2021 15:26:32 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id r14so17366435ljd.10
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 15:26:32 -0700 (PDT)
X-Received: by 2002:a2e:2ac6:: with SMTP id q189mr11263791ljq.61.1623622746600;
 Sun, 13 Jun 2021 15:19:06 -0700 (PDT)
MIME-Version: 1.0
References: <87sg1p30a1.fsf@disp2133> <CAHk-=wjiBXCZBxLiCG5hxpd0vMkMjiocenponWygG5SCG6DXNw@mail.gmail.com>
 <87pmwsytb3.fsf@disp2133> <CAHk-=wgdO5VwSUFjfF9g=DAQNYmVxzTq73NtdisYErzdZKqDGg@mail.gmail.com>
 <87sg1lwhvm.fsf@disp2133>
In-Reply-To: <87sg1lwhvm.fsf@disp2133>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 13 Jun 2021 15:18:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgsnMTr0V-0F4FOk30Q1h7CeT8wLvR1MSnjack7EpyWtQ@mail.gmail.com>
Message-ID: <CAHk-=wgsnMTr0V-0F4FOk30Q1h7CeT8wLvR1MSnjack7EpyWtQ@mail.gmail.com>
Subject: Re: Kernel stack read with PTRACE_EVENT_EXIT and io_uring threads
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        alpha <linux-alpha@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Tejun Heo <tj@kernel.org>,
        Daniel Jacobowitz <drow@nevyn.them.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: multipart/mixed; boundary="0000000000000fabcb05c4ad21da"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000000fabcb05c4ad21da
Content-Type: text/plain; charset="UTF-8"

On Sun, Jun 13, 2021 at 2:55 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> The alpha_switch_to will remove the extra registers from the stack and
> then call ret which if I understand alpha assembly correctly is
> equivalent to jumping to where $26 points.  Which is
> ret_from_kernel_thread (as setup by copy_thread).
>
> Which leaves ret_from_kernel_thread and everything it calls without
> the extra context saved on the stack.

Uhhuh. Right you are, I think. It's been ages since I worked on that
code and my alpha handbook is somewhere else, but yes, when
alpha_switch_to() has context-switched to the new PCB state, it will
then pop those registers in the new context and return.

So we do set up the right stack frame for the worker thread, but as
you point out, it then gets used up immediately when running. So by
the time the IO worker thread calls get_signal(), it's no longer
useful.

How very annoying.

The (obviously UNTESTED) patch might be something like the attached.

I wouldn't be surprised if m68k has the exact same thing for the exact
same reason, but I didn't check..

                  Linus

--0000000000000fabcb05c4ad21da
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_kpvr1cy80>
X-Attachment-Id: f_kpvr1cy80

IGFyY2gvYWxwaGEva2VybmVsL3Byb2Nlc3MuYyB8IDExICsrKysrKysrKystCiAxIGZpbGUgY2hh
bmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2FyY2gv
YWxwaGEva2VybmVsL3Byb2Nlc3MuYyBiL2FyY2gvYWxwaGEva2VybmVsL3Byb2Nlc3MuYwppbmRl
eCA1MTEyYWI5OTYzOTQuLmVkYmZlMDNmNGIyYyAxMDA2NDQKLS0tIGEvYXJjaC9hbHBoYS9rZXJu
ZWwvcHJvY2Vzcy5jCisrKyBiL2FyY2gvYWxwaGEva2VybmVsL3Byb2Nlc3MuYwpAQCAtMjUxLDgg
KzI1MSwxNyBAQCBpbnQgY29weV90aHJlYWQodW5zaWduZWQgbG9uZyBjbG9uZV9mbGFncywgdW5z
aWduZWQgbG9uZyB1c3AsCiAKIAlpZiAodW5saWtlbHkocC0+ZmxhZ3MgJiAoUEZfS1RIUkVBRCB8
IFBGX0lPX1dPUktFUikpKSB7CiAJCS8qIGtlcm5lbCB0aHJlYWQgKi8KKwkJLyoKKwkJICogR2l2
ZSBpdCAqdHdvKiBzd2l0Y2ggc3RhY2tzLCBvbmUgZm9yIHRoZSBrZXJuZWwKKwkJICogc3RhdGUg
cmV0dXJuIHRoYXQgaXMgdXNlZCB1cCBieSBhbHBoYV9zd2l0Y2hfdG8sCisJCSAqIGFuZCBvbmUg
Zm9yIHRoZSAidXNlciBzdGF0ZSIgd2hpY2ggaXMgYWNjZXNzZWQKKwkJICogYnkgcHRyYWNlLgor
CQkgKi8KKwkJY2hpbGRzdGFjay0tOworCQljaGlsZHRpLT5wY2Iua3NwID0gKHVuc2lnbmVkIGxv
bmcpIGNoaWxkc3RhY2s7CisKIAkJbWVtc2V0KGNoaWxkc3RhY2ssIDAsCi0JCQlzaXplb2Yoc3Ry
dWN0IHN3aXRjaF9zdGFjaykgKyBzaXplb2Yoc3RydWN0IHB0X3JlZ3MpKTsKKwkJCTIqc2l6ZW9m
KHN0cnVjdCBzd2l0Y2hfc3RhY2spICsgc2l6ZW9mKHN0cnVjdCBwdF9yZWdzKSk7CiAJCWNoaWxk
c3RhY2stPnIyNiA9ICh1bnNpZ25lZCBsb25nKSByZXRfZnJvbV9rZXJuZWxfdGhyZWFkOwogCQlj
aGlsZHN0YWNrLT5yOSA9IHVzcDsJLyogZnVuY3Rpb24gKi8KIAkJY2hpbGRzdGFjay0+cjEwID0g
a3RocmVhZF9hcmc7Cg==
--0000000000000fabcb05c4ad21da--
