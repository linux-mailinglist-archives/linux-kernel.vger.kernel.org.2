Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1642F34A93B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 15:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbhCZOHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 10:07:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:43986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229779AbhCZOGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 10:06:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5307161A24;
        Fri, 26 Mar 2021 14:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616767608;
        bh=NpksNz9lLbsAzvUd77qXzLFZ99XN7ephdBncdUikFNc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T4HbYzX+U6lZc3JTBVKSLzrAltmTmG3rht0aUgXUpbPQQkj9ARzmcbuxn3yeYu4SB
         SFtyZH46CvZwsxuLLOW4/FO2ho9BdbQV07w2X+y6CUwp3PSH4vzYkYnQ621PxA/7ps
         fkrf4zPKnh+L/Uhajyj7IJSAJ85T5GCaIES7xcpw=
Date:   Fri, 26 Mar 2021 15:06:02 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     dan.carpenter@oracle.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: fix indentation broken by previous
 patch
Message-ID: <YF3qSsH/3vRy7BRy@kroah.com>
References: <YFxQSJXXQ4dFPGS4@mwanda>
 <20210326091716.6599-1-fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210326091716.6599-1-fabioaiuto83@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 10:17:16AM +0100, Fabio Aiuto wrote:
> fix indentation broken by patch removing conditional
> code blocks checked by unused
> CONFIG_INTERRUPT_BASED_TXBCN family defines
> 
> https://lore.kernel.org/r/9157000821fd6febf25566b8c712fad1995c7c78.1615907632.git.fabioaiuto83@gmail.com
> 
> Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>

"previous patch" is not very descriptive :(

Please put a "Fixes:" tag in here to point out exactly what commit this
fixed, and maybe a "Reported-by:" tag if someone pointed this out to
you...

thanks,

greg k-h
