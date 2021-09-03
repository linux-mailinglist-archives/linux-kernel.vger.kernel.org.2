Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA1FD3FFE89
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 12:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245633AbhICK6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 06:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbhICK6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 06:58:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3EEC061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 03:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pH6lyDsQLhgwMRLaWAWREDHIGMEyG56GDfi7GMO4tkM=; b=R+d22mg7A8AZCCfbCSmQhdRSAz
        bTpNJ84Bo4LuaADHlzUZuChvW7X6peHqeJZK64Ng1y1zh13tojjJakiGQhuWh5l51rWB+GWeJLO4X
        fMb3Sw9Q+hq88cEJhZAa0znvoiJ9JFUV1gu1qPw6DQaOYZ22W9a2m/6BLCuJfDKlsjHYabGykiSAM
        TAucwNgLoblRVqejNTzXAEozMjho5QTWTR8pwNt1s1RYQC19XHVamkZFnObK62O5UMLuX3TZEKLTn
        bQVMP/J6iNJNBRomPkRC9e5zokLZ33WNNxo6ehF7CA6loMkxwt1m9rnELq4tDuCb8KZa0Qp35BRIX
        E0pp7O4A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mM6qm-004NOh-Fv; Fri, 03 Sep 2021 10:56:17 +0000
Date:   Fri, 3 Sep 2021 11:55:12 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Michel Lespinasse <walken.cr@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2] mmap_lock: Change trace and locking order
Message-ID: <YTH/EHbVT+OLv4O4@casper.infradead.org>
References: <20210903022041.1843024-1-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210903022041.1843024-1-Liam.Howlett@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2021 at 02:21:05AM +0000, Liam Howlett wrote:
> Print to the trace log before releasing the lock to avoid racing with
> other trace log printers of the same lock type.
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> Suggested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
