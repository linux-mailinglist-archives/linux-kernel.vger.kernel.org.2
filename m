Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB98C455740
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 09:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244761AbhKRIsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 03:48:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243165AbhKRIsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 03:48:11 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40B1C061210
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 00:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=96S4EthB+6zIOtMMZ50m2yFtwma9si/mTFRJme+WPvU=; b=oaxBH2FfzEJgcO3Q5kmi4rhOiQ
        Fie+uS6wSt0O5tQpfW/lv6Aqiw/WN+zV4KsAMPAW6G+LSEGCaWO2Pn0riDgP6NLLCpyRFktArsWwS
        Erd9iRCxbH/7q3ULr8q+AFGMIGdH4ei0LiHtJNHb7msU166ccsP6yV2dPi+h++ta29FCrpI/Gevca
        ZRK5pPfrQIFdVcWQX7trKgnGv4dJPZ26wA2/52dD16VlnR21akne5tBydfKHEBaG3ENWUpw3axos0
        ZAXpU9smE4rVPE+qs9AknWIUVnctPJ5V+f0Rvp6NACgH8B2wPjJ/XGybCguMmZZGiL5CbojzdYUGA
        gqeeZ75A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mnd24-008JLA-Pr; Thu, 18 Nov 2021 08:44:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 94D4E30001B;
        Thu, 18 Nov 2021 09:44:36 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 833B72C99C22B; Thu, 18 Nov 2021 09:44:36 +0100 (CET)
Date:   Thu, 18 Nov 2021 09:44:36 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     yajun.deng@linux.dev
Cc:     will@kernel.org, boqun.feng@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] refcount: introduce refcount_is_one() helper function
Message-ID: <YZYSdJh7xpkHJjoa@hirez.programming.kicks-ass.net>
References: <20211118074200.GF174703@worktop.programming.kicks-ass.net>
 <20211118035328.5730-1-yajun.deng@linux.dev>
 <a4b7401c06d3baa5d3d0a43d7aa6c62c@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4b7401c06d3baa5d3d0a43d7aa6c62c@linux.dev>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2021 at 08:12:56AM +0000, yajun.deng@linux.dev wrote:
> November 18, 2021 3:42 PM, "Peter Zijlstra" <peterz@infradead.org> wrote:
> 
> > On Thu, Nov 18, 2021 at 11:53:28AM +0800, Yajun Deng wrote:
> > 
> >> There are many cases where it is necessary to determine if refcount is one,
> >> introduce refcount_is_one() helper function for these cases.
> > 
> > Give me one that is not racy?
> 
> The following determine refcount is one, 35 count.

Very good, now get me one that isn't broken :-)
