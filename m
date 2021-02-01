Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC1E530A20A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 07:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbhBAGgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 01:36:21 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:59557 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbhBAGUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 01:20:03 -0500
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210201061822epoutp0261ffd043f7b119b36b5982386fa37ee6~fi0DwSR1E0701207012epoutp02S
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 06:18:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210201061822epoutp0261ffd043f7b119b36b5982386fa37ee6~fi0DwSR1E0701207012epoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1612160302;
        bh=/gKgMicK2/d+7RHapjaLlXXe/213s+qKQEHFeVCiDa0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gs2Eqm1it+UBJJRmKvrJyW+NC5j0gsXO6I+vXwPmStc7+6M01nMTz7SJVqa9XlBea
         6tG/YUKLuK5pc9cH5VkUfAkAp6JuFFp1Z+1/wyPROI6907r7eG2NYDh2b5hVGldK3k
         KDUYxq1krEdck9Xkgk9z8vg1R73nUr01xJOgxusQ=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20210201061822epcas2p2af78c3eda718f01591645078f300e38d~fi0DjRlJO3100031000epcas2p2Y;
        Mon,  1 Feb 2021 06:18:22 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.40.186]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4DTd6j2ss4z4x9Q2; Mon,  1 Feb
        2021 06:18:21 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        0D.E5.05262.C2D97106; Mon,  1 Feb 2021 15:18:20 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20210201061820epcas2p4ee9f0c9415c2157b6ebcb152625c2d2f~fi0BV_7_o0777207772epcas2p4f;
        Mon,  1 Feb 2021 06:18:20 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210201061820epsmtrp23b5ae3713cdcfa462a2315431aa947b6~fi0BVEN5H2931129311epsmtrp2d;
        Mon,  1 Feb 2021 06:18:20 +0000 (GMT)
X-AuditID: b6c32a47-1259fa800000148e-22-60179d2c6235
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        08.41.13470.B2D97106; Mon,  1 Feb 2021 15:18:19 +0900 (KST)
Received: from ubuntu (unknown [12.36.155.120]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20210201061819epsmtip18a5bfe678b5f2c4de91c098ac373cc7a~fi0BKdoA82739327393epsmtip1c;
        Mon,  1 Feb 2021 06:18:19 +0000 (GMT)
Date:   Mon, 1 Feb 2021 15:06:46 +0900
From:   Jung Daehwan <dh10.jung@samsung.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <wcheng@codeaurora.org>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "supporter:USB SUBSYSTEM open list:DESIGNWARE USB3 DRD IP DRIVER" 
        <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: Re: usb: dwc3: gadget: skip pullup and set_speed after suspend
Message-ID: <20210201060646.GA188943@ubuntu>
MIME-Version: 1.0
In-Reply-To: <20210201054539.GA188887@ubuntu>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnk+LIzCtJLcpLzFFi42LZdljTVFdnrniCwYoWCYtjbU/YLZoXr2ez
        uLxrDpvFomWtzBarFhxgt1jbNIvNgc3jcl8vk8emVZ1sHvvnrmH32LL/M6PH501yAaxROTYZ
        qYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QBcoKZQl5pQC
        hQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgoMDQv0ihNzi0vz0vWS83OtDA0MjEyBKhNyMm5c
        n8JaMJerYvvkYywNjPs5uhg5OCQETCR275DpYuTiEBLYwSixfOpXVgjnE6PE7tkdLBDON0aJ
        ByefsHcxcoJ1PNpzBcwWEtjLKNFxSAOi6AmjxIlVPWAJFgEViV0dTWwgNpuAlsS9HyeYQWwR
        AU+J6ws+s4LYzAK9TBIPN5qD2MIC7hITb99lAbF5BXQkVr2azwZhC0qcnPkELM4poCvRPuMX
        G8jZokDzXx2sB9krIfCTXWLvrmVQx7lILH55nhHCFpZ4dXwLVFxK4vO7vWwQL5dLLJpvB9Hb
        wSix5tNZqHpjiVnP2hkhbsuQmPdzPgtEvbLEkVssEGE+iY7Df9khwrwSHW1CEJ3KEtMvT2CF
        sCUlDr4+xwxR4iFxcp0WJKRuMkpceCM+gVF+FpK/ZiHZBWHrSCzY/YltFlA3s4C0xPJ/HBCm
        psT6XfoLGFlXMYqlFhTnpqcWGxUYI0f0JkZwytRy38E44+0HvUOMTByMhxglOJiVRHhPTRJL
        EOJNSaysSi3Kjy8qzUktPsRoCoykicxSosn5wKSdVxJvaGpkZmZgaWphamZkoSTOW2zwIF5I
        ID2xJDU7NbUgtQimj4mDU6qBSSrL5fOa3btajBaULJvKkLpOa251J++h2OQpzpycOts2cSgt
        uT7hbYR2wtPn2Zuer/7lukNme/2MqLnOhpfPOE7MMwh2mrTUjeH41x+HjOUOfugrS/24P7BF
        el/Zuwff8na9TN8dzLih+UTV9vzP7zv1s0psr+y6EHLKrvXu29ev/lpHh/J9mO3Cv6pwr773
        /hPvl2eWCKZwpJmu2ZHb4X3r2Lqzif83lfAt576WWi5rOFHHhNGh7Z5JVR6HpefVfR/15zV3
        2M/wf7zCPHqLnc8vrftb8k5EX+Bl2y/OYVL4Lf3epHkfVpbeFuY7+Z3/bZ7Vkw/MHZ8cBW5G
        P1OaLv7Z/t7DxnzGTwW5locfpCuxFGckGmoxFxUnAgAotogvIgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBLMWRmVeSWpSXmKPExsWy7bCSnK72XPEEg12frSyOtT1ht2hevJ7N
        4vKuOWwWi5a1MlusWnCA3WJt0yw2BzaPy329TB6bVnWyeeyfu4bdY8v+z4wenzfJBbBGcdmk
        pOZklqUW6dslcGUsnH2fqeAue8Xvj/+ZGxhnsHUxcnJICJhIPNpzhb2LkYtDSGA3o0TbwQZG
        iISkxNK5N9ghbGGJ+y1HWEFsIYFHjBIHZ3GD2CwCKhK7OprABrEJaEnc+3GCGcQWEfCUuL7g
        MyvIUGaBfiaJXxcugDULC7hLTLx9lwXE5hXQkVj1aj4bxObbjBL9e3ewQSQEJU7OfAJWxAw0
        9ca/l0xdjBxAtrTE8n8cIGFOAV2J9hm/2EDCokBHvDpYP4FRcBaS5llImmchNC9gZF7FKJla
        UJybnltsWGCYl1quV5yYW1yal66XnJ+7iREc+FqaOxi3r/qgd4iRiYPxEKMEB7OSCO+pSWIJ
        QrwpiZVVqUX58UWlOanFhxilOViUxHkvdJ2MFxJITyxJzU5NLUgtgskycXBKNTCdvNgrpW7I
        3P+B8aiw8ce991z+TV/bPYHhYu0SWecSx/d9sn2N9u+7bm14OW1jf+39h0e3l6zxeuPkvOZf
        e0F04DXDjJjE/o+awasLrnp1s/YF3J6TEyLLfjtN6prEpV8hMlub37hcfPZ2nb3qyWtVxYsT
        A06EbGO/nPvt2ALnk4teSUwuuTzZf3+mZ0W8f8+f46tEQ+R3/xOcdybN6NNsdVcvoWNmAQL/
        CrO6t2SxSNz74F/odiG/Z90NNR3Wxr8m0+vbAoXyF2ydp5/62/PVAY6tMfnqL+yusdxO4hIL
        mH+7ZfkWpQx/zb33FLLOLBfy2dUY1TgzwvWSsOkjrlqp43qsU/+aLGpdscfpSaESS3FGoqEW
        c1FxIgBB1Q696wIAAA==
X-CMS-MailID: 20210201061820epcas2p4ee9f0c9415c2157b6ebcb152625c2d2f
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----dZHoiG3rfwxb_Py8wGLYailixDOP787k4OKmtNPLilWg7srF=_804b8_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210120035123epcas2p2048f6d9896bd21f19d939a56fe0b6610
References: <CGME20210120035123epcas2p2048f6d9896bd21f19d939a56fe0b6610@epcas2p2.samsung.com>
        <1611113968-102424-1-git-send-email-dh10.jung@samsung.com>
        <87ft2qgxle.fsf@kernel.org> <20210201054539.GA188887@ubuntu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------dZHoiG3rfwxb_Py8wGLYailixDOP787k4OKmtNPLilWg7srF=_804b8_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Sun, Jan 24, 2021 at 05:31:57PM +0200, Felipe Balbi wrote:
> 
> Hi,
> 
> Daehwan Jung <dh10.jung@samsung.com> writes:
> > Sometimes dwc3_gadget_pullup and dwc3_gadget_set_speed are called after
> > entering suspend. That's why it needs to check whether suspend
> >
> > 1. dwc3 sends disconnect uevent and turn off. (suspend)
> > 2. Platform side causes pullup or set_speed(e.g., adbd closes ffs node)
> > 3. It causes unexpected behavior like ITMON error.
> 
> please collect dwc3 trace events showing this problem.
> 
> -- 
> balbi

Hi, balbi

I'm sorry for late reply. I pulled in belo patch and that issue didn't occur

usb: dwc3: gadget: Restart DWC3 gadget when enabling pullup

@ Wesley cheng
But, I think it needs to modify pm_rumtime_put to pm_runtime_put_sync_suspend
for syncronization. pm_rumtime_put calls rumtime_idle not runtime_suspend
Please check it.

usb: dwc3: gadget: Allow runtime suspend if UDC unbinded

Best Regards,
Jung Daehwan

------dZHoiG3rfwxb_Py8wGLYailixDOP787k4OKmtNPLilWg7srF=_804b8_
Content-Type: text/plain; charset="utf-8"


------dZHoiG3rfwxb_Py8wGLYailixDOP787k4OKmtNPLilWg7srF=_804b8_--
