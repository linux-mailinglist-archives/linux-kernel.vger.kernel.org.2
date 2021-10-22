Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C821437456
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 11:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbhJVJJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 05:09:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:40832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232060AbhJVJJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 05:09:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D8A1660F12;
        Fri, 22 Oct 2021 09:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634893631;
        bh=C511Ji1funobqNIOfA8ILUgvJjDmfOoWhWOgm02gUls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y9xxuG1u/piPP4mDYAXsWlwhzcBvsZmVdDUV3jseLJSOavlIOCaukzhg8abWaERJK
         PmFSeg0aBouwM/KWJCDOCJAv7Aylilt6UkfUIGbOFloN2DcbZQQZoDIGJyeKOx1Zzd
         quYnEt2Ib26+zd6hYS+xqgsqTJfq+9KTDYhN3aAM=
Date:   Fri, 22 Oct 2021 11:07:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kai Song <songkai01@inspur.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        straube.linux@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: Use memdup_user instead of
 kmalloc/copy_from_user
Message-ID: <YXJ/PU/oo9dRwTQr@kroah.com>
References: <20211022025555.6612-1-songkai01@inspur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211022025555.6612-1-songkai01@inspur.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 10:55:55AM +0800, Kai Song wrote:
> Use memdup_user helper instead of open-coding to simplify
> the code.
> 
> Signed-off-by: Kai Song <songkai01@inspur.com>
> ---
>  drivers/staging/r8188eu/os_dep/ioctl_linux.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)

Someone sent this just before you did, sorry:
	https://lore.kernel.org/r/20211021122015.6974-1-wanjiabing@vivo.com

