Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17ABC352AF3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 15:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235292AbhDBNNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 09:13:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:60814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229932AbhDBNNI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 09:13:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E890610D0;
        Fri,  2 Apr 2021 13:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617369187;
        bh=6s386t7wv+jQL2h8vfvhfbkZelFx7Zc+YwLffFZl358=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HVwRJVs0YAMk/2oKgl7x2MMEgDkXvurhaE4cpMDP4sw3b5GR29RMLKBAqfqsBPcne
         LfjNkZcyv0bBAAwzgBuNsFL49aOKwrRMlhf4TPk1nwKR3CNmLgKQ8zhrUo9PDX9Wtt
         oTQfeDVp27IolUhaO9ry1slsB/nzCDUL/y1fBSNA=
Date:   Fri, 2 Apr 2021 15:13:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, speakup@linux-speakup.org
Subject: Re: [PATCH -next] staging/speakup: Switch to kmemdup_nul()
Message-ID: <YGcYYPhjd/ej3NaP@kroah.com>
References: <20210402092111.2443601-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210402092111.2443601-1-yangyingliang@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02, 2021 at 05:21:11PM +0800, Yang Yingliang wrote:
> Use kmemdup_nul() helper instead of open-coding to
> simplify the code.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/accessibility/speakup/i18n.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Your subject line is very odd, why does it have "staging"?

Your robot is not doing well these days...

greg k-h
