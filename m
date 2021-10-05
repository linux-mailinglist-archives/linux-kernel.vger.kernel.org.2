Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 640C8421BAA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 03:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbhJEBTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 21:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbhJEBTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 21:19:21 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89393C061749
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 18:17:31 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id 5so9933931iov.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 18:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uFH58MnGys3qQcihPrr7GEc7YMtbeREM2ZW+uVuRVco=;
        b=kitDNNzkuL+1NVv6xwgm2pfF7V64T1n6mNePnHkwSM2GYq2YoNIJh0GFjrRY1H4klr
         PNft7NTo/XePqU5HdIVPB0wDuZMtDovQBPaCf80j8I1oQufyV9pK+CnZ4dBEUPSHhV7j
         NNR/UVfCV/JMpEAM0ick90XkHjRCiTb96uAOkQB4R/2QXfRnGYnR8y+safwTd9PtAL66
         7Za+fyBmNciXq+abLN1iEJ8vobMdt6+OVBB4BPZJ73YW8vdlTvtruFTaopm+OePJx9TV
         rsCdcWbCJN7J+uwLBrs+nZUPWwzL1YmMRuW1xp6aU33cFygaiKroEOqSO7rMvbBsUKuY
         3seA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uFH58MnGys3qQcihPrr7GEc7YMtbeREM2ZW+uVuRVco=;
        b=n36ghBzlWb/JQGm9k75VSNLbyqTPTTWn3aFnTz5mL286lvLf6zTSuM+CyC/gHfkU/L
         7orE5gkeM7cOhFEXM+K9macaggpb2AmmVjF4RKSxO20hHfiGxnZHt2SNEhDvpqRmRW11
         mTu98/THIp5uhfgTQNRv5ESDckv2DahFjrFYsmTEanU/5jB6yQU+0J+eUEvsbHoFNrnT
         bKElb1RQJzPHUAzfrfPVbZ/fB/lfJ58BLvbZOIfq1RgBjvLKb8gcX7XVZg3tlVWIsGTc
         H4jb8/y+3UAQX4EpSrKflMBNACXg8WEzoYhqsRV2wicfDWxQXhZRrzlvw4xSOomMRK67
         v4mQ==
X-Gm-Message-State: AOAM530XtPiuneyONI3Iw9xZAJedMLbsinDfSmLF0OOuGunRhQTEmFfX
        yzDFZ51kOUneSAKdUHpTKhi+9HFvWLEmpIfu8xwjDg==
X-Google-Smtp-Source: ABdhPJwIvw85TvixXq62uiSiKYgFRBk2mq87mKdqXrEmlD/eAEgFCQB/MSAWldDnmHdu0eiAC5IdP/8rcWC1qEZI7iU=
X-Received: by 2002:a6b:f805:: with SMTP id o5mr242261ioh.131.1633396650537;
 Mon, 04 Oct 2021 18:17:30 -0700 (PDT)
MIME-Version: 1.0
References: <20211004170102.2522514-1-dlatypov@google.com> <CABVgOS=LsVTvX-RnsfE775fnq4aGQt7SUCeRpBpEd03My99NTQ@mail.gmail.com>
 <CAGS_qxpzB0r1piC9S1z9vWy-2Dz=frfN0uK-UAar6i+zvtjdjg@mail.gmail.com>
 <CABVgOS==C7r+9JAV5+NcCqgCdqdYy+Yyr8ht7RUVwrpAmqR1vg@mail.gmail.com>
 <CAGS_qxpo0xLYWzUib6drELbE-PvbwmaB80Y25H2_S5KOGeW7iA@mail.gmail.com> <CABVgOSnXBtCHEMDYYqrbXWvKcrSbY9BXP4MJjsT+vzZS6W4J=w@mail.gmail.com>
In-Reply-To: <CABVgOSnXBtCHEMDYYqrbXWvKcrSbY9BXP4MJjsT+vzZS6W4J=w@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 4 Oct 2021 18:17:18 -0700
Message-ID: <CAGS_qxpecM8NcosSYBxbUviXkVt+i30NZNsre3q8q3vkvAb93g@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: yield output from run_kernel in real time
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 4, 2021 at 6:08 PM David Gow <davidgow@google.com> wrote:
>
> On Tue, Oct 5, 2021 at 8:36 AM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > On Mon, Oct 4, 2021 at 4:58 PM David Gow <davidgow@google.com> wrote:
> > >
> > > On Tue, Oct 5, 2021 at 7:46 AM Daniel Latypov <dlatypov@google.com> wrote:
> > > >
> > > > On Mon, Oct 4, 2021 at 4:34 PM 'David Gow' via KUnit Development
> > > > <kunit-dev@googlegroups.com> wrote:
> > > > >
> > > > > On Tue, Oct 5, 2021 at 1:01 AM Daniel Latypov <dlatypov@google.com> wrote:
> > > > > >
> > > > > > Currently, `run_kernel()` dumps all the kernel output to a file
> > > > > > (.kunit/test.log) and then opens the file and yields it to callers.
> > > > > > This made it easier to respect the requested timeout, if any.
> > > > > >
> > > > > > But it means that we can't yield the results in real time, either to the
> > > > > > parser or to stdout (if --raw_output is set).
> > > > > >
> > > > > > This change spins up a background thread to enforce the timeout, which
> > > > > > allows us to yield the kernel output in real time, while also copying it
> > > > > > to the .kunit/test.log file.
> > > > > > It's also careful to ensure that the .kunit/test.log file is complete,
> > > > > > even in the kunit_parser throws an exception/otherwise doesn't consume
> > > > > > every line, see the new `finally` block and unit test.
> > > > > >
> > > > > > For example:
> > > > > >
> > > > > > $ ./tools/testing/kunit/kunit.py run --arch=x86_64 --raw_output
> > > > > > <configure + build steps>
> > > > > > ...
> > > > > > <can now see output from QEMU in real time>
> > > > > >
> > > > > > This does not currently have a visible effect when --raw_output is not
> > > > > > passed, as kunit_parser.py currently only outputs everything at the end.
> > > > > > But that could change, and this patch is a necessary step towards
> > > > > > showing parsed test results in real time.
> > > > > >
> > > > > > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > > > > > ---
> > > > > >  tools/testing/kunit/kunit_kernel.py    | 73 +++++++++++++++-----------
> > > > > >  tools/testing/kunit/kunit_tool_test.py | 17 ++++++
> > > > > >  2 files changed, 60 insertions(+), 30 deletions(-)
> > > > > >
> > > > > > diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
> > > > > > index 2c6f916ccbaf..b8cba8123aa3 100644
> > > > > > --- a/tools/testing/kunit/kunit_kernel.py
> > > > > > +++ b/tools/testing/kunit/kunit_kernel.py
> > > > > > @@ -12,7 +12,8 @@ import subprocess
> > > > > >  import os
> > > > > >  import shutil
> > > > > >  import signal
> > > > > > -from typing import Iterator, Optional, Tuple
> > > > > > +import threading
> > > > > > +from typing import Iterator, List, Optional, Tuple
> > > > > >
> > > > > >  from contextlib import ExitStack
> > > > > >
> > > > > > @@ -103,8 +104,8 @@ class LinuxSourceTreeOperations(object):
> > > > > >                 if stderr:  # likely only due to build warnings
> > > > > >                         print(stderr.decode())
> > > > > >
> > > > > > -       def run(self, params, timeout, build_dir, outfile) -> None:
> > > > > > -               pass
> > > > > > +       def start(self, params: List[str], build_dir: str) -> subprocess.Popen:
> > > > > > +               raise RuntimeError('not implemented!')
> > > > > >
> > > > > >
> > > > > >  class LinuxSourceTreeOperationsQemu(LinuxSourceTreeOperations):
> > > > > > @@ -123,7 +124,7 @@ class LinuxSourceTreeOperationsQemu(LinuxSourceTreeOperations):
> > > > > >                 kconfig.parse_from_string(self._kconfig)
> > > > > >                 base_kunitconfig.merge_in_entries(kconfig)
> > > > > >
> > > > > > -       def run(self, params, timeout, build_dir, outfile):
> > > > > > +       def start(self, params: List[str], build_dir: str) -> subprocess.Popen:
> > > > > >                 kernel_path = os.path.join(build_dir, self._kernel_path)
> > > > > >                 qemu_command = ['qemu-system-' + self._qemu_arch,
> > > > > >                                 '-nodefaults',
> > > > > > @@ -134,18 +135,10 @@ class LinuxSourceTreeOperationsQemu(LinuxSourceTreeOperations):
> > > > > >                                 '-nographic',
> > > > > >                                 '-serial stdio'] + self._extra_qemu_params
> > > > > >                 print('Running tests with:\n$', ' '.join(qemu_command))
> > > > > > -               with open(outfile, 'w') as output:
> > > > > > -                       process = subprocess.Popen(' '.join(qemu_command),
> > > > > > -                                                  stdin=subprocess.PIPE,
> > > > > > -                                                  stdout=output,
> > > > > > -                                                  stderr=subprocess.STDOUT,
> > > > > > -                                                  text=True, shell=True)
> > > > > > -               try:
> > > > > > -                       process.wait(timeout=timeout)
> > > > > > -               except Exception as e:
> > > > > > -                       print(e)
> > > > > > -                       process.terminate()
> > > > > > -               return process
> > > > > > +               return subprocess.Popen(' '.join(qemu_command),
> > > > > > +                                          stdout=subprocess.PIPE,
> > > > > > +                                          stderr=subprocess.STDOUT,
> > > > > > +                                          text=True, shell=True)
> > > > > >
> > > > > >  class LinuxSourceTreeOperationsUml(LinuxSourceTreeOperations):
> > > > > >         """An abstraction over command line operations performed on a source tree."""
> > > > > > @@ -175,17 +168,13 @@ class LinuxSourceTreeOperationsUml(LinuxSourceTreeOperations):
> > > > > >                 kunit_parser.print_with_timestamp(
> > > > > >                         'Starting Kernel with all configs takes a few minutes...')
> > > > > >
> > > > > > -       def run(self, params, timeout, build_dir, outfile):
> > > > > > +       def start(self, params: List[str], build_dir: str) -> subprocess.Popen:
> > > > > >                 """Runs the Linux UML binary. Must be named 'linux'."""
> > > > > >                 linux_bin = get_file_path(build_dir, 'linux')
> > > > > > -               outfile = get_outfile_path(build_dir)
> > > > > > -               with open(outfile, 'w') as output:
> > > > > > -                       process = subprocess.Popen([linux_bin] + params,
> > > > > > -                                                  stdin=subprocess.PIPE,
> > > > >
> > > > > This breaks --raw_output under UML for me. Including the
> > > > > stdin=subprocess.PIPE again seems to fix it.
> > > >
> > > > Can you give an example of what it does?
> > > >
> > > > I don't see any issues with --raw_output under UML with the patch as-is.
> > > > I was mainly testing this with UML, and I must have ran it some 10s of
> > > > times, so I'm a bit surprised.
> > > >
> > > > On an earlier version, I saw some mangling of --raw_output (\n was
> > > > missing), but that went away after some revisions.
> > > >
> > >
> > > Yeah, that's the sort of thing I'm seeing: \n being treated as just a
> > > new line (without the carriage return).
> > > It happens pretty consistently, though sometimes the text wraps and
> > > sometimes (well, once) everything gets forced into the last column of
> > > the terminal. I've not been able to get it to work at all without
> > > having stdin be subprocess.PIPE.
> >
> > I can't repro in the shell I was using while writing this.
> > Starting up a new session, I get:
> > * good
> > * bad x3
> > * good
> > * bad x3
> > * good
> > * bad x3
> > * bad, but not as bad (phew, I thought this was cursed)
> >
> > .kunit/test.log contains the output with proper \n each time I checked.
> >
> > Doesn't seem to repro when redirected into a file:
> >
> > $ ./tools/testing/kunit/kunit.py exec --raw_output > /tmp/out && diff
> > /tmp/out .kunit/test.log | grep -m1 '^>'
> >
> > Piping it through cat also seems 100% fine:
> > $ ./tools/testing/kunit/kunit.py exec --raw_output | cat
> >
> > So having stdin be subprocess.PIPE sorta makes sense in some twisted way.
> > I can also now repro that setting stdin=subprocess.PIPE seems to fix it.
> >
> > I don't want to put back subprocess.PIPE, but I'm not confident in
> > being able to find a better solution...
>
> So it turns out that there are a few issues with UML assuming stdin ==
> stdout (or at least that stdin and stdout are related), as seen in
> this ongoing thread on linux-um:
> http://lists.infradead.org/pipermail/linux-um/2021-October/001805.html

Ah, that sounds very related.

>
> Some of the coments in UML's chan_user.c seem pretty related, too, in
> that termios is used to set this weird
> "mostly-raw-but-\n-includes-carriage-returns" mode:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/um/drivers/chan_user.c#n90
>
> My theory is that UML sets "raw" mode based on what stdin is, then
> only sets OPOST if stdout is a tty, so there's a mismatch here. So,
> probably this is fundamentally a UML bug, but worth us working around
> in it kunit_tool for the time being. That being said, I've not been
> able to find anything obviously stdin-y setting raw mode thus far, so
> I could be wrong.
>
> My preference is that we put stdin=subprocess.PIPE back for now, since
> we don't want a regression, and if a cause in UML is found and fixed,
> we can remove it after the fix has propagated comfortably everywhere.
>

Agreed.
I sent out v2 here:
https://lore.kernel.org/linux-kselftest/20211005011340.2826268-1-dlatypov@google.com

Based on this, we could probably drop it for the QEMU code path, but
I'll leave stdin untouched for both in the patch for consistency.

We can followup later and
* drop it from QEMU + add a comment/TODO on UML
* or just revist if/when we've found a fix and drop it from both.

> -- David
>
> >
> > >
> > > It occurs both under tmux and not, and under Konsole and xterm, so it
> > > doesn't appear to be specific to any given terminal implementation.
> > > Still occurs even after running 'reset', and with a clean build.
> > > QEMU-based --raw_output works fine.
> > >
> > >
