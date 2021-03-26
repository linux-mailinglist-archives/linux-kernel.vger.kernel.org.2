Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12D5434A54E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 11:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhCZKKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 06:10:24 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:60470 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbhCZKKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 06:10:17 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12QA4v28020165;
        Fri, 26 Mar 2021 10:10:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=wzso/oBswSxYmp6YJJHUoZ0w/o+wqquI1UqRyE6d7IU=;
 b=lS24XRrnz6MuZVnj6GTPaRtd4OaSJvkZEHbATC4i7D2vShkFODBr1xI9YH6b8ymMydn6
 XNazSomc/5oHCgJpP0GTAt+cQY6BzaUXh1/Ky2Pu1jerxRFny5+t9z7rr4RFKEjvusEU
 1ZhM2fC7HhGR2Z7c8NeDsldjKEMgb4hiCEb3gdG7itrOzrUZa0JA9fAfoqRvvunit5Kn
 IvTpLKJPBkBQQj9y8u84cQUaedzCm7hlbCrcwrAC395/n9U5WVfgRHQxar7jFh3xRpQA
 FDPsOmuubvo+ZaLXiEOzEoXIY28m9uaSBU0L+YZGGyzNYdHZ++vGMdWZFYGzKzmG5hnI 3g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 37h13hsjgv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Mar 2021 10:10:07 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12QA59xx093711;
        Fri, 26 Mar 2021 10:10:06 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 37h13xggxa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Mar 2021 10:10:06 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 12QAA33t004893;
        Fri, 26 Mar 2021 10:10:03 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 26 Mar 2021 03:10:02 -0700
Date:   Fri, 26 Mar 2021 13:09:55 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: [kbuild] fs/btrfs/sysfs.c:1034:4: warning: %u in format string (no.
 2) requires 'unsigned int' but the argument type is 'signed int'.
Message-ID: <20210326100955.GZ1667@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-ID-Hash: S3P2DBGXJWCUKZEQNTO5XITQ5HOBYE3Y
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9934 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103260073
X-Proofpoint-GUID: qxWs8HNAISr6CFa6WanF5irxJI0zd9tQ
X-Proofpoint-ORIG-GUID: qxWs8HNAISr6CFa6WanF5irxJI0zd9tQ
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9934 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxscore=0
 spamscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1011 adultscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103260073
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kefeng,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master
head:   002322402dafd846c424ffa9240a937f49b48c42
commit: ed1ed4c0da5447c5e322481ce2ef9f03336c6ffb riscv: mmiowb: Fix implicit declaration of function 'smp_processor_id'
If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

vim +1034 fs/btrfs/sysfs.c

79da4fa4d9dcf8 Jeff Mahoney    2013-11-01  1001  static void init_feature_attrs(void)
79da4fa4d9dcf8 Jeff Mahoney    2013-11-01  1002  {
79da4fa4d9dcf8 Jeff Mahoney    2013-11-01  1003  	struct btrfs_feature_attr *fa;
79da4fa4d9dcf8 Jeff Mahoney    2013-11-01  1004  	int set, i;
79da4fa4d9dcf8 Jeff Mahoney    2013-11-01  1005  
79da4fa4d9dcf8 Jeff Mahoney    2013-11-01  1006  	BUILD_BUG_ON(ARRAY_SIZE(btrfs_unknown_feature_names) !=
79da4fa4d9dcf8 Jeff Mahoney    2013-11-01  1007  		     ARRAY_SIZE(btrfs_feature_attrs));
79da4fa4d9dcf8 Jeff Mahoney    2013-11-01  1008  	BUILD_BUG_ON(ARRAY_SIZE(btrfs_unknown_feature_names[0]) !=
79da4fa4d9dcf8 Jeff Mahoney    2013-11-01  1009  		     ARRAY_SIZE(btrfs_feature_attrs[0]));
79da4fa4d9dcf8 Jeff Mahoney    2013-11-01  1010  
3b02a68a636400 Jeff Mahoney    2013-11-01  1011  	memset(btrfs_feature_attrs, 0, sizeof(btrfs_feature_attrs));
3b02a68a636400 Jeff Mahoney    2013-11-01  1012  	memset(btrfs_unknown_feature_names, 0,
3b02a68a636400 Jeff Mahoney    2013-11-01  1013  	       sizeof(btrfs_unknown_feature_names));
3b02a68a636400 Jeff Mahoney    2013-11-01  1014  
79da4fa4d9dcf8 Jeff Mahoney    2013-11-01  1015  	for (i = 0; btrfs_supported_feature_attrs[i]; i++) {
79da4fa4d9dcf8 Jeff Mahoney    2013-11-01  1016  		struct btrfs_feature_attr *sfa;
79da4fa4d9dcf8 Jeff Mahoney    2013-11-01  1017  		struct attribute *a = btrfs_supported_feature_attrs[i];
3b02a68a636400 Jeff Mahoney    2013-11-01  1018  		int bit;
79da4fa4d9dcf8 Jeff Mahoney    2013-11-01  1019  		sfa = attr_to_btrfs_feature_attr(a);
3b02a68a636400 Jeff Mahoney    2013-11-01  1020  		bit = ilog2(sfa->feature_bit);
3b02a68a636400 Jeff Mahoney    2013-11-01  1021  		fa = &btrfs_feature_attrs[sfa->feature_set][bit];
79da4fa4d9dcf8 Jeff Mahoney    2013-11-01  1022  
79da4fa4d9dcf8 Jeff Mahoney    2013-11-01  1023  		fa->kobj_attr.attr.name = sfa->kobj_attr.attr.name;
79da4fa4d9dcf8 Jeff Mahoney    2013-11-01  1024  	}
79da4fa4d9dcf8 Jeff Mahoney    2013-11-01  1025  
79da4fa4d9dcf8 Jeff Mahoney    2013-11-01  1026  	for (set = 0; set < FEAT_MAX; set++) {
79da4fa4d9dcf8 Jeff Mahoney    2013-11-01  1027  		for (i = 0; i < ARRAY_SIZE(btrfs_feature_attrs[set]); i++) {
79da4fa4d9dcf8 Jeff Mahoney    2013-11-01  1028  			char *name = btrfs_unknown_feature_names[set][i];
79da4fa4d9dcf8 Jeff Mahoney    2013-11-01  1029  			fa = &btrfs_feature_attrs[set][i];
79da4fa4d9dcf8 Jeff Mahoney    2013-11-01  1030  
79da4fa4d9dcf8 Jeff Mahoney    2013-11-01  1031  			if (fa->kobj_attr.attr.name)
79da4fa4d9dcf8 Jeff Mahoney    2013-11-01  1032  				continue;
79da4fa4d9dcf8 Jeff Mahoney    2013-11-01  1033  
6c52157fa9378e Tomohiro Misono 2018-05-16 @1034  			snprintf(name, BTRFS_FEATURE_NAME_MAX, "%s:%u",
79da4fa4d9dcf8 Jeff Mahoney    2013-11-01  1035  				 btrfs_feature_set_names[set], i);

It looks like these two arguments are reversed?

79da4fa4d9dcf8 Jeff Mahoney    2013-11-01  1036  
79da4fa4d9dcf8 Jeff Mahoney    2013-11-01  1037  			fa->kobj_attr.attr.name = name;
79da4fa4d9dcf8 Jeff Mahoney    2013-11-01  1038  			fa->kobj_attr.attr.mode = S_IRUGO;
79da4fa4d9dcf8 Jeff Mahoney    2013-11-01  1039  			fa->feature_set = set;
79da4fa4d9dcf8 Jeff Mahoney    2013-11-01  1040  			fa->feature_bit = 1ULL << i;
79da4fa4d9dcf8 Jeff Mahoney    2013-11-01  1041  		}
79da4fa4d9dcf8 Jeff Mahoney    2013-11-01  1042  	}
79da4fa4d9dcf8 Jeff Mahoney    2013-11-01  1043  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org 
_______________________________________________
kbuild mailing list -- kbuild@lists.01.org
To unsubscribe send an email to kbuild-leave@lists.01.org
