Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA10F38C940
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 16:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235763AbhEUOeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 10:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbhEUOd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 10:33:57 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BFAC061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 07:32:32 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id d25so8540237ioe.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 07:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=qoK+kS0EE+s9/4ZRFR3cEcTsJ1NFlKi6gGkPqsbUTx8=;
        b=ndUYTANHuA1h4TBqdPN/mo0A4dujG1uM3e0pSY6gPsuR4mnssc4PKJVLWpkXU/MUJg
         DHMcEo64XouPeg86/Age0jrdN8tnUc5DpuoN5ADdfyhkBO2W/fT8zaE3xp8ZoP6nLxK1
         A6wRxDqplA9ikO9tHRXE+Uz4xt9xCpzh4kqZu4SrOHSuc+hJMamR7NqMFKYNH2Q9Yz6I
         SyzMnMp8Je7rJkOcXBzSgnYn21emv8NcPywPkYGnJDelYnXZvuOTJKzI9t9UnPIdulX+
         r5b7WCBZGxH0umxqyhhVKyr00M2mezh7adeGmXHmyBHaZh3KMKPMTry9MfotFj2k+Trt
         D/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=qoK+kS0EE+s9/4ZRFR3cEcTsJ1NFlKi6gGkPqsbUTx8=;
        b=XePB5P0ZZzHNjpDZnJEKwyNuZXdXkRhYObhd/IYBywA3Vc9smKsXc8gYvjpAXBxakD
         OD0KMQI847rzUkFYFu5/G1JE6sCTvXIFD11U8GUJxlRucciN/NwCvyp7tOsasYZLNw2h
         FZ2d/UfpW14hGXfrqS546siLvJa9TyUT55iD/obCHGEas+0qTuPL5FHX8drlC+ZgsCXE
         fc5GF3I0mJ9ozPrhCRZ8Zq6f6v96pUrRz0k8zoLWKiU0rFNVweKfUxPtxndI+dXJIxop
         7EB0Qy2ndP4V8SsIzxQmgN+wglR0zOjoUUQK/SjV0ySgIf1+GAQVrpGl0obBHKTKqz20
         WmQQ==
X-Gm-Message-State: AOAM531uEvX2/eqYnGUZH3NyHD3A6bhHIql2dYOgQyyVns0mm+2CzTCq
        2rxDNHNV9DUUX+WC1gX2wNtI/ncA8JU2tfqjqA==
X-Google-Smtp-Source: ABdhPJyAKQy3IgQ5wtLD3+7t+6bkNqRi6o4nyjA6NL883ua3aN8bOHKRJ4TaYvbkKKRdzv7s2vbCnOVekLo8lQw9B5s=
X-Received: by 2002:a02:900b:: with SMTP id w11mr4725771jaf.5.1621607551717;
 Fri, 21 May 2021 07:32:31 -0700 (PDT)
MIME-Version: 1.0
From:   Jinmeng Zhou <jjjinmeng.zhou@gmail.com>
Date:   Fri, 21 May 2021 22:32:20 +0800
Message-ID: <CAA-qYXhSrMkGXQ69TyC9pOuGO1dCznxw6PU4LTjxLaDKz09iLA@mail.gmail.com>
Subject: A missing security check bug in trace_format_open().
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     shenwenbosmile@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear maintainers,
hi, our team has found a missing check bug on Linux kernel v5.10.7
using static analysis. There is a missing security check bug in
trace_format_open() before calling function seq_open().

Function profile_open() checks security_locked_down() before the
critical function seq_open().
1. //check security_locked_down() ///////////////////////
2. static int profile_open(struct inode *inode, struct file *file)
3. {
4.   int ret;
5.   ret =3D security_locked_down(LOCKDOWN_TRACEFS);
6.   if (ret)
7.     return ret;
8.   return seq_open(file, &profile_seq_op);
9. }

While trace_format_open() does not call this check,
security_locked_down(), and the parameters of calling seq_open() are
similar.
1. static int trace_format_open(struct inode *inode, struct file *file)
2. {
3.   struct seq_file *m;
4.   int ret;
5.
6.   /* Do we want to hide event format files on tracefs lockdown? */
7.
8.   ret =3D seq_open(file, &trace_format_seq_ops);
9.   if (ret < 0)
10.     return ret;
11.
12.   m =3D file->private_data;
13.   m->private =3D file;
14.
15.   return 0;
16. }

Both functions are assigned to the same struct type and field.
1. static const struct file_operations kprobe_profile_ops =3D {
2. =E2=80=A6
3.   .open           =3D profile_open,
4. =E2=80=A6
5. };
6. static const struct file_operations ftrace_event_format_fops =3D {
7. =E2=80=A6
8.   .open           =3D trace_format_open,
9. =E2=80=A6
10. };


In conclusion, we assume that these functions work in the same way.
However, it is not appropriate that one function is called without
checking.

Thanks!


Best regards,
Jinmeng Zhou
