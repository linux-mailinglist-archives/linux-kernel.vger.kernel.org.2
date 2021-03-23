Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 725A234585F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 08:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbhCWHNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 03:13:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:32844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229464AbhCWHND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 03:13:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BBAD161994;
        Tue, 23 Mar 2021 07:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616483583;
        bh=/bkXnzcEioDgUTLfrEo1w3KJfizHTxV+HOelPIhrg3o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KyYe87u6Lt+2hXKcw6R+IJv16lZIYDC3lQwO9twl8kjCXhEP+llqkqvna25LnQ3xr
         vtNid46f2+0s+5Lj7DrawdeJI7rG61voBTQkRLzxsNdpJacS/SYN9N+eIEFr7/yucT
         COITUXxVtbeuCE0Cb02D6Evhnatlx6BGuQH7/TmQ=
Date:   Tue, 23 Mar 2021 08:13:00 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        colin.king@canonical.com, davem@davemloft.net,
        lee.jones@linaro.org, arnd@arndb.de, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: wimax: Mundane typo fixes
Message-ID: <YFmU/I+KHcci42VB@kroah.com>
References: <20210323010607.3918516-1-unixbhaskar@gmail.com>
 <36821877-7a6c-9a15-4e94-cb657ef29dad@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36821877-7a6c-9a15-4e94-cb657ef29dad@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 09:14:43PM -0700, Randy Dunlap wrote:
> On 3/22/21 6:06 PM, Bhaskar Chowdhury wrote:
> > 
> > s/procesing/processing/
> > s/comunication/communication/
> > 
> > Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> 
> drivers/staging/wimax/ is in the process of being deleted.

It's already gone from my tree, and should be gone from linux-next as
well.

thanks,

greg k-h
