Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03F053955E6
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 09:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbhEaHUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 03:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbhEaHUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 03:20:39 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA87C061574
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 00:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gm3guXqY0zUKIoHZD8eyUNslrikA1c6LtNzjXt49tyw=; b=ZsqgH/9JsRYUGG6UD1Pka58byq
        +oLUoaovYlQvT6GPOnUGdSaS2Z4OAaMB3D4ZhXl2s6Ucb/8n9vksT8ZlzNjTbE7ZsnP2aYLNBF9RM
        FINDX3cIYomT3Y8ZAKfMDtO1oSqVafI1cg/MxQdnIu2P9tldIAZ7hGMoPnCQuuRoKPeRFv6x4mIbH
        mNfhc3NFiXiAbP+eXbCi0Wq+rS5C4Bvrsi95zvcnRxbxcn9ONgUDUwgX1Za6SneBviaGw0AR9WQCp
        LzsF4yyM089oqFzVyT/w8M2vaTCdZQ+AKN+LmMgVB1tPyG5PEVjASUEInh85UueH0YvFootxGCXmk
        1Epa0Haw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lncC1-002Def-6R; Mon, 31 May 2021 07:18:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D0632300268;
        Mon, 31 May 2021 09:18:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A28352011C43B; Mon, 31 May 2021 09:18:37 +0200 (CEST)
Date:   Mon, 31 May 2021 09:18:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     trix@redhat.com
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: cleanup master/slave usage in wake_wide()
Message-ID: <YLSNzZbrdtZ6PPzH@hirez.programming.kicks-ass.net>
References: <20210530193039.2556526-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210530193039.2556526-1-trix@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 30, 2021 at 12:30:39PM -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> From Documentation/process/coding-style section for
> inclusive terminology, make these variable name changes in
> wake_wide()
> 
> master -> primary
> slave -> secondary
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Please take your nonsense elsewhere. Unless there's a technical reason
to change this code, don't touch it.
