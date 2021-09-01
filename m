Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 677A23FD97C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 14:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244088AbhIAMZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 08:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244025AbhIAMZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 08:25:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4725DC061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 05:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0YHLZvLC/xYlfH0XYhEFmgV1nKxhlxOO7Z/IK6ZmpAI=; b=svqh8PybeQzFZ8KtxeRMO8ZsQe
        CCqgaOww5GCqk/9gcaqfFcrn39lgz4XyShkpdmiNZNvvWo0O2/4XFlAyJ66QLuv1lLzjm0NL1ddpl
        mF5PjgoYGhBnuJMYXvCB6KhEgwugtl3i73H/6inFdDkC2FWUspmIbSZkbj0w1ij9x7o09WqaDv9fM
        EGHydw9gPJw0GkDF2RywC0+Wc2sW4Kellvtyq8zHy6U0KH4DC1+pwV7Lz1Blvr9SVwf0kDq3lADmy
        AuEOllOcfy91C4m9RbBmTyTwlGYhJNomYGJJSR3BFlEhUQX1cxSrJaU+Y89mPitnVIMwP/uI+Nr2l
        k7DJsB3A==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mLPGe-002Il2-R5; Wed, 01 Sep 2021 12:23:26 +0000
Date:   Wed, 1 Sep 2021 13:23:00 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>, yi.he@emc.com,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v6] nvme-tcp: Do not reset transport on data digest errors
Message-ID: <YS9wpJwKFyfsAC3V@infradead.org>
References: <20210830133626.139828-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210830133626.139828-1-dwagner@suse.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to nvme-5.15.
