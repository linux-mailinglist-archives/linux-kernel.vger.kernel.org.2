Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50B6B3A9549
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 10:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbhFPIwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 04:52:33 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:51490 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231335AbhFPIwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 04:52:31 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15G8k19K031863;
        Wed, 16 Jun 2021 08:50:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=/SRyitQd9dZW6PpfyFMNrlSJINCFbjGh2/Zsrk9k+B4=;
 b=QJMzBIFeF5uZ1VAT4FGj8FvFkNlnEjMMrSsvz4hyxcpbXHe6VEAbT3U6NYlfO0REm8+2
 gVyB8eKieY1lRyQQ/CRhRBnICAmvX9WhWImaMWYH45oU1TGvTwE+F+2HKanAArr811FR
 QTP9KD0mO4KP2iSjRpxmcq9hsbFKBgWf60NrGAiD5CGwzgOluUzaUDaICFOcUND/CP6e
 2cerUuoHljv2qFDtw5R64Asn3FPrq05A1RuLRW+4pSVeXRVAHRo4B9PzdwwqtM93EysH
 hX+GLbqb+fE0KzJPMrQ43OmxmAJKDoUv8ChW74KLxdyHuE9H/dgqQuxkLy1UKmURff/J lA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 396tr0ssrr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Jun 2021 08:50:16 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15G8ipT0189521;
        Wed, 16 Jun 2021 08:50:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 396wanjm2v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Jun 2021 08:50:15 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15G8j5dV191062;
        Wed, 16 Jun 2021 08:50:14 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 396wanjm2e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Jun 2021 08:50:14 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 15G8oDsl024852;
        Wed, 16 Jun 2021 08:50:13 GMT
Received: from kadam (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 16 Jun 2021 01:50:12 -0700
Date:   Wed, 16 Jun 2021 11:50:06 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Luo bin <luobin9@huawei.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/huawei/hinic/hinic_debugfs.c:92
 hinic_dbg_get_func_table() warn: returning -1 instead of -ENOMEM is sloppy
Message-ID: <202106152239.nUY12jhM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: Cfbu3Wyzw4ERzPsSsKUDsWI37G_F-sCU
X-Proofpoint-ORIG-GUID: Cfbu3Wyzw4ERzPsSsKUDsWI37G_F-sCU
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   06af8679449d4ed282df13191fc52d5ba28ec536
commit: 5215e16244ee5889cc6135381acdbf4cbcb7905a hinic: add support to query function table
config: i386-randconfig-m021-20210615 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/net/ethernet/huawei/hinic/hinic_debugfs.c:92 hinic_dbg_get_func_table() warn: returning -1 instead of -ENOMEM is sloppy

vim +92 drivers/net/ethernet/huawei/hinic/hinic_debugfs.c

5215e16244ee58 Luo bin 2020-08-28   83  static int hinic_dbg_get_func_table(struct hinic_dev *nic_dev, int idx)
5215e16244ee58 Luo bin 2020-08-28   84  {
5215e16244ee58 Luo bin 2020-08-28   85  	struct tag_sml_funcfg_tbl *funcfg_table_elem;
5215e16244ee58 Luo bin 2020-08-28   86  	struct hinic_cmd_lt_rd *read_data;
5215e16244ee58 Luo bin 2020-08-28   87  	u16 out_size = sizeof(*read_data);
5215e16244ee58 Luo bin 2020-08-28   88  	int err;
5215e16244ee58 Luo bin 2020-08-28   89  
5215e16244ee58 Luo bin 2020-08-28   90  	read_data = kzalloc(sizeof(*read_data), GFP_KERNEL);
5215e16244ee58 Luo bin 2020-08-28   91  	if (!read_data)
5215e16244ee58 Luo bin 2020-08-28  @92  		return ~0;

Should be -ENOMEM instead of -EPERM (~0).

5215e16244ee58 Luo bin 2020-08-28   93  
5215e16244ee58 Luo bin 2020-08-28   94  	read_data->node = TBL_ID_FUNC_CFG_SM_NODE;
5215e16244ee58 Luo bin 2020-08-28   95  	read_data->inst = TBL_ID_FUNC_CFG_SM_INST;
5215e16244ee58 Luo bin 2020-08-28   96  	read_data->entry_size = HINIC_FUNCTION_CONFIGURE_TABLE_SIZE;
5215e16244ee58 Luo bin 2020-08-28   97  	read_data->lt_index = HINIC_HWIF_FUNC_IDX(nic_dev->hwdev->hwif);
5215e16244ee58 Luo bin 2020-08-28   98  	read_data->len = HINIC_FUNCTION_CONFIGURE_TABLE_SIZE;
5215e16244ee58 Luo bin 2020-08-28   99  
5215e16244ee58 Luo bin 2020-08-28  100  	err = hinic_port_msg_cmd(nic_dev->hwdev, HINIC_PORT_CMD_RD_LINE_TBL, read_data,
5215e16244ee58 Luo bin 2020-08-28  101  				 sizeof(*read_data), read_data, &out_size);
5215e16244ee58 Luo bin 2020-08-28  102  	if (err || out_size != sizeof(*read_data) || read_data->status) {
5215e16244ee58 Luo bin 2020-08-28  103  		netif_err(nic_dev, drv, nic_dev->netdev,
5215e16244ee58 Luo bin 2020-08-28  104  			  "Failed to get func table, err: %d, status: 0x%x, out size: 0x%x\n",
5215e16244ee58 Luo bin 2020-08-28  105  			  err, read_data->status, out_size);
5215e16244ee58 Luo bin 2020-08-28  106  		kfree(read_data);
5215e16244ee58 Luo bin 2020-08-28  107  		return ~0;

return -EINVAL;

5215e16244ee58 Luo bin 2020-08-28  108  	}
5215e16244ee58 Luo bin 2020-08-28  109  
5215e16244ee58 Luo bin 2020-08-28  110  	funcfg_table_elem = (struct tag_sml_funcfg_tbl *)read_data->data;
5215e16244ee58 Luo bin 2020-08-28  111  
5215e16244ee58 Luo bin 2020-08-28  112  	switch (idx) {
5215e16244ee58 Luo bin 2020-08-28  113  	case VALID:
5215e16244ee58 Luo bin 2020-08-28  114  		return funcfg_table_elem->dw0.bs.valid;
5215e16244ee58 Luo bin 2020-08-28  115  	case RX_MODE:
5215e16244ee58 Luo bin 2020-08-28  116  		return funcfg_table_elem->dw0.bs.nic_rx_mode;
5215e16244ee58 Luo bin 2020-08-28  117  	case MTU:
5215e16244ee58 Luo bin 2020-08-28  118  		return funcfg_table_elem->dw1.bs.mtu;
5215e16244ee58 Luo bin 2020-08-28  119  	case RQ_DEPTH:
5215e16244ee58 Luo bin 2020-08-28  120  		return funcfg_table_elem->dw13.bs.cfg_rq_depth;
5215e16244ee58 Luo bin 2020-08-28  121  	case QUEUE_NUM:
5215e16244ee58 Luo bin 2020-08-28  122  		return funcfg_table_elem->dw13.bs.cfg_q_num;
5215e16244ee58 Luo bin 2020-08-28  123  	}
5215e16244ee58 Luo bin 2020-08-28  124  
5215e16244ee58 Luo bin 2020-08-28  125  	kfree(read_data);
5215e16244ee58 Luo bin 2020-08-28  126  
5215e16244ee58 Luo bin 2020-08-28  127  	return ~0;

-EINVAL;

5215e16244ee58 Luo bin 2020-08-28  128  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

