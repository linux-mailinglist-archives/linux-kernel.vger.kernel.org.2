Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3303C2B6F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 00:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbhGIWgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 18:36:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:53974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229542AbhGIWgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 18:36:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BFCA4613B0;
        Fri,  9 Jul 2021 22:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1625869996;
        bh=vB6UUDCayTxmA7o4zqOKFTp2vJ9b5CMA+bhTA3+T6UY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oIhUGKASaH0OdOwF/jv5ekgOeIjfDYZ4SnnN43ojN2s7HF2+TkRCDxTG4tSwWzwN1
         PidrWQdd+CRTVHnLi5TAImaovQJ6KRAnnbzDyhb80y/hQARBuWd6cfAjx/np8C6S0F
         o9lKhO5RnWM5z6oC6UQ0Y2BtROjGmca7lB+3lKVQ=
Date:   Fri, 9 Jul 2021 15:33:16 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yang Huan <link@vivo.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, kernel@vivo.com,
        syzbot+b07d8440edb5f8988eea@syzkaller.appspotmail.com,
        Wang Qing <wangqing@vivo.com>
Subject: Re: [PATCH] mm/page_alloc: fix alloc_pages_bulk/set_page_owner
 panic on irq disabled
Message-Id: <20210709153316.a81214a453920dbcc2714ae6@linux-foundation.org>
In-Reply-To: <20210709090600.9804-1-link@vivo.com>
References: <20210709090600.9804-1-link@vivo.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  9 Jul 2021 17:05:59 +0800 Yang Huan <link@vivo.com> wrote:

> The problem is caused by set_page_owner alloc memory to save stack with
> GFP_KERNEL in local_riq disabled.
> So, we just can't assume that alloc flags should be same with new page,
> let's split it. But in most situation, same is ok, in alloc_pages_bulk,
> input GFP_ATOMIC when prep_new_pages

Please more fully describe the bug which is being fixed.  A link to the
sysbot report would be helpful.  I assume there was a stack backtrace
available?  Seeing the will help others to understand the bug.

And if you are able to identify the patch which introduced the bug, a
Fixes: tag would be helpful as well.

Thanks.

