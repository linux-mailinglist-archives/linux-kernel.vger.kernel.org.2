Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06A063B5985
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 09:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbhF1HMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 03:12:40 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:27235 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbhF1HMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 03:12:38 -0400
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210628071011epoutp0198d8585f7b35ef450176718213afcf64~MrWRUMv053042030420epoutp01b
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 07:10:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210628071011epoutp0198d8585f7b35ef450176718213afcf64~MrWRUMv053042030420epoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1624864212;
        bh=V1WLpqpnXsh2R9fgZV91rcr1af7vaYAXhnpGE3a7hkY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EVt7ch6+H+25K2Ur3GhTZ1OZGA5uwOSvLXw4ZsUWudRNQxhA69yfKciYwgD5OGG5Y
         qAjraLm/imkgwyb9TBnQE0SAVbc8hSIhDxng3f2njd4jv+KcPbI7EZGiLlLmLYgjcb
         pdMp2QfrS8G1sXjy4wW6j+W1Qro5RrW0rtA9W0bE=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20210628071011epcas2p19507323982e2cf8355622cd7b14909ea~MrWREZoGD1919219192epcas2p1X;
        Mon, 28 Jun 2021 07:10:11 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.40.190]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4GCzJf3Z76z4x9QB; Mon, 28 Jun
        2021 07:10:10 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        11.78.09541.1D579D06; Mon, 28 Jun 2021 16:10:09 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20210628071009epcas2p47fa2a3f9c13b6a3a745cc376e4fb7664~MrWPFIxKl2617926179epcas2p4o;
        Mon, 28 Jun 2021 07:10:09 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210628071009epsmtrp12f52167fd3f041df7b5b16349020348e~MrWPEOirR1527615276epsmtrp1F;
        Mon, 28 Jun 2021 07:10:09 +0000 (GMT)
X-AuditID: b6c32a46-095ff70000002545-ad-60d975d123d9
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        ED.B7.08289.1D579D06; Mon, 28 Jun 2021 16:10:09 +0900 (KST)
Received: from ubuntu (unknown [12.36.155.120]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20210628071009epsmtip20846b3873c879fd5ec9023d53b2d419a~MrWO7o6he0086100861epsmtip26;
        Mon, 28 Jun 2021 07:10:09 +0000 (GMT)
Date:   Mon, 28 Jun 2021 15:55:53 +0900
From:   Jung Daehwan <dh10.jung@samsung.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: usb: host: Reduce xhci_handshake timeout in xhci_reset
Message-ID: <20210628065553.GA83203@ubuntu>
MIME-Version: 1.0
In-Reply-To: <YNlxzj7KXG43Uyrp@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNKsWRmVeSWpSXmKPExsWy7bCmme7F0psJBu0LzS2aF69ns7i8aw6b
        xaJlrcwWzZumsDqweCze85LJY//cNewenzfJBTBH5dhkpCampBYppOYl56dk5qXbKnkHxzvH
        m5oZGOoaWlqYKynkJeam2iq5+AToumXmAG1TUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gq
        pRak5BQYGhboFSfmFpfmpesl5+daGRoYGJkCVSbkZKyfL1/wV6Di9Zr37A2MPbxdjJwcEgIm
        EoeXn2HtYuTiEBLYwShx8tErdgjnE6PEng2f2SCcz4wSM//sZ4Fp+du5hBnEFhLYxSgxaZMM
        RNETRokXb94ygiRYBFQl3jStZQex2QS0JO79OAHWICJgLNF/dhZYnFkgTeL6yj1gtrCAs8S2
        d3OA7uDg4BXQlljzSAUkzCsgKHFy5hOwvZwCmhIfLvSAlYgKqEi8OlgPslZC4Bq7xMXT+9kg
        bnOR2PR6HZQtLPHq+BZ2CFtK4mV/GztIr4RAucSi+XYQvR2MEms+nWWEqDGWmPWsnRHitEyJ
        eRsOsUHUK0scucUCEeaT6Dj8F2oMr0RHmxBEp7LE9MsTWCFsSYmDr88xQ9geEhdfLGOEhNR3
        RoklHTkTGOVnIXlsFpJlELaOxILdn4BsDiBbWmL5Pw4IU1Ni/S79BYysqxjFUguKc9NTi40K
        jJAjehMjOBVque1gnPL2g94hRiYOxkOMEhzMSiK8YlXXEoR4UxIrq1KL8uOLSnNSiw8xmgIj
        aSKzlGhyPjAZ55XEG5oamZkZWJpamJoZWSiJ83KwH0oQEkhPLEnNTk0tSC2C6WPi4JRqYPKZ
        pv6+vKVZWv2+fvTG+YUJEsUh1/kOztoiIcEkq/ziQ7/C2XVpoYp8aa6uD+5y3Tvb2GSQOi8z
        98ByjZqMhvVrz+64+kdBblnXu7CvRgzyrXOYFzBY6VrlNj05IL+ltebO0nuqtv1xaV9uHnfZ
        t3H570LZgq02jLbTtDNuvk1Q+V5dXmmipvBxmuP/TPEf70yvvF1c8/DgMunK2H3/+Qx/mIlO
        +BojKH3EeGr3hPzltZIC1zTebZ4avOlVE/feL+0vp3F8cmBTtvj3P252njqj65t5ixcI+wrZ
        5elOEOicv3vloodvjlbWx3nnSuR1PAi4kbFZWvrfl3vJNjZ7Eh4rzal5fOJOdeGizRxS8Uos
        xRmJhlrMRcWJACUWobQOBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMLMWRmVeSWpSXmKPExsWy7bCSvO7F0psJBl0L5C2aF69ns7i8aw6b
        xaJlrcwWzZumsDqweCze85LJY//cNewenzfJBTBHcdmkpOZklqUW6dslcGXcaZnCUrCLr2LS
        rVUsDYyPuLoYOTkkBEwk/nYuYe5i5OIQEtjBKPF+UR87REJSYuncG1C2sMT9liOsEEWPGCU2
        ftvAApJgEVCVeNO0FqyITUBL4t6PE8wgtoiAsUT/2VlgcWaBNInrK/eA2cICzhLb3s0BGsTB
        wSugLbHmkQrEzJ+MEhumfwGr4RUQlDg58wkLRK+WxI1/L5lA6pkFpCWW/+MACXMKaEp8uNAD
        NkZUQEXi1cH6CYyCs5A0z0LSPAuheQEj8ypGydSC4tz03GLDAqO81HK94sTc4tK8dL3k/NxN
        jOBw1tLawbhn1Qe9Q4xMHIyHGCU4mJVEeMWqriUI8aYkVlalFuXHF5XmpBYfYpTmYFES573Q
        dTJeSCA9sSQ1OzW1ILUIJsvEwSnVwNTaueIGe418XNyOPVvnW05cePpIYSpn8L6uw62/d4i7
        7JjmJxpy69n7mXNy976t3BRYNr17mtHle4XPavfwKUy05WOewf6twGCWhuItibR/Yjtn773p
        +ebbPem7kTP3BJ8Nr8uZl7v4qIXm88dFvxp7cm5PyAvq3BG/gHHuH4sdOYeveC91uP7Sh2Vf
        7O1173Y3Rxxbp2yw6ZDs7doHYbl191sXuB/y6j9zakG+w4Wtmy+csbjoWnHvprDtay3WC6+O
        aNyf9vKEnGZzW9bM7B/Mrps2lD21KT+qfv5j5slg9oRpd/5cFS+29wxwu5EgNjNA0eLSrLlZ
        +oe//LmeZlQ8KXQtz9r1cQzmyS1HogSElViKMxINtZiLihMBCihXFNYCAAA=
X-CMS-MailID: 20210628071009epcas2p47fa2a3f9c13b6a3a745cc376e4fb7664
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----c2YBr1xbOYfB2IDqioM.uLYc5x244uDgwyTZAqanlpYp6BQp=_130472_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210622113915epcas2p284c61291fc9d83487f6dfebb65fd4e9b
References: <CGME20210622113915epcas2p284c61291fc9d83487f6dfebb65fd4e9b@epcas2p2.samsung.com>
        <1624361096-41282-1-git-send-email-dh10.jung@samsung.com>
        <YNJAZDwuFmEoTJHe@kroah.com> <20210628022548.GA69289@ubuntu>
        <YNlxzj7KXG43Uyrp@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------c2YBr1xbOYfB2IDqioM.uLYc5x244uDgwyTZAqanlpYp6BQp=_130472_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Mon, Jun 28, 2021 at 08:53:02AM +0200, Greg Kroah-Hartman wrote:
> On Mon, Jun 28, 2021 at 11:25:48AM +0900, Jung Daehwan wrote:
> > On Tue, Jun 22, 2021 at 09:56:20PM +0200, Greg Kroah-Hartman wrote:
> > > On Tue, Jun 22, 2021 at 08:24:56PM +0900, Daehwan Jung wrote:
> > > > It seems 10 secs timeout is too long in general case. A core would wait for
> > > > 10 secs without doing other task and it can be happended on every device.
> > >
> > > Only if the handshake does not come back sooner, right?
> >
> > Yes, right.
> >
> > > What is causing your device to timeout here?
> >
> > Host Controller doesn't respond handshake. I don't know why and I ask HW team
> > to debug it.
>
> Please work to fix your hardware, that feels like the root of the
> problem here.  If you require the timeout for xhci_reset() to happen,
> then how do you know that the hardware really did reset properly in the
> reduced amount of time you just provided?
>

I continue fixing this issue with hardware engineer, but currently just
host controller can crash whole system and that's why I want to fix it.
How about adding some error logs in this situation for recognizing this issue?
We can add error log in xhci_stop as xhci_reset can returns error like below.

static void xhci_stop(struct usb_hcd *hcd)
{
        u32 temp;
        struct xhci_hcd *xhci = hcd_to_xhci(hcd);
+       int ret;

        mutex_lock(&xhci->mutex);

@@ -733,6 +734,9 @@ static void xhci_stop(struct usb_hcd *hcd)
        xhci->cmd_ring_state = CMD_RING_STATE_STOPPED;
        xhci_halt(xhci);
        xhci_reset(xhci);
+       if (ret)
+               xhci_err(xhci, "%s: Error while reset xhci Host controller - ret = %d\n"
+                       , __func__, ret);
        spin_unlock_irq(&xhci->lock);


> thanks,
>
> greg k-h
>



------c2YBr1xbOYfB2IDqioM.uLYc5x244uDgwyTZAqanlpYp6BQp=_130472_
Content-Type: text/plain; charset="utf-8"


------c2YBr1xbOYfB2IDqioM.uLYc5x244uDgwyTZAqanlpYp6BQp=_130472_--
