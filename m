Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09B18308208
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 00:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbhA1Xme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 18:42:34 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:56262 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbhA1Xmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 18:42:32 -0500
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 10SNfR4S019763
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 08:41:27 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 10SNfR4S019763
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1611877287;
        bh=U8WI1PblpLQ8kRIiaOsyO7MfjeKiLsJ+sPEUCHqKY3A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jga4CQgL5m1r4f0nD/1K5+6ZPDWeaX1WCnWKGU6BM2ZyINyXa4JUFhLCjoYxGEkQY
         ZWxZEKqLThkWAQhHATVaNBuqTw4UPTIuMcujq4YfabaCf7+a29nxpkBQkONNJGhvUA
         hkz8ELJtVLqAJB6q+esw+moky3dkAd+zd/q8MrF3dWRrLULPjxLzUpJTOhpQ5Q9l03
         LCZYVb8xFK27K2TnJ4aiBq1UroK31e09AMv3ZUtBNMQaRsvbhk5aN9tJcJ+Uk/h/8V
         BmJ95qmIP2m/kp5SIZZWPCTwls4I9tBz5bRN26cUB3f9PfhNH5ZlGSxIOKKAcVZTzJ
         l6TEOJ5d1R2Xg==
X-Nifty-SrcIP: [209.85.215.174]
Received: by mail-pg1-f174.google.com with SMTP id s23so4098249pgh.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 15:41:27 -0800 (PST)
X-Gm-Message-State: AOAM530AIafc70OU6Tzvc0MnxBPz/OLwWFETGc5e0Qac6Hhvk5LmXaf9
        AJpAUIgwB04LtX2xpdDwkGflvgv0z/r/8BsGIBY=
X-Google-Smtp-Source: ABdhPJzYPqVVeZn+Z1nOiwM0CA8GpjFl20AW4NmdQbMIfSAPXdqNt1LuQQNaomMEmorZCvtFjy8v8mnAWKxX4wSd5FE=
X-Received: by 2002:a63:ff09:: with SMTP id k9mr1751007pgi.175.1611877286857;
 Thu, 28 Jan 2021 15:41:26 -0800 (PST)
MIME-Version: 1.0
References: <20210128005110.2613902-1-masahiroy@kernel.org> <CADxRZqyjTU38J7qjTxZxy8qAjW_HLC3Bm7f1cS8j1tS2fGfxow@mail.gmail.com>
In-Reply-To: <CADxRZqyjTU38J7qjTxZxy8qAjW_HLC3Bm7f1cS8j1tS2fGfxow@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 29 Jan 2021 08:40:49 +0900
X-Gmail-Original-Message-ID: <CAK7LNATPGR9b5ganamfP2t1xPL6rrq6a8-JWYR83KGzLJXs7NA@mail.gmail.com>
Message-ID: <CAK7LNATPGR9b5ganamfP2t1xPL6rrq6a8-JWYR83KGzLJXs7NA@mail.gmail.com>
Subject: Re: [PATCH 00/27] arch: syscalls: unifiy all syscalltbl.sh into scripts/syscalltbl.sh
To:     Anatoly Pugachev <matorola@gmail.com>
Cc:     Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 11:03 PM Anatoly Pugachev <matorola@gmail.com> wrote:
>
> Masahiro,
>
> wanted to test on sparc64, but I'm unable to cleanly apply your patch
> series to current master of
> git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
>
> saved in all patches from mutt MUA to mbox (syscalltbl-mbox) file
> format (except of 00/27) and tried to apply via git-am:
>
> $ git desc
> v5.11-rc5-40-g76c057c84d28
>
> $ git am < ~/syscalltbl-mbox
> Applying: xtensa: syscalls: switch to generic syscalltbl.sh

Hmm? Are you applying only xtensa one (27/27) ?


> error: patch failed: arch/xtensa/kernel/syscalls/Makefile:16
> error: arch/xtensa/kernel/syscalls/Makefile: patch does not apply
> Patch failed at 0001 xtensa: syscalls: switch to generic syscalltbl.sh
> hint: Use 'git am --show-current-patch=diff' to see the failed patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
>
> But if take out body of the first patch (xtensa.patch) out of mbox, it

This is the last one, not the first.


> does cleanly applies via "patch -p1"
>
> Can someone suggest how do i apply this patch series to my local git tree?
> Thanks.


I do not know.

I can apply this series on top of the current Linus tree cleanly.




--
Best Regards
Masahiro Yamada
