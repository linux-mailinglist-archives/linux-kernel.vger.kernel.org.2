Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCC8C3FD7B9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 12:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235055AbhIAKcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 06:32:39 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:44328 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbhIAKci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 06:32:38 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C2DFD202B3;
        Wed,  1 Sep 2021 10:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630492300; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EO3JsQqvzkTHmENKGP7Sv2zsa9Ofobc6JGxvJ/VjjBE=;
        b=TAZQ9GQ46WKV1lDwWzq/TwKyqgsnYxzNbxk/WDr4KnUScH5O/iNRJkpMy5obw1wL5X2/7/
        gzUfhgCX/qs/TY9bn6b8o/2SBA+s0m5gvT8GlrJ2hh63mneZ3HPG3NseoVFX3gwA97wftB
        ZDl+K3uGckg21CEEEBlDSGeDpU7LOtQ=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DBD4AA3B95;
        Wed,  1 Sep 2021 10:31:39 +0000 (UTC)
Date:   Wed, 1 Sep 2021 12:31:36 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [RFC PATCH 1/1] mm: provide one common K(x) macro
Message-ID: <YS9WiF6enhSo8sYc@dhcp22.suse.cz>
References: <20210901092149.994791-1-oleksandr@natalenko.name>
 <20210901092149.994791-2-oleksandr@natalenko.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210901092149.994791-2-oleksandr@natalenko.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 01-09-21 11:21:49, Oleksandr Natalenko wrote:
> There are various places where the K(x) macro is defined. This commit
> gets rid of multiple definitions and provides a common one.
> 
> This doesn't solve open-coding this macro in various other places. This
> should be addressed by another subsequent commit.

Why is this an improvement? You are adding a header file for a single
macro which sounds like an overkill. The overall net outcome is added
lines of code. It is not like K() or any of its variant is adding a
maintenance burden due to code duplication. So why do we want to change
the existing state?
-- 
Michal Hocko
SUSE Labs
