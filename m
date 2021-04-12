Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 125A735BBC1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 10:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237232AbhDLIKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 04:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237214AbhDLIKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 04:10:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0D9C061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 01:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=lvcAH3egkmdk3BEVnfleRsOyxvt27C1nGCYDzcE+hkk=; b=sQ5jFlOYyMTzY0JnGSHwnsBEas
        3VVJi+90/a64uIGmKHJMN1RZcsGxuwH1JhqV0BEk/hNjPdSW4MkvVQq7bunC7rnk9y9ZiCj8Qb8ZM
        ZLzkzVA2ISZrT7mRczADplemHqCFAWIYIURVGtWdalUgynLRJ/8Tge/Rie3hXAWkT5MB5dNtoWTrW
        VI8m/Da5y0acWJvV12VGOwYct7eAOJBhj7z0vltT3YU/697ZzTWCSt/W54YfQ1z0bdE4vhPF74ZER
        bPcmKKF8kBzlszyzb6jq8S5SJmDlWwtrr0A1S/FjtGCGr13YoJOtZtjFK+IQy9Mfo7a5kF9GBnxOm
        OfUV58Jg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lVrcl-003yd6-5Q; Mon, 12 Apr 2021 08:08:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 798BF300209;
        Mon, 12 Apr 2021 10:08:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 2E6C325F2152C; Mon, 12 Apr 2021 10:08:44 +0200 (CEST)
Message-ID: <20210412080012.357146277@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 12 Apr 2021 10:00:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, x86@kernel.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, chris@chris-wilson.co.uk,
        intel-gfx@lists.freedesktop.org, linux-mm@kvack.org,
        keescook@chromium.org, hch@lst.de
Subject: [PATCH 0/7] mm: Unexport apply_to_page_range()
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

These patches remove the last few modular apply_to_page_range() users and
unexports these interface. Since these functions provide direct access to our
page-tables they're a prime target for nefarious activities.

These patches rely on the remap_pfn_range_notrack() patches from Christoph that
are currently already in Andrew's tree.

Please consider.

