Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E231B3496DF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 17:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhCYQcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 12:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhCYQcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 12:32:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D10C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 09:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oOdLjHuIxXVhFe5pzP0CyL1J+H1PHxVj/9t6qQoloCs=; b=LJ3w7uwjOEReT7g5/1kN2W63Th
        nknfOx1CZbDLdSf3Bm8PXbCWukIPpcnQwRkAU77asfGQkWP2U+5hX4UR7sf+fCnH9XSbn814bWnB2
        YMPr/v6vd14q7yiF4aQsFiQUknpn7iAluTRFyOodzJREENYVeWxYxKmkmCXNd5VtGw+QtW4MDQgl1
        Wi3HvRe9o+KbDyQIHoYNZuOnrmzTlUjFIvuiZA4pK2W1RoEfzsjXG4yP7iDSg7CP3OqfY+H/sMKqB
        Gmg5TRst6E/TC0Wfn6Z11YEAO8UCuFu12mT3loyW0RR6pvslyzwGqriTMDpvFkyaguoIw6yb+5jJi
        sh8KMeug==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lPStI-00DJHp-4n; Thu, 25 Mar 2021 16:31:39 +0000
Date:   Thu, 25 Mar 2021 16:31:24 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Uladzislau Rezki <urezki@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 0/4] vmalloc: Improve vmalloc(4MB) performance
Message-ID: <20210325163124.GY1719932@casper.infradead.org>
References: <20210324150518.2734402-1-willy@infradead.org>
 <38da93959bc948c992fc7fc1efd4d25c@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38da93959bc948c992fc7fc1efd4d25c@AcuMS.aculab.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 03:59:56PM +0000, David Laight wrote:
> Even then it is probably better to use a typed pointer

thank you for expressing your opinion
