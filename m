Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D407C33AFFA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 11:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhCOK3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 06:29:47 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52778 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhCOK3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 06:29:21 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12FAOSeA184510;
        Mon, 15 Mar 2021 10:29:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=/c0n/pNLCQxVjHIFVGolGuBy2iMkoLfoqgD0gx6c1fE=;
 b=OZzmftkehPJ0b6U2iPnCp1Sy95yGvUrdgEe5+V9nFHpWaTYEpcmnLu1RkTDF9koc+EIz
 i9DV8sYw+npLyJr71CdwG23pvuIge8kGnuycQyz9zEOuHPlI8RCumYrK2j4wAXfpFQmz
 ZNIlF+alobWNLgQf0faDfyLDBVr0FX1zan2w7z0OjBNGzHiAs0d6SWwIyeXNADaAcmnf
 ro5YM8sLKDvg9oTIEYJU6xgUdeR5g0mcsjZit6t6V26l8SgEfblHZZfBLXyiLTxbetsC
 VBxAJOCUjs9ox4mfa0IM6yGa9MNagfQ5KdkfPlVuZCFc3IuzmR8+xodWstJ9Vq7y5xSq BQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 37a4ekg92h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Mar 2021 10:29:14 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12FAJZBV142177;
        Mon, 15 Mar 2021 10:29:12 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 37979yp63q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Mar 2021 10:29:12 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 12FAT9u9018451;
        Mon, 15 Mar 2021 10:29:09 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 15 Mar 2021 10:29:09 +0000
Date:   Mon, 15 Mar 2021 13:29:02 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        gorcunov@openvz.org, security@kernel.org
Subject: Re: [PATCH] prctl: fix PR_SET_MM_AUXV kernel stack leak
Message-ID: <20210315102901.GP21246@kadam>
References: <YE53QiJuxsCUeoiu@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YE53QiJuxsCUeoiu@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9923 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103150070
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9923 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 adultscore=0 phishscore=0 suspectscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103150070
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 14, 2021 at 11:51:14PM +0300, Alexey Dobriyan wrote:
> 	prctl(PR_SET_MM, PR_SET_MM_AUXV, addr, 1);
> 
> will copy 1 byte from userspace to (quite big) on-stack array
> and then stash everything to mm->saved_auxv.

What?  It won't save everything, only the 1 byte.  What am I not seeing?

kernel/sys.c
  2073  static int prctl_set_auxv(struct mm_struct *mm, unsigned long addr,
  2074                            unsigned long len)
  2075  {
  2076          /*
  2077           * This doesn't move the auxiliary vector itself since it's pinned to
  2078           * mm_struct, but it permits filling the vector with new values.  It's
  2079           * up to the caller to provide sane values here, otherwise userspace
  2080           * tools which use this vector might be unhappy.
  2081           */
  2082          unsigned long user_auxv[AT_VECTOR_SIZE] = {};
  2083  
  2084          if (len > sizeof(user_auxv))
  2085                  return -EINVAL;
  2086  
  2087          if (copy_from_user(user_auxv, (const void __user *)addr, len))
                                   ^^^^^^^^^                             ^^^
Copies one byte from user space.

  2088                  return -EFAULT;
  2089  
  2090          /* Make sure the last entry is always AT_NULL */
  2091          user_auxv[AT_VECTOR_SIZE - 2] = 0;
  2092          user_auxv[AT_VECTOR_SIZE - 1] = 0;
  2093  
  2094          BUILD_BUG_ON(sizeof(user_auxv) != sizeof(mm->saved_auxv));
  2095  
  2096          task_lock(current);
  2097          memcpy(mm->saved_auxv, user_auxv, len);
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Saves one byte to mm->saved_auxv.

  2098          task_unlock(current);
  2099  
  2100          return 0;
  2101  }

regards,
dan carpenter

