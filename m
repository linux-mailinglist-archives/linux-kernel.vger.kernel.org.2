Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D49E35A0C9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 16:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233933AbhDIOMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 10:12:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:55408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233019AbhDIOMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 10:12:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E41B961007;
        Fri,  9 Apr 2021 14:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617977560;
        bh=H+p7sz3QwAUi4pf0kx+inkj6rVgLwICxUqcknon1Udg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eQwpOMyilhqv0pZzlwG6vkrbIBcneuoQGW6GHVmTPyK+InAaaOF8GX37rjd//lQf2
         FXhWFn90m3mddKPRoWe70Zjdqv18KlRMFX7c5LX7cwo7+zuF5vCDWCpMrnb0YFeSBA
         OXPYfKYlH6YCV9OjCDMh8eLSP0ez43bGmDn51L9A=
Date:   Fri, 9 Apr 2021 16:12:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH] staging: rtl8723bs: Change the type
 and use of a variable
Message-ID: <YHBg1Sy2509vBtrA@kroah.com>
References: <20210408111942.19411-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408111942.19411-1-fmdefrancesco@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 01:19:42PM +0200, Fabio M. De Francesco wrote:
> Change the type of fw_current_in_ps_mode from u8 to bool, because
> it is used everywhere as a bool and, accordingly, it should be
> declared as a bool. Shorten the controlling
> expression of an 'if' statement.
> 
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  drivers/staging/rtl8723bs/hal/hal_intf.c        | 2 +-
>  drivers/staging/rtl8723bs/include/rtw_pwrctrl.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

I now have 3 patches, I think, for this same driver, from you, and I
have no idea what order they should be applied in.

So I'm going to drop them all.  Can you please resend me a patch series,
with all of the outstanding patches sent to me from you that I have not
applied yet, so that I know which ones to look at and what order to
apply them in?

thanks,

greg k-h
