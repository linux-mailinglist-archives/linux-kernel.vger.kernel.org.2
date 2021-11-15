Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB59F4504E9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 14:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbhKONHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 08:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbhKONHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 08:07:19 -0500
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5BBC061714;
        Mon, 15 Nov 2021 05:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=In-Reply-To:Content-Type:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description; bh=ZvlxiZi22YI5QJjEBQbglCTQJrc3Zs1nvZwvw8W6NyU=; b=RnUp/
        qJsZs7gxvSLGrLo0v/LyO90upc/Kgl6GoKWyDhqiDERgGG1RtHCzBN66XZ1IvpmHtJstXu+pyRAO1
        NEDupIWvTZmkWasB5JK8cfXJFfejDEXGREpu9nxktpudK/g+mHns+LTe1pTSUk8P+5o/TfBwQNw0+
        vGbM7GEEkLc9e35CHshXfhZnvXW6h/COPK3IcLui5XUMdatqL2+dW+XA/edWUVf5GGyl83Tdi4yb+
        qaWYJU2Ajps0AJA/OgKEddhm8+yjs0tYH/Wk+retAC0CYYKDVeAtolynjINQdXUjvNX+YXXCK2UdQ
        V1XOc0h5+zbaKbJxd7aXg9l8QJ4/g==;
Received: from [81.174.171.191] (helo=donbot)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1mmbeh-0005p1-Q7; Mon, 15 Nov 2021 13:04:15 +0000
Date:   Mon, 15 Nov 2021 13:04:14 +0000
From:   John Keeping <john@metanate.com>
To:     Pavankumar Kondeti <quic_pkondeti@quicinc.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Axboe <axboe@kernel.dk>, Jack Pham <jackp@codeaurora.org>,
        Peter Chen <peter.chen@nxp.com>,
        kernel test robot <lkp@intel.com>,
        Wei Ming Chen <jj251510319013@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Dean Anderson <dean@sensoray.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>
Subject: Re: [PATCH v3] usb: gadget: f_fs: Use stream_open() for endpoint
 files
Message-ID: <YZJazkgZWKCg52iZ@donbot>
References: <YY4OT37EoO23s+Hm@kroah.com>
 <1636712682-1226-1-git-send-email-quic_pkondeti@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1636712682-1226-1-git-send-email-quic_pkondeti@quicinc.com>
X-Authenticated: YES
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2021 at 03:54:40PM +0530, Pavankumar Kondeti wrote:
> Function fs endpoint file operations are synchronized via an interruptible
> mutex wait. However we see threads that do ep file operations concurrently
> are getting blocked for the mutex lock in __fdget_pos(). This is an
> uninterruptible wait and we see hung task warnings and kernel panic
> if hung_task_panic systcl is enabled if host does not send/receive
> the data for long time.
> 
> The reason for threads getting blocked in __fdget_pos() is due to
> the file position protection introduced by the commit 9c225f2655e3
> ("vfs: atomic f_pos accesses as per POSIX"). Since function fs
> endpoint files does not have the notion of the file position, switch
> to the stream mode. This will bypass the file position mutex and
> threads will be blocked in interruptible state for the function fs
> mutex.
> 
> It should not affects user space as we are only changing the task state
> changes the task state from UNINTERRUPTIBLE to INTERRUPTIBLE while waiting
> for the USB transfers to be finished. However there is a slight change to
> the O_NONBLOCK behavior. Earlier threads that are using O_NONBLOCK are also
> getting blocked inside fdget_pos(). Now they reach to function fs and error
> code is returned. The non blocking behavior is actually honoured now.
> 
> Signed-off-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>

It might be worth noting that this also changes pread & pwrite which
will now return ESPIPE instead of succeeding but ignoring the offset
argument.

Those operations have always been broken and I doubt anyone is using
them, but there is slightly more user visible change than just the task
state.

With that said, I think this is a good change, so:

Reviewed-by: John Keeping <john@metanate.com>

> ---
> v3:
> - Added more background and user space impact in the commit description
> 
> v2:
> - Removed Change-Id tag
> 
>  drivers/usb/gadget/function/f_fs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
> index e20c19a..3c584da 100644
> --- a/drivers/usb/gadget/function/f_fs.c
> +++ b/drivers/usb/gadget/function/f_fs.c
> @@ -614,7 +614,7 @@ static int ffs_ep0_open(struct inode *inode, struct file *file)
>  	file->private_data = ffs;
>  	ffs_data_opened(ffs);
>  
> -	return 0;
> +	return stream_open(inode, file);
>  }
>  
>  static int ffs_ep0_release(struct inode *inode, struct file *file)
> @@ -1154,7 +1154,7 @@ ffs_epfile_open(struct inode *inode, struct file *file)
>  	file->private_data = epfile;
>  	ffs_data_opened(epfile->ffs);
>  
> -	return 0;
> +	return stream_open(inode, file);
>  }
>  
>  static int ffs_aio_cancel(struct kiocb *kiocb)
> -- 
> 2.7.4
> 
