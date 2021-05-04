Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4461372B8B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 16:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbhEDOCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 10:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbhEDOCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 10:02:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C967C061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 07:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=V4U9OF/5A5A7+ex1Qlqu0+oFqFyil+2DW5bEVur773Y=; b=pazQueOhDe2ARSKQLwocmk9zmx
        eUloDS38mmm+XUf0HA2b2cNeWLq8cyH8LB36OfpBrEgOo7TAHEC2wd+V3QmEp+K4JgkCErZecwCtd
        N/h+0hDGI8m9R6hYUgCLjZoHQebjj1W2rpDTRbPsqF7sEd8hU8z3rnLXuTGeF7GNQAHXL8pLdImnv
        dJEay8jYsdGVaIwCK6T2d8X8FGnpif/TdDsjpJrTbiWsX0Tb/GC373ohR+lx9NnSKXNMj/qZ6SG4W
        7cZj/XqdcxEpVeCApoyutZm3gYkNT+H/Ltc83JjRkYqXh5dwEmZPmWAqKUcc69Eix1l7wbtisNT0i
        ZobOxktg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1ldvbz-00GeEB-E3; Tue, 04 May 2021 14:01:23 +0000
Date:   Tue, 4 May 2021 15:01:19 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     outreachy-kernel@googlegroups.com,
        David Kershner <david.kershner@unisys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        sparmaintainer@unisys.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [Outreachy kernel] Re: [PATCH v7] staging: unisys: visorhba:
 Convert module from IDR to XArray
Message-ID: <20210504140119.GH1847222@casper.infradead.org>
References: <20210504133253.32269-1-fmdefrancesco@gmail.com>
 <20210504134216.GG1847222@casper.infradead.org>
 <3550993.e1xmc6yJDa@linux.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3550993.e1xmc6yJDa@linux.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 04, 2021 at 03:58:02PM +0200, Fabio M. De Francesco wrote:
> On Tuesday, May 4, 2021 3:42:16 PM CEST Matthew Wilcox wrote:
> > On Tue, May 04, 2021 at 03:32:53PM +0200, Fabio M. De Francesco wrote:
> > > Changes from v6; Added a call to xa_destroy() that I had forgotten.
> > 
> > What?  No!  Go back and re-read what I wrote about this previously.
> >
> I remember that explanation you gave me some days ago for not using it. But I 
> was mislead by a comment ("Do we not have to call xa_destroy()?") by Dan and 
> your "Correct" soon after the above comment. So I thought that I had 
> misunderstand and the put back that call to xa_destroy(). I lost something in 
> following the flow of the reviews, I suppose.

English doesn't have the equivalent of the French 'si' or German 'doch',
unfortunately.  I imagine Italian does.
