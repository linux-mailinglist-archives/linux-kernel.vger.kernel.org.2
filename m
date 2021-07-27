Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 835A93D748C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 13:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236490AbhG0LsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 07:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbhG0LsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 07:48:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C078C061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 04:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=amNN9ICmSy0CIVY3BfkjSZ+Y52dJCXLET8MjYMJxcRY=; b=IxH8llkwulKXXSh6OvycrTVgSK
        QZCBD45U22q3e4ZQBfB5GqMco8wIRURRoyN0H5TXp/+2ndJUUOpqwGHxTYM8mW6jcg3hee0KgRyHZ
        59GXle0LFmt24/kM5MZriLCjau7tDrcHfb4HfC+9BdLUR27DCvd9C7Dy2rR8s3A5Ygp89RoxsYB15
        gdGCuBLp1Gx/qKh61/rgDanAPZzb7sSSrakS+OaR9cvj9t4vlM4z06AbrKu+DDJDji8olnPwtPiYO
        3M91tb2xFPoay8x5JxcM9vSFDaH6VLXxRPp9EUbK1QnB50S/4qdJKTt4dDYrIhAsp4gUfE87LRjgJ
        jy/vA5Cg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m8LXf-00EyC9-6Q; Tue, 27 Jul 2021 11:46:50 +0000
Date:   Tue, 27 Jul 2021 12:46:35 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Wang Qing <wangqing@vivo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: folio: use copy_highpage() instead of
 folio_migrate_copy() when copy once
Message-ID: <YP/yGzyzxOmp3SNT@casper.infradead.org>
References: <1627356775-28742-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1627356775-28742-1-git-send-email-wangqing@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2021 at 11:32:54AM +0800, Wang Qing wrote:
> folio_migrate_copy() will call cond_resched(), even if it only needs to be
> copied once, restore the previous implementation before there is a better
> solution: use copy_highpage() when copy once.

no.  i already fixed this on july 22.

https://lore.kernel.org/linux-mm/YPmB60EwQPpEvdb%2F@casper.infradead.org/
