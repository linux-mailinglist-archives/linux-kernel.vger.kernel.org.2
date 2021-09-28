Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D97B41B220
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 16:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241316AbhI1OcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 10:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241280AbhI1OcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 10:32:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592FEC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 07:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SlTizmY7Szq/oKJhNf9yib5mfTsaovwgKAlrcFr83EU=; b=rURbXiZXq4hHr3tBbNcObnNJON
        5c4luiZoDNnaPhud7MHRme4A/Tp9NnhxXjDTXwP5DmcwbmrUzkdrOXjPr+cZucVeRWf7OCidyGrDw
        bQ1Dgp9vdG178XWCrHbOR3HuneEUvfnHNgD89v4cSRM70NRatbaD8QXARsK1QmGfLualMCUWVlHRl
        UBNDmwXM7uE5XujoFeLMoXs4szUYtR+Bl9//P3ylvPf4gly8Wg+uzFtv/tIapVPEVkA8623J607/Z
        vdNdXxdQX8DRK45/dZvMrI6YHuC5rAEMavHHkoBE54WhZRh2HlfBBRdda1mY8iO2TRvpfnO7hcEkt
        XUyBmPqA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mVE6h-00AwBU-On; Tue, 28 Sep 2021 14:29:37 +0000
Date:   Tue, 28 Sep 2021 15:29:19 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     bp@alien8.de, tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/microcode/amd: Add __list_del_entry_valid() in front
 of __list_del() in free_cache()
Message-ID: <YVMmv5AlKcJeKBkh@infradead.org>
References: <1632819884-800736-1-git-send-email-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1632819884-800736-1-git-send-email-jiasheng@iscas.ac.cn>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 09:04:44AM +0000, Jiasheng Jiang wrote:
> Directly use __list_del() to remove 'p->plist' might be unsafe,
> as we can see from the __list_del_entry_valid() of 'lib/list_debug.c'
> that p->plist->prev or p->plist->next may be the LIST_POISON,
> or p->list is not a valid double list.
> In that case, __list_del() will be corruption.
> Therefore, we suggest that __list_del_entry_valid()
> should be added in front of the __list_del() in free_cache.

No one should be using list_del directly anyway, so please fix that.
