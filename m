Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5245C44BCA7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 09:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbhKJIP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 03:15:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:35426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229756AbhKJIP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 03:15:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 37ACC61057;
        Wed, 10 Nov 2021 08:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636531959;
        bh=hOElsn9o0XHWX7llXiy9jQT7NSmeSlmSgpbdWccwyac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XAVOdcMtoGgoVD6OdatAhX/b33DPVo8aDz+DlDTxkyceQH5V+I6VQ6Wqh8Z2d9sIC
         ucg36FIFR70uVzkOMOU1RWf6JiZzxksUteoqaPcekKKxCdjYrJPevQsWOrpcRd28Qr
         pPyyfLfb7J67VIpsnAFnTqmthrkJsiFWuTZa/72g=
Date:   Wed, 10 Nov 2021 09:12:37 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     cgel.zte@gmail.com
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        straube.linux@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] staging: r8188eu: remove unneeded variable
Message-ID: <YYt+9d9Jn0SBocVC@kroah.com>
References: <20211109115307.133100-1-deng.changcheng@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109115307.133100-1-deng.changcheng@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2021 at 11:53:07AM +0000, cgel.zte@gmail.com wrote:
> From: Changcheng Deng <deng.changcheng@zte.com.cn>
> 
> Fix the following coccicheck review:
> ./drivers/staging/r8188eu/core/rtw_cmd.c: 66: 5-8: Unneeded variable
> 
> Remove unneeded variable used to store return value.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>

But this is coccicheck finding the issue, not the "Zeal Robot", right?
A script that just runs scripts already in the kernel tree does not mean
that an entity is deserving of an email address and reported-by tag,
right?

thanks,

greg k-h
