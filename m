Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9643A429DF3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 08:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233409AbhJLGtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 02:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232784AbhJLGtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 02:49:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE9DC061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 23:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NPzymWGZFZtOe+/jKRLbVu5DHM/rAWyTP2BsW0jWWww=; b=ch35Euih1D4ciiB3AVzymRFAuy
        nC4QrxOzS3GXGIjv2jekKYj93c5sAi16rI5uHSsqPG3ZEWpDnCFTw34RyJc+rzhRU6NbHboKesTaF
        ThoU4MFVqSSXpJWNJX9Jvur8gNAaX3gr21qiQjIhzMIVBZml85bTcTbzYQv9/zJPhz4jYp6wByaBI
        bh83aD2tpRv7A5MBqCHsbN0VMV1x7TKTBPDbtF8G9ur9R2bGLq/ILa/ZNfapQJN5Y5q6jkpfIhl54
        IjWydMjTF+xH28D5Gw22eRL5PHlSbIWE5VR/o+SbgtDrxqkD2BYlmqNVgjH4AEoiIdXoFI+jUcgHJ
        tI6uIvDg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maBVd-006H2q-C2; Tue, 12 Oct 2021 06:43:55 +0000
Date:   Tue, 12 Oct 2021 07:43:33 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     geert@linux-m68k.org, vverma@digitalocean.com, hdanton@sina.com,
        hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org,
        christian.brauner@ubuntu.com, axboe@kernel.dk,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 0/8] Use copy_process/create_io_thread in vhost layer
Message-ID: <YWUuld90s+MIsLkn@infradead.org>
References: <20211007214448.6282-1-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211007214448.6282-1-michael.christie@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The whole series looks good to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
