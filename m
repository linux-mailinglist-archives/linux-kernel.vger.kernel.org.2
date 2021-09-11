Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF6C5407976
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 18:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbhIKQIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 12:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhIKQIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 12:08:48 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51949C061574
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 09:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bH8bL0RXwdDf8deZLel2vgFOUIrsBVfYGkMLh4lRFZY=; b=TWSPtO4XiuDsTx/hbt76Jupq67
        v61daFXL2JCPnEoNlzy47qodzCEbPrfofcuugYjAHSZFFkKDt9sQf74rFU/4egxGk4LMvOxqELChb
        KQV/fCtRnsvM3LGYSMxfqclfRd6RCfCYjIbv2SVH7WkkNnU/27GfD2eeHt+7LJEVcT/2uJ3FLM8pe
        AV9DNFhKQ1Wg33Trc89m0jUVUuz2nAUDkKfWXczr3t3PzWOP09hw/li+6+s9IKcu9Eu0tMXBdj23s
        R4FsIl6umtOeOiOmC4Gz5yZ3XOLRhYS4xpJiAZluS2lVRWETmZHrLMhNQZxwPlwYpOEjzcg2yZ//7
        1BPFZvwQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mP5XF-002PZn-4b; Sat, 11 Sep 2021 16:07:21 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id F401D9862C9; Sat, 11 Sep 2021 18:07:19 +0200 (CEST)
Date:   Sat, 11 Sep 2021 18:07:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yinan Liu <yinan@linux.alibaba.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, mark-pk.tsai@mediatek.com,
        mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] scripts: ftrace - move the nop-processing in
 ftrace_init to compile time
Message-ID: <20210911160719.GB4323@worktop.programming.kicks-ass.net>
References: <20210911135043.16014-1-yinan@linux.alibaba.com>
 <20210911135043.16014-3-yinan@linux.alibaba.com>
 <20210911101247.4a37ec51@rorschach.local.home>
 <de1bbbc9-3d66-a3dd-550f-509032be20ba@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de1bbbc9-3d66-a3dd-550f-509032be20ba@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 11, 2021 at 11:28:32PM +0800, Yinan Liu wrote:
> This is my GCC version: GCC version 4.8.5 20150623 (red hat 4.8.5-44) (GCC)

Please don't top post. Also please upgrade your GCC, that's too told to
even build the current kernel tree (IIRC we have minimum GCC-5.1, but I
can recommend using GCC-8 or later).
