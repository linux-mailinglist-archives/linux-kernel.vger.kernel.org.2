Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 510F43F45F7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 09:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235212AbhHWHrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 03:47:21 -0400
Received: from verein.lst.de ([213.95.11.211]:46720 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235115AbhHWHrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 03:47:20 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D7E5F6736F; Mon, 23 Aug 2021 09:46:36 +0200 (CEST)
Date:   Mon, 23 Aug 2021 09:46:36 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     sishuaigong <sishuai@purdue.edu>
Cc:     jlbec@evilplan.org, hch@lst.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] configfs: fix a race in configfs_lookup()
Message-ID: <20210823074636.GA23822@lst.de>
References: <20210820214458.14087-1-sishuai@purdue.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210820214458.14087-1-sishuai@purdue.edu>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021 at 05:44:58PM -0400, sishuaigong wrote:
> When configfs_lookup() is executing list_for_each_entry(),
> it is possible that configfs_dir_lseek() is calling list_del().
> Some unfortunate interleavings of them can cause a kernel NULL
> pointer dereference error
> 
> Thread 1                  Thread 2
> //configfs_dir_lseek()    //configfs_lookup()
> list_del(&cursor->s_sibling);
>                           list_for_each_entry(sd, ...)
> 
> Fix this bug by using list_for_each_entry_safe() instead.

I don't see how list_for_each_entry_safe would save you there.
You need a lock to sychronize the two, list_for_each_entry_safe
only ensures the next entry is looked up before iterating over
the current one.
