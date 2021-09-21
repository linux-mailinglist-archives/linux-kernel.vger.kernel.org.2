Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2173541360A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 17:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233974AbhIUPWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 11:22:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:53824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231196AbhIUPWH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 11:22:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 23FAA60F6D;
        Tue, 21 Sep 2021 15:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632237638;
        bh=WvJINhXcisUZky+HUN9DxgfI9FXGZMjUYALHdqdsI54=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C9Etw3YtCOWVw9JzdGgLkkidUQJqj78YNO0MHYMvVWqv58rO0GTMuE1tWD4MyhWJy
         +71NUacvJfBvgBdZpp02JiXZXoc+/HtcolUs5uztcIGUA780GZ9cyyWLgvKjpQGp1s
         YuTkcsGAMnqYQDhQXem6YbirKQJB8mvsiHp8o2oM=
Date:   Tue, 21 Sep 2021 17:20:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Longpeng(Mike)" <longpeng2@huawei.com>
Cc:     andraprs@amazon.com, lexnv@amazon.com, alcioa@amazon.com,
        linux-kernel@vger.kernel.org, arei.gonglei@huawei.com,
        kamal@canonical.com, pbonzini@redhat.com, sgarzare@redhat.com,
        stefanha@redhat.com, vkuznets@redhat.com,
        ne-devel-upstream@amazon.com
Subject: Re: [PATCH v2 1/4] nitro_enclaves: merge contiguous physical memory
 regions
Message-ID: <YUn4Qq/vrqRai/FB@kroah.com>
References: <20210921151039.1502-1-longpeng2@huawei.com>
 <20210921151039.1502-2-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210921151039.1502-2-longpeng2@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 11:10:36PM +0800, Longpeng(Mike) wrote:
> There can be cases when there are more memory regions that need to be
> set for an enclave than the maximum supported number of memory regions
> per enclave. One example can be when the memory regions are backed by 2
> MiB hugepages (the minimum supported hugepage size).
> 
> Let's merge the adjacent regions if they are physical contiguous. This
> way the final number of memory regions is less than before merging and
> could potentially avoid reaching maximum.
> 
> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
> ---
>  drivers/virt/nitro_enclaves/ne_misc_dev.c | 87 ++++++++++++++++++++-----------
>  1 file changed, 58 insertions(+), 29 deletions(-)
> 

What changed from v1?
