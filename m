Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B97741360B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 17:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233986AbhIUPWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 11:22:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:54006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232704AbhIUPW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 11:22:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C04360F6D;
        Tue, 21 Sep 2021 15:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632237660;
        bh=p8GxsjLMAWzJgEzZyJz8W9RjaO+JnWtFIUgbDcG+KpY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wleWj54G9Yk5lr/L5BtBswf4SabM3tlyPl/6msteH/lmHno2G5vqZmcJYnYhEvT0a
         vyEI1LCY/28vCtRRZK1rGn1Oh0ElPR6VR1Duz8xsuzv5Z5Lsyku2WU5nteyAKXC7eI
         buc7/awPlttb8IbpRo498Vi9D98TUrc6Q69hbW8c=
Date:   Tue, 21 Sep 2021 17:20:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Longpeng(Mike)" <longpeng2@huawei.com>
Cc:     andraprs@amazon.com, lexnv@amazon.com, alcioa@amazon.com,
        linux-kernel@vger.kernel.org, arei.gonglei@huawei.com,
        kamal@canonical.com, pbonzini@redhat.com, sgarzare@redhat.com,
        stefanha@redhat.com, vkuznets@redhat.com,
        ne-devel-upstream@amazon.com
Subject: Re: [PATCH v2 3/4] nitro_enclaves: add test framework for the misc
 functionality
Message-ID: <YUn4WTDbU72tcyNY@kroah.com>
References: <20210921151039.1502-1-longpeng2@huawei.com>
 <20210921151039.1502-4-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210921151039.1502-4-longpeng2@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 11:10:38PM +0800, Longpeng(Mike) wrote:
> Add test framework for the misc functionality.

What is "the misc functionality"?

> 
> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
> ---
>  drivers/virt/nitro_enclaves/Kconfig        |  8 ++++++++
>  drivers/virt/nitro_enclaves/ne_misc_dev.c  | 27 +++++++++++++++++++++++++++
>  drivers/virt/nitro_enclaves/ne_misc_test.c | 17 +++++++++++++++++
>  3 files changed, 52 insertions(+)
>  create mode 100644 drivers/virt/nitro_enclaves/ne_misc_test.c

What changed from v1?

thanks,

greg k-h
