Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 966EB379C4E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 03:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbhEKBxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 21:53:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:50994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229736AbhEKBxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 21:53:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C50D86147E;
        Tue, 11 May 2021 01:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1620697959;
        bh=425hPXrffouqTBt0PqY0MyZ5g9I8atvZ2WoYdvxm/Ng=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lFoZy9GgAJysOT6TX+G66+vJiH0SuYwyqKFvag7rZG8OVGWmnAmjzvqSkUmb64maF
         4DFAKtX/LiJqnxHD5wkzykY0N14v7idlf+WeYNK+H6hnIL66Sf9IjNFtnxaAKFcFRS
         tb9Vxj3w6W5dwjDkOiQYsBnQoH4nfGt3qXlgXFL8=
Date:   Mon, 10 May 2021 18:52:38 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mel Gorman <mgorman@suse.de>, Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 2/2] mm/vmalloc: Print a warning message first on
 failure
Message-Id: <20210510185238.787adc7378bc6d82262399d2@linux-foundation.org>
In-Reply-To: <20210510103342.GA2169@pc638.lan>
References: <20210509193844.2562-1-urezki@gmail.com>
        <20210509193844.2562-2-urezki@gmail.com>
        <YJg8QO2JXm0+8UH6@casper.infradead.org>
        <20210509200519.GA3016@pc638.lan>
        <YJhDpkpdUKiNEAnt@casper.infradead.org>
        <20210509212641.GA3220@pc638.lan>
        <20210510103342.GA2169@pc638.lan>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 May 2021 12:33:42 +0200 Uladzislau Rezki <urezki@gmail.com> wrote:

> Please find the v4 version of the patch that is in question:
> 
> >From 7e27e4ac8f299ae244e9e0e90e0292ae2c08d37d Mon Sep 17 00:00:00 2001
> From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
> Date: Sat, 8 May 2021 23:41:21 +0200
> Subject: [PATCH v4 1/1] mm/vmalloc: Print a warning message first on failure

Added, thanks.

Matthew has a point of course, but I do think that any console driver
which tries to allocate memory within the cotext of printk() is so
pathetic that it isn't worth compromising core code to cater for it...

