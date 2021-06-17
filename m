Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE163ABC47
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 21:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbhFQTGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 15:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbhFQTGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 15:06:04 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1028CC061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 12:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=ifAeVwyWSLp/AucEQv6COIlQl2ZmBHjobjYTjK3ptKc=; b=S0P1luiCiXD/GTWvjPBAeN7drk
        QzeFHm5XtPTA+N1+U4TqUgP1KzOX11l3XAEjF2ZgvN7ilohfZa1fyUXipkwb+GmoPY2tjm70AoW1b
        GZfKuAG1SbH47LkmSz+2QiFaWyHuaD3MN+0FjOMbkwwksc3ud16dOaIMwv4Z82QIriBpY7ZIRg6sh
        eVFOA13oCNlqSzZUk2enB4iXVnfxBL3aILcRrPST9o42yRtWtYhpXGqQz9krN6PtavCLAxyvYS3f6
        Hg9THBreoydE1OaaNEw92Tesa/z9u0b2SsB5PdiDEBlFnL6qVaBfUkoEuCw5WDvIPbbTuzB9YctLi
        2oFyTnlw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltxIa-008uZa-6u; Thu, 17 Jun 2021 19:03:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 745C43002FB;
        Thu, 17 Jun 2021 21:03:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 51A51202434C2; Thu, 17 Jun 2021 21:03:37 +0200 (CEST)
Message-ID: <20210617185717.486456641@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 17 Jun 2021 20:57:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@redhat.com, will@kernel.org, longman@redhat.com,
        boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        joro@8bytes.org, bp@alien8.de, tglx@linutronix.de,
        bigeasy@linutronix.de
Subject: [PATCH 0/3] lockdep: PROVE_RAW_LOCK_NESTING=y fixes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Boris said, that Joerg said the locking selftests showed a few FAILED. They
were right.

