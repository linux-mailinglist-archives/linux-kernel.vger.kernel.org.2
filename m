Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A20A63B6B1F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 01:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236124AbhF1XCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 19:02:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:38624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235313AbhF1XCb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 19:02:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 24A7461CF8;
        Mon, 28 Jun 2021 23:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1624921205;
        bh=ZsWXc9FKF9jThbjc7um9yI6tcNaF+KHjq8t5fFUWmrc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=l1Zz2/tgvo1jyws/qAAFhigF8Ji8mVZa67ZBwc7L4Z/eMFlUg6ea9eZPnW14/lGO/
         T40NIIeTtGjzYibo4b1ahhUd+nquuolDPjU/RqK60dldHkZHScuun1Wm8ptLYW9hyk
         xeb2ycRQWVmPW/4xxPSW6iZbPhbacFkO4KvTFq28=
Date:   Mon, 28 Jun 2021 16:00:04 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Mel Gorman <mgorman@suse.de>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 2/3] mm/vmalloc: Switch to bulk allocator in
 __vmalloc_area_node()
Message-Id: <20210628160004.ad39038af33e4be17df0d7f6@linux-foundation.org>
In-Reply-To: <20210519210750.GA5615@pc638.lan>
References: <20210516202056.2120-1-urezki@gmail.com>
        <20210516202056.2120-3-urezki@gmail.com>
        <YKUWKFyLdqTYliwu@infradead.org>
        <20210519143900.GA2262@pc638.lan>
        <20210519155630.GD3672@suse.de>
        <20210519195214.GA2343@pc638.lan>
        <20210519210750.GA5615@pc638.lan>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 May 2021 23:07:50 +0200 Uladzislau Rezki <urezki@gmail.com> wrote:

> > Basically a single-page allocator is more permissive so it is a higher
> > chance to success. Therefore a fallback to it makes sense.
> > 
> Hello, Christoph.
> 
> See below the patch. Does it sound good for you? It is about moving
> page allocation part into separate function:

Please just send over a patch which addresses this and Christoph's
other review comments.

I don't think the discussion with Mel against this patch identified any
needed changes, so I'll send this series to Linus.

