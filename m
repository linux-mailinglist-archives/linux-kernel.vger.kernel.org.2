Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC6C43B5749
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 04:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbhF1Cmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 22:42:37 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:14904 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbhF1Cmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 22:42:36 -0400
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210628024010epoutp037e93e3808db5aa32c24ad0d1bf3ae17e~MnqgEesp90509505095epoutp03J
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 02:40:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210628024010epoutp037e93e3808db5aa32c24ad0d1bf3ae17e~MnqgEesp90509505095epoutp03J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1624848010;
        bh=xgM1k65guTFI2CYWiKANjoXaS/s0doPNTqGpzDSNygM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HjM6qui2uPABXCV96qn4dcsCzOsQCwowKcgWmYLYjNc1EUJhcURhj6dKB3cojKX4K
         XNU6O3+68B9Ax29miuwkQsTPmT4HND8NQOmWmDsQZb90KOWZaWoZGMg0s9j+MoGUA2
         37iKnmDUoJb2Pmf1WCI1Qbzhve1/CXlRA2dHcmfc=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20210628024009epcas2p10b060a621fde1914c6ddbbde476e0d71~MnqfUCsqP0084200842epcas2p1S;
        Mon, 28 Jun 2021 02:40:09 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.40.189]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4GCsK30VXqz4x9Q2; Mon, 28 Jun
        2021 02:40:07 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F8.C2.09541.68639D06; Mon, 28 Jun 2021 11:40:06 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20210628024005epcas2p422fd632b700d8af62e7d3016c9998879~MnqcJb9-z2970529705epcas2p4Y;
        Mon, 28 Jun 2021 02:40:05 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210628024005epsmtrp2593a7aadf620266c1402745cf162d522~MnqcIog7J0429704297epsmtrp2Z;
        Mon, 28 Jun 2021 02:40:05 +0000 (GMT)
X-AuditID: b6c32a46-0abff70000002545-8d-60d93686fd0a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        3B.19.08394.58639D06; Mon, 28 Jun 2021 11:40:05 +0900 (KST)
Received: from ubuntu (unknown [12.36.155.120]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20210628024005epsmtip10afa0c237ca95d028e1a2fceda98c4b8~Mnqb_AaRY2483724837epsmtip1c;
        Mon, 28 Jun 2021 02:40:05 +0000 (GMT)
Date:   Mon, 28 Jun 2021 11:25:48 +0900
From:   Jung Daehwan <dh10.jung@samsung.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: usb: host: Reduce xhci_handshake timeout in xhci_reset
Message-ID: <20210628022548.GA69289@ubuntu>
MIME-Version: 1.0
In-Reply-To: <YNJAZDwuFmEoTJHe@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHKsWRmVeSWpSXmKPExsWy7bCmuW6b2c0Eg44GbovmxevZLC7vmsNm
        sWhZK7NF86YprA4sHov3vGTy2D93DbvH501yAcxROTYZqYkpqUUKqXnJ+SmZeem2St7B8c7x
        pmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QNuUFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZK
        qQUpOQWGhgV6xYm5xaV56XrJ+blWhgYGRqZAlQk5GX37+9kKHkpXPFyyjKmBcZ5oFyMnh4SA
        icS5CfPZuhi5OIQEdjBKzO9bygLhfGKUuHT/LTNIlZDAN0aJpz/lYDqe9bQxQhTtZZSYeOs0
        VMcTRon/W66yg1SxCKhK7NoJUsXJwSagJXHvxwmwSSICxhL9Z2eB1TALpElcX7kHzBYWcJbY
        9m4OK4jNK6ANtOEfM4QtKHFy5hMWEJtTQFOibUc3kM3BISqgIvHqYD3IXgmBS+wSz87eYYS4
        zkXi5PILzBC2sMSr41vYIWwpic/v9rKB9EoIlEssmm8H0dvBKLHm01moXmOJWc/aGSFuy5R4
        c7gRql5Z4sgtFogwn0TH4b/sEGFeiY42IYhOZYnplyewQtiSEgdfn4O6wEPi4otljPDQfT7p
        MMsERvlZSD6bhWQbhK0jsWD3JyCbA8iWllj+jwPC1JRYv0t/ASPrKkax1ILi3PTUYqMCI+S4
        3sQITohabjsYp7z9oHeIkYmD8RCjBAezkgivWNW1BCHelMTKqtSi/Pii0pzU4kOMpsBomsgs
        JZqcD0zJeSXxhqZGZmYGlqYWpmZGFkrivBzshxKEBNITS1KzU1MLUotg+pg4OKUamI4lK3/f
        v2DTkU6Gjtg7v1IPeD3f1iZv3nFy431H1tCmLR73e14tjd2l2GOxYFpG1/5N4nlP3E1jW+x1
        jugpmXzlernjl+diQa+Lql3ZdSWXJKMYNZsvaz256unI2JvYerliC6PerpN3arYwHO1PTck5
        4HRNcwr71e2zomUq+MSW9am2219Qiyh4UGsYZPfSoatjvVTX5G2f3lx6sVg/avmxeJkZNaVq
        B/pVZWNMzmlevXL/1yPzSFWZ4wd/LeWZmS3OK5jwbvEcOYZTrxf+8dqWZL95OrPLA3HR9I/r
        FzDOzEldvS2VY1HAkmcLtPz7uN21rHhTLitXfWa0jZ3KcPD8+/ZCAf5K80cbP2xNV2Ipzkg0
        1GIuKk4EAJhwZyYRBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCLMWRmVeSWpSXmKPExsWy7bCSnG6r2c0Eg7c3tS2aF69ns7i8aw6b
        xaJlrcwWzZumsDqweCze85LJY//cNewenzfJBTBHcdmkpOZklqUW6dslcGXcuNHIVjBPsuLU
        k8PMDYxfhLoYOTkkBEwknvW0MXYxcnEICexmlDi+YR0jREJSYuncG+wQtrDE/ZYjrBBFjxgl
        3r15zQySYBFQldi1sw2sgU1AS+LejxNgcREBY4n+s7PAmpkF0iSur9wDZgsLOEtsezeHFcTm
        FdAG2vyPGWLoDkaJDVefQSUEJU7OfMIC0awlcePfS6YuRg4gW1pi+T8OkDCngKZE245uFpCw
        qICKxKuD9RMYBWchaZ6FpHkWQvMCRuZVjJKpBcW56bnFhgWGeanlesWJucWleel6yfm5mxjB
        Aa2luYNx+6oPeocYmTgYDzFKcDArifCKVV1LEOJNSaysSi3Kjy8qzUktPsQozcGiJM57oetk
        vJBAemJJanZqakFqEUyWiYNTqoGJ+e25uzc2v7ymUDzJMlDra9Ka/Q1Wiq41Sn98Zk35Mfl2
        ofUZo+13Av/dM91iNCNPXO+Oltbn5riT33afmWL7lqPNaZZ78NKAZyvUsy83NZY8s+fdNOcs
        B/Nhd7azBzP6RP8GqUedsF+8sqr6ybsk5WlVUn+lBKLT2M0MRWZb3Cv5bbG/fGctT+1FuXnv
        rqz4lO18xkRSblvL79aLWRteLykRELNf+bdttovU6ZNrVh1J27BncmiIt8hW/kmvmpc6qMmm
        RKWJZF42MljA1nCZ4+eJJ1u61/9/Fnum/of9tzm/9Ioe/xaKcZzw6/Ijzd1NC5xV5pz5WJFr
        vym6f1qjnc7syeITW6L9mnJZ7SKZlFiKMxINtZiLihMBcnZB99cCAAA=
X-CMS-MailID: 20210628024005epcas2p422fd632b700d8af62e7d3016c9998879
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----X6LHfpBqzMP5jYSBa_XevzFelDsmuxNqFv4WWGlsp9xK5mkh=_12d688_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210622113915epcas2p284c61291fc9d83487f6dfebb65fd4e9b
References: <CGME20210622113915epcas2p284c61291fc9d83487f6dfebb65fd4e9b@epcas2p2.samsung.com>
        <1624361096-41282-1-git-send-email-dh10.jung@samsung.com>
        <YNJAZDwuFmEoTJHe@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------X6LHfpBqzMP5jYSBa_XevzFelDsmuxNqFv4WWGlsp9xK5mkh=_12d688_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Tue, Jun 22, 2021 at 09:56:20PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Jun 22, 2021 at 08:24:56PM +0900, Daehwan Jung wrote:
> > It seems 10 secs timeout is too long in general case. A core would wait for
> > 10 secs without doing other task and it can be happended on every device.
> 
> Only if the handshake does not come back sooner, right?

Yes, right.

> What is causing your device to timeout here?

Host Controller doesn't respond handshake. I don't know why and I ask HW team
to debug it.

> > It's better to reduce timeout for general case and use new quirk if needed.
>
> What new quirk?

I mean someone can add new quirk if one still needs long timeout. I guess 1 sec
seems enough but there're many kinds of devices.

> And why 1 second, where did that number come from?

It was 250 msecs before changed to 10 secs. There's no required minimum time in
xhci specification. 1 second is estimated number and it works well on my device.

> >
> > Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
> > ---
> >  drivers/usb/host/xhci.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> > index 9248ce8..0a1b6be 100644
> > --- a/drivers/usb/host/xhci.c
> > +++ b/drivers/usb/host/xhci.c
> > @@ -196,7 +196,7 @@ int xhci_reset(struct xhci_hcd *xhci)
> >  		udelay(1000);
> >
> >  	ret = xhci_handshake(&xhci->op_regs->command,
> > -			CMD_RESET, 0, 10 * 1000 * 1000);
> > +			CMD_RESET, 0, 1 * 1000 * 1000);
> >  	if (ret)
> >  		return ret;
> >
> > @@ -210,7 +210,7 @@ int xhci_reset(struct xhci_hcd *xhci)
> >  	 * than status until the "Controller Not Ready" flag is cleared.
> >  	 */
> >  	ret = xhci_handshake(&xhci->op_regs->status,
> > -			STS_CNR, 0, 10 * 1000 * 1000);
> > +			STS_CNR, 0, 1 * 1000 * 1000);
>
> With this change, what "goes faster"?  What is currently causing
> problems with your host controller that this timeout value actually
> matters?  Why is it failing?

I guess the root cause of it is from host controller, which it is HW.
Our HW engineer has been debugging it, but I haven't get any clue till now.
However, I think 10 secs timeout is too long and it can cause system problem.
That's why I want to change timeout value. A CPU core would not do anything but
waiting xhci reset for 10 secs with disabling irq like below.

usb_remove_hcd -> xhci_stop -> xhci_reset -> xhci_handshake

static void xhci_stop(struct usb_hcd *hcd)
{
        u32 temp;
        struct xhci_hcd *xhci = hcd_to_xhci(hcd);

        mutex_lock(&xhci->mutex);

        /* Only halt host and free memory after both hcds are removed */
        if (!usb_hcd_is_primary_hcd(hcd)) {
                mutex_unlock(&xhci->mutex);
                return;
        }

        xhci_dbc_exit(xhci);

        spin_lock_irq(&xhci->lock);           -> disable IRQ
        xhci->xhc_state |= XHCI_STATE_HALTED;
        xhci->cmd_ring_state = CMD_RING_STATE_STOPPED;
        xhci_halt(xhci);
        xhci_reset(xhci);                     -> 10 seconds timeout!
        spin_unlock_irq(&xhci->lock);

Best Regards,
Jung Daehwan

> thanks,
> 
> greg k-h
> 

------X6LHfpBqzMP5jYSBa_XevzFelDsmuxNqFv4WWGlsp9xK5mkh=_12d688_
Content-Type: text/plain; charset="utf-8"


------X6LHfpBqzMP5jYSBa_XevzFelDsmuxNqFv4WWGlsp9xK5mkh=_12d688_--
