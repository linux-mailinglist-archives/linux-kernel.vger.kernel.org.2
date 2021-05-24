Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8203938E82F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 15:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbhEXOA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 10:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbhEXOAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 10:00:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D13C06138A
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 06:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=a+7GFCpQRXul40vCcwixBiKb50
        UzfUH0e6FpH5mKe4xLi3nLsVFDlf05X6jI8pKqmG2+eacm6MQX3JsQq/MJqq0NiWpcvXnH2q6wfKG
        ToG93o3O9YEI+E0Nw2fKW9V/QxE6ImDCoet+xfGkpRrqzZ1BPOSsyLYycy0Y7fC3NQilWTAS1ia9f
        8MjTsQ6T1gPYkztIybObBqdqzzz7roHG3Me/PhccE5qyZ9ooqBB9PdYto0EHFr0wR8FQ6xKb3w/Qr
        Dn0fGLnclxrA5Z2QxVl/C+w3I37FafTDPPnfslNvq3pwW4kX0dCAc3e6rpyBO+p0QFMAW9Re6KyUp
        uiSROxAw==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1llB6O-002Qsc-LQ; Mon, 24 May 2021 13:58:44 +0000
Date:   Mon, 24 May 2021 14:58:40 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Christoph Hellwig <hch@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] mm/vmalloc: Fallback to a single page allocator
Message-ID: <YKuxEL4COzTsgdj0@infradead.org>
References: <20210521111033.2243-1-urezki@gmail.com>
 <YKecydxDtWLTDuKg@casper.infradead.org>
 <20210521125509.GA2442@pc638.lan>
 <20210521130718.GA17882@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521130718.GA17882@pc638.lan>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
