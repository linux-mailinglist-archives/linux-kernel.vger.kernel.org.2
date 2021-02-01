Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E692930AE9C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 19:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbhBAR71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 12:59:27 -0500
Received: from mail.zx2c4.com ([104.131.123.232]:36496 "EHLO mail.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229663AbhBAR7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 12:59:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1612201916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8H4PmtHOZLPbqbAwMx0YvCGu/m87MtMsLJaMPY0DO38=;
        b=JVFb3K3FYo4WqseEMJ7K1AkrpJO6ERZ+yyavwrF0x91dFvQtw4xFEfud1DO4OzPEs7rPe0
        Bk3hKSh0phvR9yJJ+R3sndETQu0oVbNHwX/m0PeFiB2/5r8WGnRH7DGExjvHcSHprVXvJ0
        cjWKF5KUEn0apEobo9NtP87MnfOce4A=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 3634a7b4 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Mon, 1 Feb 2021 17:51:56 +0000 (UTC)
Received: by mail-yb1-f172.google.com with SMTP id r2so155507ybk.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 09:51:56 -0800 (PST)
X-Gm-Message-State: AOAM531peExOj4I5KTHiuQttgo2nh8e+nLrX8ci7y/XVKICSPiLrvT7Y
        DgIHfFHfo8QCa3OV39jMWt7raaD4pe++BqaShzA=
X-Google-Smtp-Source: ABdhPJwvsXUL4HnViA7KFLcP8aHPlok8xuysB2NjPKamdocjxG61iK2GYtj5Kb7ZRT1mq1qRKM+ddJbo2CnAcmKyeco=
X-Received: by 2002:a25:4981:: with SMTP id w123mr25686628yba.123.1612201915772;
 Mon, 01 Feb 2021 09:51:55 -0800 (PST)
MIME-Version: 1.0
References: <CAHmME9oHBtR4fBBUY8E_Oi7av-=OjOGkSNhQuMJMHhafCjazBw@mail.gmail.com>
In-Reply-To: <CAHmME9oHBtR4fBBUY8E_Oi7av-=OjOGkSNhQuMJMHhafCjazBw@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 1 Feb 2021 18:51:45 +0100
X-Gmail-Original-Message-ID: <CAHmME9rDC9ObAT=6CJ3h0KQ9ogHsrnDNMnocm5882A2j6OPF6g@mail.gmail.com>
Message-ID: <CAHmME9rDC9ObAT=6CJ3h0KQ9ogHsrnDNMnocm5882A2j6OPF6g@mail.gmail.com>
Subject: Re: forkat(int pidfd), execveat(int pidfd), other awful things?
To:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Andy Lutomirski <luto@amacapital.net>
Cc:     LKML <linux-kernel@vger.kernel.org>, Jann Horn <jann@thejh.net>,
        Christian Brauner <christian.brauner@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> int execve_parent(int parent_pidfd, int root_dirfd, int cgroup_fd, int
> namespace_fd, const char *pathname, char *const argv[], char *const
> envp[]);

A variant on the same scheme would be:

int execve_remote(int pidfd, int root_dirfd, int cgroup_fd, int
namespace_fd, const char *pathname, char *const argv[], char *const
envp[]);

Unpriv'd process calls fork(), and from that fork sends its pidfd
through a unix socket to systemd-sudod, which then calls execve_remote
on that pidfd.

There are a lot of (potentially very bad) ways to skin this cat.
