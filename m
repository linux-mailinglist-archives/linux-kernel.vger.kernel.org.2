Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 361EA408AA6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 14:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239795AbhIMMEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 08:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235453AbhIMMEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 08:04:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DC8C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 05:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8lo0vHb7ImFTleNlkpQJ1WfMvQ1mq+ieRDjrF0GF73g=; b=lDGUtuApfMgigT8AonOdtU/3nC
        8pVHJZQjWm8BWpfst35hW+oycb6mcNK2EuOKNemn2/8ylDgJLtdX2iOVg716gWCHmawVns2ezllUn
        4IDJNn9Nz01v9HhkJtfB2GvOplz22QlmfF1h37dpUCHtGUFF7xmfTtISUwzr3e6wN4NGDFGIBJfiN
        Osstqd4lip+FnCToe+Rf9Z+fw07qtdaxPJSDIYNm4MAEFmOgoBv8nE7xaltBZoLML+Eqa+wu3kzH/
        S8STskT0RenTYf9QX05qEjmbaLQqb+oV+YQ1VJ8r79ja3wxCziu18Wm6L6Og+T/HVaPWMs9G3WGob
        0GfjwWWQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mPkf1-00DRrQ-11; Mon, 13 Sep 2021 12:02:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C715630003A;
        Mon, 13 Sep 2021 14:02:05 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A76BF2BE7CB9D; Mon, 13 Sep 2021 14:02:05 +0200 (CEST)
Date:   Mon, 13 Sep 2021 14:02:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>, kbuild@lists.01.org,
        kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [peterz-queue:sched/core 13/19] kernel/sched/debug.c:453
 print_cfs_group_stats() warn: variable dereferenced before check 'se' (see
 line 444)
Message-ID: <YT89vdIDp2UkDamz@hirez.programming.kicks-ass.net>
References: <202109111001.XChyxkS3-lkp@intel.com>
 <CALOAHbBqZ5MgQ958ZG2ne4T5xXw0YjcO2aKutGgS6WX2_+vYew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbBqZ5MgQ958ZG2ne4T5xXw0YjcO2aKutGgS6WX2_+vYew@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 07:04:14PM +0800, Yafang Shao wrote:
> Hi Peter,
> 
> Could you pls. help amend below change to the original commit ?

Yep, will do, thanks!
