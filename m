Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF9F31F908
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 13:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbhBSMHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 07:07:07 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:57014 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbhBSMGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 07:06:07 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11JC5E0K169152;
        Fri, 19 Feb 2021 12:05:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=imsrzSSI/vvBI5ueuekT+d9U8MRYf+FdzBwlN96lu2Q=;
 b=pfU+gXbnZyi2ZqFhvGJkKXk1/sgWKgIa5EuI4IGCmU/FSKRIVgjNCRi7kEZjgII7K1gT
 XPfvLVM2JQCgGAF3cOPD0OBkMgfycnPSyQ96LUyBAcXbyIj6/2ENfkf1ulRDYykcWuG6
 LXSqzT5Nd0wkCrHUl1mCdsjIZo7AmxfEQWoFDFHRkzjq9RsvSNJFovYDopJVX9VeIrqQ
 ss5kHJ5IHl5o9urVczrZEpqAwvk7PjNoO5tW5zp3mpnYAXY/rHG528CZ6Zp2oifJvgBK
 /dl76C7MK2b2JUtA/iTWzqXgNAs6oxmnQirF4Z8uzDbjVvJBO6sPmbKSnDaCtGHaKw1X Dw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 36p66r99jb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Feb 2021 12:05:14 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11JC0GhI084445;
        Fri, 19 Feb 2021 12:05:12 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 36prq1tvbv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Feb 2021 12:05:12 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 11JC5Acf004245;
        Fri, 19 Feb 2021 12:05:11 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 19 Feb 2021 04:05:10 -0800
Date:   Fri, 19 Feb 2021 15:04:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Amrit Khera <amritkhera98@gmail.com>
Cc:     gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, joel@joelfernandes.org, christian@brauner.io,
        hridya@google.com, surenb@google.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: android: Fix const keyword style issue in
 ashmem.c
Message-ID: <20210219120457.GY2087@kadam>
References: <20210219114237.5720-1-amritkhera98@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219114237.5720-1-amritkhera98@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9899 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102190098
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9899 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 clxscore=1011 spamscore=0 mlxscore=0
 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102190099
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 05:12:38PM +0530, Amrit Khera wrote:
> This change fixes a checkpatch warning for "struct file_operations
> should normally be const".
> 
> Signed-off-by: Amrit Khera <amritkhera98@gmail.com>
> ---
> Changes in v2:
>  - Wrapped the commit description
>  - Build tested
     ^^^^^^^^^^^^
Heh.  Nope.

This breaks the build.

regards,
dan carpenter

