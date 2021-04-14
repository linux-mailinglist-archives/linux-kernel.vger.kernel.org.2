Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50B6835EE47
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 09:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349488AbhDNHWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 03:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242024AbhDNHWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 03:22:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1231C061574;
        Wed, 14 Apr 2021 00:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pU///pcRL1z9/+8uTgCodVo5x+FjYrV6Z2iez9GC9YY=; b=FGNVSVPQCVIG9eXB/bWWtRztff
        WOcL9PQzKTe6oRgRxXBb1yA2hwafYS1+UvLS2Ps2TGsC77ajsmOeOOquaEGeMp3a+ymAyGIS0edNt
        IM7ec40iTdS3P/tMB7+AbePXoD+Z3GtUa67InkkSP4V7T0n4IllyksKgt1xXUv6ykkap1yfnKzkTz
        uJFzO966bHE/ZqAKaBF+0QyV7HVALLbjC5xiFfRWKBRqmS/aAZNphmKLsDyXqNK5RpJWtguz8Ld3q
        qN56QaAPpiDPyElbJMtE4ZRz/eX/Gzck2eUB5akrKZx43m8FF6lP7cpJespH0SLGSfxnJogeIAv09
        ZD/1t3Hw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lWZpt-006nRS-Uz; Wed, 14 Apr 2021 07:21:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 848C0300033;
        Wed, 14 Apr 2021 09:21:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 35657203CF7D6; Wed, 14 Apr 2021 09:21:17 +0200 (CEST)
Date:   Wed, 14 Apr 2021 09:21:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Muhammad Usama Anjum <musamaanjum@gmail.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>, Borislav Petkov <bp@suse.de>,
        open list <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, dan.carpenter@oracle.com,
        colin.king@canonical.com
Subject: Re: [PATCH] objtool: prevent memory leak in error paths
Message-ID: <YHaX7cxNTPHAEC4T@hirez.programming.kicks-ass.net>
References: <20210413204511.GA664936@LEGION>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210413204511.GA664936@LEGION>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 01:45:11AM +0500, Muhammad Usama Anjum wrote:
> Memory allocated by sym and sym->name isn't being freed if some error
> occurs in elf_create_undef_symbol(). Free the sym and sym->name if error
> is detected before returning NULL.
> 
> Addresses-Coverity: ("Prevent memory leak")

-EDONTCARE, objtool is single-shot by design, on error we quit, which
frees all memory. Please exclude all of objtool from this class of
problems in your Coverity thing.
