Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93E67412F01
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 09:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbhIUHGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 03:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhIUHGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 03:06:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D93C061575
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 00:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0YHLZvLC/xYlfH0XYhEFmgV1nKxhlxOO7Z/IK6ZmpAI=; b=pLhi6DxxjyiDnSFxRsA+piazY3
        Q74sL3hFqbUjq9cbbjySKw3d1ja5ARRmffelXt8iMZHNvssmXR5aQqzUyByY5wmNsyTv4bMawr/iA
        s3ympbnZ/O2x5qXSReot9ZfZD+FIyCgkfSIiFQPH5/txxSp5u9YaCdS6XwH0n/QINzuud6W1ZWgAL
        3RrEBt8jW/L2oGpE34oIjIv7vxmkDlohwbdUGDkmIeNCc02HgsPU9Hd7PoA3+BnVR7+ItAWCPOyvE
        U766bod2em9i2O80kKOoHQkU7I9nljlRvbp3LHhcvrX0KY0jVXhjlINFO54aqg9xpt/a5yUcL/8SK
        PU4axXtg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mSZp9-003aJg-HZ; Tue, 21 Sep 2021 07:04:25 +0000
Date:   Tue, 21 Sep 2021 08:04:15 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Wen Xiong <wenxiong@us.ibm.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH v7 0/3] Handle update hardware queues and queue freeze
 more carefully
Message-ID: <YUmD70Xcf6rMmHO2@infradead.org>
References: <20210914092008.40370-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914092008.40370-1-dwagner@suse.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to nvme-5.15.
