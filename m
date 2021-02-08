Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFF63313E5E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 20:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236065AbhBHTCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 14:02:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234251AbhBHR1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 12:27:35 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7324EC061793
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 09:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ke1hxt0FRH7sV6bLaq9pHrT4cON6Sd9F2qPDMzZG7NI=; b=TwoTO4rvqglLPbU0a10zOrdEFi
        ETZHslKkqFVfe/ub6DERrZhVSXQQh0/TbAdhIjrUF/mwALGrnZCf0hkvVlcalQFFIQElif+GGRpqX
        mE1nkjHKru1zEOmwK7WjkklN/hk6GJtCCB8E476lhyHyH+kksvtD7DpNdpBRDfOZgF2YnUCPJ/t26
        G7E39ADHWpHDC+1dXa2/ikcvBUwF+fEBUgtDyJrAOntZ5tv9tELDhT7EbZ7/wUIi1Wko7ldTppHn0
        3AFPXoh3ss+QGtJmHOQfF7HaDi9RBnUnluR/Qb2WwwvVgeEnvbNsS12Od0FnayqCnc+bUGJc5Kwgs
        3Veb73wA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l9AIS-006HH7-U4; Mon, 08 Feb 2021 17:26:01 +0000
Date:   Mon, 8 Feb 2021 17:26:00 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     andriy.shevchenko@linux.intel.com, david@redhat.com,
        vbabka@suse.cz, cl@linux.com, linmiaohe@huawei.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, joe@perches.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] mm, slub: don't combine pr_err with INFO
Message-ID: <20210208172600.GU308988@casper.infradead.org>
References: <20210208101439.55474-1-laoar.shao@gmail.com>
 <20210208101439.55474-3-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210208101439.55474-3-laoar.shao@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 08, 2021 at 06:14:38PM +0800, Yafang Shao wrote:
> It is strange to combine "pr_err" with "INFO", so let's remove the
> prefix completely.

So is this the right thing to do?  Should it be pr_info() instead?
Many of these messages do not appear to be error messages, but
rather informational messages.

