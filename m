Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44F0A4048DE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 13:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235115AbhIILFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 07:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234484AbhIILFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 07:05:12 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD7AC061575
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 04:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=WFbVkb6EnrdoKFjRJRW78vlxmGDwdJ7j+T9flhfIxHs=; b=kuvRBMcnEjNc+40VsFEt0vrfS4
        17aNTkXIv5tY/o2TY7wwpZHuViQRtR9ntNRN0OfiGocwwIft1/dp5+rhwgNWOU3UGhkDiDUGFNuRE
        698IkmAwi+vQDHud+QI7X7U1LSZKs/CCuAp2Dn0Q95R+I0g8Rnsplsj5dRR4vNRzBZLSvA3mZrC7f
        WAEKNXA8JRkHNcSaVPycwUcDv6G2w3i8yOx/+jyHDoZOV3tsUQE/f2ws6jgbM8TnINSFqdKtnEl/Z
        M90wQfzpIEx+AwX8dbO9et7oNeHr641Gcjdn05URz8ro3gAeuiXIIyAf/2Il8ZRh7uFAzPxYFEo3y
        6siQaWSg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mOHqF-001rBD-LZ; Thu, 09 Sep 2021 11:03:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CBAE13000A9;
        Thu,  9 Sep 2021 13:03:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id ABBA92C3CBEDA; Thu,  9 Sep 2021 13:03:37 +0200 (CEST)
Message-ID: <20210909105915.757320973@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 09 Sep 2021 12:59:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mike Galbraith <efault@gmx.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH 0/4] locking/rwbase: Assorted fixes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hai, these here patches are what I've got based on Boqun's review.
The plan is to stuff in them in locking/urgent somewhere tomorrow.

Please holler if you see anything that ought to make me reconsider this :-)

