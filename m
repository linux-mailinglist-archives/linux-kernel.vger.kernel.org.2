Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3AB3EA72C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 17:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238390AbhHLPJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 11:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237682AbhHLPJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 11:09:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E20C061756
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 08:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=bYb2ie6jMLMzND0qi3cawroT6axBFe5IDHItnoLWNfQ=; b=PSqKAk7KoY+Cz+5OSdXuT7DPbQ
        /arIZDmC7pBItMpZPItoy2/r+fwZPx/+DsmWY/RwNSQVWg9HLlEZNiJu4W/otwkQWT+WHw4u49xAe
        AO2EUfTZH2Ot81+fCO2uJtmG2JFXGTDC69tqN+HqVIrbr3S8C98Y8JjLzWKoqskBU/3qii8hdaOf8
        TA0YOYTiuNkUSl3uEgiQFLTA6vMS0aieIcmZ5nrji2mD4sKGV4WOgIGcRCAIt1r/H3q4r+77ss+O/
        6TrkuDGISLk7cW2ptKmKK+QDY5v58X6jdFHf0vNHXjvNeLYkYgPUifwFjBBv2tQkisZQ8r0Iof4Jb
        eHTu9TBA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mECIu-00EhL3-7Q; Thu, 12 Aug 2021 15:07:47 +0000
Date:   Thu, 12 Aug 2021 16:07:32 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Huang Ying <ying.huang@intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Data corruption problem with swapfiles and THP
Message-ID: <YRU5NAD+G9DVFYM/@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is an assumption in the swap writepage path that a THP is physically
contiguous on swap:

        bio->bi_iter.bi_sector = swap_page_sector(page);
        bio->bi_opf = REQ_OP_WRITE | REQ_SWAP | wbc_to_write_flags(wbc);
        bio->bi_end_io = end_write_func;
        bio_add_page(bio, page, thp_size(page), 0);

As far as I can tell, this is not necessarily true.  If a file is not
contiguous, we can have an extent which is 1MB long followed by an extent
somewhere else on storage that's 1MB long.  When we try to write a 2MB
page to swap, we overwrite whatever's on the block device after that
first 1MB extent.

(Came across this by code examination while looking at getting rid of
the bio path entirely; no attempt has been made to produce this problem;
something else may prevent it from actually happening)
