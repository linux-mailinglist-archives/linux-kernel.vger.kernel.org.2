Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA0D13ADA30
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 15:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234353AbhFSNsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 09:48:46 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:25886 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233286AbhFSNsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 09:48:43 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15JDf56E004044;
        Sat, 19 Jun 2021 13:46:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=HP6iHUHGUTOwLc0E//CINN2obCmftl4AYOilvitxiCs=;
 b=Kg4whScVvT5tVH15TVen85gGD8B/U8YHZVOHnlzbGdnnIWSpm6d14M/zLokOzGEa7C5S
 N3fmTC59umPOCVesuhXYZhBEmW49yh2yrYcn0ua5ZFmJNb87GXWR1uiHBgsHNWl7Tu8K
 rj1rvi5wAcyV6l/pjMgINUnUDGHAQob/u+zgfuMSpGQA5up9wGpNJpY+/XPxB7V8P9ow
 aeG0XIpcDPbt6IgG2NZ/pAiIFwcW8xQ6QYTd0P1Qrx/hL/h2SqxwvoZzUX8hKyYr00uC
 fvjmOcWi0d1cz+ZEDWZMz9Gx/CC7hWtBdd6M0i7qbx2PCA6ysHo2t47k6dnjSf4cZ2q6 Cg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39970bggbt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Jun 2021 13:46:24 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15JDf1oF108790;
        Sat, 19 Jun 2021 13:46:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 3995psqfd0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Jun 2021 13:46:23 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15JDkM8x119767;
        Sat, 19 Jun 2021 13:46:22 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 3995psqfcg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Jun 2021 13:46:22 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 15JDkK2t018967;
        Sat, 19 Jun 2021 13:46:20 GMT
Received: from kadam (/102.222.70.252)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 19 Jun 2021 13:46:19 +0000
Date:   Sat, 19 Jun 2021 16:46:13 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Samuel Cabrero <scabrero@suse.de>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Steve French <stfrench@microsoft.com>,
        Aurelien Aptel <aaptel@suse.com>
Subject: fs/cifs/cifs_swn.c:468 cifs_swn_store_swn_addr() error:
 uninitialized symbol 'port'.
Message-ID: <202106192055.9FuqF8dj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: Z54XJFU9_bf2oiGVt7wyID2GON94DJAn
X-Proofpoint-ORIG-GUID: Z54XJFU9_bf2oiGVt7wyID2GON94DJAn
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9ed13a17e38e0537e24d9b507645002bf8d0201f
commit: 121d947d4fe15bcec90bcfc1249ee9b739cb9258 cifs: Handle witness client move notification
config: h8300-randconfig-m031-20210618 (attached as .config)
compiler: h8300-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
fs/cifs/cifs_swn.c:468 cifs_swn_store_swn_addr() error: uninitialized symbol 'port'.

vim +/port +468 fs/cifs/cifs_swn.c

121d947d4fe15b Samuel Cabrero 2020-11-30  447  static int cifs_swn_store_swn_addr(const struct sockaddr_storage *new,
121d947d4fe15b Samuel Cabrero 2020-11-30  448  				   const struct sockaddr_storage *old,
121d947d4fe15b Samuel Cabrero 2020-11-30  449  				   struct sockaddr_storage *dst)
121d947d4fe15b Samuel Cabrero 2020-11-30  450  {
121d947d4fe15b Samuel Cabrero 2020-11-30  451  	__be16 port;
121d947d4fe15b Samuel Cabrero 2020-11-30  452  
121d947d4fe15b Samuel Cabrero 2020-11-30  453  	if (old->ss_family == AF_INET) {
121d947d4fe15b Samuel Cabrero 2020-11-30  454  		struct sockaddr_in *ipv4 = (struct sockaddr_in *)old;
121d947d4fe15b Samuel Cabrero 2020-11-30  455  
121d947d4fe15b Samuel Cabrero 2020-11-30  456  		port = ipv4->sin_port;
121d947d4fe15b Samuel Cabrero 2020-11-30  457  	}
121d947d4fe15b Samuel Cabrero 2020-11-30  458  
121d947d4fe15b Samuel Cabrero 2020-11-30  459  	if (old->ss_family == AF_INET6) {
121d947d4fe15b Samuel Cabrero 2020-11-30  460  		struct sockaddr_in6 *ipv6 = (struct sockaddr_in6 *)old;
121d947d4fe15b Samuel Cabrero 2020-11-30  461  
121d947d4fe15b Samuel Cabrero 2020-11-30  462  		port = ipv6->sin6_port;
121d947d4fe15b Samuel Cabrero 2020-11-30  463  	}
121d947d4fe15b Samuel Cabrero 2020-11-30  464  
121d947d4fe15b Samuel Cabrero 2020-11-30  465  	if (new->ss_family == AF_INET) {
121d947d4fe15b Samuel Cabrero 2020-11-30  466  		struct sockaddr_in *ipv4 = (struct sockaddr_in *)new;
121d947d4fe15b Samuel Cabrero 2020-11-30  467  
121d947d4fe15b Samuel Cabrero 2020-11-30 @468  		ipv4->sin_port = port;

Apparently Smatch is not smart enough to know that AF_INET and AF_INET6
are the only possible values for old->ss_family.  I hope that eventually
we will be able to enable GCC's uninitialized variable checking and GCC
is certainly not able to figure this out either.

121d947d4fe15b Samuel Cabrero 2020-11-30  469  	}
121d947d4fe15b Samuel Cabrero 2020-11-30  470  
121d947d4fe15b Samuel Cabrero 2020-11-30  471  	if (new->ss_family == AF_INET6) {
121d947d4fe15b Samuel Cabrero 2020-11-30  472  		struct sockaddr_in6 *ipv6 = (struct sockaddr_in6 *)new;
121d947d4fe15b Samuel Cabrero 2020-11-30  473  
121d947d4fe15b Samuel Cabrero 2020-11-30  474  		ipv6->sin6_port = port;
121d947d4fe15b Samuel Cabrero 2020-11-30  475  	}
121d947d4fe15b Samuel Cabrero 2020-11-30  476  
121d947d4fe15b Samuel Cabrero 2020-11-30  477  	*dst = *new;
121d947d4fe15b Samuel Cabrero 2020-11-30  478  
121d947d4fe15b Samuel Cabrero 2020-11-30  479  	return 0;
121d947d4fe15b Samuel Cabrero 2020-11-30  480  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

