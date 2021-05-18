Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 888F1387B38
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 16:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbhEROg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 10:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbhEROg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 10:36:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDBFC061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 07:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=V41BGrwJAcDzACJWMGS38sqXTQTEeXnRt0JcY9r2fHM=; b=nDtysvCwvj0uv29VbSGeK/Qtw3
        1QYK2aKJNx7PGsK48QQxqSQPjPAij9Gv7wQ7kkATWLHVyWMRlru7ZlDE6y8grK24lSNQdPS8D+VFe
        XfXnxGtJld78JsTPiM5A07ecX5GE83v78LUpVNHUCR8RQazwpMMYU0GSa/ilJIRuWQZ2jtxVoK7dQ
        4lTCkahRXTrTmRqLWxYzk6gxKgPJKjHPtFQnhPfoynv6axP8hwnPMt60dlk07m+kS+w5XosVpJVuY
        S9q58kwkDzF/rgwB25Hbiit3gJovNOwOtDWnvAejCJTrpHCczGr3QgndRxp1PqsPHb4zqXjDykF5c
        UV3cGH3w==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lj0nC-00E3nb-O5; Tue, 18 May 2021 14:34:01 +0000
Date:   Tue, 18 May 2021 15:33:54 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 5/5] mm/swap: simplify the code of find_get_incore_page()
Message-ID: <YKPQUjjdC3mP5f/P@casper.infradead.org>
References: <20210518135352.3705306-1-linmiaohe@huawei.com>
 <20210518135352.3705306-6-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518135352.3705306-6-linmiaohe@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 09:53:52PM +0800, Miaohe Lin wrote:
> pagecache_get_page() can do find_subpage() for us if we do not specify
> FGP_HEAD. No functional change intended.

Please, no.  This interferes with the folio work.
