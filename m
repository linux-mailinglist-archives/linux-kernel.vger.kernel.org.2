Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAD3436107
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 14:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbhJUMGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 08:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbhJUMGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 08:06:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08EAAC06161C
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 05:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hp2dNCx95JcsISYZ6Sb5wN1lWRmuob1doeRvoZZX2tA=; b=X96b/OUUwWMCB8kedTeH33H346
        lPb6No4F1NGnCRNH86Cgi/Y0r5FxcGMpVYedGOHrUlCUpOxsKOg77CEdqOd7eW5Zc4sbQBeQ86Nzw
        vEuh0yYLTOBbyojRruFQh9xIfCn5huHcsmmAzJokZZ5jBGUP8PB4ZRkqHspZRL+oRIJc4xStec0G8
        Bi7/i6Y2M2wcDztjZP5x+y6wVMQI75lxEZm5CFVDhUk6FHGv0cVz80UEjqTtRhZZK8p3BY8rRf72a
        yMBGxegEPSuYjtdpWrm1H9GWEHGkHVLfSJ51cAAoToGs+B+wmriX3oaHS2KTEvSr2iJ0+DTmcsKwI
        aMwybIsQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdWlG-00DFKr-IN; Thu, 21 Oct 2021 12:02:08 +0000
Date:   Thu, 21 Oct 2021 13:01:30 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Manjong Lee <mj0123.lee@samsung.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        seunghwan.hyun@samsung.com, sookwan7.kim@samsung.com,
        nanich.lee@samsung.com, yt0928.kim@samsung.com,
        junho89.kim@samsung.com, jisoo2146.oh@samsung.com
Subject: Re: [PATCH 1/1] mm: bdi: Initialize bdi_min_ratio when bdi unregister
Message-ID: <YXFWmo9v65kJWVWC@casper.infradead.org>
References: <CGME20211021072307epcas1p4aa4388c13e71a66e3e1d5f7ee68b5a7f@epcas1p4.samsung.com>
 <20211021161942.5983-1-mj0123.lee@samsung.com>
 <YXFMJJ3u+x34iNy0@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXFMJJ3u+x34iNy0@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2021 at 04:16:52AM -0700, Christoph Hellwig wrote:
> On Fri, Oct 22, 2021 at 01:19:43AM +0900, Manjong Lee wrote:
> > Because when sdcard is removed, bdi_min_ratio value will remain.
> > Currently, the only way to reset bdi_ min_ratio is to reboot.
> 
> But bdis that are unregistered are never re-registered.  What is
> the problem you're trying to solve?

The global bdi_min_ratio needs to be adjusted.  See
bdi_set_min_ratio() in mm/page-writeback.c.
