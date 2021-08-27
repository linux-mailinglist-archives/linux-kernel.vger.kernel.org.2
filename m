Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 711CD3F9B19
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 16:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234358AbhH0Os1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 10:48:27 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57884 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbhH0Os0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 10:48:26 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 16A662022C;
        Fri, 27 Aug 2021 14:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630075657; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jMmBtD+OA80W8GrXQh+AfV9EwTPhieb7P13hnbE8+GY=;
        b=ppSTVxbjmrq6GEJhGXt9sjGJwKurJTnS8GlaswWRb/doqUiAEFJUk+kStt/YI37O0coa1O
        ue4xZv5bVCrZCy79eUgzNp38a9657Dwc7aC92Oq1YRcrfBx00mI3189AOIhZ+/MmCw0NTC
        f5lvItL8k7QrvUEPaRVPLIYYkcW3e7E=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B7132A3B91;
        Fri, 27 Aug 2021 14:47:36 +0000 (UTC)
Date:   Fri, 27 Aug 2021 16:47:33 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     chris@chrisdown.name, senozhatsky@chromium.org,
        rostedt@goodmis.org, john.ogness@linutronix.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] printk/index: Fix -Wunused-function warning
Message-ID: <YSj7Bfw2Ps5cOsu8@alley>
References: <20210804130105.18732-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210804130105.18732-1-yuehaibing@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2021-08-04 21:01:05, YueHaibing wrote:
> If CONFIG_MODULES is n, we got this:
> 
> kernel/printk/index.c:146:13: warning: ‘pi_remove_file’ defined but not used [-Wunused-function]
> 
> Move it inside #ifdef block to fix this warning.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

The patch has been committed into printk/linux.git,
branch for-5.15-printk-index.

Best Regards,
Petr
