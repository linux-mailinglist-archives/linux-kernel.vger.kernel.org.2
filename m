Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D09733EB5E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 09:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbhCQIYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 04:24:50 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:41155 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhCQIY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 04:24:26 -0400
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210317082423epoutp0226e325eaef4c17615f196eda20295b3a~tE6poYoQ63227432274epoutp02e
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 08:24:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210317082423epoutp0226e325eaef4c17615f196eda20295b3a~tE6poYoQ63227432274epoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1615969463;
        bh=/wFcLEJ4RhhU0ctmdSOlI+6C+UgAlyzjcZkKgXeK7Eg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gW9EORhELcrEbJArjB6T9e0E87EAXvkz8ZnKcVumoH3OSdDQP3It+u4/XJgElDSEQ
         YXNSccEWWvtOk9JLWZaLMRXT7uxuzFW5rRzRtxV7L7IY7+EcUf+O82+NSabd2RT+iP
         4lg8rPuyJETDu85JIPacBs6QgkL3meISAoa7j5go=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20210317082423epcas2p28b88950676c2e0406a9ba35459579cfa~tE6pUVVla1858218582epcas2p2L;
        Wed, 17 Mar 2021 08:24:23 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.40.186]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4F0jqn2vrPz4x9Px; Wed, 17 Mar
        2021 08:24:21 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        12.4B.05262.2BCB1506; Wed, 17 Mar 2021 17:24:18 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20210317082418epcas2p1ab980cdce32e463c8613f26b88cb65e6~tE6kfIafM2216622166epcas2p1T;
        Wed, 17 Mar 2021 08:24:18 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210317082418epsmtrp2ebfbb5ea8fcbb7eb2b8294168d661a90~tE6keP-BA2950029500epsmtrp2H;
        Wed, 17 Mar 2021 08:24:18 +0000 (GMT)
X-AuditID: b6c32a47-b97ff7000000148e-2e-6051bcb2b471
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        D9.79.08745.2BCB1506; Wed, 17 Mar 2021 17:24:18 +0900 (KST)
Received: from rack03 (unknown [12.36.155.109]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20210317082418epsmtip1e2a0705ea86b56b0d03b2a8df7ab274b~tE6kU_dZC1899918999epsmtip1B;
        Wed, 17 Mar 2021 08:24:18 +0000 (GMT)
Date:   Wed, 17 Mar 2021 17:25:20 +0900
From:   taehyun cho <taehyun.cho@samsung.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     balbi@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        taehyun.cho@samsung.com
Subject: Re: [PATCH] usb: dwc3: remove 'pm_runtime_set_active' in resume
 callback
Message-ID: <20210317082520.GB138912@rack03>
MIME-Version: 1.0
In-Reply-To: <20210315141335.GA402778@rowland.harvard.edu>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIJsWRmVeSWpSXmKPExsWy7bCmhe7mPYEJBpMELY61PWG3aF68ns3i
        8q45bBaLlrUyW0z4fYHNYtJBUQc2j02rOtk89s9dw+4x++4PRo++LasYPT5vkgtgjcqxyUhN
        TEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAHar6RQlphTChQK
        SCwuVtK3synKLy1JVcjILy6xVUotSMkpMDQs0CtOzC0uzUvXS87PtTI0MDAyBapMyMn4M2U/
        Y8FpoYoXt1pYGxjn8ncxcnBICJhI7Fov1MXIxSEksINRYvKTd4wQzidGiVXrG1kgnM+MEt9a
        ZjB3MXKCdfzZMpsZIrGLUeLQxF2sEM4TRomTi26yg1SxCKhK9D19ANbBJqAtsb/5JiuILSKg
        JbG56SVYN7PAbEaJo7v3sIEkhAWCJea96wDax87BK6Aj8RksyisgKHFy5hMWEJtTwEqi8893
        JpCzRQVUJF4drAeZIiHwlV3izel7LBDHuUhMWXgN6lBhiVfHt7BD2FISn9/tZYNoaGeU+HVi
        DSuEM4VR4sO6U4wQVcYSs561g9nMApkS/Rd+MUECSVniyC0WiDCfRMfhv+wQYV6JjjYhiE5V
        ifaL99kgbGmJS5tvQtkeEt8+r4AG1n5Gib1zV7FNYJSfheS3WUi2Qdg6Egt2f2KbBbSCGWjW
        8n8cEKamxPpd+gsYWVcxiqUWFOempxYbFRgjR/YmRnDa1HLfwTjj7Qe9Q4xMHIyHGCU4mJVE
        eE3zAhKEeFMSK6tSi/Lji0pzUosPMZoC42kis5Rocj4wceeVxBuaGpmZGViaWpiaGVkoifMW
        GzyIFxJITyxJzU5NLUgtgulj4uCUamAKu5kYcPX1LHGOH09Vf7zhmaXQkFV8cOUfsVgFc09B
        zmOFqyW4plyzueH3odNzBZv09WiJ6Ft5J26Gn46tc3vgM2Oj7CZJFdZc4SWbPiVGnRM4MkNb
        zy/9zWfl6UzTBBllPGaeLNz9/cwh6b73mTr+Zjc/XEt+mmkWPZ1L7dOFtLKnJUd3TmO/vb1z
        p+8C1YXTrzPlb8jPN33HKxr+5fHeTMnTjybd8znMHxRjlD9V89gk1bQyzqqaaWwGIue/Nl5T
        bPcInGejd/THScMHPfv8C6LTjptkSdj/7Z9q95h1W/wTL/EDrPc3q3nyLZq3ZOu6F70/9149
        sbpb8ojbft5571jytaPmR804YTHpzi8pJZbijERDLeai4kQAmB9UfyQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGLMWRmVeSWpSXmKPExsWy7bCSnO6mPYEJBqufCVkca3vCbtG8eD2b
        xeVdc9gsFi1rZbaY8PsCm8Wkg6IObB6bVnWyeeyfu4bdY/bdH4wefVtWMXp83iQXwBrFZZOS
        mpNZllqkb5fAlTHh9Uu2gg6BihtzH7A3MH7m6WLk5JAQMJH4s2U2cxcjF4eQwA5Gic4VzUwQ
        CWmJU48XMEPYwhL3W46wQhQ9YpQ4e2A9O0iCRUBVou/pA7AiNgFtif3NN1lBbBEBLYnNTS/B
        pjILzGaUOLp7DxtIQlggWGLeuw6WLkZ2Dl4BHYnPbBAz9zNKtJ87xgJSwisgKHFy5hMwmxlo
        zo1/L4EO4gCypSWW/+MACXMKWEl0/vkOFhYVUJF4dbB+AqPgLCTNs5A0z0JoXsDIvIpRMrWg
        ODc9t9iwwCgvtVyvODG3uDQvXS85P3cTIzjotbR2MO5Z9UHvECMTB+MhRgkOZiURXtO8gAQh
        3pTEyqrUovz4otKc1OJDjNIcLErivBe6TsYLCaQnlqRmp6YWpBbBZJk4OKUamFo38Syzmvox
        vSC47Lnxi/J/EotSuIwubD6UJ+OavGcaR8WPnQ6L5BzjTjDo1/Erry3geiC3jmfSOtV2w5jW
        S5tSrPhnSHAzTnGO5eG19J3XHyLLZiWd7nxafpbEWq3Ta1lnL9Jo+9+R1WUbNvvJC6GtHpq5
        h0wuH5bxlMqJ3ZbwK35VVdb/7o/fDqrGaPxSXv59x77NGU3ap5WeblSdXtCy10pr75UjK1WO
        8AaYrpb0XXwqyX76OimWGi/rlof93sa7uAId9iTf2PaqjM+lduHc/mePVhoFWn977HZwSnxA
        7umPd3WV539VaFqoy5f5JObqoRlfJr560pQqxzd7+Y2lH5XEau4uK/up9O3MRSWW4oxEQy3m
        ouJEAP4ac3DpAgAA
X-CMS-MailID: 20210317082418epcas2p1ab980cdce32e463c8613f26b88cb65e6
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----dZHoiG3rfwxb_Py8wGLYailixDOP787k4OKmtNPLilWg7srF=_2304d0_"
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

------dZHoiG3rfwxb_Py8wGLYailixDOP787k4OKmtNPLilWg7srF=_2304d0_
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

Alan,

Thanks to your comments, I checked our platform device driver and found
the problem. Our parent platform device didn't set active in resume
callback. This made a problem. Thank you for the help and sorry for
disturbing you.

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

------dZHoiG3rfwxb_Py8wGLYailixDOP787k4OKmtNPLilWg7srF=_2304d0_
Content-Type: text/plain; charset="utf-8"


------dZHoiG3rfwxb_Py8wGLYailixDOP787k4OKmtNPLilWg7srF=_2304d0_--
