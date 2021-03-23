Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64A513465D3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 18:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbhCWRBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 13:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhCWRA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 13:00:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8488BC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 10:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=825tfiSvqVacuyUEuxcQyTkRHvhtiZqC5C0oGwhAk3U=; b=IG2hdbEj73cEqAaxuioR7niNeI
        eqG1gXQAJVxT1kpo4kcup5UnZicObPInYv4eDJ8Ld29xgpZMBMhpzxGNES60Me+UllXJkUMcBiNO3
        duMiNk3uU2rytKtK6XZl32zaLE/DdNIw0awSb2/IZwDgK2VjMBKx5y5YdkoVxFRT/6fHtbQg7xZZn
        oDniuLcSPc6zeprWrYQ6tASZ0TSyib0eQX0S2QSm8nvCOf/NSqyNHpYbxVNAVIjwxnK6xvf6j/WT2
        8ExfuazMO5TN2jAbi+WJga4xVTaXJgO+pytn+14NREcYZrmu0Hc5LSs+omtUwOjtwxxo6g/UKNFsr
        eK60zCDg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lOkNh-00AJUl-3C; Tue, 23 Mar 2021 17:00:02 +0000
Date:   Tue, 23 Mar 2021 16:59:49 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     "Thomas Hellstr??m (Intel)" <thomas_os@shipmail.org>,
        dri-devel@lists.freedesktop.org,
        Christian Koenig <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] mm,drm/ttm: Block fast GUP to TTM huge pages
Message-ID: <20210323165949.GA2457820@infradead.org>
References: <20210321184529.59006-1-thomas_os@shipmail.org>
 <20210321184529.59006-2-thomas_os@shipmail.org>
 <YFnST5VLcEgv9q+s@phenom.ffwll.local>
 <314fc020-d243-dbf0-acb3-ecfcc9c2443c@shipmail.org>
 <20210323163715.GJ2356281@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323163715.GJ2356281@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 01:37:15PM -0300, Jason Gunthorpe wrote:
> Isn't the devmap PTE flag arch optional? Does this fall back to not
> using huge pages on arches that don't support it?
> 
> Also, I feel like this code to install "pte_special" huge pages does
> not belong in the drm subsystem..

It doesn't.  Unfortunately the drm code has a lot of such warts where
it pokes way to deep into VM internals. 
