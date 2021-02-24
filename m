Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34C78323804
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 08:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233025AbhBXHmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 02:42:22 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:39720 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbhBXHmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 02:42:16 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11O7eZEL065109;
        Wed, 24 Feb 2021 07:41:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=5N9Zni7SESpGz83tWFRd5XihpHqYHf3ynWb5KcCbM+g=;
 b=T3VJuvYhu2DKEqdoBLvtB+b/A4K1OxEyFbP+OLlZeE3hFQe7swYvLUwGFJSmokEEEm3X
 MjTNm/VvXnAyFnHZ9/iMEO9iWTc9BwfiMbIiJRj/w9O0Yq6dFWjNmqvd+sMB0jyEc4bQ
 jG7hq+o8POsqtIk5MJnSt5qHNhdrnZO2XjYUnJUImqlI+5CTCThn3RQQ7QP+WudIcjdb
 LfBeaGG1YSkf0Q7L+mK3VeVdW4zhcym+7tmSP0LeUzbF1tysDzCPcsAzGEYeApEKjFTq
 fljhWuq7BP4HUDS9T6Bsz0MWWjRNKv1k91v1gv4C7y9/5DtqNPalMqf+yr+33gFDKcO7 fA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 36tsur1yy9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Feb 2021 07:41:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11O7eXaw059050;
        Wed, 24 Feb 2021 07:41:28 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 36ucbyhen8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Feb 2021 07:41:28 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 11O7fOOf006136;
        Wed, 24 Feb 2021 07:41:26 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 23 Feb 2021 23:41:23 -0800
Date:   Wed, 24 Feb 2021 10:41:17 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     William Durand <will+git@drnd.me>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/13] staging: rtl8192e: remove blank line in bss_ht
 struct
Message-ID: <20210224074117.GR2087@kadam>
References: <20210220155418.12282-1-will+git@drnd.me>
 <20210220155418.12282-2-will+git@drnd.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210220155418.12282-2-will+git@drnd.me>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9904 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102240060
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9904 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 clxscore=1015 phishscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102240060
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 20, 2021 at 03:54:05PM +0000, William Durand wrote:
> Fixes a checkpatch CHECK issue.
> 

All these patches have the same vague commit message.  It's okay if the
commit message basically restates the commit one line summary.  It
should say something like:

Fix a checkpatch warning about a blank line after an open curly brace.

Rename FooBar to foo_bar to silence a checkpatch warning about
CamelCase.

regards,
dan carpenter

