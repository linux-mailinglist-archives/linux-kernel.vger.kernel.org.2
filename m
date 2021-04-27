Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9E036BD8A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 04:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234101AbhD0CzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 22:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbhD0CzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 22:55:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FCECC061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 19:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TApLiyiy8kC1+MWlnitS8UqPbKuSkbZMje0719pdLtA=; b=E0LeOVXadZZ/HDH2GsNFaJk1fF
        AIt1lyfMthKQN72pT7eSDbX29uWxAv3iIaZ4VmgNDY4o+rbUO/KRl90WMOfLbir2Bm/TgZYAbVaOp
        MX/IOE1Tno821wFRjLLF//7giW1ObiUhzUflJQIySh1hJNGPvFoQTrwFiCqdR7+3fRNLfHmmGf/Lr
        cCIAZMjZGoNyRIOvYciFvWAOMqauSxk94fxYv4LZALHZoZCjWcrKyIp+wAZGq+MzuZ9xmXLzcgbFy
        TDWpYtH1mAB1vctD2ArcG4aQJaWLky92k6lmYAWyB/Vtd9XQFL/4oOu4r9///lu0XFNxDK8u3ScGY
        x2j5BEEw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lbDrK-006ODW-A1; Tue, 27 Apr 2021 02:54:00 +0000
Date:   Tue, 27 Apr 2021 03:53:58 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Xiongwei Song <sxwjean@me.com>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Xiongwei Song <sxwjean@gmail.com>
Subject: Re: [PATCH] mm: append __GFP_COMP flag for trace_malloc
Message-ID: <20210427025358.GV235567@casper.infradead.org>
References: <1619491400-1904-1-git-send-email-sxwjean@me.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1619491400-1904-1-git-send-email-sxwjean@me.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 10:43:20AM +0800, Xiongwei Song wrote:
> From: Xiongwei Song <sxwjean@gmail.com>
> 
> When calling kmalloc_order, the flags should include __GFP_COMP here,
> so that trace_malloc can trace the precise flags.

I suppose that depends on your point of view.  Should we report the
flags used by the caller, or the flags that we used to allocate memory?
And why does it matter?
