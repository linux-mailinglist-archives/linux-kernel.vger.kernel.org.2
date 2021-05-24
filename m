Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50E0D38F356
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 20:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233190AbhEXS4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 14:56:51 -0400
Received: from netrider.rowland.org ([192.131.102.5]:40331 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S232983AbhEXS4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 14:56:49 -0400
Received: (qmail 1333070 invoked by uid 1000); 24 May 2021 14:55:20 -0400
Date:   Mon, 24 May 2021 14:55:20 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Guido Kiener <Guido.Kiener@rohde-schwarz.com>,
        dave penkler <dpenkler@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+e2eae5639e7203360018@syzkaller.appspotmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        USB list <linux-usb@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [syzbot] INFO: rcu detected stall in tx
Message-ID: <20210524185520.GA1332625@rowland.harvard.edu>
References: <d673611ca53f42a3a629eb051cabc6eb@rohde-schwarz.com>
 <20210519173545.GA1173157@rowland.harvard.edu>
 <12088413-2f7d-a1e5-5e8a-25876d85d18a@synopsys.com>
 <20210520020117.GA1186755@rowland.harvard.edu>
 <74b2133b-2f77-c86f-4c8b-1189332617d3@synopsys.com>
 <37c41d87-6e30-1557-7991-0b7bca615be1@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37c41d87-6e30-1557-7991-0b7bca615be1@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 06:18:59PM +0300, Mathias Nyman wrote:
> On 20.5.2021 23.30, Thinh Nguyen wrote:
> > As for the xhci driver, there maybe a case where the stream URB never
> > gets to complete because the transaction err_count is not properly
> > updated. The err_count for transaction error is stored in ep_ring, but
> > the xhci driver may not be able to lookup the correct ep_ring based on
> > TRB address for streams. There are cases for streams where the event
> > TRBs have their TRB pointer field cleared to '0' (xhci spec section
> > 4.12.2). If the xhci driver doesn't see ep_ring for transaction error,
> > it automatically does a soft-retry. This is seen from one of our
> > testings that the driver was repeatedly doing soft-retry until the class
> > driver timed out.
> > 
> > Hi Mathias, maybe you have some comment on this? Thanks.
> 
> This is true, if TRB pointer is 0 then there is no retry limit for soft retry.
> We should add one and prevent a loop. after e few soft resets we can end with a
> hard reset to clear the host side endpoint halt.
> 
> We don't know the URB that was being tansferred during the error, and can't 
> give it back with a proper error code.
> In that sense we still end up waiting for a timeout and someone to cancel
> the urb.

That's not good.  There may not be a timeout; drivers expect transfers 
to complete with a failure, not to be retried indefinitely.

However, if you do know which endpoint/stream the error is connected to, 
you should be able to get the URB.  It will be the first one queued for 
that endpoint/stream.

Alan Stern
