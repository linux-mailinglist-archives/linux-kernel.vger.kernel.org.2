Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 506443CD503
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 14:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237004AbhGSMEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 08:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236571AbhGSMET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 08:04:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359C3C061574
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 05:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tGkUUStChLCXt1Uh1220a9d3L35+2D4Hyrolq+19Nbc=; b=FesO4hgZXSGsqrTOY4GPu4RWOC
        xFyqdunUnk/ncfxgNVnYtdkBcOYownzTEQi5Kq1h7NqnJ9lRRtZc/KsLHP3Kl4BgF+vmVWjxP7MZv
        exMfmFqQ9fSstaNshZwpG3XayTQHDR8p0NlVQsA9F+5rzpSZsJF7/6kdgUXPcHS6zfnzA0eOtZEN1
        ABaFWiBAXuEEEWgWahlL3FCEfPYBQg2vIobdIjp682bb7X99Z7hgH6n6rZeT40Erxuh9QFqhSgT0+
        8fUaTaz3BWRCN28WocOT3Q2LMF9uHbTZblywfZikEQn5l2pf+ny8LK3ifaCRV6cJKi7V+hYg/rGnT
        Jqgaks9Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5SdD-006r45-0z; Mon, 19 Jul 2021 12:44:32 +0000
Date:   Mon, 19 Jul 2021 13:44:22 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1 1/1] mm/util: Rephrase documentation for kmemdup_nul()
 to clarify input
Message-ID: <YPVzptA7JYMyWszg@casper.infradead.org>
References: <20210719122002.41334-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719122002.41334-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 19, 2021 at 03:20:02PM +0300, Andy Shevchenko wrote:
> kmemdup_nul() strictly speaking is not related to the string API,
> while being quite useful for it. Rephrase documentation to make it
> clear that input data can be anything (any data, which may contain
> any bytes, including 0x00).

That's not a useful thing to do, though.  This rephrasing you've
done is more confusing than the original.

