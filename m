Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E532A381B30
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 23:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235119AbhEOV1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 17:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbhEOV07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 17:26:59 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DF2C061573
        for <linux-kernel@vger.kernel.org>; Sat, 15 May 2021 14:25:45 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id q5so2517931wrs.4
        for <linux-kernel@vger.kernel.org>; Sat, 15 May 2021 14:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=cZgEA8wOuqe/FNFw+8yZb56BnmuD/jPua+RvSgM8YNU=;
        b=BgyJ42sXr2TXru4AL2U45bOvmYummbyZa5u0P3DyuBlYQWcmwNviKwTkPkbpUUE+hz
         86qhSaNjfxkb3aPO5nVnU98Uz/LYx0qit08s0QYmSqawZBNLa5rigP1Mb0XvaenBuOr+
         HLtlehsVnku+qXPCUWkknPSh/lmn9JeiiVUaiLhAhEH2MsuAbPksYnC7wOZYDzuEEFDM
         BkN+mUfItPBAigRZCi9d094wsxOHB5cevVOetpphC2I3L1eQak4tZur/ae3Rrn7EEHBC
         BM7qsFhcIOrKZzwktLmfiDJ4JiSw7uSP3VY4tlx65roa7nSh8h/cUxVIZ89N2M4FT7kd
         cngQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=cZgEA8wOuqe/FNFw+8yZb56BnmuD/jPua+RvSgM8YNU=;
        b=Nlm3WIFYiWk1ir4jxjTskDKSdti3mWnC+eD8dV66WZgNggIk/iJAj2IdDCDhYUJWrQ
         xi7aoPuDpcziv+woxbMUI2wxtuLF7tge6Lno9lP5AKfxELgsQWhQBlfnckBNa9Vxo7Ce
         Xrh3rdQIKt2S0AHHfhPAT89udZe7mg5nGEHuaP6HKP9CY1v2O8D3wSQZff7HoeI0lgPF
         eZFrLEmzNvm7zYgbQHFEFpRbM2jJ2FR6QVVAImrpYGEhOvvfZAVt2V2jV+/ASipWPa/f
         MTGtcpmAk0bf+TLaCazGXO4+k9M42+iW3LYMKWX9lLU+AVgsPv31syV+63Dp3YViIVif
         zt4A==
X-Gm-Message-State: AOAM530MG4s3gX7gWf0pkKB05pOdAuMeoL0kv2VR64E3VfOzM8bX5/PT
        T3UrE28i9Hk+F14//TFlv75tCJ4q0ZE7FnS8u+tCD2hZF9BXJw==
X-Google-Smtp-Source: ABdhPJyhx9yH5ZeXuXhSBZaiPoCN/tfqE3T/Bl53p3yGbXIiz4TZAhXJLYmKs8iy5v3Kz/rRjyFw0v9UZ9Z60Rhjiyg=
X-Received: by 2002:a5d:534f:: with SMTP id t15mr29932131wrv.206.1621113942931;
 Sat, 15 May 2021 14:25:42 -0700 (PDT)
MIME-Version: 1.0
From:   Ivan Zuboff <anotherdiskmag@gmail.com>
Date:   Sun, 16 May 2021 00:25:32 +0300
Message-ID: <CAL-cVehkm=KPdQ=1rN6hyeMDiMXa--aG3gij==Nf8mNv=XZ0sQ@mail.gmail.com>
Subject: lockf returns false-positive EDEADLK in multiprocess multithreaded environment
To:     linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000b5a0d505c2650026"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000b5a0d505c2650026
Content-Type: text/plain; charset="UTF-8"

As a developer, I found a counter-intuitive behavior in lockf function
provided by glibc and Linux kernel that is likely a bug.

In glibc, lockf function is implemented on top of fcntl system call:
https://github.com/lattera/glibc/blob/master/io/lockf.c
man page says that lockf can sometimes detect deadlock:
http://manpages.ubuntu.com/manpages/xenial/man3/lockf.3.html
Same with fcntl(F_SETLKW), on top of which lockf is implemented:
http://manpages.ubuntu.com/manpages/hirsute/en/man3/fcntl.3posix.html

Deadlock detection algorithm in the Linux kernel
(https://github.com/torvalds/linux/blob/master/fs/locks.c) seems buggy
because it can easily give false positives. Suppose we have two
processes A and B, process A has threads 1 and 2, process B has
threads 3 and 4. When this processes execute concurrently, following
sequence of actions is possible:
1. processA thread1 gets lockI
2. processB thread2 gets lockII
3. processA thread3 tries to get lockII, starts to wait
4. processB thread4 tries to get lockI, kernel detects deadlock,
EDEADLK is returned from lockf function

Steps to reproduce this scenario (see attached file):
1. gcc -o edeadlk ./edeadlk.c -lpthread
2. Launch "./edeadlk a b" in the first terminal window.
3. Launch "./edeadlk a b" in the second terminal window.

What I expected to happen: two instances of the program are steadily working.

What happened instead:
Assertion failed: (lockf(fd, 1, 1)) != -1 file: ./edeadlk.c, line:25,
errno:35 . Error:: Resource deadlock avoided
Aborted (core dumped)

Surely, this behavior is kind of "right". lockf file locks belongs to
process, so on the process level it seems that deadlock is just about
to happen: process A holds lockI and waits for lockII, process B holds
lockII and is going to wait for lockI. However, the algorithm in the
kernel doesn't take threads into account. In fact, a deadlock is not
gonna happen here if the thread scheduler will give control to some
thread holding a lock.

I think there's a problem with the deadlock detection algorithm
because it's overly pessimistic, which in turn creates problems --
lockf errors in applications.

--000000000000b5a0d505c2650026
Content-Type: text/x-csrc; charset="US-ASCII"; name="edeadlk.c"
Content-Disposition: attachment; filename="edeadlk.c"
Content-Transfer-Encoding: base64
Content-ID: <f_koq9a8tt0>
X-Attachment-Id: f_koq9a8tt0

I2luY2x1ZGU8dW5pc3RkLmg+CiNpbmNsdWRlPHN0ZGlvLmg+CiNpbmNsdWRlPHN0ZGxpYi5oPgoj
aW5jbHVkZTxmY250bC5oPgojaW5jbHVkZTxlcnJuby5oPgojaW5jbHVkZTxwdGhyZWFkLmg+CiNp
bmNsdWRlPHN0ZGRlZi5oPgojaW5jbHVkZTxzdGRpbnQuaD4KCiNkZWZpbmUgRElFKHgpXAp7XAoJ
ZnByaW50ZihzdGRlcnIsICJBc3NlcnRpb24gZmFpbGVkOiAiICN4ICIgZmlsZTogJXMsIGxpbmU6
JWQsIGVycm5vOiVkICIsIF9fRklMRV9fLCBfX0xJTkVfXywgZXJybm8pOyBcCglwZXJyb3IoIi4g
RXJyb3I6Iik7XAoJZmZsdXNoKHN0ZG91dCk7XAoJYWJvcnQoKTtcCn0KI2RlZmluZSBBU1MoeCkg
aWYgKCEoeCkpIERJRSh4KQojZGVmaW5lIEFTUzEoeCkgQVNTKCh4KSAhPSAtMSkKI2RlZmluZSBB
U1MwKHgpIEFTUygoeCkgPT0gMCkKCnZvaWQgKiBkZWFkbG9ja2VyKHZvaWQgKmFyZykKewogICAg
aW50IGZkID0gKGludCkocHRyZGlmZl90KWFyZzsKICAgIGZvciAoOzspIHsKICAgICAgICBBU1Mx
KCBsb2NrZihmZCwgRl9MT0NLLCAxKSApOwogICAgICAgIEFTUzEoIGxvY2tmKGZkLCBGX1VMT0NL
LCAxKSApOwogICAgfQogICAgcmV0dXJuIE5VTEw7Cn0KCmludCBtYWluKGludCBhcmdjLCBjaGFy
ICogYXJndltdKQp7CiAgICBpbnQgZmQxLCBmZDI7CiAgICBBU1MoIGFyZ2MgPj0gMyApOwogICAg
QVNTMSggZmQxID0gY3JlYXQoYXJndlsxXSwgMDY2MCkgKTsKICAgIEFTUzEoIGZkMiA9IGNyZWF0
KGFyZ3ZbMl0sIDA2NjApICk7CiAgICB2b2lkICogdGhydjsKICAgIHB0aHJlYWRfdCB0aHIxLCB0
aHIyOwogICAgQVNTMCggcHRocmVhZF9jcmVhdGUoJnRocjEsIE5VTEwsIGRlYWRsb2NrZXIsICh2
b2lkICopKHB0cmRpZmZfdClmZDIpICk7CiAgICBBU1MwKCBwdGhyZWFkX2NyZWF0ZSgmdGhyMiwg
TlVMTCwgZGVhZGxvY2tlciwgKHZvaWQgKikocHRyZGlmZl90KWZkMSkgKTsKICAgIEFTUzAoIHB0
aHJlYWRfam9pbih0aHIxLCAmdGhydikgKTsKICAgIEFTUzAoIHB0aHJlYWRfam9pbih0aHIyLCAm
dGhydikgKTsKICAgIHJldHVybiAwOwp9Cg==
--000000000000b5a0d505c2650026--
