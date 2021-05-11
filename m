Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3392037A82E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 15:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbhEKNyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 09:54:16 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:33248 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbhEKNyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 09:54:09 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14BDi4Q4086486;
        Tue, 11 May 2021 13:52:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=9JEMNpTkUbMew+8iyiXkDiJD3T72kysb9ppGftbCYFw=;
 b=xn7QvQKmWOwhpNTKGT1lVx7omgJ37+7rL/vpQd6+/wDNP05eiRcr4G/tlApikL5rDu3b
 o0sqFq2+WZLqNZ7GNHhDWiB1oUejWFSzPaeclEHewWAs98NbA8nHG7ZjeRLbKYW6GI3k
 ifbZbo/T40f2Tk8Yn6wslWbn185cs2ELtsnFOJz1Nes4PbmJuFcv/Kylex2Z/DYzN2mY
 YhBSDfuYvoI5ZuVMYITmUIz3OmA81dmdw4U9/2pkxYKHbJ55uXIP71G1ObrxxvAAEHGc
 jQqk7H5VbOPeR9ao4MpIsEOi6g/YTBwcg9506hcpJbu9gAbIh+vrOVt0YteGxErDboso cw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 38e285e1h1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 May 2021 13:52:42 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14BDo2jq161228;
        Tue, 11 May 2021 13:52:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 38fh3ws4cw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 May 2021 13:52:41 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14BDqfKB172342;
        Tue, 11 May 2021 13:52:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 38fh3ws4cj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 May 2021 13:52:41 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14BDqepc172306;
        Tue, 11 May 2021 13:52:40 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 38fh3ws4c4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 May 2021 13:52:40 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 14BDqbBH003928;
        Tue, 11 May 2021 13:52:38 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 11 May 2021 06:52:37 -0700
Date:   Tue, 11 May 2021 16:52:29 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Joseph Qi <joseph.qi@linux.alibaba.com>
Cc:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gang He <ghe@suse.com>, ocfs2-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ocfs2: fix snprintf() checking
Message-ID: <20210511135229.GU1955@kadam>
References: <YJovRPdOiaU6I+JK@mwanda>
 <bd7ddc22-11c4-3e88-120a-d68f153f573d@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd7ddc22-11c4-3e88-120a-d68f153f573d@linux.alibaba.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: NEtZ-WQU7Q0BXXwfg0Ssw1gddO56b9z9
X-Proofpoint-ORIG-GUID: NEtZ-WQU7Q0BXXwfg0Ssw1gddO56b9z9
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105110106
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 08:54:53PM +0800, Joseph Qi wrote:
> 
> 
> On 5/11/21 3:16 PM, Dan Carpenter wrote:
> > The snprintf() function returns the number of bytes which would have
> > been printed if the buffer was large enough.  In other words it can
> > return ">= remain" but this code assumes it returns "== remain".
> > 
> > The run time impact of this bug is not very severe.  The next iteration
> > through the loop would trigger a WARN() when we pass a negative limit
> > to snprintf().  We would then return success instead of -E2BIG.
> > 
> > The kernel implementation of snprintf() will never return negatives so
> > there is no need to check and I have deleted that dead code.
> > 
> > Fixes: a860f6eb4c6a ("ocfs2: sysfile interfaces for online file check")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> Looks good. But the last 2 sections are introduced by:
> 74ae4e104dfc ocfs2: Create stack glue sysfs files.
> 
> With 'Fixes' tag updated,
> Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> 

Thanks!  Will do.

regards,
dan carpenter

