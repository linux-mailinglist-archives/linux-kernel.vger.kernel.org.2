Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3C023A248E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 08:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbhFJGg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 02:36:58 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56048 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbhFJGg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 02:36:56 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15A6TxrG097991;
        Thu, 10 Jun 2021 06:34:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=ne4xUVAQopKmDKr3TJFcodoirGsiaGm9fJHDgDuEYCs=;
 b=gwuZb5OhApvvOF1WvMZerERf+t0SRxS9oozUCotm0lRwz3JwoL8+NC0A4e0mxnuJiyPK
 Y97n+Z91v2oe0rxgH5vJ9tL8S0OH32LGRKUr9dQcgN86tuP6xqHkxL1w1A9g6Qddsb3p
 ARU8hlAd1RDglBkMCTvcIF+MBcbP28ERCXrnU8TosJUUPrUKHZb9cRs/8wc5rtdSvbMb
 DR7RErALM9NPzDXVW82LyrHLOSXc+HHleRcbPowT2B95wFL8gQnHy1TbfNEMIy7BQUUh
 Cp35VZg2Q6lkpJSbDkuUpoR5n9h4BDwYKvTAeLIpqdN+tbUpVigTgKBnzHpkCuIVWlo3 Xw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 39017nk1sq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jun 2021 06:34:49 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15A6UgkX111067;
        Thu, 10 Jun 2021 06:34:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 3922wx9b0e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jun 2021 06:34:49 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15A6Yng4131798;
        Thu, 10 Jun 2021 06:34:49 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 3922wx9ayb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jun 2021 06:34:48 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 15A6Yj6N017660;
        Thu, 10 Jun 2021 06:34:45 GMT
Received: from kadam (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 10 Jun 2021 06:34:44 +0000
Date:   Thu, 10 Jun 2021 09:34:37 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Hyun Kwon <hyun.kwon@xilinx.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: drivers/gpu/drm/xlnx/zynqmp_dp.c:997 zynqmp_dp_aux_cmd_submit()
 error: we previously assumed 'buf' could be null (see line 966)
Message-ID: <202106100353.e6wuQ23n-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: 5wpJorNXyeeR7QLTobFmSJV72h0mPnfq
X-Proofpoint-ORIG-GUID: 5wpJorNXyeeR7QLTobFmSJV72h0mPnfq
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10010 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 impostorscore=0 suspectscore=0 clxscore=1011
 mlxscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106100041
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   368094df48e680fa51cedb68537408cfa64b788e
commit: d76271d22694e874ed70791702db9252ffe96a4c drm: xlnx: DRM/KMS driver for Xilinx ZynqMP DisplayPort Subsystem
config: h8300-randconfig-m031-20210609 (attached as .config)
compiler: h8300-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/gpu/drm/xlnx/zynqmp_dp.c:997 zynqmp_dp_aux_cmd_submit() error: we previously assumed 'buf' could be null (see line 966)

vim +/buf +997 drivers/gpu/drm/xlnx/zynqmp_dp.c

d76271d22694e8 Hyun Kwon 2018-07-07   949  static int zynqmp_dp_aux_cmd_submit(struct zynqmp_dp *dp, u32 cmd, u16 addr,
d76271d22694e8 Hyun Kwon 2018-07-07   950  				    u8 *buf, u8 bytes, u8 *reply)
d76271d22694e8 Hyun Kwon 2018-07-07   951  {
d76271d22694e8 Hyun Kwon 2018-07-07   952  	bool is_read = (cmd & AUX_READ_BIT) ? true : false;
d76271d22694e8 Hyun Kwon 2018-07-07   953  	u32 reg, i;
d76271d22694e8 Hyun Kwon 2018-07-07   954  
d76271d22694e8 Hyun Kwon 2018-07-07   955  	reg = zynqmp_dp_read(dp, ZYNQMP_DP_INTERRUPT_SIGNAL_STATE);
d76271d22694e8 Hyun Kwon 2018-07-07   956  	if (reg & ZYNQMP_DP_INTERRUPT_SIGNAL_STATE_REQUEST)
d76271d22694e8 Hyun Kwon 2018-07-07   957  		return -EBUSY;
d76271d22694e8 Hyun Kwon 2018-07-07   958  
d76271d22694e8 Hyun Kwon 2018-07-07   959  	zynqmp_dp_write(dp, ZYNQMP_DP_AUX_ADDRESS, addr);
d76271d22694e8 Hyun Kwon 2018-07-07   960  	if (!is_read)
d76271d22694e8 Hyun Kwon 2018-07-07   961  		for (i = 0; i < bytes; i++)
d76271d22694e8 Hyun Kwon 2018-07-07   962  			zynqmp_dp_write(dp, ZYNQMP_DP_AUX_WRITE_FIFO,
d76271d22694e8 Hyun Kwon 2018-07-07   963  					buf[i]);
                                                                                ^^^^^^
d76271d22694e8 Hyun Kwon 2018-07-07   964  
d76271d22694e8 Hyun Kwon 2018-07-07   965  	reg = cmd << ZYNQMP_DP_AUX_COMMAND_CMD_SHIFT;
d76271d22694e8 Hyun Kwon 2018-07-07  @966  	if (!buf || !bytes)

Obviously when bytes is zero then buf is NULL etc...  This is false
positive so you can ignore it if you want, but another option would be
to just check "bytes" here.  if (!bytes) is the same as if (!buf).

d76271d22694e8 Hyun Kwon 2018-07-07   967  		reg |= ZYNQMP_DP_AUX_COMMAND_ADDRESS_ONLY;
d76271d22694e8 Hyun Kwon 2018-07-07   968  	else
d76271d22694e8 Hyun Kwon 2018-07-07   969  		reg |= (bytes - 1) << ZYNQMP_DP_AUX_COMMAND_BYTES_SHIFT;
d76271d22694e8 Hyun Kwon 2018-07-07   970  	zynqmp_dp_write(dp, ZYNQMP_DP_AUX_COMMAND, reg);
d76271d22694e8 Hyun Kwon 2018-07-07   971  
d76271d22694e8 Hyun Kwon 2018-07-07   972  	/* Wait for reply to be delivered upto 2ms */
d76271d22694e8 Hyun Kwon 2018-07-07   973  	for (i = 0; ; i++) {
d76271d22694e8 Hyun Kwon 2018-07-07   974  		reg = zynqmp_dp_read(dp, ZYNQMP_DP_INTERRUPT_SIGNAL_STATE);
d76271d22694e8 Hyun Kwon 2018-07-07   975  		if (reg & ZYNQMP_DP_INTERRUPT_SIGNAL_STATE_REPLY)
d76271d22694e8 Hyun Kwon 2018-07-07   976  			break;
d76271d22694e8 Hyun Kwon 2018-07-07   977  
d76271d22694e8 Hyun Kwon 2018-07-07   978  		if (reg & ZYNQMP_DP_INTERRUPT_SIGNAL_STATE_REPLY_TIMEOUT ||
d76271d22694e8 Hyun Kwon 2018-07-07   979  		    i == 2)
d76271d22694e8 Hyun Kwon 2018-07-07   980  			return -ETIMEDOUT;
d76271d22694e8 Hyun Kwon 2018-07-07   981  
d76271d22694e8 Hyun Kwon 2018-07-07   982  		usleep_range(1000, 1100);
d76271d22694e8 Hyun Kwon 2018-07-07   983  	}
d76271d22694e8 Hyun Kwon 2018-07-07   984  
d76271d22694e8 Hyun Kwon 2018-07-07   985  	reg = zynqmp_dp_read(dp, ZYNQMP_DP_AUX_REPLY_CODE);
d76271d22694e8 Hyun Kwon 2018-07-07   986  	if (reply)
d76271d22694e8 Hyun Kwon 2018-07-07   987  		*reply = reg;
d76271d22694e8 Hyun Kwon 2018-07-07   988  
d76271d22694e8 Hyun Kwon 2018-07-07   989  	if (is_read &&
d76271d22694e8 Hyun Kwon 2018-07-07   990  	    (reg == ZYNQMP_DP_AUX_REPLY_CODE_AUX_ACK ||
d76271d22694e8 Hyun Kwon 2018-07-07   991  	     reg == ZYNQMP_DP_AUX_REPLY_CODE_I2C_ACK)) {
d76271d22694e8 Hyun Kwon 2018-07-07   992  		reg = zynqmp_dp_read(dp, ZYNQMP_DP_REPLY_DATA_COUNT);
d76271d22694e8 Hyun Kwon 2018-07-07   993  		if ((reg & ZYNQMP_DP_REPLY_DATA_COUNT_MASK) != bytes)
d76271d22694e8 Hyun Kwon 2018-07-07   994  			return -EIO;
d76271d22694e8 Hyun Kwon 2018-07-07   995  
d76271d22694e8 Hyun Kwon 2018-07-07   996  		for (i = 0; i < bytes; i++)
d76271d22694e8 Hyun Kwon 2018-07-07  @997  			buf[i] = zynqmp_dp_read(dp, ZYNQMP_DP_AUX_REPLY_DATA);
d76271d22694e8 Hyun Kwon 2018-07-07   998  	}
d76271d22694e8 Hyun Kwon 2018-07-07   999  
d76271d22694e8 Hyun Kwon 2018-07-07  1000  	return 0;
d76271d22694e8 Hyun Kwon 2018-07-07  1001  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

