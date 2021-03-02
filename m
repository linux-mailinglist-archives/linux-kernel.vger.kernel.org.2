Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49D3332AC20
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 22:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381467AbhCBVKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 16:10:10 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:40730 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352079AbhCBSK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 13:10:57 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 122GjDhd068314;
        Tue, 2 Mar 2021 17:02:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=JfHN7bR7XJbye+/fOE8L0CdgtTYsUUluVDX1OIk1+9w=;
 b=Cl4ZToh7Svl6FMTp0Q1NBZX5PrsoawG24bKigjtCSPUiK2EIFrUs7kxJLGgIYhmu0dnP
 L9ITCmaDHdDm3ITVSOverds0OzhXpRczfdo1PVG3CC8uuYpUZC9gsf/HchDPR+DxMoaK
 tv6mWEntMuceuZhL48S7ahJ0x8KYFRrr3fSZ4oKeW0lCZDC06NNdmN7w13DgDFm72czU
 muTPUthV3AvZ6ylL+JrbFW85oripH2FQjTPp/fUrWA0ozcL9kE0B19xSPt7SYBpfVEEJ
 zR/fRlw6tLCeZ6DO16bXeg6QUwlGv96AvgG2HDTMAnA6g/CzincVpmAcUYkWLMa5/YFS lA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 36yeqn0bg5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Mar 2021 17:02:01 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 122H0xR7036909;
        Tue, 2 Mar 2021 17:01:59 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 37000x9at5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Mar 2021 17:01:59 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 122H1voH001162;
        Tue, 2 Mar 2021 17:01:57 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 02 Mar 2021 09:01:57 -0800
Date:   Tue, 2 Mar 2021 20:01:49 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        kbuild@lists.01.org, kbuild test robot <lkp@intel.com>,
        kbuild-all@lists.01.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: drivers/pinctrl/qcom/pinctrl-lpass-lpi.c:458 lpi_config_set()
 error: uninitialized symbol 'strength'.
Message-ID: <20210302170149.GX2222@kadam>
References: <20210227092152.GC2087@kadam>
 <CACRpkdbWtBA-ptCF7prizoP1D9cshWgpt8r4CGRRfxwcXiX61g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdbWtBA-ptCF7prizoP1D9cshWgpt8r4CGRRfxwcXiX61g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9911 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103020131
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9911 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=999 suspectscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103020130
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 04:47:01PM +0100, Linus Walleij wrote:
> On Sat, Feb 27, 2021 at 10:22 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> 
> > New smatch warnings:
> > drivers/pinctrl/qcom/pinctrl-lpass-lpi.c:458 lpi_config_set() error: uninitialized symbol 'strength'.
> >
> > Old smatch warnings:
> > drivers/pinctrl/qcom/pinctrl-lpass-lpi.c:457 lpi_config_set() error: uninitialized symbol 'pullup'.
> 
> I don't think these are real problems, but maybe there is some way to explicitly
> express that so that smatch knows as well?
> 

We chould just initialize it to zero.  Eventually, (or maybe already???),
zero initializing stack variables will be the default for kernels built
with modern compilers.  So initializing it to zero in that case won't
change runtime at all.

regards,
dan carpenter

