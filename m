Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67BE332AA35
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 20:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1576559AbhCBTQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 14:16:01 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:35746 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238765AbhCBQ3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 11:29:13 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 122GP8lr028821;
        Tue, 2 Mar 2021 16:28:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=mIMowcrbj4TgmNWttx2aM+yXkbCVccyVmHGqavTctpY=;
 b=pOdQQ0Mp3n5dC55GVf7pCLe0iOnzBQysIf1EQXn2CdiSLVqJOBBWu5WAr14FQP6n1tbe
 7kuEmbovtYA0Wwco6KHoS2ygDw9aR1DFD2mRZdP2ksgz0D6LQovtJGf6hSsJkR3YLcqL
 inpkCVxns9NZqraa9sMV9HByrbaAMUh6VXTZB3zPj2g1cN307xLc/eLwZoHBNwLQEumD
 OmBST9g+tGO/xeRAVjXZ+a0mxDfScbufXu23Rupb3hzXBeClEJdGwtQ9zhwWseLcqBqT
 n/JFylhR1V8PS8b7lbS9Et53vCOBrN4exsRs935vb2vewenQXb4tmrUC71Pa5r8IcR2j EQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 36yeqn07fe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Mar 2021 16:28:19 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 122GOxL3018297;
        Tue, 2 Mar 2021 16:28:16 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 37000x7q6q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Mar 2021 16:28:16 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 122GSErF019697;
        Tue, 2 Mar 2021 16:28:14 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 02 Mar 2021 16:28:13 +0000
Date:   Tue, 2 Mar 2021 19:28:05 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        kbuild@lists.01.org, kbuild test robot <lkp@intel.com>,
        kbuild-all@lists.01.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: drivers/pinctrl/qcom/pinctrl-lpass-lpi.c:458 lpi_config_set()
 error: uninitialized symbol 'strength'.
Message-ID: <20210302162805.GV2222@kadam>
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
 definitions=main-2103020129
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9911 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=999 suspectscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103020129
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

They will call syzbot warning at runtime as well.  Syzbot complains
about the read, and not that the value is important for flow analysis.

regards,
dan carpenter

