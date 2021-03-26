Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C179834AC70
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 17:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbhCZQUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 12:20:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:37026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230240AbhCZQUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 12:20:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E7FE60238;
        Fri, 26 Mar 2021 16:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616775643;
        bh=sGeQMMUyCKfthnoYlkyFne9XUQZHWtH80Xz18/AFaVc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DqUu5ia43uoH46rVofPH4b+KKApSPiR5P5JZUf6i3lll9KknyEQApOOGxaO52OooW
         NxZXIJZuj7EFkyD3g75PBc9rGcqQXR3OkPwFtchUnLVMHeiyVdM05HmXEURxXAZzrw
         gSnqx0CsqH5i6PE7B4KROUi15iD8EWKxOp5tEli0=
Date:   Fri, 26 Mar 2021 17:20:40 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     dan.carpenter@oracle.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fixes: 65f183001f6e (staging: rtl8723bs: remove unused
 code blocks conditioned by never set CONFIG_INTERRUPT_BASED_TXBCN*)
Message-ID: <YF4J2JVz1tHiFsGJ@kroah.com>
References: <YF3qSsH/3vRy7BRy@kroah.com>
 <20210326155252.6746-1-fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210326155252.6746-1-fabioaiuto83@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 04:52:52PM +0100, Fabio Aiuto wrote:
> fix indentation broken by patch removing conditional
> code blocks checked by unused
> CONFIG_INTERRUPT_BASED_TXBCN family defines
> 
> https://lore.kernel.org/r/9157000821fd6febf25566b8c712fad1995c7c78.1615907632.git.fabioaiuto83@gmail.com

No, please use a "Fixes:" tag that points to the git commit id that this
commit fixes.  Look in the kernel tree for loads of examples of how to
do this, and it's even documented in the Documentation/ process guide as
well.

thanks,

greg k-h
