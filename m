Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6809A415BD4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 12:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240371AbhIWKQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 06:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240335AbhIWKQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 06:16:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54DCC061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 03:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=v9wmDg94//1DSWEYtCDvETeBICadVbjbxJSkTzaHgNg=; b=lhnzzJokM6qsdHEw4Dgxo6ZscN
        VkkJVeaPPXAEFtzxeEWqg26JXYpGRBRizhYSein3Fwni6cqSFOC092P6FdPwnKK0ANnDkFfTePv1V
        8Nxqvm9Opz7QvKymjZ2ozs1WjoXSpj/nZ8EYHl+pyQTor2snRQBOdV912TTPkzBAfJTEHq7p/A5d1
        TLuBTXpPnl4Evzd2IZo6yPMuC9cHImMMGzNWLJz8MLVmaccGH89laEzrjlPiHwckt7r+s9iIkmH0h
        1Rh3rgkZd4ytIca+4paTWSdzHCAu8vNsPwFhGEESJ0iFB332c/aD8qUZzU6XiV9k7t8IZ/ebxdcNe
        x9U6tTXg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mTLjP-005lXU-Dx; Thu, 23 Sep 2021 10:13:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A018B30031A;
        Thu, 23 Sep 2021 12:13:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 86EAE2C9B8ABB; Thu, 23 Sep 2021 12:13:30 +0200 (CEST)
Date:   Thu, 23 Sep 2021 12:13:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, acme@kernel.org, mingo@redhat.com,
        kernel-team@fb.com, eranian@google.com,
        Lucian Grijincu <lucian@fb.com>
Subject: Re: [PATCH] perf/core: fix userpage->time_enabled of inactive events
Message-ID: <YUxTSn82eIP/4IzO@hirez.programming.kicks-ass.net>
References: <20210922011715.4154119-1-songliubraving@fb.com>
 <YUxSMqrJK/rKPZS3@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUxSMqrJK/rKPZS3@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 12:08:50PM +0200, Peter Zijlstra wrote:
> On Tue, Sep 21, 2021 at 06:17:15PM -0700, Song Liu wrote:

> It's wrong because:
> 
>  - you should only do this for (is_active & EVENT_TIME)

Note I also didn't do that :/ I actually did, but then figured it wasn't
worth the effort/mess it creates.
