Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98C383618ED
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 06:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237133AbhDPEeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 00:34:19 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40342 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234735AbhDPEeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 00:34:18 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13G4UGuk120220;
        Fri, 16 Apr 2021 04:33:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=UzHh1s1A9xZLwKQW9CzUH80x6lRo4mY2afOfWgLd+34=;
 b=O3AN2e6FVhdjRUxyhQIZFAw8cRDklDeFRqA3Sga7B1le4vBWyVmOKSIDTSzhTOdIniG9
 vd6xDTzMYAKinHvdiir1n/OGLDYlnRbmEqks/0juzKPNF3TTnsL2PZ6aBNOvBGqV9HYT
 sS1pkddCYkIQQ0yb9UMrOBLk0iJxYtQ0Lb6QGGuW/8x6b3V/5SPFnPY3L+7m33uNNut3
 s+WwGu3GaKYmG9Q/5xicJRil6bB+UKxcCRuB95ePX6Y3bKrHXfpBGMYXDfChNh/vaNxV
 ijPc5KvUqPUtw3cYrtlGbyFqcBlHqcwZ5Sy+hXRxBTwZyb7xkNq2MxR+75yMmEOifsYj Lw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 37u3erqumm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Apr 2021 04:33:47 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13G4TevP160557;
        Fri, 16 Apr 2021 04:33:44 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 37unswmt5g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Apr 2021 04:33:44 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 13G4Xhvm012119;
        Fri, 16 Apr 2021 04:33:43 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 16 Apr 2021 04:33:42 +0000
Date:   Fri, 16 Apr 2021 07:33:36 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Rob Clark <robdclark@chromium.org>
Cc:     Akhil P Oommen <akhilpo@codeaurora.org>, kbuild@lists.01.org,
        lkp@intel.com, kbuild-all@lists.01.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [kbuild] drivers/gpu/drm/msm/adreno/a3xx_gpu.c:600
 a3xx_gpu_init() error: passing non negative 1 to ERR_PTR
Message-ID: <20210416043336.GM6048@kadam>
References: <20210409093738.GH6048@kadam>
 <d3cd5c0b-f30e-6130-582d-7b68d8320507@codeaurora.org>
 <CAJs_Fx7fgeURHzm2k-Bb8h_xy1=-5vrbt+jt5J=vEzr1rEd8Cw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJs_Fx7fgeURHzm2k-Bb8h_xy1=-5vrbt+jt5J=vEzr1rEd8Cw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9955 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104160033
X-Proofpoint-ORIG-GUID: 24_kf9yiqzMsssr6F_2R75Yr0qp1Mo42
X-Proofpoint-GUID: 24_kf9yiqzMsssr6F_2R75Yr0qp1Mo42
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9955 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 clxscore=1015
 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104160033
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 04:21:01PM -0700, Rob Clark wrote:
> > > 5785dd7a8ef0de Akhil P Oommen 2020-10-28  571         icc_path = devm_of_icc_get(&pdev->dev, "gfx-mem");
> > > 5785dd7a8ef0de Akhil P Oommen 2020-10-28  572         ret = IS_ERR(icc_path);
> > > 5785dd7a8ef0de Akhil P Oommen 2020-10-28  573         if (ret)
> > > 5785dd7a8ef0de Akhil P Oommen 2020-10-28  574                 goto fail;
> > >
> > > IS_ERR() returns/true false so this will lead to an Oops in the caller.
> > >
> > >       icc_path = devm_of_icc_get(&pdev->dev, "gfx-mem");
> > >       if (IS_ERR(icc_path)) {
> > >               ret = PTR_ERR(icc_path);
> > >               goto fail;
> > >       }
> > Agree.
> >
> > >
> > > 5785dd7a8ef0de Akhil P Oommen 2020-10-28  575
> > > 5785dd7a8ef0de Akhil P Oommen 2020-10-28  576         ocmem_icc_path = devm_of_icc_get(&pdev->dev, "ocmem");
> > > 5785dd7a8ef0de Akhil P Oommen 2020-10-28  577         ret = IS_ERR(ocmem_icc_path);
> > > 5785dd7a8ef0de Akhil P Oommen 2020-10-28  578         if (ret) {
> > > 5785dd7a8ef0de Akhil P Oommen 2020-10-28  579                 /* allow -ENODATA, ocmem icc is optional */
> > > 5785dd7a8ef0de Akhil P Oommen 2020-10-28  580                 if (ret != -ENODATA)
> > > 5785dd7a8ef0de Akhil P Oommen 2020-10-28  581                         goto fail;
> > >
> > > Same.  ret is true/false so it can't be equal to -ENODATA, plus the
> > > caller will Oops.
> > >
> > > Btw, this patch removed the assignments:
> > >
> > >               gpu->icc_path = of_icc_get(dev, "gfx-mem");
> > >               gpu->ocmem_icc_path = of_icc_get(dev, "ocmem");
> > >
> > > So I think "gpu->icc_path" and "gpu->ocmem_icc_path" are always
> > > NULL/unused and they should be removed.
> > >
> > Agree. Will share a fix.
> > Thanks, Dan.
> 
> gpu->ocmem_icc_path/icc_path is used on older devices.. it sounds like
> we broke some older devices and no one has noticed yet?

This is error paths and dead code.  Probably no one is affected in
real life.

regards,
dan carpenter
