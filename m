Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD33377C78
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 08:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbhEJGnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 02:43:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:58586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229608AbhEJGnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 02:43:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C0E3A6142D;
        Mon, 10 May 2021 06:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620628934;
        bh=cbIYQxBc0Q9FjBe4AcfYtRoFvrNz0aGtnSSUr4mptpk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x9nHUXYNFg/mQo6exGZb8ZlkWCUPtScBsaRE8sur0bEwr9Q7yhoBWQCXhVZoitBrO
         F6Om0mVodKN8nXFlCjXISvdImbvpQPVdNfS05ODrfH7qKqXJDq3jsvs+vV2YlBSUB+
         eSS1XFcJcKmkUCxdkKFh4HVeGxUDATTDZtgQE8z0=
Date:   Mon, 10 May 2021 08:42:11 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Deepak R Varma <mh12gx2825@gmail.com>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Ian Abbott <abbotti@mev.co.uk>,
        Qiheng Lin <linqiheng@huawei.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] comedi: remove editor modelines and cruft (again)
Message-ID: <YJjVw/N7nRlGTVMU@kroah.com>
References: <20210510063450.412055-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210510063450.412055-1-masahiroy@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 03:34:50PM +0900, Masahiro Yamada wrote:
> Commit fa60ce2cb450 ("treewide: remove editor modelines and cruft")
> is different from what I submitted.
> 
> My original patch [1] did treewide cleanups including the comedi driver.
> 
> Unfortunately, commit 8ffdff6a8cfb ("staging: comedi: move out of staging
> directory") moved drivers/staging/comedi/ to drivers/comedi/ before my
> patch landed on Linus' tree from akpm tree.
> 
> If Andrew Morton had used Git, 'git merge' would have resolved such file
> moves properly without any manual intervention.
> 
> Patches in akpm tree often get broken in his quilt workflows, and then
> people end up with sending fixup patches.
> 
> [1] https://lkml.kernel.org/r/20210324054457.1477489-1-masahiroy@kernel.org
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
> I really hope Andrew Morton will use Git.

Nah, quilt is really really good :)

I'll take this in my tree, no worries.

greg k-h
