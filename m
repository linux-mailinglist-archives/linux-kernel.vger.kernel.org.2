Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 810873F948F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 08:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238494AbhH0Gxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 02:53:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:52532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229611AbhH0Gxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 02:53:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E5C9B60EE5;
        Fri, 27 Aug 2021 06:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630047162;
        bh=B+mVYYKfDGlL4DqFrbOpqVvGn4+tX4m1MV+mH78PBew=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wm/p9oBbZLqRVCXOL2ucMQ+S+fYUvCW9eNgExcmPRMgAlNp+Sv0X3JQ3VTdSYy2eg
         xOmmbB/Dj0gdl/4RfdTF3gdIYDfvqzGSQum7Ey6CHjxCcy9CBXS7Nre7KJJWWEBTbj
         Qo9oqq1hZv1Z4ds1KGdr9KjJKiYFqni97Pa9GNvc=
Date:   Thu, 26 Aug 2021 20:55:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wenlong Zhang <yixiaonn@gmail.com>
Cc:     fabioaiuto83@gmail.com, ross.schm.dev@gmail.com,
        marcocesati@gmail.com, insafonov@gmail.com, cyruscyliu@gmail.com,
        yajin@vm-kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: rtl8723bs: prevent ->ssid overflow in
 rtw_wx_set_scan()
Message-ID: <YSfjtZsISLH6cktF@kroah.com>
References: <20210826154622.55361-1-yixiaonn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210826154622.55361-1-yixiaonn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2021 at 11:46:22PM +0800, Wenlong Zhang wrote:
> Commit 74b6b20df8cf ("staging: rtl8188eu: prevent ->ssid overflow in rtw_wx_set_scan()")
> fixed up the staging driver rtl8188eu by adding another check 
> to prevent writing beyond the end of the ->ssid[] array.
> 
> Resolve this by properly fixing up the rtl8723bs driver's version of
> rtw_wx_set_scan() 

Odd trailing whitespace :(

> 
> Reported-by: Wenlong Zhang(iLifetruth) <yixiaonn@gmail.com>
> Fixes: 74b6b20df8cf ("staging: rtl8188eu: prevent ->ssid overflow in rtw_wx_set_scan()")
> 
> Signed-off-by: Wenlong Zhang <yixiaonn@gmail.com>

No need for a blank line here.

Also, you don't need a reported-by: if you are the author and sign off
on the patch, that would just be implied :)

Can you fix this up and resend a v2?

thanks,

greg k-h
