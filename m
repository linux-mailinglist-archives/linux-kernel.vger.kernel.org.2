Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 366C2309F6A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 00:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbhAaXSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 18:18:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbhAaXSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 18:18:48 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A2DC061573
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 15:18:07 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id p20so2123753ejb.6
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 15:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lXh/zepkoRwHY1DFPH6efVLlYByObi9Zs7kzu1OmHVs=;
        b=HE8gI5YpC5VWSeITDW5wJGif9g8E84FVYqJe7PyTLYtmF7Ko6vvH7DPfAFF6o1uovn
         wctlJzays4t8uqzttmBAEf63XrMpcCUfMEAUJDJPf+6Qjgp4rb9LeydN5E+Jrw9SlHmV
         QxzVegwGXqcqkvLnHi9oNwMttp0RGHH5orkRbiqjRtqmjguDBGKOnVjAkDJz51DxyNcp
         DrA8vD/VLwBrQyRn2R/djq/sYWSKFfowVkYg1GCgk1mbbMNqH8grwUZD3F8VfAZJkJ1s
         c/XIYjxRKMQ8X8QVBTtlLTt3vhg6V/Gl3ENJ1LhGsIUxmSBbTkhL/yFzy8GFrCRU4UXq
         Y2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lXh/zepkoRwHY1DFPH6efVLlYByObi9Zs7kzu1OmHVs=;
        b=IXBsCzs67EEnP6cW+txnE2x965RcageOv7NMqTPVyPhRWU/8yjGZl+ba4hnXzxvuRV
         igdln31zyNyRcMG382IfaKCFRp1buOJQ1OL2I6uZDF4aGAzH4XBfUm3tnNxFXEMFhrTX
         aubBdPx01eLL4SBahmorm3Rgmxp6qixoBAKC28H3P5r0SxlbdS/h8EMxDm5Kj+q+BhQE
         sq6BtguF8kox0/CFAbitiDbmkiqiVGdmENwQJHuM4Mqbh8JtqcM3jwtEJeXeEoml75yv
         wMQS0a1oMivzy/QZp4ef/PinPraGvCFcRFjo/gO3m1cW6LdaW5tnJIn2DgjrIg4eoSDf
         BJEw==
X-Gm-Message-State: AOAM533bLqni5VIOIbyybgMvj9Sjgv28oVU7OSl0ZCI3Vb/r2k48CHgP
        TDYByhQwzlTtHioAQaOWDCUBmFuG2gskLJMcNZ13iA==
X-Google-Smtp-Source: ABdhPJwVEwYgpcMBrXRKXFlGp+CBPu5BvQGehi5LSppJQrYgs+n+7uzHBitD+PoYi7iO7sjYIS/qbI8VdwpZuSvlEQ0=
X-Received: by 2002:a17:906:1741:: with SMTP id d1mr15283637eje.182.1612135085987;
 Sun, 31 Jan 2021 15:18:05 -0800 (PST)
MIME-Version: 1.0
References: <CAP045Ao_Zb0HGg0=bvUeV6GjX=-3fz0ScsvM_jE7VsZcVk_-tg@mail.gmail.com>
 <C479ACCB-A1A5-4422-8120-999E8D54314B@amacapital.net> <CAP045AoMRNjvVd1PdHvdf-nn3LNpTDp66sp+SAmZgNU888iFQQ@mail.gmail.com>
In-Reply-To: <CAP045AoMRNjvVd1PdHvdf-nn3LNpTDp66sp+SAmZgNU888iFQQ@mail.gmail.com>
From:   Kyle Huey <me@kylehuey.com>
Date:   Sun, 31 Jan 2021 15:17:54 -0800
Message-ID: <CAP045ApWnr=UQrBrv3fHj-C6EweukMWEyrCgsiY6Bt_i1Vdj6A@mail.gmail.com>
Subject: Re: [REGRESSION] x86/entry: TIF_SINGLESTEP handling is still broken
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        open list <linux-kernel@vger.kernel.org>,
        "Robert O'Callahan" <rocallahan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 31, 2021 at 2:27 PM Kyle Huey <me@kylehuey.com> wrote:
>
> On Sun, Jan 31, 2021 at 2:20 PM Andy Lutomirski <luto@amacapital.net> wro=
te:
> >
> >
> >
> > > On Jan 31, 2021, at 2:08 PM, Kyle Huey <me@kylehuey.com> wrote:
> > >
> > > =EF=BB=BFOn Sun, Jan 31, 2021 at 2:04 PM Andy Lutomirski <luto@amacap=
ital.net> wrote:
> > >> Indeed, and I have tests for this.
> > >
> > > Do you mean you already have a test case or that you would like a
> > > minimized test case?
> >
> > A smallish test that we could stick in selftests would be great if that=
=E2=80=99s straightforward.
>
> I'll look into it.
>
> - Kyle

A minimal test case follows.

The key to triggering this bug is to enter a ptrace syscall stop and
then use PTRACE_SINGLESTEP to exit it. On a good kernel this will not
result in any userspace code execution in the tracee because on the
way out of the kernel's syscall handling path the singlestep trap will
be raised immediately. On a bad kernel that stop will not be raised,
and in the example below, the program will crash.

- Kyle

---

#include <assert.h>
#include <stdio.h>
#include <sys/ptrace.h>
#include <sys/user.h>
#include <sys/wait.h>
#include <unistd.h>

void do_child() {
  /* Synchronize with the parent */
  kill(getpid(), SIGSTOP);
  /* Do a syscall */
  printf("child is alive\n");
  /* Return and exit */
}

int main() {
  pid_t child =3D -1;
  int status =3D 0;
  unsigned long long previous_rip =3D 0;
  struct user_regs_struct regs;

  if ((child =3D fork()) =3D=3D 0) {
      do_child();
      return 0;
  }

  /* Adds 0x80 to syscall stops so we can see them easily */
  intptr_t options =3D PTRACE_O_TRACESYSGOOD;
  /* Take control of the child (which should be waiting */
  assert(ptrace(PTRACE_SEIZE, child, NULL, options) =3D=3D 0);
  assert(waitpid(child, &status, 0) =3D=3D child);
  assert(WIFSTOPPED(status) && WSTOPSIG(status) =3D=3D SIGSTOP);

  /* Advance to the syscall stop for the write underlying
   * the child's printf.
   */
  assert(ptrace(PTRACE_SYSCALL, child, NULL, 0) =3D=3D 0);
  assert(waitpid(child, &status, 0) =3D=3D child);
  /* Should be a syscall stop */
  assert(WIFSTOPPED(status) && WSTOPSIG(status) =3D=3D SIGTRAP | 0x80);

  /* Mess with the child's registers, so it will crash if
   * it executes any code
   */
  assert(ptrace(PTRACE_GETREGS, child, NULL, &regs) =3D=3D 0);
  previous_rip =3D regs.rip;
  regs.rip =3D 0xdeadbeef;
  assert(ptrace(PTRACE_SETREGS, child, NULL, &regs) =3D=3D 0);
  /* Singlestep. This should trap without executing any code */
  assert(ptrace(PTRACE_SINGLESTEP, child, NULL, 0) =3D=3D 0);
  assert(waitpid(child, &status, 0) =3D=3D child);
  /* Should be at a singlestep SIGTRAP. In a buggy kernel,
   * the SIGTRAP is skipped, execution resumes, and we
   * get a SIGSEGV at the invalid address.
   */
  assert(WIFSTOPPED(status) && WSTOPSIG(status) =3D=3D SIGTRAP);

  /* Restore registers */
  assert(ptrace(PTRACE_GETREGS, child, NULL, &regs) =3D=3D 0);
  regs.rip =3D previous_rip;
  assert(ptrace(PTRACE_SETREGS, child, NULL, &regs) =3D=3D 0);

  /* Continue to the end of the program */
  assert(ptrace(PTRACE_CONT, child, NULL, 0) =3D=3D 0);
  assert(waitpid(child, &status, 0) =3D=3D child);
  /* Verify the child exited cleanly */
  assert(WIFEXITED(status) && WEXITSTATUS(status) =3D=3D 0);

  printf("SUCCESS\n");

  return 0;
}
