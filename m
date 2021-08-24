Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3B623F5AC1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 11:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235794AbhHXJQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 05:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235842AbhHXJP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 05:15:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356A9C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 02:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=BW/7NLbZXOq6HV2zM6aZohR72rr7qvEY0eDamwzhcBY=; b=uE4gYl6ROZMvfa1c9mIoSf+1ps
        k116TrZ/6zEiGuWWf2UrWFj82lXSrVEL5Y7I4HHSUk3oP9FXgpWk7qomj4ciqVaTql5qOM4Wy9ZpB
        F4TwlDL3t5GZgO4B7R+GNrwmJr0JMc168yezFMXI8huiO10F1xwZ8ICK+JrfJ3ykDhOldVmOEZjEO
        2PCa1hD99HtIlC7ZMwiJjHAw7UhUUIESz8aWbgAWZohEerNcNX1nfGyOeBrOQAFRwT8wNpeFac0o8
        kFNA2cC6dWo5Md9xol8/ynjgHvg+EChjxG6fwi/qvP1P7VeXPIgme9ktmYUyfnCXl/GIf9OUPt4Q+
        oguFLR2A==;
Received: from [2001:4bb8:193:fd10:f8c0:1a4c:b688:f5a6] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mISUP-00Apqd-Bv; Tue, 24 Aug 2021 09:13:08 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: small ioremap cleanups
Date:   Tue, 24 Aug 2021 11:12:57 +0200
Message-Id: <20210824091259.1324527-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

the first patch moves a little code around the vmalloc/ioremap
boundary followed a bigger move by Nick earlier.  The second
enforces non-executable mapping on ioremap just like we do
for vmap.  No driver currently uses executable mappings anyway,
as they should.
