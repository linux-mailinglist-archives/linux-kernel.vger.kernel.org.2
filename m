Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19AB73D05B2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 01:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbhGTWxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 18:53:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:53086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236298AbhGTWrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 18:47:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 125C661165;
        Tue, 20 Jul 2021 23:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1626823692;
        bh=pZ4VoRnokIR9onzVreo9fLmob6Y3sBGkp5Ds0EVJjhM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EdBQodRejK5wyrYq6wz0piYROUp3iT+9dF45XPFy0WI1yovjAjDI+hqIkKGatheg4
         gcKjOQMvS9xBmleIESd4gZKxIvF/lYjjsQMSMEsP6tHz0dXWhmirIvQK1S5meOSqCp
         eRDoig4pKc/LzI07o+djctGoZj3GTL7Aa5SPdG/o=
Date:   Tue, 20 Jul 2021 16:28:10 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Chen Wandun <chenwandun@huawei.com>
Cc:     <0x7f454c46@gmail.com>, <wangkefeng.wang@huawei.com>,
        <weiyongjun1@huawei.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/mremap: fix memory account on do_munmap() failure
Message-Id: <20210720162810.e4710eebca48e9dc8ce2fa4d@linux-foundation.org>
In-Reply-To: <20210717101942.120607-1-chenwandun@huawei.com>
References: <20210717101942.120607-1-chenwandun@huawei.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Jul 2021 18:19:42 +0800 Chen Wandun <chenwandun@huawei.com> wrote:

> mremap will account the delta between new_len and old_len in
> vma_to_resize, and then call move_vma when expanding an existing
> memory mapping. In function move_vma, there are two scenarios when
> calling do_munmap:
> 1. move_page_tables from old_addr to new_addr success
> 2. move_page_tables from old_addr to new_addr fail
> 
> In first scenario, it should account old_len if do_munmap fail,
> because the delta has already been accounted.
> 
> In second scenario, new_addr/new_len will assign to old_addr/old_len
> if move_page_table fail, so do_munmap is try to unmap new_addr actually,
> if do_munmap fail, it should account the new_len, because error code
> will be return from move_vma, and delta will be unaccounted.
> What'more, because of new_len == old_len, so account old_len also is
> OK.
> 
> In summary, account old_len will be correct if do_munmap fail.

Sorry, but I'm having trouble following that description.  Dmitry, could
you please review this change and then assist in clarifying the
changelog text?

Also, could it be argued that we're doing this in the wrong place? 
Should it be the responsibility of do_munmap() to fix up the accounting
if it is going to return an error?  Rather than expecting the
do_munmap() caller to fix up do_munmap()'s mess?

Thirdly, is the comment in there true?  Does this accounting error only
occur due to ENOMEM?  If that is the case then I am inclined not to
backport this fix into -stable kernels, as the error is so unlikely to
be triggered.  Thoughts on this?

