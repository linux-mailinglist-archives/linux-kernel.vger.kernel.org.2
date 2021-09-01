Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC773FD983
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 14:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244012AbhIAM1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 08:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbhIAM1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 08:27:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DDCC061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 05:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=j04+nObtEo9Lx3wgZg+CisiSWMhsMj0sdOktBlelLfc=; b=VKgUay1NPt84DBlLxiUAeiUH92
        568nlOHq9RmYLOJ8lbQTtu8zf0snIrD4tFoILO7R/xDo0FCdMIOlK+Iqiu88YUVCoXnt7IzXvwftn
        NFQOJfbjplYjPA3ypobMKBIiC3RWOlE1mhvbsDd3HuN3S2UxrQjmaqugkvG/lgMBs5poW0tCLPliy
        CwdppGclZWlsAFpSXt7QwHLeg6ezeZLPjN+kx/4Wl53j11icr+Ds/vA6qf1rfbkz2MuHjAefwdtK8
        Vca4qNcm0JVHEx6w+MhKkSLSjhAiwPK9CHQ8hZwDrHFzzH6jZY51DAyU5xqX3jDMQRnlziKUU5Hx4
        KiEwQjSA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mLPIp-002IwP-KV; Wed, 01 Sep 2021 12:25:33 +0000
Date:   Wed, 1 Sep 2021 13:25:15 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] nvme: only call synhronize_srcu when clearing current
 path
Message-ID: <YS9xKzRWW97L6ZN9@infradead.org>
References: <20210901092524.131610-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210901092524.131610-1-dwagner@suse.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to nvme-5.15 with a cosmetic fixup to keep the lines from
overflowing.
