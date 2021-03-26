Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13DEA34A053
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 04:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbhCZDm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 23:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbhCZDm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 23:42:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D992C06174A;
        Thu, 25 Mar 2021 20:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=S3aM59LzwZv2lhTP9C0ITO0CQL7/3mTFFH7WMQjCEiU=; b=N4Z+WQ/0D63wmvnhgzwQTM+nmf
        yHCwotlJqph2PP5rp2afCDzn0M0r/qd4LphT504V1vClIfCS42aw/ChtGSLtQR25PPTZpEVR7mBfV
        xetgewEuFA0Z5yR0TWnadlD+i3Ge967HX8RMosXugO2B7130o39Lf5qyClEiLkQ6U1iSUDuQMdCXC
        mLLRQqrqGboWT3pw409QtubI7+bLlxGCvzhZ/anulvSkLdnMQ6lN2jyqnfRAZQUkSCX8K5yLEaiaA
        40nYIlasmrInug/FdILDGXfruXcYMGK657AdZcSd+VbxHYjywoAwWfEHTEe2I96ogXoE3/TFkC2O+
        FyF0F/fg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lPdMO-00EEBG-Rh; Fri, 26 Mar 2021 03:42:10 +0000
Date:   Fri, 26 Mar 2021 03:42:08 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Qinglang Miao <miaoqinglang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next] mm/page_alloc: remove duplicated include from
 page_alloc.c
Message-ID: <20210326034208.GC1719932@casper.infradead.org>
References: <20210326025542.3565329-1-miaoqinglang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210326025542.3565329-1-miaoqinglang@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 10:55:42AM +0800, Qinglang Miao wrote:
> Remove duplicated include.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>

can't you make hulk robot do something useful, like untangle the
mass of header includes?  For example, in -next, net/ipv4/tcp.c
has a dependency on pagemap.h.  Why?
