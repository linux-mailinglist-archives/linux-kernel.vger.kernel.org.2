Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 326D133D39C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 13:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbhCPMQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 08:16:18 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:25197 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbhCPMP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 08:15:59 -0400
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210316121557epoutp048d8bb9f13b0f8415f547d0d39fb30dd7~s0birMHho1102111021epoutp04V
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 12:15:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210316121557epoutp048d8bb9f13b0f8415f547d0d39fb30dd7~s0birMHho1102111021epoutp04V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1615896957;
        bh=Li37h5E+FYADkrX8n9IvGCQEPn2IijJDX2+GYSW7/Pk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=A3Lc6QQml77JTfgy8yDGIMK+WR5tm37Q+Ry6aRDTFuCc8UHwS4YDbX17G31d0Yu60
         +8iSd0PpwIz+jWUi/96EaBe3QCw03OxihTOs5JlJ5s0JYNBEhzbLlPZZnxrvDmUx32
         t6mGXz+SVxoWF2Ga6ZXBtxEc3js15E8+QC1C9uMY=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20210316121557epcas2p40e21bebd9a85e92abde2095ed9202205~s0biXxLBA1829418294epcas2p4u;
        Tue, 16 Mar 2021 12:15:57 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.40.184]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4F0C1Q4z78z4x9Px; Tue, 16 Mar
        2021 12:15:54 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        E2.6F.10621.A71A0506; Tue, 16 Mar 2021 21:15:54 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20210316121554epcas2p2e5a4a929050aa245c29a0a28d23cb03b~s0bfrna6u2714327143epcas2p2r;
        Tue, 16 Mar 2021 12:15:54 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210316121554epsmtrp1d454a3488f3b827d9aefc826ce33509a~s0bfq7ko-1153611536epsmtrp1c;
        Tue, 16 Mar 2021 12:15:54 +0000 (GMT)
X-AuditID: b6c32a45-337ff7000001297d-15-6050a17a090e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F0.7F.08745.A71A0506; Tue, 16 Mar 2021 21:15:54 +0900 (KST)
Received: from rack03 (unknown [12.36.155.109]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20210316121553epsmtip2332bd2cdb1b6f635fc029dddac71b5de~s0bff3Nim2031020310epsmtip2Q;
        Tue, 16 Mar 2021 12:15:53 +0000 (GMT)
Date:   Tue, 16 Mar 2021 21:16:43 +0900
From:   taehyun cho <taehyun.cho@samsung.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     balbi@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: dwc3: remove 'pm_runtime_set_active' in resume
 callback
Message-ID: <20210316121643.GA138912@rack03>
MIME-Version: 1.0
In-Reply-To: <20210315141335.GA402778@rowland.harvard.edu>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmk+LIzCtJLcpLzFFi42LZdljTTLdqYUCCwcRZShbH2p6wWzQvXs9m
        cXnXHDaLRctamS0m/L7A5sDqsWlVJ5vH/rlr2D1m3/3B6PF5k1wAS1SOTUZqYkpqkUJqXnJ+
        SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QXiWFssScUqBQQGJxsZK+nU1R
        fmlJqkJGfnGJrVJqQUpOgaFhgV5xYm5xaV66XnJ+rpWhgYGRKVBlQk7G1pUXmQpahSpu/vjL
        3sD4jK+LkZNDQsBE4uaBT2xdjFwcQgI7GCWOb9wB5XxilGh98QXK+cwoMXNVNwtMy+Prqxkh
        ErsYJRY2r4KqesIocej5V0aQKhYBVYl7976DdbAJaEvsb77JCmKLCGhJbG56yQzSwCzQwCgx
        /2wTO0hCWCBYYt67DrAGXgEdiaZnU9ggbEGJkzOfgMU5BawkOv98Z+pi5OAQFVCReHWwHmSO
        hMA9dombZ1axgMQlBFwkZsyCek5Y4tXxLewQtpTEy/42doj6dkaJXyfWsEI4UxglPqw7xQhR
        ZSwx61k7mM0skCnxYMJSNoihyhJHbrFAhPkkOg7/ZYcI80p0tAlBdKpKtF+8zwZhS0tc2nwT
        yvaQ+PZ5BTMkgPYzSuydu4ptAqP8LCSvzUKyDcLWkViw+xOQzQFkS0ss/8cBYWpKrN+lv4CR
        dRWjWGpBcW56arFRgSFydG9iBKdKLdcdjJPfftA7xMjEwXiIUYKDWUmE1zQvIEGINyWxsiq1
        KD++qDQntfgQoykwoiYyS4km5wOTdV5JvKGpkZmZgaWphamZkYWSOG+xwYN4IYH0xJLU7NTU
        gtQimD4mDk6pBiaX7bsLGRQlQ34cXv7rjsXS2Mnx6Sc7XNYJFTrXXTAqTmf1yk/iWfLpt2Lk
        rhrfrzrzc5iX7ikK5ZwUvFXgdcvMbt1tk2bN+DQj4ePiVRo3L9T6Gbybtn3KntzCrk+spm+Y
        v52MvHSxa8rXR5JPOE02eYd2bUh+fYi1Jkvqv5CzXX5uXPYfB5Xc9tg73AHHjDLC588WD9xx
        7/Z3pmdOds7GKvG9wiybT4TxGnF8sH/7t5FNRtEzKIPhM8cnrplePdr9HuYpKhcXnFa+Jl7n
        +0hJnEf15iOjH8d1dC6fmtInfUDqydwGHytOI/uzFY4875Jm7pofYZ0geCXww+myxqfzm3dd
        ndnr9abj4e/F1kosxRmJhlrMRcWJADhN0fMeBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsWy7bCSvG7VwoAEg5ZGFotjbU/YLZoXr2ez
        uLxrDpvFomWtzBYTfl9gc2D12LSqk81j/9w17B6z7/5g9Pi8SS6AJYrLJiU1J7MstUjfLoEr
        43ffQpaCQ/wVj7oqGhj38HQxcnJICJhIPL6+mhHEFhLYwSjxvSMCIi4tcerxAmYIW1jifssR
        VoiaR4wSS5cbgtgsAqoS9+59ZwGx2QS0JfY33wSrERHQktjc9BKol4uDWaCBUWL+2SZ2kISw
        QLDEvHcdYA28AjoSTc+msIEUCQnsZ5RoP3cMKiEocXLmEzCbGWjSjX8vmboYOYBsaYnl/zhA
        wpwCVhKdf76DhUUFVCReHayfwCg4C0nzLCTNsxCaFzAyr2KUTC0ozk3PLTYsMMpLLdcrTswt
        Ls1L10vOz93ECA5wLa0djHtWfdA7xMjEwXiIUYKDWUmE1zQvIEGINyWxsiq1KD++qDQntfgQ
        ozQHi5I474Wuk/FCAumJJanZqakFqUUwWSYOTqkGJv4FtTxers6c1+ZnTHfdaaNbK6VewGgw
        4WPwx8P26odZf2bVhC+oyL8WdFDRo+b2dus7X3R/yV3gWTlbRujcV4nzJc6iRb8V01U21XIq
        JEu8bc16Ye2xcT/Tb8PzL2ZaJt+ZdPXMlDe561YtCbhkcrfp/8M44y8fJXy82trO6S3KeVrC
        eEMw4WnggYnqSutEDFh0TkkIe9+K8Fmyw9Gh6+62Sjef/qrs28l/DqaeOSz58feEcoY3wob/
        T71MkKl79+Sd68bPK89OXvOcI7Uijc+zI3j/Bd2wnZvF1kY6Tkw5VjzF1nUNT0H180dnH0xb
        9vVmg1fBdwuVL3mRnsUtWRF7Zpm90ytwX83UklzQocRSnJFoqMVcVJwIAB+iHabfAgAA
X-CMS-MailID: 20210316121554epcas2p2e5a4a929050aa245c29a0a28d23cb03b
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----VQObM9Pl3j-Am1LaCn7xN8sri-O7OboG09SNkG7pZ6-k7KuL=_22549a_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210315074223epcas2p11ddf190ec730f8629c1310117135f813
References: <CGME20210315074223epcas2p11ddf190ec730f8629c1310117135f813@epcas2p1.samsung.com>
        <20210315074317.7736-1-taehyun.cho@samsung.com>
        <20210315141335.GA402778@rowland.harvard.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------VQObM9Pl3j-Am1LaCn7xN8sri-O7OboG09SNkG7pZ6-k7KuL=_22549a_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Mon, Mar 15, 2021 at 10:13:35AM -0400, Alan Stern wrote:
> On Mon, Mar 15, 2021 at 04:43:17PM +0900, taehyun cho wrote:
> > 'pm_runtime_set_active' sets a flag to describe rumtime status.
> > This flag is automatically set in pm_runtime_get_sync/put_sync API.
> > 'pm_runtime_set_active' checks the runtime status of parent device.
> > As a result, the below error message is printed.
> > dwc3 11110000.dwc3: runtime PM trying to activate child device
> > 11110000.dwc3 but parent (11110000.usb) is not active.
> 
> This is very suspicious.  That error message indicates a real error is 
> present; removing these pm_runtime_set_active calls won't fix the error.
> 
> You need to determine why the parent platform device 11110000.usb isn't 
> active when the dwc3 probe and resume routines are called.  It seems 
> likely that there is a bug in the platform device's driver.
> 
> Alan Stern
>

I thought the issue happened because 'pm_runtime_set_active' set a flag again.
I will check again if there is a problem in our platform device driver and
get back.

Taehyun Cho

> > Signed-off-by: taehyun cho <taehyun.cho@samsung.com>
> > ---
> >  drivers/usb/dwc3/core.c | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > index 94fdbe502ce9..e7c0e390f885 100644
> > --- a/drivers/usb/dwc3/core.c
> > +++ b/drivers/usb/dwc3/core.c
> > @@ -1553,7 +1553,6 @@ static int dwc3_probe(struct platform_device *pdev)
> >  
> >  	spin_lock_init(&dwc->lock);
> >  
> > -	pm_runtime_set_active(dev);
> >  	pm_runtime_use_autosuspend(dev);
> >  	pm_runtime_set_autosuspend_delay(dev, DWC3_DEFAULT_AUTOSUSPEND_DELAY);
> >  	pm_runtime_enable(dev);
> > @@ -1920,7 +1919,6 @@ static int dwc3_resume(struct device *dev)
> >  		return ret;
> >  
> >  	pm_runtime_disable(dev);
> > -	pm_runtime_set_active(dev);
> >  	pm_runtime_enable(dev);
> >  
> >  	return 0;
> > -- 
> > 2.26.0
> 

------VQObM9Pl3j-Am1LaCn7xN8sri-O7OboG09SNkG7pZ6-k7KuL=_22549a_
Content-Type: text/plain; charset="utf-8"


------VQObM9Pl3j-Am1LaCn7xN8sri-O7OboG09SNkG7pZ6-k7KuL=_22549a_--
