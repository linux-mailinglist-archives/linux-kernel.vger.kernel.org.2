Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0F8313268
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 13:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbhBHMdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 07:33:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbhBHMVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 07:21:41 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A9FC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 04:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QZ68eDzyWCAz+2nzBsWZkgQ2ABiWw5RkvWAcGTc7SYk=; b=gtIqzmS2+JJ6S1kU0/ahQmN3xj
        mXoKgk4xk/ags7dmt6vbepjPku6haySRxRHMaLqiPAmdXIRyFgEChraIh+O3gDrXQDAWQ/2bN0KHu
        QPm3P9fObTLgOfoFXL0qjlqbeQ1fv3PQ7FTSYt+5HPT1uSIUFnS+FxE7KgsUXzODuFrXPn/xsH/qh
        fH9TLkuPDkNnqfVIOaQmBSBnE9/O1ojKd8FOmf8nBC0xrIpZmZujzoJxoMm+ebgPK/+GWDmoadH16
        0Pb18useRleA77Z7VsjIoR3YtDZaEgF8iQNVpmwquv+VjmIQxihAXiT9K7vqg7Up4QGdzIAJpdoU4
        Gg7K2DVw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l95WT-005wbT-UM; Mon, 08 Feb 2021 12:20:10 +0000
Date:   Mon, 8 Feb 2021 12:20:09 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     andriy.shevchenko@linux.intel.com, david@redhat.com,
        vbabka@suse.cz, cl@linux.com, linmiaohe@huawei.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, joe@perches.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] mm, vsprintf: introduce new format to dump full
 information of page flags
Message-ID: <20210208122009.GN308988@casper.infradead.org>
References: <20210208101439.55474-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210208101439.55474-1-laoar.shao@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 08, 2021 at 06:14:36PM +0800, Yafang Shao wrote:
> To avoid breaking some tools which parsing pGp via debugfs or affecting
> the printf buffer, other new formats are introduced, so the user can choose
> what and in which order they want, suggested by Andy. These new introduced
> format as follows,
>     pGpb: print other information first and then the names of page flags
>     pGpl: print the names of page flags first and then the other info

This is overengineering things.  We already print in little-endian order,
and the other information should be tacked onto the end.  Just extend
%pGp.  Andy's suggestion to add another flag was a bad one.

