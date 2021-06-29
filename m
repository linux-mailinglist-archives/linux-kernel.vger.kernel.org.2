Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB4693B6E88
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 09:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbhF2HJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 03:09:54 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:1478 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232097AbhF2HJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 03:09:54 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15T70du6002270;
        Tue, 29 Jun 2021 07:07:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=F2nO6KhDW4v6veTEQnwjOs2scu2iwkeGP00AAd7JfM0=;
 b=It2LbuvCulSho5Y6fVXWYR2GJuj/ey8+sRaHD8o8/q4B3RP3yOCOdqAfFLBS7wjRpGTl
 L0AetBGj3OCxHAesr/+/n6RSWU1dfIPvwpLpZJOyOMkK8iMlKgsEvxmDylRBXXK587zy
 qNV/KHNPgcEMfhzKfawTJEFLyv0HRasEiRYN+8PSB4fLOPk79ZVmVnhejCeqbYAJNBoL
 5zdlnSOzy52lsRz9+7+Szzr1NyIiFlpzFDyImTTBKfb4VriqmJh/aup862KPful2DUwC
 HGwTW2xQ1Vc0K+f0MQCBaRr5shoK8cg0M1brULWjthYhdLl3QNa7rBBy6Af12k8hk911 6Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39f174jya7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jun 2021 07:07:16 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15T6xsr4162051;
        Tue, 29 Jun 2021 07:07:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 39ee0u4rwp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jun 2021 07:07:15 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15T74LHT179657;
        Tue, 29 Jun 2021 07:07:15 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 39ee0u4rv6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jun 2021 07:07:15 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 15T7776J025527;
        Tue, 29 Jun 2021 07:07:10 GMT
Received: from kadam (/102.222.70.252)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 29 Jun 2021 00:07:06 -0700
Date:   Tue, 29 Jun 2021 10:06:51 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [kbuild] drivers/mtd/parsers/ofpart_bcm4908.c:41
 bcm4908_partitions_fw_offset() warn: should 'offset << 10' be a 64 bit type?
Message-ID: <202106290224.39KCjBKr-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Message-ID-Hash: EU3O553ZQLHTZB2ZBG7ZV4NF5SX5YKVA
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: LbI7-rS0lIoThdA2oDBqelB2u4f_UfPE
X-Proofpoint-ORIG-GUID: LbI7-rS0lIoThdA2oDBqelB2u4f_UfPE
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master
head:   62fb9874f5da54fdb243003b386128037319b219
commit: bb17230c61a6424b622e92006ec52ba23aa5a967 mtd: parsers: ofpart: support BCM4908 fixed partitions
config: microblaze-randconfig-m031-20210628 (attached as .config)
compiler: microblaze-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/mtd/parsers/ofpart_bcm4908.c:41 bcm4908_partitions_fw_offset() warn: should 'offset << 10' be a 64 bit type?

vim +41 drivers/mtd/parsers/ofpart_bcm4908.c

bb17230c61a642 Rafał Miłecki 2021-03-01  17  static long long bcm4908_partitions_fw_offset(void)
bb17230c61a642 Rafał Miłecki 2021-03-01  18  {
bb17230c61a642 Rafał Miłecki 2021-03-01  19  	struct device_node *root;
bb17230c61a642 Rafał Miłecki 2021-03-01  20  	struct property *prop;
bb17230c61a642 Rafał Miłecki 2021-03-01  21  	const char *s;
bb17230c61a642 Rafał Miłecki 2021-03-01  22  
bb17230c61a642 Rafał Miłecki 2021-03-01  23  	root = of_find_node_by_path("/");
bb17230c61a642 Rafał Miłecki 2021-03-01  24  	if (!root)
bb17230c61a642 Rafał Miłecki 2021-03-01  25  		return -ENOENT;
bb17230c61a642 Rafał Miłecki 2021-03-01  26  
bb17230c61a642 Rafał Miłecki 2021-03-01  27  	of_property_for_each_string(root, "brcm_blparms", prop, s) {
bb17230c61a642 Rafał Miłecki 2021-03-01  28  		size_t len = strlen(BLPARAMS_FW_OFFSET);
bb17230c61a642 Rafał Miłecki 2021-03-01  29  		unsigned long offset;
bb17230c61a642 Rafał Miłecki 2021-03-01  30  		int err;
bb17230c61a642 Rafał Miłecki 2021-03-01  31  
bb17230c61a642 Rafał Miłecki 2021-03-01  32  		if (strncmp(s, BLPARAMS_FW_OFFSET, len) || s[len] != '=')
bb17230c61a642 Rafał Miłecki 2021-03-01  33  			continue;
bb17230c61a642 Rafał Miłecki 2021-03-01  34  
bb17230c61a642 Rafał Miłecki 2021-03-01  35  		err = kstrtoul(s + len + 1, 0, &offset);
bb17230c61a642 Rafał Miłecki 2021-03-01  36  		if (err) {
bb17230c61a642 Rafał Miłecki 2021-03-01  37  			pr_err("failed to parse %s\n", s + len + 1);
bb17230c61a642 Rafał Miłecki 2021-03-01  38  			return err;
bb17230c61a642 Rafał Miłecki 2021-03-01  39  		}
bb17230c61a642 Rafał Miłecki 2021-03-01  40  
bb17230c61a642 Rafał Miłecki 2021-03-01 @41  		return offset << 10;

We likely do not care about this microblaze .config too much in this
context, but it would be simple enough to declare offset as a long long.

bb17230c61a642 Rafał Miłecki 2021-03-01  42  	}
bb17230c61a642 Rafał Miłecki 2021-03-01  43  
bb17230c61a642 Rafał Miłecki 2021-03-01  44  	return -ENOENT;
bb17230c61a642 Rafał Miłecki 2021-03-01  45  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org 

_______________________________________________
kbuild mailing list -- kbuild@lists.01.org
To unsubscribe send an email to kbuild-leave@lists.01.org

