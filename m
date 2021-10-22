Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4A143702C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 04:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbhJVCrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 22:47:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:60214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232554AbhJVCrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 22:47:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 359E7613DA;
        Fri, 22 Oct 2021 02:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1634870732;
        bh=c6hUSwQF7luins0JK+w46yPAWdt0DouzfgIY/quVreE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kBL1C/uLaibJPDQVHUNkCX/Odyh8lgmtwfafHNGlEExbSFGDfeQL9pkiCb7ovUgDW
         MYcLDXcA4gJhfthx7s/aTLqoqbBZ7GhOjoTwU/y9RdGLG0VwcQftlxdSqndhbEaTHC
         vS4J5e1nu6uGTZClKN5joSGsMOut2CFQq92Q2USc=
Date:   Thu, 21 Oct 2021 19:45:30 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Manjong Lee <mj0123.lee@samsung.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, seunghwan.hyun@samsung.com,
        sookwan7.kim@samsung.com, nanich.lee@samsung.com,
        yt0928.kim@samsung.com, junho89.kim@samsung.com,
        jisoo2146.oh@samsung.com
Subject: Re: [PATCH 1/1] mm: bdi: Initialize bdi_min_ratio when bdi
 unregister
Message-Id: <20211021194530.1fabf4fa45cfe3bee6598484@linux-foundation.org>
In-Reply-To: <YXFWmo9v65kJWVWC@casper.infradead.org>
References: <CGME20211021072307epcas1p4aa4388c13e71a66e3e1d5f7ee68b5a7f@epcas1p4.samsung.com>
        <20211021161942.5983-1-mj0123.lee@samsung.com>
        <YXFMJJ3u+x34iNy0@infradead.org>
        <YXFWmo9v65kJWVWC@casper.infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Oct 2021 13:01:30 +0100 Matthew Wilcox <willy@infradead.org> wrote:

> On Thu, Oct 21, 2021 at 04:16:52AM -0700, Christoph Hellwig wrote:
> > On Fri, Oct 22, 2021 at 01:19:43AM +0900, Manjong Lee wrote:
> > > Because when sdcard is removed, bdi_min_ratio value will remain.
> > > Currently, the only way to reset bdi_ min_ratio is to reboot.
> > 
> > But bdis that are unregistered are never re-registered.  What is
> > the problem you're trying to solve?
> 
> The global bdi_min_ratio needs to be adjusted.  See
> bdi_set_min_ratio() in mm/page-writeback.c.

I added cc:stable to this and tweaked the comment & coding style a bit:

--- a/mm/backing-dev.c~mm-bdi-initialize-bdi_min_ratio-when-bdi-unregister-fix
+++ a/mm/backing-dev.c
@@ -947,10 +947,12 @@ void bdi_unregister(struct backing_dev_i
 	wb_shutdown(&bdi->wb);
 	cgwb_bdi_unregister(bdi);
 
-	/* if min ratio doesn't 0, it has to set 0 before unregister */
-	if (bdi->min_ratio) {
+	/*
+	 * If this BDI's min ratio has been set, use bdi_set_min_ratio() to
+	 * update the global bdi_min_ratio.
+	 */
+	if (bdi->min_ratio)
 		bdi_set_min_ratio(bdi, 0);
-	}
 
 	if (bdi->dev) {
 		bdi_debug_unregister(bdi);
_

