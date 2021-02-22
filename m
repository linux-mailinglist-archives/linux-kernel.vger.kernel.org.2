Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3F043210D9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 07:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbhBVG37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 01:29:59 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:40230 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbhBVG35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 01:29:57 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11M6PA0k059973;
        Mon, 22 Feb 2021 06:29:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=9rROBaHXtAdoPay+/wxFmTz+pB912Bh3fUYAYRMbSiU=;
 b=fFFnJDFDzU3TnjOFy2tZvzYc8RsYdT+fyu46rPP4AjXkN+nrqREcfDVcNCQa9tUjFybc
 ztkTzJGTl83TI6QXgOT8ym+oFslSdLtXPfWVmWYrUrncGcUa+9lRr4wsFwVOCiWFv8fp
 A1jEdD4xDnZpH5cwnKqQtBvoP6H5aWf4bURAyFptzrXIuN+9BAMtumtw3JjVJoqGpTlb
 ux965tL/qTeor2w0/PYMTAm6FrvBMgTvBWnK8ccnJcoZj0jXHrdNlG53LQnzVixH78ch
 QK5lOZ3vzNDRRH87o7k2zhfoO1+ql/S4+8hIfgnV7nK0nJyQpUu0ArRQYnbBgijNyxyZ uw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 36tsuqtgv7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Feb 2021 06:29:00 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11M6QeK3167926;
        Mon, 22 Feb 2021 06:28:58 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 36uc0kveh0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Feb 2021 06:28:58 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 11M6SwE9004680;
        Mon, 22 Feb 2021 06:28:58 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 21 Feb 2021 22:28:57 -0800
Date:   Mon, 22 Feb 2021 09:28:49 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     chakravarthikulkarni <chakravarthikulkarni2021@gmail.com>
Cc:     devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] staging: ks7010: Replace macros with do while loop.
Message-ID: <20210222062849.GN2087@kadam>
References: <20210221201327.12714-1-chakravarthikulkarni2021@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210221201327.12714-1-chakravarthikulkarni2021@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9902 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 adultscore=0
 mlxscore=0 mlxlogscore=822 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102220057
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9902 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 clxscore=1011 phishscore=0 mlxlogscore=821 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102220057
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 22, 2021 at 01:43:24AM +0530, chakravarthikulkarni wrote:
> This commit fix errors found in checkpath.pl.
> Error message is:
> <Macros with complex values should be enclosed in parentheses.>
> It is a good idea to keep complex macros in do while loop.
> Otherwise result may have side effect.
> 
> Signed-off-by: chakravarthikulkarni <chakravarthikulkarni2021@gmail.com>

This breaks the build.

Also just ignore this checkpatch warning.  The original defines are
fine.

regards,
dan carpenter

