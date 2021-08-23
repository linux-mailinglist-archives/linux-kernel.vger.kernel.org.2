Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30F333F4648
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 10:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235376AbhHWIB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 04:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235287AbhHWIBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 04:01:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A43C061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 01:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0YHLZvLC/xYlfH0XYhEFmgV1nKxhlxOO7Z/IK6ZmpAI=; b=LwsmtFikbcXbaYBXBdZ3mQcZMl
        DTnWULW8+ctm9puDTLm96Ubh7pAXsKXZ9n3U4SyScm98QBozTDAU5GyTKDmkaPfY7dxuHcA5omXlA
        PC0xanTLSBd9dvpUhAEd11qa2XS4HE55nk1tqush/NPKSK1/sTnkfpB/YcvcpN5yfpIWtnQD61xbi
        UjQLE0XKpdOQ1WAtdg1PS5k1Wm6LrFEQzgCAw6ny3DkVlda+KOwFWVMRt/9dtmhdgzkZZpZ4Lp2ZS
        i7sS9Q3y/x7ivnfEeChXPM0MVraFjPak+0EA3B/GJFuKVjInRxUvNLLQY+0H5Ur7YigvCqaSTRfzl
        99qRcLPg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mI4sJ-009SGY-Dj; Mon, 23 Aug 2021 08:00:16 +0000
Date:   Mon, 23 Aug 2021 09:00:07 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v3] nvme: revalidate paths during rescan
Message-ID: <YSNVh+o3ZCBQaa1G@infradead.org>
References: <20210811152803.30017-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811152803.30017-1-dwagner@suse.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to nvme-5.15.
