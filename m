Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDB138C5E6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 13:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbhEULoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 07:44:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:34984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231377AbhEULoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 07:44:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9D95860BBB;
        Fri, 21 May 2021 11:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621597372;
        bh=J0VUrpKHwPQKvndZSyuxTadg62+/NbNTAlMEwDH96ss=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EL8/lxHoWNSN4+k7XgTOnzTGKD4NJ4BMzB7SvQyn1/1OW27swEuxdopcWV4NsuSJA
         NtazeWnvgP9Do0paN+Zukqxrd/QawH+XOaWGd+IxFJEopqSQKtBqmRaFCPZs3AouIJ
         SrJbDHGdXKmUGhak2/kXL7O2LZHgijcbcfsHN9Xg=
Date:   Fri, 21 May 2021 13:42:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     laforge@gnumonks.org, arnd@arndb.de, akpm@osdl.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH] char: pcmcia: fix possible array index out of bounds in
 set_protocol()
Message-ID: <YKecuUjrQRAmBnss@kroah.com>
References: <20210521100705.28234-1-yukuai3@huawei.com>
 <YKeSdYJiVMO9NKV4@kroah.com>
 <23af0838-07c3-7113-4229-28cc82b07527@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23af0838-07c3-7113-4229-28cc82b07527@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 07:34:52PM +0800, yukuai (C) wrote:
> On 2021/05/21 18:59, Greg KH wrote:
> > On Fri, May 21, 2021 at 06:07:05PM +0800, Yu Kuai wrote:
> > > The length of array 'pts_reply' is 4, and the loop in set_protocol()
> > > will access array element from 0 to num_bytes_read - 1. Thus if
> > > io_read_num_rec_bytes() gets 'num_bytes_read' more than 4, it will
> > > cause index out of bounds errors.
> > 
> > And how can num_bytes_read be greater than 4?
> 
> Hi
> 
> Do you mean num_bytes_read here should never be greater than 4?
> 
> 544                 io_read_num_rec_bytes(iobase, &num_bytes_read);
> 545                 if (num_bytes_read >= 4) {
> 546                         DEBUGP(2, dev, "NumRecBytes = %i\n",
> num_bytes_read);
> 547                         break;


Like I said, it is tested if it is bigger, but then nothing happens if
that is true.  So try to error out here.

> > Ah, it is tested, but you might want to error out if that happens, as
> > obviously something went wrong.
> > 
> > Do you have this hardware to test these changes?
> 
> Sorry we don't have this hardware...

Ah, then I wouldn't worry about it, as odds are, no one else does either :)

thanks,

greg k-h
