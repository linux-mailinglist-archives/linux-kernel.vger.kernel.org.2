Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28A56320027
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 22:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhBSVNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 16:13:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbhBSVNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 16:13:23 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E395C06178A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 13:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=hvFIe2GFd2RFFrKYkM+yvuqY5A+7qEuqu9TP8TMwF2s=; b=thM16NEpRdx1CFXNx+jeGv9AfS
        P4eikMPR61FT+Yo/k6IL61mf25KXFdmn/KNCK8lbO3NsedP0nK3yD0Oj0i+0XaPLSlm3tmfI+iLid
        JrXQvGXT3mJkDIsmF5dKYP9Tx09feNEknxcAEIscrcxOkab6YXLXIsbcJG4vvNoqp1bPghKQHDLe4
        sVldEzmHHJb7XoYpyRaOHxiAd9JDciLWivxS/+c6iM0Ne4SKdYnCjm8zf0QDCyK03SX/7t/Xq4LnU
        vVJgJ+eGZXkvMSOJENiuK0YOBwVrOVq692Ar3en4+L/QADrmIDdmBtkfFXt+jrYgpaB4Ws8GAUVwK
        a1wl04Bw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lDD2M-003Hk1-IA; Fri, 19 Feb 2021 21:10:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6A4AB30700B;
        Fri, 19 Feb 2021 22:10:05 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 3DCDF2021555D; Fri, 19 Feb 2021 22:10:05 +0100 (CET)
Message-ID: <20210219204300.749932493@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 19 Feb 2021 21:43:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, x86@kernel.org, pjt@google.com,
        mbenes@suze.cz, jgross@suse.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [RFC][PATCH 0/6] objtool: Optimize !retpoline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's a few patches that go on top of the previously posted series:

  https://lkml.kernel.org/r/20210211173044.141215027@infradead.org
  https://lkml.kernel.org/r/20210218165938.213678824@infradead.org

and can also be found, in full, here:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git objtool/wip

The purpose is to replace every compiler generated (tail) call to the retpoline
thunks with an alternative, one that avoids the thunk when retpolines are
disabled.

Very lightly tested...

