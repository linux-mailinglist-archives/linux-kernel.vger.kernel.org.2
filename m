Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B91431C500
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 02:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbhBPBnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 20:43:33 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:28675 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbhBPBnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 20:43:31 -0500
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210216014246epoutp0298d6d5516435a05ae596f8c60e62e45e~kFutCdWjw0297002970epoutp02M
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 01:42:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210216014246epoutp0298d6d5516435a05ae596f8c60e62e45e~kFutCdWjw0297002970epoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1613439766;
        bh=wfwTm47lDge4YFd5N8PBRffYZhlfn4XosQPFzlkHm6E=;
        h=Date:From:To:Cc:Subject:Reply-To:In-Reply-To:References:From;
        b=HLZjFMBkuCiqPSUG745swCQryDJj07lDWef7JvTar+ki0I99HsR3YjjiWwqMHFGe6
         tg2vU7xmKekmv8I+dTGPkKzTi7L9jSQmJpoxi16SHoqylW78E2PZDMpkV91+Rq99HM
         mPUDEUt/ZnU4526OxJRohLe5ry8kwHpJd+NMKIRU=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20210216014245epcas2p3c73f4985f2cf74119bb46b25f8523fa3~kFur-_wGV1274712747epcas2p3g;
        Tue, 16 Feb 2021 01:42:45 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.40.183]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4DfkHk5Qxkz4x9Q8; Tue, 16 Feb
        2021 01:42:42 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        A4.11.56312.1132B206; Tue, 16 Feb 2021 10:42:41 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20210216014241epcas2p3f4f4eb9d21177b6a83ec8737ff282cee~kFuomCukO1310313103epcas2p3i;
        Tue, 16 Feb 2021 01:42:41 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210216014241epsmtrp1ed4b82c7d8adedd9a0b07b14404e3c8c~kFuolS3T21280712807epsmtrp1U;
        Tue, 16 Feb 2021 01:42:41 +0000 (GMT)
X-AuditID: b6c32a46-1efff7000000dbf8-a5-602b2311772e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        1E.2B.08745.1132B206; Tue, 16 Feb 2021 10:42:41 +0900 (KST)
Received: from ubuntu (unknown [12.36.155.120]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20210216014241epsmtip1bf37b83e00e16290268cae41d09fa5d6~kFuoZ6_811238812388epsmtip1k;
        Tue, 16 Feb 2021 01:42:41 +0000 (GMT)
Date:   Tue, 16 Feb 2021 10:30:52 +0900
From:   Jung Daehwan <dh10.jung@samsung.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Wesley Cheng <wcheng@codeaurora.org>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:DESIGNWARE USB3 DRD IP DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: usb: dwc3: gadget: Change runtime pm function for DWC3 runtime
 suspend
Message-ID: <20210216013052.GA37172@ubuntu>
Reply-To: eg Kroah-Hartman <gregkh@linuxfoundation.org>
MIME-Version: 1.0
In-Reply-To: <20210215174145.GA960831@rowland.harvard.edu>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHJsWRmVeSWpSXmKPExsWy7bCmma6gsnaCwe3FBhbH2p6wWzQvXs9m
        cXnXHDaLRctamS0m/L7AZrG2aRabA5vH5b5eJo9NqzrZPPbPXcPuMfvuD0aPz5vkAlijcmwy
        UhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgC5QUihLzCkF
        CgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BQYGhboFSfmFpfmpesl5+daGRoYGJkCVSbkZHx9
        to+94Ldwxa1nx9gaGFcIdDFyckgImEhM6djL2sXIxSEksINRYtOJ6YwQzidGid+/nzFBOJ8Z
        Jb5OXMMG07L6wh82iMQuRokD249DVT1hlDg79y8LSBWLgKrEzosXWEFsNgEtiXs/TjCD2CIC
        QRIt314ygdjMAicZJfZ8TQexhQVCJZ79bQLazcHBK6At8WF7EkhYSMBc4t+y+WAjeQUEJU7O
        fAJmcwpYSeyZf5wNpFxUQEXi1cF6kBMkBDo5JFp63kEd6iIx88UJKFtY4tXxLewQtpTEy/42
        dpBeCYFyiUXz7SB6Oxgl1nw6ywhRYywx61k7I8SZmRJXnn6DqleWOHKLBSLMJ9Fx+C9UmFei
        o00IolNZYvrlCawQtqTEwdfnmCFsD4lz295BQxro8d17P7JMYFSYheSzWUi2Qdg6Egt2f2Kb
        BbSCWUBaYvk/DghTU2L9Lv0FjKyrGMVSC4pz01OLjQqMkON9EyM4oWq57WCc8vaD3iFGJg7G
        Q4wSHMxKIrzsn7UShHhTEiurUovy44tKc1KLDzGaAmNsIrOUaHI+MKXnlcQbmhqZmRlYmlqY
        mhlZKInzFhs8iBcSSE8sSc1OTS1ILYLpY+LglGpgqpWcdUFq1brtm2uyTA4zzjkuv4b/Fztr
        5Ycp2bcNxR4lx2fGauc8uNDAmHN/QfGHRb8F10deb7jY9jtmhghruabgHivNbRN8v3reaLR7
        yM9d1uOW3BD2LrZSKrx1gkvQuaNv+s2Sex5lcW3SvPLV7/UpIYcC3hKfd7qcq1Mr7eVXbJeV
        XvYrXlzuiNxKR+vyMwtuHtBgXhb0e37Gnd3bFFKtgiIfHNc+sPA1Pwfnzo9n3t/P1hB8WiBt
        wGB2d/2r17uS3Oebf9qt2xHEZ1Kaa+VwSvHIoaa8lDv1q6fUOqh5XivfmJ/wxvMQW8vh4ro/
        u1mz2aW2iavxM77fw6qmuuyDdnlgjUorw5lPM9mVWIozEg21mIuKEwHpZHhBMQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsWy7bCSnK6gsnaCwYdmYYtjbU/YLZoXr2ez
        uLxrDpvFomWtzBYTfl9gs1jbNIvNgc3jcl8vk8emVZ1sHvvnrmH3mH33B6PH501yAaxRXDYp
        qTmZZalF+nYJXBmdzb/YCnYIVlx9dJu1gfEfbxcjJ4eEgInE6gt/2LoYuTiEBHYwSkxoucsG
        kZCUWDr3BjuELSxxv+UIK0TRI0aJTRuXs4AkWARUJXZevMAKYrMJaEnc+3GCGcQWEQiS+Pn6
        KCNIA7PAaUaJJUengyWEBUIlnv1tAkpwcPAKaEt82J4EEhYSMJf4t2w+C8SCk4wSbZdPg13B
        KyAocXLmE7BlzEALbvx7yQTSyywgLbH8HwdImFPASmLP/ONsIGFRARWJVwfrJzAKzULSPAtJ
        8yyE5gWMzKsYJVMLinPTc4sNC4zyUsv1ihNzi0vz0vWS83M3MYIjQktrB+OeVR/0DjEycTAe
        YpTgYFYS4WX/rJUgxJuSWFmVWpQfX1Sak1p8iFGag0VJnPdC18l4IYH0xJLU7NTUgtQimCwT
        B6dUA9MMKZMVgQt36z7J3MRc0mi/+vqEh0Uihzu+HJ6fF88rMaFsAdvmeS4fwlc3XolarTH9
        mtrFsIqJ2dc8haekBr+N4/WJ+t5odNydY5NKhvHFt+3/fq96maDw0kj0/D2ruqqnsy8pmB8/
        nWtcP503ff1pxg1cO2zyGTya90iG5IZu2f7k0y5ZFx6Xy8fyxC7O3bco8OZ7z+3z+ZhKlQKK
        zohOZRBOn3C2dQrTq245za5l7vecIm9UCnXfVvhm9dVp5Tm9j3N+NEoH8qfO5DstzVgvO2P1
        3yDFiULVt3/crPyimH1zDleKLbdzUf/kG0ahsS+jEn9lyvcYTeT6G6bswDShy3XnJq2Lt85s
        v/5xvo8SS3FGoqEWc1FxIgDpCgwB9wIAAA==
X-CMS-MailID: 20210216014241epcas2p3f4f4eb9d21177b6a83ec8737ff282cee
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----67xPSh7gQJE2vY6JU5h3EjeTyNsSGO5MVEyKVG.JoDNTAUCr=_10c571_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210215025057epcas2p205c3c283a8806d818d71f90c872c6e51
References: <CGME20210215025057epcas2p205c3c283a8806d818d71f90c872c6e51@epcas2p2.samsung.com>
        <1613356739-91734-1-git-send-email-dh10.jung@samsung.com>
        <20210215174145.GA960831@rowland.harvard.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------67xPSh7gQJE2vY6JU5h3EjeTyNsSGO5MVEyKVG.JoDNTAUCr=_10c571_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

Hello, Alan

On Mon, Feb 15, 2021 at 12:41:45PM -0500, Alan Stern wrote:
> On Mon, Feb 15, 2021 at 11:38:58AM +0900, Daehwan Jung wrote:
> > It seems pm_runtime_put calls runtime_idle callback not runtime_suspend callback.
> 
> How is this fact related to your patch?

I think we should cause dwc3_runtime_suspend at the time.
That's why I use pm_runtime_put_sync_suspend.

> 
> > It's better to use pm_runtime_put_sync_suspend to allow DWC3 runtime suspend.
> 
> Why do you think it is better?  The advantage of pm_runtime_put is that 
> it allows the suspend to occur at a later time in a workqueue thread, so 
> the caller doesn't have to wait for the device to go into suspend.
> 

We can assume DWC3 was already in suspend state if pm_runtime_get_sync
returns 0. DWC3 resumes due to pm_rumtime_get_sync but it doesn't
re-enter runtime_suspend but runtime_idle. pm_runtime_put decreases
usage_count but doesn't cause runtime_suspend.

1. USB disconnected
2. UDC unbinded
3. DWC3 runtime suspend
4. UDC binded unexpectedly
5. DWC3 runtime resume (pm_runtime_get_sync)
6. DWC3 runtime idle (pm_runtime_put)
   -> DWC3 runtime suspend again (pm_runtime_put_sync_suspend)

I've talked with Wesley in other patch.

usbb: dwc3: gadget: skip pullup and set_speed after suspend
patchwork.kernel.org/project/linux-usb/patch/1611113968-102424-1-git-send-email-dh10.jung@samsung.com

@ Wesley

I think We should guarantee DWC3 enters suspend again at the time.
How do you think?

Best Regards,
Jung Daehwan

> Alan Stern
> 


> > Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
> > ---
> >  drivers/usb/dwc3/gadget.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> > index aebcf8e..4a4b93b 100644
> > --- a/drivers/usb/dwc3/gadget.c
> > +++ b/drivers/usb/dwc3/gadget.c
> > @@ -2229,7 +2229,7 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
> >  	 */
> >  	ret = pm_runtime_get_sync(dwc->dev);
> >  	if (!ret || ret < 0) {
> > -		pm_runtime_put(dwc->dev);
> > +		pm_runtime_put_sync_suspend(dwc->dev);
> >  		return 0;
> >  	}
> >  
> > -- 
> > 2.7.4
> > 
> 

------67xPSh7gQJE2vY6JU5h3EjeTyNsSGO5MVEyKVG.JoDNTAUCr=_10c571_
Content-Type: text/plain; charset="utf-8"


------67xPSh7gQJE2vY6JU5h3EjeTyNsSGO5MVEyKVG.JoDNTAUCr=_10c571_--
