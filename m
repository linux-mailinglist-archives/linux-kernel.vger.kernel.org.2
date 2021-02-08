Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA7A7314055
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 21:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236713AbhBHUXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 15:23:12 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:58644 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235961AbhBHS7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 13:59:06 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 118IfOSq187494;
        Mon, 8 Feb 2021 18:58:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=ESN4pvY7wPX52ORAOP/fxbyeolt7DhvyEd465ssL220=;
 b=sycL5PL1XXUIZqG1Z3/xGDuLePm4jSOfCtLq4T6/IoPXvaXpwgLSB4VuYUsMMuW5R+K6
 dJM9A+BaGm46Kmjj0Y7msU6oy7x86LQUmHyw0KPiTCgrmQzyWCqrpr488KZ+LDcc3tOs
 o7PlqtISe+cK5RFPLclcx1xyiREpvBa/q0FNjiBnlZShIHFGqv3jdIF1hMp/wLOhugII
 AbuJbJEof3gbweeXwxHrY8PZ+fuecI2972bWimhSjDgkWbyvQfJ9rlBYhGG8fRvQgZTX
 /rhTM5rpguYe5PGtLGrKkW+dYPVoOD8nBP43+8UtHqVsTn0BNZiRI3od0CNT4PZVCZR1 Zw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 36hk2kd0mj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Feb 2021 18:58:21 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 118IdpJX053151;
        Mon, 8 Feb 2021 18:58:19 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 36j4pmqbbs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Feb 2021 18:58:19 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 118IwH2R029843;
        Mon, 8 Feb 2021 18:58:18 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 08 Feb 2021 10:58:17 -0800
Date:   Mon, 8 Feb 2021 21:58:10 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ioana Ciornei <ciorneiioana@gmail.com>
Cc:     gregkh@linuxfoundation.org, laurentiu.tudor@nxp.com,
        linux-kernel@vger.kernel.org, Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: Re: [PATCH 1/3] bus: fsl-mc: Fix test for end of loop
Message-ID: <20210208185810.GM20820@kadam>
References: <20210208170949.3070898-1-ciorneiioana@gmail.com>
 <20210208170949.3070898-2-ciorneiioana@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210208170949.3070898-2-ciorneiioana@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9889 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102080114
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9889 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 priorityscore=1501 clxscore=1011 impostorscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102080114
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 08, 2021 at 07:09:47PM +0200, Ioana Ciornei wrote:
> From: Dan Carpenter <dan.carpenter@oracle.com>
> 
> The "desc" pointer can't possibly be NULL here.  If we can't find the
> correct "desc" then tt points to the last element of the
> fsl_mc_accepted_cmds[] array.  Fix this by testing if
> "i == FSL_MC_NUM_ACCEPTED_CMDS" instead.
> 
> Fixes: 2cf1e703f066 ("bus: fsl-mc: add fsl-mc userspace support")
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Generally the tags are expected to go in chronological order:

Fixes: commit
Signed-off-by: Author
Acked-by: Whoever
Signed-off-by: Maintainer

regards,
dan carpenter

