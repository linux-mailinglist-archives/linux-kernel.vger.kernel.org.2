Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7D83405C4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 13:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbhCRMln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 08:41:43 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:50650 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbhCRMlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 08:41:17 -0400
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210318124115epoutp01843cda84ff905a836838195b4baab553~tcEMpXGdQ0164501645epoutp01P
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 12:41:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210318124115epoutp01843cda84ff905a836838195b4baab553~tcEMpXGdQ0164501645epoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1616071275;
        bh=11BcnpzQFDKnBsBW46q6ydlQ/5Qwougb2EVJLwZjeMc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=g4+zv6Ayz+n8cp04JPsqOUzmopId1oDRf1bJddCcReLZHlJ8i9TJVs4TnPVT5gz37
         g4k8D8UTPJwp2i5C47Mydkklv5miZSFrnIpaaOiwsqsP2h/A1wTX7dzgjt15HQTaf0
         qtzlua78sI63hVB/cuPOeAj9bzo4M56KKT0LJFFQ=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20210318124113epcas2p171c49d09c5263b54302059fb16b312f1~tcELiMV2X3207132071epcas2p1I;
        Thu, 18 Mar 2021 12:41:13 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.40.186]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4F1RTg72mbz4x9Pt; Thu, 18 Mar
        2021 12:41:11 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        17.FD.10621.76A43506; Thu, 18 Mar 2021 21:41:11 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20210318124110epcas2p273a333d13db63b48024d64c59f5e25ab~tcEIZ9S7U2110721107epcas2p2_;
        Thu, 18 Mar 2021 12:41:10 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210318124110epsmtrp2d5f6e499544f25c68a01337be452b866~tcEIYe6Jr1985119851epsmtrp2M;
        Thu, 18 Mar 2021 12:41:10 +0000 (GMT)
X-AuditID: b6c32a45-337ff7000001297d-77-60534a67c709
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B5.3C.13470.66A43506; Thu, 18 Mar 2021 21:41:10 +0900 (KST)
Received: from rack03 (unknown [12.36.155.109]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20210318124110epsmtip232d67f5df824a2bfbdd89cd3c7a20a1f~tcEIOSbHL2771327713epsmtip2z;
        Thu, 18 Mar 2021 12:41:10 +0000 (GMT)
Date:   Thu, 18 Mar 2021 21:42:12 +0900
From:   taehyun cho <taehyun.cho@samsung.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     balbi@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: dwc3: remove 'pm_runtime_set_active' in resume
 callback
Message-ID: <20210318124212.GC138912@rack03>
MIME-Version: 1.0
In-Reply-To: <20210317151159.GA488655@rowland.harvard.edu>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkk+LIzCtJLcpLzFFi42LZdljTXDfdKzjB4NIbU4tjbU/YLZoXr2ez
        uLxrDpvFomWtzBYTfl9gc2D12LSqk81j/9w17B6z7/5g9Pi8SS6AJSrHJiM1MSW1SCE1Lzk/
        JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwdor5JCWWJOKVAoILG4WEnfzqYo
        v7QkVSEjv7jEVim1ICWnwNCwQK84Mbe4NC9dLzk/18rQwMDIFKgyISfj34+njAUPBSom/ZJt
        YNzE28XIySEhYCIxvf8VaxcjF4eQwA5GiebGRjYI5xOjxJaFzxlBqoQEvjFK/H1dBNOx7MpW
        RoiivYwSW19fgup4wiixaN8vdpAqFgFViSnvNjCD2GwC2hL7m2+ygtgiAloSm5teMoM0MAs0
        MErMP9sE1iAsECwx710HC4jNK6AjMfXUVVYIW1Di5MwnYHFOASuJaQ++AK3m4BAVUJF4dbAe
        ZI6EwEt2iY7eP8wgcQkBF4kHdzkgLhWWeHV8CzuELSXx+d1eNoj6dkaJXyfWsEI4UxglPqw7
        xQhRZSwx61k7mM0skCnR+Hg1G8RQZYkjt1ggwnwSHYf/skOEeSU62oQgOlUl2i/eZ4OwpSUu
        bb4JZXtIfPu8ghkSQJOYJOb9XcY2gVF+FpLXZiHZBmHrSCzY/QnI5gCypSWW/+OAMDUl1u/S
        X8DIuopRLLWgODc9tdiowBA5sjcxgtOklusOxslvP+gdYmTiYDzEKMHBrCTCa5oXkCDEm5JY
        WZValB9fVJqTWnyI0RQYUROZpUST84GJOq8k3tDUyMzMwNLUwtTMyEJJnLfY4EG8kEB6Yklq
        dmpqQWoRTB8TB6dUA5MEZ8EiHjtbzYvnls/TVTEsjmMWj0tLdjsu8Ue/4Vrt3don91w9H0UK
        BucsmltSFbR1BVvn/IMMoseVpY+oJl7r2Tjl0A4X/5qIxvYD1pctfaTjbA//CzuiZW45q+dc
        wcbg+mXh3jufBxxMuanUmpi0eYvx1sSUrX/9HtenhS0onnYw0SprGvuelyH7fbmjjfSePCxM
        uPJ+/4KA0oZygcOfHgtzBHR15tVpTA15OMO3VLJwrQmjRP89mfz3HzlWhkV//8pS//7hsl0+
        9W2H7df9ZP2WN/mdcXVun94b78PbdHzXzAsqnfxxxl3+C0qO248w/eOc9Lsx62P07lcbJOc9
        W7nmxmb9nZc3qm7zKVViKc5INNRiLipOBAANS7bhHAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsWy7bCSvG6aV3CCQddJCYtjbU/YLZoXr2ez
        uLxrDpvFomWtzBYTfl9gc2D12LSqk81j/9w17B6z7/5g9Pi8SS6AJYrLJiU1J7MstUjfLoEr
        4+G2rIJ5fBX/729ia2Ds4O5i5OSQEDCRWHZlKyOILSSwm1HixCUJiLi0xKnHC5ghbGGJ+y1H
        WCFqHjFKTPyXAGKzCKhKTHm3AayGTUBbYn/zTbAaEQEtic1NL4HiXBzMAg2MEvPPNrGDJIQF
        giXmvetgAbF5BXQkpp66ygpSJCQwiUliystzbBAJQYmTM5+AFTEDTbrx7yVTFyMHkC0tsfwf
        B0iYU8BKYtqDL4wgYVEBFYlXB+snMArOQtI8C0nzLITmBYzMqxglUwuKc9Nziw0LDPNSy/WK
        E3OLS/PS9ZLzczcxggNcS3MH4/ZVH/QOMTJxMB5ilOBgVhLhNc0LSBDiTUmsrEotyo8vKs1J
        LT7EKM3BoiTOe6HrZLyQQHpiSWp2ampBahFMlomDU6qBiWteoISbgIy7mFdVO5Pntv+Cmonc
        i5cZTFi4dmbe2nnTr3e9C7p1auJzhUvTXks8O1Fn4Ph50+dPn2yLdr0Nso05tSioWEJ4x487
        NQ1iSgWFhk+F7vtl7VgXUL5y4zfdqdfXO56UabHd01M+Me/nnPl3HNp7Z4bKcPKIW9Sv4trQ
        IMmksXFG/p7wH1um7D7x4mLHuduHGau75u33sNUP1kxSDJL1m6FoPftulkfWpSW75lyeZV3/
        yNamZw77PUeOWOu/jMe9o6592tsTcubUzNvH5Ja+Och8lCvl459TjC9ijLYq7n/lUXJwosrk
        muenan1zzWWTg6TnHvpcz16izzlh3onN04XWMebcsDN+5KrEUpyRaKjFXFScCADc7y/F3wIA
        AA==
X-CMS-MailID: 20210318124110epcas2p273a333d13db63b48024d64c59f5e25ab
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----VQObM9Pl3j-Am1LaCn7xN8sri-O7OboG09SNkG7pZ6-k7KuL=_23e9e0_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210315074223epcas2p11ddf190ec730f8629c1310117135f813
References: <CGME20210315074223epcas2p11ddf190ec730f8629c1310117135f813@epcas2p1.samsung.com>
        <20210315074317.7736-1-taehyun.cho@samsung.com>
        <20210315141335.GA402778@rowland.harvard.edu>
        <20210317082520.GB138912@rack03>
        <20210317151159.GA488655@rowland.harvard.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------VQObM9Pl3j-Am1LaCn7xN8sri-O7OboG09SNkG7pZ6-k7KuL=_23e9e0_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Wed, Mar 17, 2021 at 11:11:59AM -0400, Alan Stern wrote:
> On Wed, Mar 17, 2021 at 05:25:20PM +0900, taehyun cho wrote:
> > On Mon, Mar 15, 2021 at 10:13:35AM -0400, Alan Stern wrote:
> > > On Mon, Mar 15, 2021 at 04:43:17PM +0900, taehyun cho wrote:
> > > > 'pm_runtime_set_active' sets a flag to describe rumtime status.
> > > > This flag is automatically set in pm_runtime_get_sync/put_sync API.
> > > > 'pm_runtime_set_active' checks the runtime status of parent device.
> > > > As a result, the below error message is printed.
> > > > dwc3 11110000.dwc3: runtime PM trying to activate child device
> > > > 11110000.dwc3 but parent (11110000.usb) is not active.
> > > 
> > > This is very suspicious.  That error message indicates a real error is 
> > > present; removing these pm_runtime_set_active calls won't fix the error.
> > > 
> > > You need to determine why the parent platform device 11110000.usb isn't 
> > > active when the dwc3 probe and resume routines are called.  It seems 
> > > likely that there is a bug in the platform device's driver.
> > > 
> > > Alan Stern
> > >
> > 
> > Alan,
> > 
> > Thanks to your comments, I checked our platform device driver and found
> > the problem. Our parent platform device didn't set active in resume
> > callback. This made a problem.
> 
> Ah, good.  Does the platform driver set the active flag in its probe 
> routine?
>

PM resume callback function in our platform driver had a bug.
Resume callback function doesn't set active flag in 'pm_runtime_suspended' state.
This is a obvious bug. We are rebuilding our platform device driver. This bug
looks inserted while rebuilding a driver.

Thanks.

Taehyun Cho

> >  Thank you for the help and sorry for
> > disturbing you.
> 
> No problem at all.
> 
> Alan Stern
> 

------VQObM9Pl3j-Am1LaCn7xN8sri-O7OboG09SNkG7pZ6-k7KuL=_23e9e0_
Content-Type: text/plain; charset="utf-8"


------VQObM9Pl3j-Am1LaCn7xN8sri-O7OboG09SNkG7pZ6-k7KuL=_23e9e0_--
