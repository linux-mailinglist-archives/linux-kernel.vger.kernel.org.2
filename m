Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABF0035ED49
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 08:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349234AbhDNGkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 02:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231917AbhDNGj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 02:39:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66AEC061756;
        Tue, 13 Apr 2021 23:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9FMDp4FETi2Plb1JTq4/Y90vv0hkjYHxRXV0YigHgkU=; b=NiKW6pebZPWlXqHQEZnlj0rogl
        O+K72x+e4LN1WVcf6Ka/PjrjeMEA7BGc8sBpsSrAR6pZJMwYjqFnkmPHkUcVkrv/LiTn5BpA0zqKj
        FOvNYnJBawz/QZQv5o0V3jlbEdYo3hx3MRJkuml9A205qFPpZ3GOAZlvpILUudK8UOhw+H111eIPE
        FD3eE6S6zBAeJLrfC3ov1c6POkyId7njuUpkYOBsyTtItJC/wvvw/Tv6ovLRq/HAH6wl2GOl0c5qi
        y/EaDxv/LOIvt1XfZAGCR9+jI6v+CceDuhO1FmepzIFkJKdXqlNvmorLD4N2wh8uuCEV70yrbYpkI
        1J8uU87A==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lWZBO-006kdc-0D; Wed, 14 Apr 2021 06:39:27 +0000
Date:   Wed, 14 Apr 2021 07:39:25 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Remove me from IDE/ATAPI section
Message-ID: <20210414063925.GA1607069@infradead.org>
References: <20210412090346.31213-1-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412090346.31213-1-bp@alien8.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 11:03:46AM +0200, Borislav Petkov wrote:
>  IDE/ATAPI DRIVERS
> -M:	Borislav Petkov <bp@alien8.de>
>  L:	linux-ide@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/cdrom/ide-cd.rst

The Maintained should also become Orphaned then.
