Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 718C3306138
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 17:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbhA0Qpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 11:45:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbhA0Qpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 11:45:40 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C387C061574
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 08:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dJZWJgvFEi8PEyXlP/99T+0iLG9fMp6z1w2MyP1S/s4=; b=F34Vgv8BM/QM71TxFhN6T8WpCH
        1ajLqHyAE0C8o75IQMgiVR56qAFCuuWRUIflM0NWGTYBBW0zkc6SxUrWD7N6GW12HWJ3342s87yT+
        pdKHS+iup6NqMb/boQeXBWeiYo1gaUCrk1KZXTyCTs33IF5/Nv8jiiHjhXtUb4pNLnfyrtzevZyJ6
        EaruioXf7IYaRExrzkk/VknuFRwTPcI77Vs5tiLgq0Jd+s0rpeUud5EG8m/6U5eqED0hS8x9kxsjM
        bciXLu/CMRUHvMIIJq+r3lh5y5YkwavG3WMipGmk0fqjXZU6Phjhxjni3zuQQNKYrJSVtEVoXG6n5
        VweR+Ofg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l4nw4-0005mV-S2; Wed, 27 Jan 2021 16:44:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D492F3003D8;
        Wed, 27 Jan 2021 17:44:50 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BCB182D2A484F; Wed, 27 Jan 2021 17:44:50 +0100 (CET)
Date:   Wed, 27 Jan 2021 17:44:50 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: kprobes broken since 0d00449c7a28 ("x86: Replace ist_enter()
 with nmi_enter()")
Message-ID: <YBGYgvYMZuve7E++@hirez.programming.kicks-ass.net>
References: <25cd2608-03c2-94b8-7760-9de9935fde64@suse.com>
 <20210128001353.66e7171b395473ef992d6991@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210128001353.66e7171b395473ef992d6991@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 12:13:53AM +0900, Masami Hiramatsu wrote:

> Peter, would you have any idea?

Without a clear error, I've no clue yet. I'll try and investigate a
little more once we have a little more data.
