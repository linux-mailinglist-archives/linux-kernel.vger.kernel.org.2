Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46B9E332CB2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 17:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbhCIQ65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 11:58:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbhCIQ6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 11:58:46 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56616C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 08:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=qKoGol5i8+369WDG2dfWRUQDWOaqn8UMCBv4N+kp+ko=; b=eDxqP58GHbzY/vY2ZOPo1SVUkZ
        4xsKyRkP/R2gszd0fMN1dv+SBtyNNGPcH6AMfWJzL8ZSE+Ziqpt5ypAr6i9HbowdSyzxk9afEy6W4
        gkf+07TCUJ2aQJnQ5lDkc2hPjLq7BVvQhPlS+9nJX86SPn3Pxoe9775PL57ICGL4aqMoleKRhA26n
        gIGf8Ru2valdi3QqqewWKS87lmgRUwwiGkAeoautnyKslvhlCVyPr3kxStyHHR88r5s7Qz8odJbj0
        AVdHeh0rlGBWaJScjoKnqgVNyklhfz0QJD9TphmJzUGxfeIIdlBM4hMvFXmeW4n4AXthQ0vObjv5E
        974Tecqw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lJfgZ-000p8s-C0; Tue, 09 Mar 2021 16:58:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 532B4300238;
        Tue,  9 Mar 2021 17:58:18 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0B9B62077BB0D; Tue,  9 Mar 2021 17:58:18 +0100 (CET)
Date:   Tue, 9 Mar 2021 17:58:17 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: The killing of ideal_nops[]
Message-ID: <YEepKVHc5kkDybu6@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

AFAICT everything made in the past 10 years ends up using p6_nops. Is it
time to kill off ideal_nops[] and simplify life?


