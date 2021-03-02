Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D57A32A5A7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 17:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350989AbhCBM7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 07:59:20 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:46214 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446616AbhCBMM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 07:12:27 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 122CAffn122673;
        Tue, 2 Mar 2021 12:11:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=vFlqk/n0sIz+J0WMlX2+mDATUbkRMfGZ850YdcvXnso=;
 b=aDkp699qaeUuRSv20RiDqQYqtifHpA/unSABaDLBZHtkxGADqZdePdPTcK+7I5jhHi0t
 NrKPt9gkV6/1rHDr3YwZPHqzSBAoZkrb7fDIL/lmvBHg2EdxPgMRz0D6Jr3cZX35clbQ
 q3RV7mYHU+1GwF9oeRLXRVBChP7vImqT55jCpsqAQhR6QU/w7c1bez//9tONsKKl0QqC
 TspzgOgx74J0FRO3jGqCLTD+v0OQIycAcFF7wxERQJe98h5nLGgIRd5oJsOeqb7tR1SA
 7WfcFQ6NgufBz2yR4mEA//jDzF89GLA/o5nCsZln9vD1K4pnvw+lEgwCe23g5zT3vBX2 pQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 36ye1m7afn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Mar 2021 12:11:37 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 122CAWsu111291;
        Tue, 2 Mar 2021 12:11:36 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 36yyurwn9n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Mar 2021 12:11:36 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 122CBYQ0016706;
        Tue, 2 Mar 2021 12:11:34 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 02 Mar 2021 04:11:34 -0800
Date:   Tue, 2 Mar 2021 15:11:25 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [kbuild] drivers/spi/spi-cadence-quadspi.c:250:18: warning: Shifting
 signed 32-bit value by 31 bits is undefined behaviour
Message-ID: <20210302121125.GU2222@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-ID-Hash: AHKHJSBLOLPMOOQZWT5HBY4OYHJX2END
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9910 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103020102
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9910 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 priorityscore=1501
 mlxlogscore=999 impostorscore=0 suspectscore=0 adultscore=0 malwarescore=0
 mlxscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103020102
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master
head:   7a7fd0de4a9804299793e564a555a49c1fc924cb
commit: 31fb632b5d43ca16713095b3a4fe17e3d7331e28 spi: Move cadence-quadspi driver to drivers/spi/
compiler: nds32le-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

cppcheck possible warnings: (new ones prefixed by >>, may not real problems)

>> drivers/spi/spi-cadence-quadspi.c:250:18: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
    return reg & (1 << CQSPI_REG_CONFIG_IDLE_LSB);

vim +250 drivers/spi/spi-cadence-quadspi.c

14062341053690 drivers/mtd/spi-nor/cadence-quadspi.c Graham Moore 2016-06-04  246  static bool cqspi_is_idle(struct cqspi_st *cqspi)
14062341053690 drivers/mtd/spi-nor/cadence-quadspi.c Graham Moore 2016-06-04  247  {
14062341053690 drivers/mtd/spi-nor/cadence-quadspi.c Graham Moore 2016-06-04  248  	u32 reg = readl(cqspi->iobase + CQSPI_REG_CONFIG);
14062341053690 drivers/mtd/spi-nor/cadence-quadspi.c Graham Moore 2016-06-04  249  
14062341053690 drivers/mtd/spi-nor/cadence-quadspi.c Graham Moore 2016-06-04 @250  	return reg & (1 << CQSPI_REG_CONFIG_IDLE_LSB);
                                                                                                           ^^^^^^^^^^^^^^^^^^^^^^^^^
CQSPI_REG_CONFIG_IDLE_LSB is 31 and reg is a u32 so this is very
puzzling.

14062341053690 drivers/mtd/spi-nor/cadence-quadspi.c Graham Moore 2016-06-04  251  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org 
_______________________________________________
kbuild mailing list -- kbuild@lists.01.org
To unsubscribe send an email to kbuild-leave@lists.01.org
