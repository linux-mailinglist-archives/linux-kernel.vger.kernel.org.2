Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20A553EEFB4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240927AbhHQPzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:55:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:49038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240281AbhHQPtC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:49:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E254460F58;
        Tue, 17 Aug 2021 15:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629215290;
        bh=5H+7vJbliQsK8rs/+6iZ2HR7NrfuQkz/HOEYxQLMkoI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pK+MLTaqQaH4Vkn15pGfHDsShIQF/E8n2g8oBolYwxlF9M4WGXhND3rv0j/TUhOuD
         HiRo3zpGif/fRzNswPlKWa93QFr85bNRh1wNFt2EYzO0LpWZEiiG1iYNikRRNN/spO
         GeiaoWrNZS7RoMl81z0aN9Kx2cNsBbzlF/6gi1lY=
Date:   Tue, 17 Aug 2021 17:48:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xianting Tian <xianting.tian@linux.alibaba.com>
Cc:     jirislaby@kernel.org, amit@kernel.org, arnd@arndb.de,
        osandov@fb.com, linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/2] tty: hvc: pass DMA capable memory to put_chars()
Message-ID: <YRvaN0RwW03kkO1O@kroah.com>
References: <20210817132300.165014-1-xianting.tian@linux.alibaba.com>
 <20210817132300.165014-2-xianting.tian@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210817132300.165014-2-xianting.tian@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 09:22:59PM +0800, Xianting Tian wrote:
> We tested the patch, it worked normally.

Who is "we"?

> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>

Like I said before, I need another developer from your company to review
and sign-off on this patch (and the other one), before I am willing to
look at it, based on the previous mistakes that have happened here.

thanks,

greg k-h
