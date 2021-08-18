Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9C6C3EFD81
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 09:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239161AbhHRHMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 03:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238419AbhHRHMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 03:12:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA03C061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 00:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XVk0mIofspuMqQgKhMDBgK4vbHJ8w+HnPday2+GyeMM=; b=TegRh2SsWU5s2skh0SxGV6jJ6N
        G6mwaxfu9yJ+pdJ72AvCt+gEdmUqg2nzDMUGLHglziHllJGXXDCaVIizT8SqTLBvP0dpi/bsU3tuZ
        oexf+p3nPBAN6XSUqoDTCb2VK77C6pSbwW13ACaBzP+LkmbyTR7VvqPMWNW/9NE76H/ZOWX/8gEJ7
        WAUpUFRRtAtOWPvJwsfS1/eYyYHc3DOI3w6UirPNq0gSSWli5W4jq3P8AtjPkB+H7CpHxtsNdtYcT
        SLKXLgiLep/rjhEODCdcIPBa3cO7t4gjiV5BCZjuLYSEIjZeCwDg+48kFsf/t8H/W7bmSjM8+LK+6
        BwNZ0BEA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGFj7-003USt-DM; Wed, 18 Aug 2021 07:11:22 +0000
Date:   Wed, 18 Aug 2021 08:11:05 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     torvic9@mailbox.org
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH 1/2] x86, Makefile: Move the CPU-specific 64-bit tuning
 settings to arch/x86/Makefile.cpu
Message-ID: <YRyyicOaNu/HDgJR@infradead.org>
References: <269701460.117528.1629210189833@office.mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <269701460.117528.1629210189833@office.mailbox.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 04:23:09PM +0200, torvic9@mailbox.org wrote:
> +# SPDX-License-Identifier: GPL-2.0
> +# CPU tuning section (64-bit) - shared with UML.
> +# Must change only cflags-y (or [yn]), not CFLAGS! That makes a difference for UML.

Plase avoid the overly long line.  Also having an empty line between the
SPDX tag and the actual top of the file comment really helps readability.
