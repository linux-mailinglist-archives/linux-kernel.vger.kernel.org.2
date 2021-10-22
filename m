Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0058C43807C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 01:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbhJVXRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 19:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbhJVXRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 19:17:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98184C061764
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 16:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3zlCnVEVcta2MtBWsgS/Tybs/RLk1R8UL/fZPbL2R8w=; b=ZOC1L5UJ0dalx5agQ66MagvMbR
        d30bKwXRgvqQGUBeRTrmSCgQ9TGoBsT1TpYlFwT0ykmJXOz8MIT+JcB1FmStOWWGvUeOYpZdNdj1S
        9rqXSHHqQVs/zn7H5E8TUfxO0Lygy4sWH7mAjkSd1rfu5QiGdz48dvo52hZjxHUcZjGd4FlPm3RTE
        efrPbv5pdwOot8hjm7xq3vJR0JwXgZJ6hdHW1E7NAXvwevmnZe/LKaei8uOOKdrhbeAZmtgr84UZ0
        gfj9bVshaB9xcsJfdOpxndbH44z1yjIMHJNFoSFN3uvEq7T5Hx4Zzj6I+YsbyTuFa0xoDiN1aGFvd
        2GPxLnCg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1me3ky-00C6aT-Kx; Fri, 22 Oct 2021 23:15:24 +0000
Date:   Fri, 22 Oct 2021 16:15:24 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     dhowells@redhat.com, neilb@suse.de
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] afs: simplify sget_fc() call
Message-ID: <YXNGDPMRD+K6nmCu@bombadil.infradead.org>
References: <20210726202253.2226788-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210726202253.2226788-1-mcgrof@kernel.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2021 at 01:22:53PM -0700, Luis Chamberlain wrote:
> We can just use set_anon_super_fc(), no need for our own
> custom implementation of something we already have available.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

*poke*

 Luis
