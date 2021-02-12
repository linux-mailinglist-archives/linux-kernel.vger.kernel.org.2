Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22A0631A266
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 17:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhBLQLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 11:11:17 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:36300 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229493AbhBLQLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 11:11:13 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 11CGAG7W018325
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Feb 2021 11:10:17 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 79CA415C3428; Fri, 12 Feb 2021 11:10:16 -0500 (EST)
Date:   Fri, 12 Feb 2021 11:10:16 -0500
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Jan Kara <jack@suse.cz>,
        syzbot <syzbot+3b6f9218b1301ddda3e2@syzkaller.appspotmail.com>,
        Jan Kara <jack@suse.com>, LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: possible deadlock in dquot_commit
Message-ID: <YCaoaNpF5n3nyja9@mit.edu>
References: <000000000000a05b3b05baf9a856@google.com>
 <20210211113718.GM19070@quack2.suse.cz>
 <CACT4Y+b7245_5yjTk5Mw1pFBdV_f2LypAVSAZVym9n1Q0v5c-Q@mail.gmail.com>
 <YCWlzl1q+eP22KVc@mit.edu>
 <CACT4Y+YJtk_Lb9AGB4K3pdc-1VpBV0ZzH=1oHVDA003YpAhAog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+YJtk_Lb9AGB4K3pdc-1VpBV0ZzH=1oHVDA003YpAhAog@mail.gmail.com>
From:   "Theodore Ts'o" <tytso@mit.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Theodore Ts'o <tytso@mit.edu>

On Fri, Feb 12, 2021 at 12:01:51PM +0100, Dmitry Vyukov wrote:
> > >
> > > There is a reproducer for 4.19 available on the dashboard. Maybe it will help.
> > > I don't why it did not pop up on upstream yet, there lots of potential
> > > reasons for this.
> >
> > The 4.19 version of the syzbot report has a very different stack
> > trace.  Instead of it being related to an apparent write to the quota
> > file, it is apparently caused by a call to rmdir:
> >
>
> The 4.19 reproducer may reproducer something else, you know better. I
> just want to answer points re syzkaller reproducers. FTR the 4.19
> reproducer/reproducer is here:
> https://syzkaller.appspot.com/bug?id=b6cacc9fa48fea07154b8797236727de981c1e02

Yes, I know.  That was my point.  I don't think it's useful for
debugging the upstream dquot_commit syzbot report (for which we don't
have a reproducer yet).

> > there is never any attempt to run rmdir() on the corrupted file system that is mounted.
> 
> Recursive rmdir happens as part of test cleanup implicitly, you can
> see rmdir call in remove_dir function in the C reproducer:
> https://syzkaller.appspot.com/text?tag=ReproC&x=12caea37900000

That rmdir() removes the mountpoint, which is *not* the fuzzed file
system which has the quota feature enabled.

> > procid never gets incremented, so all of the threads only operate on /dev/loop0
> 
> This is intentional. procid is supposed to "isolate" parallel test
> processes (if any). This reproducer does not use parallel test
> processes, thus procid has constant value.

Um... yes it does:

int main(void)
{
  syscall(__NR_mmap, 0x1ffff000ul, 0x1000ul, 0ul, 0x32ul, -1, 0ul);
  syscall(__NR_mmap, 0x20000000ul, 0x1000000ul, 7ul, 0x32ul, -1, 0ul);
  syscall(__NR_mmap, 0x21000000ul, 0x1000ul, 0ul, 0x32ul, -1, 0ul);
  use_temporary_dir();
  loop();
  return 0;
}

and what is loop?

static void loop(void)
{
  int iter = 0;
  for (;; iter++) {
  	...
    reset_loop();
    int pid = fork();
    if (pid < 0)
      exit(1);
    if (pid == 0) {
      if (chdir(cwdbuf))
        exit(1);
      setup_test();
      execute_one();
      exit(0);
    }
    ...	
    remove_dir(cwdbuf);
  }
}

> > Am I correct in understanding that when syzbot is running, it uses the syzbot repro, and not the C repro?
> 
> It tries both. If first tries to interpret "syzkaller program" as it
> was done when the bug was triggered during fuzzing. But then it tries
> to convert it to a corresponding stand-alone C program and confirms
> that it still triggers the bug. If it provides a C reproducer, it
> means that it did trigger the bug using this exact C program on a
> freshly booted kernel (and the provided kernel oops is the
> corresponding oops obtained on this exact program).
> If it fails to reproduce the bug with a C reproducer, then it provides
> only the "syzkaller program" to not mislead developers.

Well, looking at the C reproducer, it doesn't reproduce on upstream,
and the stack trace makes no sense to me.  The rmdir() executes at the
end of the test, as part of the cleanup, and looking at the syzkaller
console, the stack trace involving rmdir happens *early* while test
threads are still trying to mount the file system.

	    	  	    	      - Ted
