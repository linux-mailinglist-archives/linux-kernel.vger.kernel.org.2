Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9A530855D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 06:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbhA2FyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 00:54:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhA2FyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 00:54:09 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D6DC061573;
        Thu, 28 Jan 2021 21:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CzDvjW0PsVn2C/KV8egp8yfOHQE/Tji5vpufDPEiy+Q=; b=s/8aDS3xramd3dUVdb/vzacIyC
        Jj5WXpgxm4/ZnT9cScIAb0sh0MKpEBa4AvZY5VBuRmoXF34eGO5R+GTbueOCO21tvXHioV8UNFwLO
        eJs5SdpHdCSQjvbzJzHffD6pm9LmrnB0qfybrmL9gXaFBVcmmV1ucqliuz3qLhn3dWAF0y849l7tS
        5pJ/lIqOTDeYqogShW7Bb2hXhK0P2nhJN0GC+DoFAtLoWP25oB+X6gPBghYZNl2ZbO9Az2JYbkmn+
        bf+vUU1rk1NVDRXa5zasGKV8oiJTjUIKFY5p7Z1EZ8x9+uty8Oo5joBdDlnC7TTjT5QDnc+4RPTXI
        AgRgFAFA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l5Mig-009Rs8-5J; Fri, 29 Jan 2021 05:53:22 +0000
Date:   Fri, 29 Jan 2021 05:53:22 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>,
        Alessandro Zummo <alessandro.zummo@towertech.it>,
        ALWAYS copy <linux-ide@vger.kernel.org>,
        and cc <htejun@gmail.com>, Andre Hedrick <andre@linux-ide.org>,
        CJ <cjtsai@ali.com.tw>, Clear Zhang <Clear.Zhang@ali.com.tw>,
        Jens Axboe <axboe@kernel.dk>, Loc Ho <lho@apm.com>,
        Mark Lord <mlord@pobox.com>,
        Suman Tripathi <stripathi@apm.com>, Tejun Heo <teheo@suse.de>,
        Thibaut VARENE <varenet@parisc-linux.org>,
        Tuan Phan <tphan@apm.com>
Subject: Re: [PATCH 00/20] [Set 1] Rid W=1 warnings from ATA
Message-ID: <20210129055322.GA2250604@infradead.org>
References: <20210128180239.548512-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210128180239.548512-1-lee.jones@linaro.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Everything except the individual CFLAGS flags looks fine to me,
so for all the patches except for the CFLAGS changes:

Reviewed-by: Christoph Hellwig <hch@lst.de>
