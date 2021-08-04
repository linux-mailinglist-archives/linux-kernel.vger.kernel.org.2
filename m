Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 444963E0270
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 15:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238119AbhHDNxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 09:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237156AbhHDNxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 09:53:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F9AC0613D5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 06:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sQHuzcjS6P96HYdRIf7uqQ4lnDNFAoSA8AvFOLfc/M4=; b=tewNok//YUiPhUzswLRFPp3jXc
        PuQKMVAbnitnz6zWHQzh8f6a/RQc9KVm15hvF7mMIUaPZt/jrMllAsqYk4YTJHKNB1aUYp9c3Hidm
        Upeu+cPbKwVMygr0h+RzLCHAC+sONRLA/6CkStl0UZTuRxjrHM3HsJItd63qdoupvZCJT6BEgwrAC
        dd8mLHSVuiShgokS+uG1Fm6GAsRC7MuugPO+3QW53ogsr+OfrXzRIHA6u894yWnTn/2PDQsg1vVR3
        i+/d/SXddJC4/Nc15pt2Iw3zncwB6dSBWBMks2GIEWXwrzVvQvg7iDB7Ga6EmnB2eEY+VqGTfWH3b
        0ZN9VGOQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mBHJU-005uPG-Qe; Wed, 04 Aug 2021 13:52:13 +0000
Date:   Wed, 4 Aug 2021 14:52:04 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Chao Yu <chao@kernel.org>
Cc:     jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao.yu@linux.dev>
Subject: Re: [PATCH] f2fs: introduce nosmall_discard mount option
Message-ID: <YQqbhMtVZvCF30r9@infradead.org>
References: <20210730100530.4401-1-chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210730100530.4401-1-chao@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2021 at 06:05:30PM +0800, Chao Yu wrote:
> This patch introduces a new mountoption "nosmall_discard" to support
> disabling small discard functionality, note that the mountoption can not
> be removed by remount() due to related metadata should always be
> initialized during mount().

Why does this need an option?  It should be enable IFF and only IFF a
SMR drive is detected.
