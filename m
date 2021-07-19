Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3B23CCC4D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 04:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234270AbhGSCgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 22:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233759AbhGSCgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 22:36:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1FFC061762
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jul 2021 19:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lBjjp8J+Tqp3xf+vSwlOPlck4yC59kCbKLbvN+rwOQo=; b=OU8b6Fi3bGUkzahn3rv2irVKz/
        F0xgLdF2gIz+hruxrPCn521Lq/o1L/xVYqU6byGSZgc5KKVvBz+PQtvyNZDupbviD/T8z5fl6CRXz
        Mv93QgE0uV11ZbpP+/lBo35KdbSF0H1IRD17gFPd6gk6hbNhlHn34XMGn8+ecTDXQ5GA2I+RJx/8a
        BVWos6zsAlo5HBxHYXB287FltwRfpxOvVJYIU5Nm649ZRI69ybRr2nleLsjuWLIJMXaspnYmTJ4jL
        RCFcByctmMFZrQHjlk3fDYWZoRoxTwRoFz3zXZmV3ZAKT8oeq9FMrmk6jem7DpFw8oXCZpq1yE/IV
        0C4mni/g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5J4R-006Stc-3p; Mon, 19 Jul 2021 02:32:11 +0000
Date:   Mon, 19 Jul 2021 03:31:51 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Chanho Min <chanho.min@lge.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Gunho Lee <gunho.lee@lge.com>, Juneho Choi <juno.choi@lge.com>,
        Inkyu Hwang <inkyu.hwang@lge.com>
Subject: Re: [PATCH] mm: make falutaround selectable
Message-ID: <YPTkFxkEUeoCE2lg@casper.infradead.org>
References: <20210719010845.31898-1-chanho.min@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719010845.31898-1-chanho.min@lge.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 19, 2021 at 10:08:45AM +0900, Chanho Min wrote:
> While faultaround can have performance gains, on certain platform it
> increases pss and causes swap to occur more frequently. This patch allows
> to unselect faultaround on platforms that do not want this behavior.

It would be better if we could determine the circumstances under which
faultaround is causing problems and automatically disable it without
asking the sysadmin to determine that.

Can you tell us more about the workload?
