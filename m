Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC373077A1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 15:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbhA1OEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 09:04:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbhA1OE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 09:04:28 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771A4C061573
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 06:03:48 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id y128so5516040ybf.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 06:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hR4maZAuuWcL/drVKqFCnOGFXfdfKTcsp0/MfidRU2I=;
        b=us2AxaCL/UKIKygGo50I0lPwM8WiYg9XE9IvTiRNWsJqtVExnA8BaRs/AvctYbW9YI
         K9z9ssHS9iPmp/+Jy4ryLq3LWrlgifcls4AF2QmNC0qLlZob7J26ktAE+AOGLDzBYt2C
         bnsmlMq9mG/BIsKX1GOBlnLfIlaAPOG1DY2lJHeqq1SoZxOzdLAZp4G8a1xRtNJMVpPy
         1dBE/4oaOLxfBqDDt5HrhtFAQFT9hWQmYtz3ul7DtpdsjCav3ESB4/H8Fa8wbpTKqX5f
         VQQswPHpK0QeieAWezLQ1iLmJK6oyzw1++aMLQiLsAUJ04Bcsu34w/n/AVZPB1g1P2JT
         d50A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hR4maZAuuWcL/drVKqFCnOGFXfdfKTcsp0/MfidRU2I=;
        b=o7Qwb6BO7fbR5dN8C+uqR0lz1O2SYRvnkLrPBm3EXxQ//2cweox808LeRWvHWmApof
         bf+4tfjNlZVmztCmEblspXJFgsWV9ei4KEEITn0IPzSmIgKit4eAZA3rzf2Oo58m33P2
         cZz83PZT5+Pcc1xxHyLKuyvYc60KPJrXwwo7EFUwT+AFIsEMjkDVub7jg2OThnqx2gmZ
         Ij8c+tMaH5Qgh6tT1uQkHFxSMzEDA+gWt150GW5/7Z5/9Iy5p0Ef7cHHWC9HoKVsKytR
         KbN8myQF/SX0u7HNhNDhNm+fdveaVsnJ3RZyf+0oJbrJEOtpsCUBlIsLZOIeQPEHt8W6
         tdEA==
X-Gm-Message-State: AOAM533MH7ji85R6Uoc53vqF9DhzyJzP89+jqJfl6cLfOP7zAMPgcX3c
        JuDIcLsYYZcf7nKZdw8gUDQ2P/Z4a6azow7O8coUTWi5HhOR2A==
X-Google-Smtp-Source: ABdhPJyUJ6yYIrlR9JlciEEm79Hfo3zRSFCZTicbbZ1kQusmGmxumoZi2jRLewggzh3rszdjFkUj047RsBNwG/BhrY8=
X-Received: by 2002:a25:31c3:: with SMTP id x186mr22931121ybx.500.1611842627692;
 Thu, 28 Jan 2021 06:03:47 -0800 (PST)
MIME-Version: 1.0
References: <20210128005110.2613902-1-masahiroy@kernel.org>
In-Reply-To: <20210128005110.2613902-1-masahiroy@kernel.org>
From:   Anatoly Pugachev <matorola@gmail.com>
Date:   Thu, 28 Jan 2021 17:03:36 +0300
Message-ID: <CADxRZqyjTU38J7qjTxZxy8qAjW_HLC3Bm7f1cS8j1tS2fGfxow@mail.gmail.com>
Subject: Re: [PATCH 00/27] arch: syscalls: unifiy all syscalltbl.sh into scripts/syscalltbl.sh
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masahiro,

wanted to test on sparc64, but I'm unable to cleanly apply your patch
series to current master of
git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

saved in all patches from mutt MUA to mbox (syscalltbl-mbox) file
format (except of 00/27) and tried to apply via git-am:

$ git desc
v5.11-rc5-40-g76c057c84d28

$ git am < ~/syscalltbl-mbox
Applying: xtensa: syscalls: switch to generic syscalltbl.sh
error: patch failed: arch/xtensa/kernel/syscalls/Makefile:16
error: arch/xtensa/kernel/syscalls/Makefile: patch does not apply
Patch failed at 0001 xtensa: syscalls: switch to generic syscalltbl.sh
hint: Use 'git am --show-current-patch=diff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

But if take out body of the first patch (xtensa.patch) out of mbox, it
does cleanly applies via "patch -p1"

Can someone suggest how do i apply this patch series to my local git tree?
Thanks.
