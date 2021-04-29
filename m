Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F73236EBED
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 16:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239584AbhD2OF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 10:05:56 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49234 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237084AbhD2OFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 10:05:53 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13TDtk9n174920;
        Thu, 29 Apr 2021 14:04:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2020-01-29; bh=XWujCC1T2A1mMi7XFh+vWKACrp/bu7LxNnRA3pYtwqg=;
 b=h953Gq0Vwb2epbVqoLOWxkGz+aWIeGGh7TYELDFR2oJBUfQYiX+prI5i5pAAK07O3BgG
 zuNASl0NBCIt0UMwga5KsqBIBI452h7Cr3NbtnQ83vhvjL1ofIvS5tuN5lA3liqLwaju
 6iLHG6tS9nh81rpd0WrFDpVelyyh+6UZ9cpXEONciLOPWzUahSrsQ+nlhE1nhJ3xEqw0
 saZHr52QqKS5sZVv2xkfrig5w7MRtcmvc3wuHNFbJVnf6grZI1xdZaYIXz3iWhAR9ZyD
 6gSzam9m8fC8jxTinaK6b+PV8bd6bxVGRC24Bkat4IU5/Nqizx66EvVTXqIMNGPhQnGX 5A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 385ahbvga1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Apr 2021 14:04:38 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13TDuhWk010686;
        Thu, 29 Apr 2021 14:04:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 384w3wbdhm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Apr 2021 14:04:37 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 13TE4afv065013;
        Thu, 29 Apr 2021 14:04:36 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 384w3wbdgd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Apr 2021 14:04:36 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 13TE4WEV006195;
        Thu, 29 Apr 2021 14:04:32 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 29 Apr 2021 07:04:32 -0700
Date:   Thu, 29 Apr 2021 17:04:23 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, legion@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-mm@kvack.org
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH v11 4/9] Reimplement RLIMIT_NPROC on top of ucounts
Message-ID: <202104272256.9Y5ZQxrO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5286a8aa16d2d698c222f7532f3d735c82bc6bc.1619094428.git.legion@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: GnOKWP_uxfwZW1upvqeIeMmTwjRK-LjD
X-Proofpoint-ORIG-GUID: GnOKWP_uxfwZW1upvqeIeMmTwjRK-LjD
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9969 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1011 adultscore=0 suspectscore=0 spamscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104290093
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

url:    https://github.com/0day-ci/linux/commits/legion-kernel-org/Count-rlimits-in-each-user-namespace/20210427-162857
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git next
config: arc-randconfig-m031-20210426 (attached as .config)
compiler: arceb-elf-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
kernel/ucount.c:270 dec_rlimit_ucounts() error: uninitialized symbol 'new'.

vim +/new +270 kernel/ucount.c

176ec2b092cc22 Alexey Gladkov 2021-04-22  260  bool dec_rlimit_ucounts(struct ucounts *ucounts, enum ucount_type type, long v)
176ec2b092cc22 Alexey Gladkov 2021-04-22  261  {
176ec2b092cc22 Alexey Gladkov 2021-04-22  262  	struct ucounts *iter;
176ec2b092cc22 Alexey Gladkov 2021-04-22  263  	long new;
                                                ^^^^^^^^

176ec2b092cc22 Alexey Gladkov 2021-04-22  264  	for (iter = ucounts; iter; iter = iter->ns->ucounts) {
176ec2b092cc22 Alexey Gladkov 2021-04-22  265  		long dec = atomic_long_add_return(-v, &iter->ucount[type]);
176ec2b092cc22 Alexey Gladkov 2021-04-22  266  		WARN_ON_ONCE(dec < 0);
176ec2b092cc22 Alexey Gladkov 2021-04-22  267  		if (iter == ucounts)
176ec2b092cc22 Alexey Gladkov 2021-04-22  268  			new = dec;
176ec2b092cc22 Alexey Gladkov 2021-04-22  269  	}
176ec2b092cc22 Alexey Gladkov 2021-04-22 @270  	return (new == 0);
                                                        ^^^^^^^^
I don't know if this is a bug or not, but I can definitely tell why the
static checker complains about it.

176ec2b092cc22 Alexey Gladkov 2021-04-22  271  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

