Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C104E32ADF5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2360233AbhCBWSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 17:18:10 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:43626 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376372AbhCBUqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 15:46:22 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 122GP3Va071559;
        Tue, 2 Mar 2021 16:32:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=BivTdPNGoqce3+4h3sjftkX1T8dbiGYAQs+L83n9Ad4=;
 b=Q1hJz12mSfqqeLZMBVLZ2zNF+ZE4a7ZoChM08KKqUToft3pIg+5I+qKNLyZQePRb9Wy8
 CBQgBEvC9ZDKLQjbk28WmM5WgcFIIER7zteWDqk64+s8aH3YVGFKuswzSKtTnqebtRRC
 HCrJhahvZaJb6t6uhzYTW6vVwmysNRi2n/4MrkowrAUL64fnnDhgYCz4zlpu6IJ9X4OF
 bf+REvYlkN4dEvYCjfaiG+EkY7BhAyX14Q35oEmx0cbbObLjXOj0G2xy/hOQOQscqXt3
 oIQ6iKrYUvK0aef5LRzJaYC/7ffcFnfYlYj0siU97PnvZvFfr7DyP6i0Vs44DMK7iX/6 oQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 36ybkb8d1f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Mar 2021 16:32:21 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 122GOx15172440;
        Tue, 2 Mar 2021 16:32:20 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 36yynpcpae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Mar 2021 16:32:20 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 122GWJWp001741;
        Tue, 2 Mar 2021 16:32:19 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 02 Mar 2021 08:32:18 -0800
Date:   Tue, 2 Mar 2021 19:32:11 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        kbuild@lists.01.org, kbuild test robot <lkp@intel.com>,
        kbuild-all@lists.01.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: drivers/pinctrl/qcom/pinctrl-lpass-lpi.c:458 lpi_config_set()
 error: uninitialized symbol 'strength'.
Message-ID: <20210302163211.GW2222@kadam>
References: <20210227092152.GC2087@kadam>
 <CACRpkdbWtBA-ptCF7prizoP1D9cshWgpt8r4CGRRfxwcXiX61g@mail.gmail.com>
 <20210302162805.GV2222@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302162805.GV2222@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9911 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103020129
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9911 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 mlxlogscore=999 adultscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103020129
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 07:28:05PM +0300, Dan Carpenter wrote:
> On Tue, Mar 02, 2021 at 04:47:01PM +0100, Linus Walleij wrote:
> > On Sat, Feb 27, 2021 at 10:22 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > 
> > > New smatch warnings:
> > > drivers/pinctrl/qcom/pinctrl-lpass-lpi.c:458 lpi_config_set() error: uninitialized symbol 'strength'.
> > >
> > > Old smatch warnings:
> > > drivers/pinctrl/qcom/pinctrl-lpass-lpi.c:457 lpi_config_set() error: uninitialized symbol 'pullup'.
> > 
> > I don't think these are real problems, but maybe there is some way to explicitly
> > express that so that smatch knows as well?
> 
> They will call syzbot warning at runtime as well.  Syzbot complains
> about the read, and not that the value is important for flow analysis.

s/flow analysis/flow control/...  Syzbot doesn't care if the
uninitialized value affects runtime.

regards,
dan carpenter

