Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A32EC32825B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 16:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237149AbhCAPWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 10:22:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237105AbhCAPUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 10:20:17 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A0EC061756
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 07:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=H+RP+8sy28bTiBPrwN72CBkl729IEc5jZJwP1/JcGJE=; b=0CPXeim9O1vOo9/QUmvpeSOH0a
        QeCBeb0mcFlWOSuelkLNaW4jeolz+qr6DffrO/xGZ82F8MO4nj58/Y5My2v6CuDmwyVeVBdov0xt1
        ii1q1JkxjQ/Il9AYz24XIrnu00dg3Tlj//MY0vw/bI+89jP+TpuhD0B2BnhqLCMPR+3K+ozxsYxSB
        lHaACLElhT24039XWDThd5U1BrngTT/z5OClIJ8lAkAYamgrWAWzAcco6Q3S89mIvAK9eF8HUGEq0
        xCpsGHn/piC5qp6P06quUCDkBQFemi26rtHGHiCsBUuzpwXtQv8iC9N3FlMsLKfE7+1NabKc5K+sq
        fPsiIIRg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lGkKY-00027F-D8; Mon, 01 Mar 2021 15:19:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7A296301959;
        Mon,  1 Mar 2021 16:19:25 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6A6492BAC31C1; Mon,  1 Mar 2021 16:19:25 +0100 (CET)
Date:   Mon, 1 Mar 2021 16:19:25 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     tglx@linutronix.de, mingo@redhat.com, dvhart@infradead.org,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 1/4] kernel/futex: Kill rt_mutex_next_owner()
Message-ID: <YD0F/c15JRoE8K4J@hirez.programming.kicks-ass.net>
References: <20210226175029.50335-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210226175029.50335-1-dave@stgolabs.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



For lack of a 0/n, these patches look good to me.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
