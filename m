Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F405315173
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 15:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbhBIOWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 09:22:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbhBIOWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 09:22:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154B6C061786;
        Tue,  9 Feb 2021 06:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=92OsEoxu6KZ4vU5fiZgZg2D97j0aRwFV+gTD+J7BNss=; b=pqyGdfYq+vHsnlPwnBh51WwvXf
        SCwUPOG+246tWxWLrbKR/9Nr+gmJg3AZLKKoDot1eM+q5fbmrs+IHx7As5fKSpNFXeDfJHh0yNE6F
        vEdxNVQhJcijsAldTPGGgqwZYHqECFZ2UBWmiktkBfn81EMaJn6EYbgw6gNoaPQs2dpfY5pHFJy69
        lEC3Rqg7nKXqjOPKHpE6j0vuHoNfBFRtUxmgnkkjQLcMVsMekNFW/pksO6sbJLVvX0zkJyfu7oDWJ
        LNM037TEDKwd57Pt/3bDUX4WtVGOocsUJeTkMZoNCwxLLh9Vpr9MDBb1puSvqib3K48IH1s7d1viK
        x7ifWumw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l9TtS-007XvU-S3; Tue, 09 Feb 2021 14:21:31 +0000
Date:   Tue, 9 Feb 2021 14:21:30 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
Subject: Re: [PATCH] docs: maintainer: Fix the spelling mistaeks to mistakes
 in the file pull-requests.rst
Message-ID: <20210209142130.GX308988@casper.infradead.org>
References: <20210209140155.3890715-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209140155.3890715-1-unixbhaskar@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 07:31:55PM +0530, Bhaskar Chowdhury wrote:
> 
> s/mistaeks/mistakes/

You missed the joke.
