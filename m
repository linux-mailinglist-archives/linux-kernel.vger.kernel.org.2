Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4556844F388
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 15:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235755AbhKMOOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 09:14:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:37964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231672AbhKMOOI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 09:14:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C153460F51;
        Sat, 13 Nov 2021 14:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636812676;
        bh=t9CShlrauEAsztx26mv4Lvg2o8CuZu2WW6wTb8AXz3c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D6coJK3qOSEpAJVLfCmIWRKcIws9pFpiWpIc46Kb16AnBUH7uUcyXodHlykJXvyJC
         8T2egcJDjF+uPOzkQlLBgkv9yzw5dWN/JXW0pdNHNBhYL3Tmwkx1hJhOq30cDVaKs1
         68Im7ohvYMj/h5aZ4wOrwjJbqdi2m4aQqNpOwWJ4=
Date:   Sat, 13 Nov 2021 15:11:13 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Liu Junqi <liujunqi@pku.edu.cn>
Cc:     linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: mt7621-dma: reindent to avoid '(' at the end
 of line
Message-ID: <YY/HgcL/iF09sNcQ@kroah.com>
References: <20211113135952.365607-1-liujunqi@pku.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211113135952.365607-1-liujunqi@pku.edu.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 13, 2021 at 09:59:52PM +0800, Liu Junqi wrote:
> A change to make the code more like typical coding style.
> 
> Signed-off-by: Liu Junqi <liujunqi@pku.edu.cn>
> ---
> I'm a kernel newbie and it's my first time to send a patch following the "Write and Submit your first Linux kernel Patch" video on youtube.
> The first version was rejected because of putting a '*' at the beginning of a line, and this version is exactly what Joe Perches advised in the reply to the original patch email.
> Please let me know if I got anything wrong ^_^

Take a look at the link that my patch-bot told youto read.  It will show
you how to write a "this changed in this version" type of text below the
--- line.

Please do that and try again.

thanks,

greg k-h
