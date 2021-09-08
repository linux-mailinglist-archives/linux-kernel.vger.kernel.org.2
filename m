Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8C04037F8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 12:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239260AbhIHKiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 06:38:24 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:43581 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232947AbhIHKiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 06:38:23 -0400
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210908103713epoutp042f2dfbdaa6a021acf4ad5b52c10317e1~i0nlqtnwU2298922989epoutp04c
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 10:37:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210908103713epoutp042f2dfbdaa6a021acf4ad5b52c10317e1~i0nlqtnwU2298922989epoutp04c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1631097434;
        bh=cknpne7tUB+htTiksKA9RjWjn4CejQjJ6PgycXbQk4A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=W2esUCYE8m2kp4gbdHW88GHgDUYSZHGx690nje7npmdwpypKA4y5mx2EA6gbXLWG3
         jfQjLy5aXyMWG75miBJJZ3tl+ch0BwuYPCTsLNvt/8P5kQRI/QmvP/b4ehVKY4zZnT
         9qoT8pR6D36FdNsn1XnA+XL5MphdIebwvUZ+i0Ss=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20210908103713epcas2p35730f585c2d127ba6a655bcea92de683~i0nlKglXx0876308763epcas2p3u;
        Wed,  8 Sep 2021 10:37:13 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.40.188]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4H4JVH2jZ1z4x9Q7; Wed,  8 Sep
        2021 10:37:11 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        FD.8B.09717.75298316; Wed,  8 Sep 2021 19:37:11 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20210908103710epcas2p4f1cdebf6520f5ed780e39c06523a876a~i0ni4G9UH1292312923epcas2p4U;
        Wed,  8 Sep 2021 10:37:10 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210908103710epsmtrp161d9fd1a2c4e7de92cafef332a0828b1~i0ni3UJnd2560825608epsmtrp1r;
        Wed,  8 Sep 2021 10:37:10 +0000 (GMT)
X-AuditID: b6c32a45-4abff700000025f5-07-6138925786a2
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CF.DA.09091.65298316; Wed,  8 Sep 2021 19:37:10 +0900 (KST)
Received: from ubuntu (unknown [12.36.155.120]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20210908103710epsmtip28d505555424469364f8e3f48496f1add~i0nirOfnP0966309663epsmtip2c;
        Wed,  8 Sep 2021 10:37:10 +0000 (GMT)
Date:   Wed, 8 Sep 2021 19:21:29 +0900
From:   Jung Daehwan <dh10.jung@samsung.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>
Cc:     "open list:USB GADGET/PERIPHERAL SUBSYSTEM" 
        <linux-usb@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: usb: gadget: u_serial: check Null pointer in EP callback
Message-ID: <20210908102129.GB13332@ubuntu>
MIME-Version: 1.0
In-Reply-To: <20210908073235.GA13332@ubuntu>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFKsWRmVeSWpSXmKPExsWy7bCmhW74JItEg0dP+C2OtT1ht2hevJ7N
        4vKuOWwWi5a1MjuweGxa1cnmsX/uGnaPz5vkApijcmwyUhNTUosUUvOS81My89JtlbyD453j
        Tc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgLYpKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yV
        UgtScgoMDQv0ihNzi0vz0vWS83OtDA0MjEyBKhNyMmZ+m8lW8F+pYsOy+YwNjKdluhg5OSQE
        TCQe/rrO2sXIxSEksINR4uSRJ0wgCSGBT4wS155rQ9jfGCUuXq+Aa9iwnw2iYS+jxP2jX1kg
        nCeMElN+bmMGqWIRUJF40vybEcRmE9CSuPfjBFhcRCBM4tOUG2wgNrNAtsS2y3uA4hwcwgKu
        El2PK0HCvALaEnvvbGaHsAUlTs58wgJicwroSEzY8ooVpFwUaPyrg/UQ91xjl7g0JQ0kLCHg
        IvFrdzVEWFji1fEt7BC2lMTL/jZ2iJJyiUXz7UAOlhDoYJRY8+ksI0SNscSsZ+2MEIdlSkxY
        1cUEUa8sceQWC0SYT6Lj8F+oMbwSHW1CEJ3KEtMvT2CFsCUlDr4+xwxhe0hM29AODdlOJom/
        b9ezTGCUn4Xkr1lItkHYOhILdn9imwW0gllAWmL5Pw4IU1Ni/S79BYysqxjFUguKc9NTi40K
        DJHjeRMjOBFque5gnPz2g94hRiYOxkOMEhzMSiK8f83NEoV4UxIrq1KL8uOLSnNSiw8xmgLj
        aCKzlGhyPjAV55XEG5oamZkZWJpamJoZWSiJ816wtEgUEkhPLEnNTk0tSC2C6WPi4JRqYCp7
        mV2yX8KDa67bdZ0zkXWcJdInKpUtXZtb1LfJtxgZ72Cd62egkqC6N9LWJqFU9b7QjqaW1Ut2
        T9wnzXSBP0rPxuVz0LLoj1Wt2bVTcosX/lP+/fqhE88hppcOXPplbBmHDdaI35HTP8ResfhK
        +Fe3m88+GgVbh9f0FBl2WDneeHU2b/eF3OlLTp3SecWnfOf+rrOVbftnRDqeTnpycd9k5fDc
        jovTs7svPHy2r4KRzX6Rwpou+yOv9BzzvI+KT57L9LZC2rnVSWvaBpvNBtf3/lrTME+61eKs
        9Dd/0WXGgk0q3mseCaRZ/Ai1eNDz40la1b1sGct7G+pm3DN9UmWVtXHhAoXmzslpZ7Y8UWIp
        zkg01GIuKk4EAER/jIINBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMLMWRmVeSWpSXmKPExsWy7bCSvG7YJItEg4Y+E4tjbU/YLZoXr2ez
        uLxrDpvFomWtzA4sHptWdbJ57J+7ht3j8ya5AOYoLpuU1JzMstQifbsErowtG3+zFOxRqHj1
        4DtLA+NCqS5GTg4JAROJhxv2s3UxcnEICexmlFj6sYMNIiEpsXTuDXYIW1jifssRVoiiR4wS
        m5e8AStiEVCReNL8mxHEZhPQkrj34wQziC0iECaxvOMrWA2zQLbEtst7gOIcHMICrhJdjytB
        wrwC2hJ772xmh5jZzSTR+206C0RCUOLkzCcsEL1aEjf+vWQC6WUWkJZY/o8DJMwpoCMxYcsr
        VpCwKNAJrw7WT2AUnIWkeRaS5lkIzQsYmVcxSqYWFOem5xYbFhjmpZbrFSfmFpfmpesl5+du
        YgSHs5bmDsbtqz7oHWJk4mA8xCjBwawkwvvX3CxRiDclsbIqtSg/vqg0J7X4EKM0B4uSOO+F
        rpPxQgLpiSWp2ampBalFMFkmDk6pBiZh/4K0Cd2OjgwKxdbXz2bN2HrvpN/M9OCG/aK7TLwC
        lWdcO/V1Z6hclOfkItalNRJ7TrCHWa+ZoD3L7u75oscvFia4J6lf/hfx9K5by5yHv3R2Ht6Z
        ZC+qdk1ru9l9qRufr079csVC7XHLVOUZ+l1fOyxbGspniVxr1pi5+7tW7Bq96Fqd2Rtervre
        yrjDN35S9TyrI4J7rbnYdeYsO+HndmCni4SR19Y5USL+O/ewL2TX59685HdZ3M6Pk/aIa61a
        XSMuuvmQTEVC8tF78W3GBRF7uPKvum2oqvtjYPbsjW7n9bzliXsyF0nO89wx0S0qmG/NzYk9
        HPPMymfs1d5k664r7ZSd0SHAWvpW1UmJpTgj0VCLuag4EQCEhY2k1gIAAA==
X-CMS-MailID: 20210908103710epcas2p4f1cdebf6520f5ed780e39c06523a876a
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----vylgt3.nD9L0r9nTp.3cTjl0ntXvr5JYF2c57dsKmcMNm8FN=_18baf9_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210806080835epcas2p2134b8b635e27d129a9e2f2f400a814fc
References: <CGME20210806080835epcas2p2134b8b635e27d129a9e2f2f400a814fc@epcas2p2.samsung.com>
        <1628236406-185160-1-git-send-email-dh10.jung@samsung.com>
        <YQzu+Xy+3wAyXeDK@kroah.com> <000001d7a482$93438b20$b9caa160$@samsung.com>
        <20210908073235.GA13332@ubuntu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------vylgt3.nD9L0r9nTp.3cTjl0ntXvr5JYF2c57dsKmcMNm8FN=_18baf9_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Fri, Aug 06, 2021 at 05:13:34PM +0200, Greg Kroah-Harman wrote:
> On Fri, Aug 06, 2021 at 04:53:26PM +0900, Daehwan Jung wrote:
> > From: taehyun cho <taehyun.cho@samsung.com>
> > 
> > Endpoint complete function in u_serial can be executed when 'gs_port' 
> > is Null. This situation happens when 'dwc3_gadget_pullup' returns 
> > ETIMEDOUT. The reason why ETIMEDOUT is returned is that whole system 
> > is out of order including interrupt regardless of USB.
> > 
> > pc : __lock_acquire+0x54/0x5ec
> > lr : lock_acquire+0xe8/0x198
> > sp : ffffffc03914b9d0
> > x29: ffffffc03914b9d0 x28: ffffff895f13b680
> > x27: 0000000000000000 x26: 0000000000000000
> > x25: 00000000000003c8 x24: 0000000000000080
> > x23: ffffffc010a8f650 x22: 0000000000000000
> > x21: 0000000000000000 x20: 0000000000000000
> > x19: ffffffc010a8f650 x18: ffffffc02d70a0b0
> > x17: 0000000000000000 x16: 00000000000229e0
> > x15: 0000000000000004 x14: 00000000000004f2
> > x13: ffffffc0120fe178 x12: 0000000000000003
> > x11: 00000000ffffffff x10: 0000000100000001
> > x9 : 0000000000000001 x8 : 00000000000003c8
> > x7 : 0000000000000000 x6 : ffffffc010a8f650
> > x5 : 0000000000000000 x4 : 0000000000000080
> > x3 : 0000000000000000 x2 : 0000000000000000
> > x1 : 0000000000000000 x0 : 00000000000003c8 Call trace:
> >  __lock_acquire+0x54/0x5ec
> >  lock_acquire+0xe8/0x198
> >  _raw_spin_lock+0x70/0x88
> >  gs_read_complete+0x48/0xac
> >  usb_gadget_giveback_request+0x48/0x80
> >  dwc3_gadget_giveback+0xcc/0xe8
> >  dwc3_remove_requests+0xa8/0x188
> >  __dwc3_gadget_ep_disable+0x98/0x110
> >  dwc3_gadget_ep_disable+0x50/0xbc
> >  usb_ep_disable+0x44/0x94
> >  gserial_disconnect+0xc0/0x250
> >  acm_free_func+0x30/0x48
> >  usb_put_function+0x34/0x68
> >  config_usb_cfg_unlink+0xdc/0xf8
> >  configfs_unlink+0x144/0x264
> >  vfs_unlink+0x134/0x218
> >  do_unlinkat+0x13c/0x2a0
> >  __arm64_sys_unlinkat+0x48/0x60
> >  el0_svc_common.llvm.10277270529376503802+0xb8/0x1b4
> >  do_el0_svc+0x24/0x8c
> >  el0_svc+0x10/0x1c
> >  el0_sync_handler+0x68/0xac
> >  el0_sync+0x18c/0x1c0
> > 
> > Signed-off-by: taehyun cho <taehyun.cho@samsung.com>
> > ---
> >  drivers/usb/gadget/function/u_serial.c | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> > 
> > diff --git a/drivers/usb/gadget/function/u_serial.c 
> > b/drivers/usb/gadget/function/u_serial.c
> > index 6f68cbe..af08a18 100644
> > --- a/drivers/usb/gadget/function/u_serial.c
> > +++ b/drivers/usb/gadget/function/u_serial.c
> > @@ -450,6 +450,15 @@ static void gs_read_complete(struct usb_ep *ep, 
> > struct usb_request *req)  {
> >  	struct gs_port	*port = ep->driver_data;
> >  
> > +	/*
> > +	 * Port became NULL when 'dwc3_gadget_pullup' returns ETIMEDOUT.
> > +	 * Return here to avoid panic.
> > +	 */
> > +	if (!port) {
> > +		pr_err("%s, failed to get port\n", __func__);
> > +		return;
> > +	}
> > +
> 
	spin_lock(&port->port_lock);
	...
	spin_unlock(&port->port_lock);
> What prevents port from being null right after checking this?  Where is the
> lock to prevent this?
>
It tries to get lock first in gs_read_complete/gs_write_complete like above.
That's why the panic occured during getting lock but this issue is not related
to lock. We just want to prevent doing something after port becomes null.
> >  	/* Queue all received data until the tty layer is ready for it. */
> >  	spin_lock(&port->port_lock);
> >  	list_add_tail(&req->list, &port->read_queue); @@ -461,6 +470,15 @@ 
> > static void gs_write_complete(struct usb_ep *ep, struct usb_request 
> > *req)  {
> >  	struct gs_port	*port = ep->driver_data;
> >  
> > +	/*
> > +	 * port became NULL when 'dwc3_gadget_pullup' returns ETIMEDOUT.
> > +	 * Return here to avoid panic.
> > +	 */
> > +	if (!port) {
> > +		pr_err("%s, failed to get port\n", __func__);
> > +		return;
> > +	}
> 
> Same here, where is the lock?
> 
> And why report an error, what can a user do about it?
> 

It could happen to access null pointer and occur whole system panic.

Best Regards,
Jung Daehwan

> thanks,
> 
> greg k-h
> 
> 



------vylgt3.nD9L0r9nTp.3cTjl0ntXvr5JYF2c57dsKmcMNm8FN=_18baf9_
Content-Type: text/plain; charset="utf-8"


------vylgt3.nD9L0r9nTp.3cTjl0ntXvr5JYF2c57dsKmcMNm8FN=_18baf9_--
