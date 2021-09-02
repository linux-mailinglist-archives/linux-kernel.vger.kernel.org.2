Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBC1C3FF3AD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 20:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347185AbhIBS7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 14:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347174AbhIBS65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 14:58:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDD9C061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 11:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mEWxwozPp98XvUMfIR/xO8RlM5RAnk1dZj5xJ5vpaHw=; b=mspsIZXn1cKDmDNtLwqIda6upd
        KJx9BQBMxZXtu01JyTlN8Z+pmNjWJyEP/bw6rCJraCsGDz5rTSaDo1c90lTtrmJLmCje8yNL2QlNd
        vH/oNX3zL6dOfuh9B/20IWOP8G3Rmmpsv+/Ac9YSY13TPR117vHFt17HGK15GXrogx/llddHgdw0H
        Y6XT9NRx7AyEuXb0Iq3YkMZ1x5QJwzMPJfVFbgf36g1qCQ1YES4H9IPyQSZLf4gGDBtqeRAjsjwxM
        +WkfUCpmCKCzokxBQNqZnh5CR5uomGZTBim5aGBCAcjpl08GSJQ7HvnzRAVLrGZcezG0+WamV4aAf
        v49pRZgQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mLrsi-003kTE-I9; Thu, 02 Sep 2021 18:57:04 +0000
Date:   Thu, 2 Sep 2021 19:56:12 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Lameter <cl@linux.com>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: slub: BUG: Invalid wait context
Message-ID: <YTEeTK83KNBmuJLC@casper.infradead.org>
References: <3b7661a1-dbde-ea54-f880-99777c95ae22@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b7661a1-dbde-ea54-f880-99777c95ae22@kernel.dk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2021 at 10:22:23AM -0600, Jens Axboe wrote:
> Hi,
> 
> Booting current -git yields the below splat. I'm assuming this is
> related to the new RT stuff, where spin_lock() can sleep. This obviously
> won't fly off IPI.

You want to turn off PROVE_RAW_LOCK_NESTING for the moment.
