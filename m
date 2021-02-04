Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26D2830AE87
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 18:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbhBARzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 12:55:02 -0500
Received: from mail.zx2c4.com ([104.131.123.232]:36346 "EHLO mail.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232462AbhBARyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 12:54:52 -0500
X-Greylist: delayed 396 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Feb 2021 12:54:51 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1612201648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=KsSWLRNvHtqLZ/lu/iHPVGBawnROqG20zNGdQaCD7HA=;
        b=PAUHVi90Iwlnhoz0chyPAAMjc285efXFxBkbIf8RBEWNIcbSdtxuR3QWqG46o4a1JxQfVw
        87TBf2B/5EqO2CDocpeBJFhMgzjzaw+1QlR9LF/MjARqseZK6+NwvDsZmSEdEA3++jJbca
        1KmfVXU6FpwP8LL0tRYTwWQKzVxV3dw=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 815801c6 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Mon, 1 Feb 2021 17:47:28 +0000 (UTC)
Received: by mail-yb1-f182.google.com with SMTP id q201so14118642ybg.8
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 09:47:28 -0800 (PST)
X-Gm-Message-State: AOAM532NBWGDbQo9amaCzMD4I2ek1Pk4Jq1CtbMFEeq7uuoX/WfiANnl
        dmZuHcXt8lswn4mwiEvYG7ibCk80Z/Jvc+bKhwQ=
X-Google-Smtp-Source: ABdhPJzjKgTkuZkwBCx6W8tj6h7g7/av3LQr5hFaREKuh9kX5C89k0fD079sPfHEeqZVP8Za9VEEhpkh0G/am9b5mjI=
X-Received: by 2002:a25:cc3:: with SMTP id 186mr25452179ybm.306.1612201648057;
 Mon, 01 Feb 2021 09:47:28 -0800 (PST)
MIME-Version: 1.0
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 1 Feb 2021 18:47:17 +0100
X-Gmail-Original-Message-ID: <CAHmME9oHBtR4fBBUY8E_Oi7av-=OjOGkSNhQuMJMHhafCjazBw@mail.gmail.com>
Message-ID: <CAHmME9oHBtR4fBBUY8E_Oi7av-=OjOGkSNhQuMJMHhafCjazBw@mail.gmail.com>
Subject: forkat(int pidfd), execveat(int pidfd), other awful things?
To:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Andy Lutomirski <luto@amacapital.net>
Cc:     LKML <linux-kernel@vger.kernel.org>, Jann Horn <jann@thejh.net>,
        Christian Brauner <christian.brauner@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy & others,

I was reversing some NT stuff recently and marveling over how wild and
crazy things are over in Windows-land. A few things related to process
creation caught my interest:

- It's possible to create a new process with an *arbitrary parent
process*, which means it'll then inherit various things like handles
and security attributes and tokens from that new parent process.

- It's possible to create a new process with the memory space handle
of a different process. Consider this on Linux, and you have some
abomination like `forkat(int pidfd)`.

The big question is "why!?" At first I was just amused by its presence
in NT. Everything is an object and you can usually freely mix and
match things, and it's very flexible, which is cool. But this is NT,
not Linux.

Jann and I were discussing, though, that maybe some variant of these
features might be useful to get rid of setuid executables. Imagine
something like `systemd-sudod`, forked off of PID 1 very early.
Subsequently all new processes on the system run with
PR_SET_NO_NEW_PRIVS or similar policies to prevent non-root->root
transition. Then, if you want to transition, you ask systemd-sudod (or
polkitd, or whatever else you have in mind) to make you a new process,
and it then does the various policy checks, and executes a new process
for you as the parent of the requesting process.

So how would that work? Well, executing processes with arbitrary
parents would be part of it, as above. But we'd probably want to more
carefully control that new process. Which chroot is it in? How do
cgroups work? And so on. And ultimately this design leads to something
like ZwCreateProcess, where you have several arguments, each to a
handle to some part of the new process state, or null to be inherited
from its parent.

int execve_parent(int parent_pidfd, int root_dirfd, int cgroup_fd, int
namespace_fd, const char *pathname, char *const argv[], char *const
envp[]);

One could imagine this growing pretty unwieldy. There's also this
other design aspect of Linux that's worth considering. Namespaces and
other process-inherited resources are generally hierarchical, with
children getting the resource from their parent. This makes sense and
is simple to conceptualize. Everytime we add a new thing_fd as a
pointer to one of these resources, and allow it to be used outside of
that hierarchy, it introduces a kind of "escape hatch". That might be
considered "bad design" by some; it might not be by others. Seen this
way, NT is one massive escape hatch, with pretty much everything being
an object with a handle.

But! Maybe this is nonetheless an interesting design avenue to
explore. The introduction of pidfd is sort of just the "beginning" of
that kind of design.

Is any of this interesting to you as a future of privilege escalation
and management on Linux?

Jason
