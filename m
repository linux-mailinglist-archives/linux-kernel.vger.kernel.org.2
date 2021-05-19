Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8282388A17
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 11:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344433AbhESJEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 05:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232558AbhESJDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 05:03:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B35C06175F;
        Wed, 19 May 2021 02:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yAo0whiTRAB+vHw2nGY2Av2YlNGl/QPd243UE02n6K8=; b=KRaX7Evnu6b/kidSVejYcyiTNi
        v3jN2gBPw+Iza429gUs7FpYS/QCroOqoHVClfbiduXgRFIBjIky0e/nFX34PyLZx+q8b6au8GAo45
        x7ugqPZ+SpBcvCxEOnAdJsoZQg5KeRmwj2bwnTvmwE70r6FATT5P/8Sd6+bZfgBePJWxwvv4W3Sbk
        LQWJisW/VrjHJPpf414I5jj/MIDZuLO2+EByqTCKprJ5ie3VYMvemrsg3X3eAEWcaPv5fodAKZaSe
        ZIm0cFhC4F/8oH0UfyeWO+m8+ZtnBsO+UO1FMJ81DszKoFFVclUVHWst+5bIKrZmFbzPOI/UySW/C
        cEeuUtiQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1ljI4u-00Emu3-HT; Wed, 19 May 2021 09:01:35 +0000
Date:   Wed, 19 May 2021 10:01:20 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Juerg Haefliger <juerg.haefliger@canonical.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: Re: [PATCH v2 1/3] init/Kconfig: Move BLK_CGROUP to block/Kconfig
Message-ID: <YKTT4IufF5kO6V4O@infradead.org>
References: <20210519085615.12101-1-juergh@canonical.com>
 <20210519085615.12101-2-juergh@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519085615.12101-2-juergh@canonical.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 10:56:13AM +0200, Juerg Haefliger wrote:
> While at it, make the option prompt more descriptive and fix the help
> text indentation to be 1 tab + 2 spaces.
> 
> Signed-off-by: Juerg Haefliger <juergh@canonical.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
