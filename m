Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16CD2382C1E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 14:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237033AbhEQMbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 08:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237014AbhEQMas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 08:30:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A514AC061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 05:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+pTARd/J+Nn5q3ByAbyk/qheF0T8+IAYZW0neGnkNm0=; b=hZVpyqZ0bo24554QSUuKPU47V8
        PHGgjab6IazWR79JIaq3y/ZsKgnMjI8lsJP4oJkkc6iM6YOqNt+2apHYhoLypQ23JSLt+YNeO0VsA
        nGJgycsNs3nlcdDLA/zTPBh8HqQmhI6WidmBen3r7/lPAjBbxYoudY+kIRRtD8aFP+ib5RjTuxvwJ
        /QVIKh93c2FSBnGfSvD/FL7e1tLfMqa2VPnERb7i/Hz769h2ROS2gOymOqLjCM9lmzxXBELl0Mzg3
        2b8RgP4eYbEZN02PG7V4WuI1sUrX+u5VQj8G8XDM3eeXCmnZWla/erQSxgWQfLflcgqHo5/49X30j
        DWPbDZ5g==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1licMt-00CtlD-9F; Mon, 17 May 2021 12:29:09 +0000
Date:   Mon, 17 May 2021 13:29:07 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH v1 1/1] drm/i915: Include only needed headers in ascii85.h
Message-ID: <YKJhk9nrDs3oWe46@infradead.org>
References: <20210407122337.77493-1-andriy.shevchenko@linux.intel.com>
 <YKJfZXn3P/ZdslRP@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKJfZXn3P/ZdslRP@smile.fi.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Btw, can someone please add a few comments to ascii85.h?
I have no idea WTF "ascii85" is, why it matters and how the two helpers
should be used.
