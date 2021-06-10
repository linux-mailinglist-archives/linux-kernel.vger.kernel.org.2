Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4E0F3A2DA7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 16:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbhFJOEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 10:04:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:34828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231261AbhFJOEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 10:04:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A839E6109E;
        Thu, 10 Jun 2021 14:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623333715;
        bh=yrLAXXvUeS68GMJbgtmovi+jlNOK0o/BU4Tl7w2FEKw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nXFOXgEZ2ID7f6vJvZlzP+G+ZJOggPvOgfsTTe7ByEEWlPVVL3A67BMTaMvi1MIAN
         s9k9T1uTjSwN6o33WtFIA2v+Ag2YbSJ1QUcbo4elpP7np1zfSXIEwS83EIQIUQh0ey
         LjrHPvsu3bVAgnNeB1DOg0fAnirKg/j1yp6wG+7s=
Date:   Thu, 10 Jun 2021 16:01:52 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     "Zhangjiantao (Kirin, nanjing)" <water.zhangjiantao@huawei.com>,
        "Xuetao (kirin)" <xuetao09@huawei.com>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chenyu (U)" <chenyu56@huawei.com>,
        Caiyadong <caiyadong@huawei.com>,
        xuhaiyang <xuhaiyang5@hisilicon.com>
Subject: Re: [PATCH] xhci: solve a double free problem while doing s4
Message-ID: <YMIbUN3HkyKjn6am@kroah.com>
References: <1623244292-108534-1-git-send-email-xuetao09@huawei.com>
 <1428e2d7b7b74fccb3493384f96c521a@huawei.com>
 <e6ca9524-67a6-1eef-a44f-b9a1acd5205c@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e6ca9524-67a6-1eef-a44f-b9a1acd5205c@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 04:45:54PM +0300, Mathias Nyman wrote:
> On 9.6.2021 17.22, Zhangjiantao (Kirin, nanjing) wrote:
> > when system is doing s4, the process of xhci_resume may be as below:
> > 1、xhci_mem_cleanup
> > 2、xhci_init->xhci_mem_init->xhci_mem_cleanup(when memory is not enough).
> > xhci_mem_cleanup will be executed twice when system is out of memory.
> > xhci->port_caps is freed in xhci_mem_cleanup,but it isn't set to NULL.
> > It will be freed twice when xhci_mem_cleanup is called the second time.
> > 
> 
> Thanks, nice catch
> 
> > We got following bug when system resumes from s4:
> > 
> > kernel BUG at mm/slub.c:309!
> > Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
> > CPU: 0 PID: 5929 Tainted: G S   W   5.4.96-arm64-desktop #1
> > pc : __slab_free+0x5c/0x424
> > lr : kfree+0x30c/0x32c
> > 
> > Call trace:
> >  __slab_free+0x5c/0x424
> >  kfree+0x30c/0x32c
> >  xhci_mem_cleanup+0x394/0x3cc
> >  xhci_mem_init+0x9ac/0x1070
> >  xhci_init+0x8c/0x1d0
> >  xhci_resume+0x1cc/0x5fc
> >  xhci_plat_resume+0x64/0x70
> >  platform_pm_thaw+0x28/0x60
> >  dpm_run_callback+0x54/0x24c
> >  device_resume+0xd0/0x200
> >  async_resume+0x24/0x60
> >  async_run_entry_fn+0x44/0x110
> >  process_one_work+0x1f0/0x490
> >  worker_thread+0x5c/0x450
> >  kthread+0x158/0x160
> >  ret_from_fork+0x10/0x24
> > 
> > Signed-off-by: Tao Xue <xuetao09@huawei.com>
> 
> Checkpatch complains:
> ERROR: Missing Signed-off-by: line by nominal patch author 'Zhangjiantao (Kirin, nanjing) <water.zhangjiantao@huawei.com>'
> 
> Is Zhangjiantao (Kirin, nanjing)  the correct author? If yes can I add 
> "Signed-off-by: Zhangjiantao (Kirin, nanjing) <water.zhangjiantao@huawei.com>?

Please note that it is generally a bad thing for others to add someone
else's s-o-b line, as it is a legal agreement.  It is best for them to
send it instead.

thanks,

greg k-h
