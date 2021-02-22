Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8675A32102C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 06:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbhBVFJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 00:09:51 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:49172 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbhBVFJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 00:09:49 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11M58sl8168430;
        Mon, 22 Feb 2021 05:08:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=/m+7oTrzIn384y8FbVl58HcGUphAqAcWWQU34GsbqS0=;
 b=smpeLXjhTmG2QoG7uKYLk6zvXJa/vPNBsOf79yek1Q/3hCP1wrArUimYCIvfv6lJqxAF
 KvSIckX+GaLwz4bdzRS1hJ3XNLR4rEPQAipYwSEgnMoArLlInN2coMa5bjVp4u/ub3yz
 4DAC96ZxFkIykchGP7P7YUfvNIs7kOMjl8wiSOBH40JM39f3eqTtpK2prq0Nx+FJStCp
 GXxYwDzRpb5Iny3tpC/LJxsXg8NyU3BX8f7acpLmmDsezi/MTh4m63x5n148VczDwk0J
 uqnTT6mJ4H0h8KOMpveJ35Hp6zEjkFAXTL6HUlT5g62rWjnBOnbKenuhhefccB6QwyJZ lA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 36tqxbaebp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Feb 2021 05:08:54 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11M56esk082911;
        Mon, 22 Feb 2021 05:08:53 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 36uc0ktfpx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Feb 2021 05:08:52 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 11M58nG2019356;
        Mon, 22 Feb 2021 05:08:49 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 21 Feb 2021 21:08:49 -0800
Date:   Mon, 22 Feb 2021 08:08:41 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kurt Manucredo <fuzzybritches@protonmail.com>
Cc:     gregkh@linuxfoundation.org, ross.schm.dev@gmail.com,
        straube.linux@gmail.com, d.straghkov@ispras.ru, tiwai@suse.de,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: rtl8723bs: fix code style comparison warning
Message-ID: <20210222050841.GC2087@kadam>
References: <20210219182331.8-1-fuzzybritches@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219182331.8-1-fuzzybritches@protonmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9902 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102220045
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9902 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102220045
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 06:23:54PM +0000, Kurt Manucredo wrote:
> 
> 
> checkpatch gives the following WARNING:
> WARNING: Comparisons should place the constant on the right side of the test
> this patch fixes the coding style warning.
> 
> Signed-off-by: Kurt Manucredo <fuzzybritches@protonmail.com>
> ---

Looks okay to me.  Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

