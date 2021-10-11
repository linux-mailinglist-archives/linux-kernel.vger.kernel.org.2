Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D62A74297A5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 21:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234699AbhJKTmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 15:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234687AbhJKTmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 15:42:21 -0400
Received: from scorn.kernelslacker.org (scorn.kernelslacker.org [IPv6:2600:3c03:e000:2fb::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B976C061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 12:40:21 -0700 (PDT)
Received: from [2601:196:4600:6634:ae9e:17ff:feb7:72ca] (helo=wopr.kernelslacker.org)
        by scorn.kernelslacker.org with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <davej@codemonkey.org.uk>)
        id 1ma19l-00AVhJ-4H; Mon, 11 Oct 2021 15:40:17 -0400
Received: by wopr.kernelslacker.org (Postfix, from userid 1026)
        id 522E456009C; Mon, 11 Oct 2021 15:40:16 -0400 (EDT)
Date:   Mon, 11 Oct 2021 15:40:16 -0400
From:   Dave Jones <davej@codemonkey.org.uk>
To:     Linux Kernel <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Should EXIT_DEAD be visible to userspace ?
Message-ID: <20211011194016.GA16788@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Note: SpamAssassin invocation failed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of our users reported a crash in some userspace tooling this
morning, which scrapes /proc/pid to gather stack traces, process states
etc of everything running at the time.

The crash occurred because it fell over an unexpected task state,
which was 'X'.   According to the procps man-pages, this state should
never be seen, but here it clearly was.

The kernel running at the time was kinda old (5.2) but I don't see much
change in the EXIT_DEAD space that would explain something that got
fixed subsequently.   It's also probably going to be difficult to
reproduce unfortunately.

So my question is, is procps wrong and code should expect to see X state
processes in proc ?  The code in question is being hardened to handle
unexpected inputs, but I'm curious if the kernel is leaking some state
that it shouldn't.

	Dave

