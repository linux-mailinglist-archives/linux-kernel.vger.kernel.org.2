Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6610C437056
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 05:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbhJVDDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 23:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbhJVDDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 23:03:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53E1C061764
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 20:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VkfP0BQNS3FE9QhrfQNys6FB6k6JJJc7e6jw1eQ9Db8=; b=AOjGpvdQf1WdT1MqcEyvAVsBol
        1NoLZbN3rbR3Z9QcllZALHSh1+bSxGBrgt7hDiX9MoK6d5jrO88yvScCDH5LymP2s+DhJ58jt8RDX
        T8TIP+CRb+u12oVLUeKF1J9X4OpW6oCMYCd+Dz5aOPyGLD/SXrCHQT2F7f5NksYArNath/UJNqqKI
        baWD9voJy0e+44oCpVGGCd48t+/X0TgQPQ89oMrYhGBzfdzbjAc6hhyygerWGxa5RU7VwngUhbVma
        F6tHQPjGX46q0cIKotO0mC41XQC3zwmQrGW67kKlRGrlywykk820jgigebf2mdyOD4fSNQ6ZCbIq4
        SToetSiw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdkl3-00DfGS-93; Fri, 22 Oct 2021 02:58:26 +0000
Date:   Fri, 22 Oct 2021 03:58:13 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Manjong Lee <mj0123.lee@samsung.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, seunghwan.hyun@samsung.com,
        sookwan7.kim@samsung.com, nanich.lee@samsung.com,
        yt0928.kim@samsung.com, junho89.kim@samsung.com,
        jisoo2146.oh@samsung.com
Subject: Re: [PATCH 1/1] mm: bdi: Initialize bdi_min_ratio when bdi unregister
Message-ID: <YXIoxefk8UDDCt0M@casper.infradead.org>
References: <CGME20211021072307epcas1p4aa4388c13e71a66e3e1d5f7ee68b5a7f@epcas1p4.samsung.com>
 <20211021161942.5983-1-mj0123.lee@samsung.com>
 <YXFMJJ3u+x34iNy0@infradead.org>
 <YXFWmo9v65kJWVWC@casper.infradead.org>
 <20211021194530.1fabf4fa45cfe3bee6598484@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021194530.1fabf4fa45cfe3bee6598484@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2021 at 07:45:30PM -0700, Andrew Morton wrote:
> On Thu, 21 Oct 2021 13:01:30 +0100 Matthew Wilcox <willy@infradead.org> wrote:
> 
> > On Thu, Oct 21, 2021 at 04:16:52AM -0700, Christoph Hellwig wrote:
> > > On Fri, Oct 22, 2021 at 01:19:43AM +0900, Manjong Lee wrote:
> > > > Because when sdcard is removed, bdi_min_ratio value will remain.
> > > > Currently, the only way to reset bdi_ min_ratio is to reboot.
> > > 
> > > But bdis that are unregistered are never re-registered.  What is
> > > the problem you're trying to solve?
> > 
> > The global bdi_min_ratio needs to be adjusted.  See
> > bdi_set_min_ratio() in mm/page-writeback.c.
> 
> I added cc:stable to this and tweaked the comment & coding style a bit:

Definitely improvements on that front.

I don't know the BDI code particularly well, and the implementation of
bdi_set_min_ratio() confuses me, so I can't say whether the original
patch is clearly correct or not.
