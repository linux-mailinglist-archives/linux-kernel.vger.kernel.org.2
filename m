Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC1938C555
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 12:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233736AbhEULAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 07:00:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:44578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232812AbhEULA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 07:00:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AA124611AD;
        Fri, 21 May 2021 10:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621594745;
        bh=zglt8lwAJE+2sgcpfmhLh1Vdez/O/6l085XdndnYaMc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EhCGmIp70pd2iRfQ0k5QrbyhXqOcny1ctvsqeNaf8YyvACq5p2EaO1cZibtf3CbJe
         XKaKFzdd7AvChLjyzijGN66EVltLMYSpmYFxv7aszO8B24581ZIipL4dlmG32eLg7y
         V76qnWx//5yZ6filfgOs9Y59YdUk9lqbdHNbMnVU=
Date:   Fri, 21 May 2021 12:59:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     laforge@gnumonks.org, arnd@arndb.de, akpm@osdl.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH] char: pcmcia: fix possible array index out of bounds in
 set_protocol()
Message-ID: <YKeSdYJiVMO9NKV4@kroah.com>
References: <20210521100705.28234-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521100705.28234-1-yukuai3@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 06:07:05PM +0800, Yu Kuai wrote:
> The length of array 'pts_reply' is 4, and the loop in set_protocol()
> will access array element from 0 to num_bytes_read - 1. Thus if
> io_read_num_rec_bytes() gets 'num_bytes_read' more than 4, it will
> cause index out of bounds errors.

And how can num_bytes_read be greater than 4?

Ah, it is tested, but you might want to error out if that happens, as
obviously something went wrong.

Do you have this hardware to test these changes?

thanks,

greg k-h
