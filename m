Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E35A379C5D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 03:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbhEKCAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 22:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbhEKCAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 22:00:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27DCC061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 18:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=94dTxvf+dfWqWALs6j6WFSSXBzIqjxhol9xgA8vTt+s=; b=JZix6jWG46gP2Y9OnRBmly+QdW
        tBFpXe0LFPUut4WOC2m0bhh15+ZFMSzqcifpwuOHKbn14vc7HzGbhyvePxjAJHHvx7WmcYwa29n6H
        MOC6M8Frywqs8q01YlCKUzeeGWZmgkEl/rOrZdPiF3QX6J5R9Du7/1/IhSwzJh1KMZS+kIIxCiHEc
        Oxk+YUrE+ef+Vr/razzvxRGDuy3H40QgNlJSySblcUPsKjFQMpmdEWUaRwS+ic9BaaiJFAFcO5s4V
        PmiRn6w3iB9icgpjQsIyzxnBIBbKmOVtOW/+ZD26ECbGe7PUQMET1tXCYfzblbYu1+YxzrSVkAp5K
        TXL/eW+Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lgHf8-006nC6-Pe; Tue, 11 May 2021 01:58:25 +0000
Date:   Tue, 11 May 2021 02:58:18 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mel Gorman <mgorman@suse.de>, Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 2/2] mm/vmalloc: Print a warning message first on
 failure
Message-ID: <YJnkurvLPolj+RHU@casper.infradead.org>
References: <20210509193844.2562-1-urezki@gmail.com>
 <20210509193844.2562-2-urezki@gmail.com>
 <YJg8QO2JXm0+8UH6@casper.infradead.org>
 <20210509200519.GA3016@pc638.lan>
 <YJhDpkpdUKiNEAnt@casper.infradead.org>
 <20210509212641.GA3220@pc638.lan>
 <20210510103342.GA2169@pc638.lan>
 <20210510185238.787adc7378bc6d82262399d2@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210510185238.787adc7378bc6d82262399d2@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 06:52:38PM -0700, Andrew Morton wrote:
> On Mon, 10 May 2021 12:33:42 +0200 Uladzislau Rezki <urezki@gmail.com> wrote:
> 
> > Please find the v4 version of the patch that is in question:
> > 
> > >From 7e27e4ac8f299ae244e9e0e90e0292ae2c08d37d Mon Sep 17 00:00:00 2001
> > From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
> > Date: Sat, 8 May 2021 23:41:21 +0200
> > Subject: [PATCH v4 1/1] mm/vmalloc: Print a warning message first on failure
> 
> Added, thanks.
> 
> Matthew has a point of course, but I do think that any console driver
> which tries to allocate memory within the cotext of printk() is so
> pathetic that it isn't worth compromising core code to cater for it...

I'm fine with v4 of this patch, fwiw.  I saw no advantage to the earlier
version, but now that the advantage has been explained, the advantage
outweighs the disadvantage.
