Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47DEE3C2B65
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 00:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbhGIWce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 18:32:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:53588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229542AbhGIWcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 18:32:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EB7B96139A;
        Fri,  9 Jul 2021 22:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1625869788;
        bh=TAn+FzBS95wW3IA+etHMOKOSXxRjWCUe3WyWiWvBeTM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UW3oTJyxZcXV4fosRLEHivkbSQC7f0D09pmKttrcLOu+PK2bFcBmO4NuqROC6TsCA
         9BshaN7m2LiiD3wOzeTKmmkstc15l0HL68xuTx0lTUEbGZN+C77I4MJYVuvVNeLeHB
         LqMzFlLjrKgeAPJ2mvtQUOzzpqC6rSaDpZOXA8sk=
Date:   Fri, 9 Jul 2021 15:29:45 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     =?UTF-8?B?5p2o5qyi?= <link@vivo.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@vivo.com,
        Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [PATCH] mm/vmalloc: try alloc_pages_bulk first to get order 0
 pages fast
Message-Id: <20210709152945.f2c373e8834d4b8488fd027f@linux-foundation.org>
In-Reply-To: <ABEAoQDbD-*iJqfqrqFbUarq.3.1625824439751.Hmail.link@vivo.com>
References: <20210709093852.GY3840@techsingularity.net>
        <ABEAoQDbD-*iJqfqrqFbUarq.3.1625824439751.Hmail.link@vivo.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Jul 2021 17:53:59 +0800 (GMT+08:00) 杨欢 <link@vivo.com> wrote:

> >Thanks. I suggest you take a look at the current merge window and check
> >if anything additional needs to be done after the vmalloc bulk allocation
> Sorry for that, I will work in linux-next

That material is now in mainline, so work against Linus's 5.14-rc1 please.
