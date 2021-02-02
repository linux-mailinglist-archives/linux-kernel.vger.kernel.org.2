Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B71C30BA30
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 09:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbhBBIpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 03:45:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbhBBIph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 03:45:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4174C061573
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 00:44:56 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612255495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mNqc9XcHFo5uNF2W+JXo18dFCyeXoeAXi1CqG297LtY=;
        b=hbdcpaoU/0UqPrnl07yNS5UCnwto4xw8sL+knusJNbCXg8w/HkaYxzyKkV7mzEtHFiJwy8
        vjNCEoYKloEGpba4gTCXV8+RGEiu1UN7IatGBjmgIqOejImDt1qroBizHNyfAZp/BEjbD1
        kzp9lkmGteYwX6op9idgiKfTO9pnXJ43NZLS2Ix9Ca9jmwROrrqiCN61934LbAqihfYioj
        g9KoarOg/AZX1hYvCNfrfRNx9pYwmiQELHe5xjAaDKe7MIkFKtXu63a37JF9d9bTIDPFML
        XiwEgbUI9PzTRuipxtuOF7zp6UEY8uuo2L87zrOIEivl0DF3m15b5Q2neSO6tw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612255495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mNqc9XcHFo5uNF2W+JXo18dFCyeXoeAXi1CqG297LtY=;
        b=QFmgSZFu1TtTN76yGhp3cTN8sIMK3IoHvFqH3ZtKnOVj043vc6gXBNnN41/YRPzE7JXe+i
        RZ22Zz5r3vwAPEAw==
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH 3/3] printk: move CONSOLE_EXT_LOG_MAX to kernel/printk/printk.c
In-Reply-To: <20210202070218.856847-3-masahiroy@kernel.org>
References: <20210202070218.856847-1-masahiroy@kernel.org> <20210202070218.856847-3-masahiroy@kernel.org>
Date:   Tue, 02 Feb 2021 09:50:54 +0106
Message-ID: <87bld22709.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-02, Masahiro Yamada <masahiroy@kernel.org> wrote:
> This macro is only used in kernel/printk/printk.c

I recently posted a patch [0] that added another macro CONSOLE_LOG_MAX
here. But it also is only used in printk.c. I see no reason why either
should be in the header. Neither my patch nor commit d43ff430f434
("printk: guard the amount written per line by devkmsg_read()") show any
motivation for using printk.h.

I am fine with moving them out. The only consequences could be
out-of-tree modules breaking, but do we care about that?

John Ogness

[0] https://lkml.kernel.org/r/20210126211551.26536-5-john.ogness@linutronix.de
