Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBB123AE310
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 08:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbhFUGWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 02:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbhFUGWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 02:22:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7677C061574;
        Sun, 20 Jun 2021 23:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uNPhX10VS4Wsxa/3lttySqU/Lgh5QfKb1rKtABFNOog=; b=tmomkpjoveAIKFsL8pIBCHEUwD
        H14nWK8xQ4Kney+2ABTK3OjwIGIEcJdPFbCe9+CDvys+GTxzgPjt+ekmhwpgquzErPv7VY7Yy8Zu/
        FI96nEO8MHf1RDnSNtF3qRGf5kJBhG5qV/TRZyEzmEGkoahawJsQh4lDZvvzTUshUTgY4jpVZcsLu
        Sy7vlLqjMrXb+szCktDbdxBje6RAvqLQ0QaUKNA9cFnt8m7rEauUwjtPW5l5rivVHWUiKoGiJMJxC
        hjkfWXGJeGg8qIARfV/4zoI2wnGpzH9Qqz/mkyOXFt3gl5jVAjdrJR31WHFhBCzB/B6c07/bIVMFr
        qrPfJ+Cw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvDGi-00CmTX-Eo; Mon, 21 Jun 2021 06:18:59 +0000
Date:   Mon, 21 Jun 2021 07:18:48 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     hch@infradead.org, axboe@kernel.dk, desmondcheongzx@gmail.com,
        gregkh@linuxfoundation.org, linux-block@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        miquel.raynal@bootlin.com, richard@nod.at,
        Shuah Khan <skhan@linuxfoundation.org>,
        syzbot+6a8a0d93c91e8fbf2e80@syzkaller.appspotmail.com,
        vigneshr@ti.com
Subject: Re: [PATCH v2] block: genhd: don't call probe function with
 major_names_lock held
Message-ID: <YNAvSJHMuveUp1o/@infradead.org>
References: <f790f8fb-5758-ea4e-a527-0ee4af82dd44@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f790f8fb-5758-ea4e-a527-0ee4af82dd44@i-love.sakura.ne.jp>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The obvious fix is to not call unregister_blkdev under loop_ctl_mutex.
Which is pretty pointless anyway - I have a series to fix that but it
might need some reordering to move this to the front.
