Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C48344E0BA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 04:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbhKLDUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 22:20:30 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:27215 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbhKLDU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 22:20:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1636687060; x=1668223060;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R+0x19yaXzzJhuzEP8YP4krwjPAk5az9d5FAImXB5CA=;
  b=xJzRw8t75AjXF5U9CgvPB+bz+6RJH0vAv7zs9fkARJsoKvaTePhKyJGP
   O3KZDbcKIsbOnnZfbvR925KgdVhg8vCfGVAJ4vO/K/ebTJr6a0y+c7dpQ
   PyYhM2xi6w/6v8Pu3xFs3dxAsg8OdVwz34jDklqz+oE3nRbpqnDHII1bc
   E=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 11 Nov 2021 19:17:39 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 19:17:39 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Thu, 11 Nov 2021 19:17:38 -0800
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 11 Nov 2021 19:17:34 -0800
Date:   Fri, 12 Nov 2021 08:47:30 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Jack Pham <jackp@codeaurora.org>,
        Peter Chen <peter.chen@nxp.com>,
        Wesley Cheng <wcheng@codeaurora.org>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] usb: gadget: f_fs: Use stream_open() for endpoint
 files
Message-ID: <20211112031730.GB11612@hu-pkondeti-hyd.qualcomm.com>
References: <20211111120636.GA11612@hu-pkondeti-hyd.qualcomm.com>
 <1636632958-22802-1-git-send-email-quic_pkondeti@quicinc.com>
 <YY0WvD57FGums0a8@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YY0WvD57FGums0a8@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Thu, Nov 11, 2021 at 02:12:28PM +0100, Greg Kroah-Hartman wrote:
> On Thu, Nov 11, 2021 at 05:45:56PM +0530, Pavankumar Kondeti wrote:
> > Function fs endpoint files does not have the notion of file position.
> > So switch to stream like functionality. This allows concurrent threads
> > to be blocked in the ffs read/write operations which use ffs_mutex_lock().
> > The ffs mutex lock deploys interruptible wait. Otherwise, threads are
> > blocking for the mutex lock in __fdget_pos(). For whatever reason, ff the
> > host does not send/receive data for longer time, hung task warnings
> > are observed.
> 
> So the current code is broken?  What commit caused it to break?

This is not a serious bug that can affect functionality. if hung_task_panic
sysctl is not enabled, probably nobody would notice this except an obscure
warning in the kernel dmesg log. It is all about the task state while
it is blocked for I/O. The function fs code uses interruptible wait but
we are not reaching there and getting blocked at VFS layer due to the below
commit introduced from 3.14 kernel.

commit 9c225f2655e36a470c4f58dbbc99244c5fc7f2d4
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon Mar 3 09:36:58 2014 -0800

    vfs: atomic f_pos accesses as per POSIX

    Our write() system call has always been atomic in the sense that you get
    the expected thread-safe contiguous write, but we haven't actually
    guaranteed that concurrent writes are serialized wrt f_pos accesses, so
    threads (or processes) that share a file descriptor and use "write()"
    concurrently would quite likely overwrite each others data.

We have uncovered this issue via customer bug report which happens very rarely.
It only happens like when host does not pull the data for a very long time.
Since function fs does not care about file position, thought stream_open()
is the right thing to do here.

> 
> Doesn't this change cause a change in behavior for existing userspace
> tools, or will they still work as-is?
> 

I don't think it affects user space as it just changes the task state from 
UNINTERRUPTIBLE to INTERRUPTIBLE while waiting for the USB transfers to
finish. However there is a slight change to the O_NONBLOCK behavior.
Earlier threads that are using O_NONBLOCK are also getting blocked
inside fdget_pos(). Now they reach to f_fs and error code is returned. IOW,
we are actually fixing the non blocking behavior here.

PS: I believe you asked these questions since the commit description does not
cover it. I can happily add all this information to it. Since it is all historical,
I did not mention it.

Thanks,
Pavan
