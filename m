Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 937F9382D13
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 15:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235366AbhEQNQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 09:16:46 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:8584 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230312AbhEQNQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 09:16:45 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14HDBDVu001655;
        Mon, 17 May 2021 13:15:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=ma0UoF8ThuxWjuV2MJTVrxlighgBjQT54b+xSc7zqtk=;
 b=YqJ96+9iqZxHfiExbtSBrkTcHk1zvzR3jK5at5Fkum4y41pMkeiXBe7EqtnHSyzJrRX2
 6OY8NyS42nO3JNe3avlLSKs+K+Osy+a4B6LkF67jngkD6jxc7zvxA0s6ZubZZTkjK5Tk
 DVxS4OD3Y4cxYE0C/K6+sAnh9ZS7Rfe4C6PeKWs7wF3aC2pNggctRRoTm6uxnBT/Lzs0
 zjcoD5Fq2Jj7ii8Q56yBi4lloXZ39av4ut2FGQV6GEjWemVVE02/hFGi8gVy0+oOltcy
 IjZnacTj7h+9n6pvWBBDFi1fsji6qavNKuX++gFbFcNOklaTOgGLUsJa6j2ba1Gra/+y lw== 
Received: from oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 38kfhwg6th-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 May 2021 13:15:22 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14HDFLOs024681;
        Mon, 17 May 2021 13:15:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 38j645ej87-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 May 2021 13:15:21 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14HDFKBD024490;
        Mon, 17 May 2021 13:15:20 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 38j645ej6k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 May 2021 13:15:20 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 14HDFIPx012386;
        Mon, 17 May 2021 13:15:19 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 17 May 2021 06:15:18 -0700
Date:   Mon, 17 May 2021 16:15:12 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: drivers/net/dsa/ocelot/felix.c:1329 felix_check_xtr_pkt() error:
 uninitialized symbol 'err'.
Message-ID: <202105172026.SG93CMim-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: E8kLUfMjSX7kFKhMyybC4pu_-SCk2smw
X-Proofpoint-ORIG-GUID: E8kLUfMjSX7kFKhMyybC4pu_-SCk2smw
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d07f6ca923ea0927a1024dfccafc5b53b61cfecc
commit: 0a6f17c6ae2116809a7b7eb6dd3eab59ef5460ef net: dsa: tag_ocelot_8021q: add support for PTP timestamping
config: i386-randconfig-m021-20210517 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/net/dsa/ocelot/felix.c:1329 felix_check_xtr_pkt() error: uninitialized symbol 'err'.

vim +/err +1329 drivers/net/dsa/ocelot/felix.c

0a6f17c6ae21168 Vladimir Oltean 2021-02-14  1286  static bool felix_check_xtr_pkt(struct ocelot *ocelot, unsigned int ptp_type)
0a6f17c6ae21168 Vladimir Oltean 2021-02-14  1287  {
0a6f17c6ae21168 Vladimir Oltean 2021-02-14  1288  	struct felix *felix = ocelot_to_felix(ocelot);
0a6f17c6ae21168 Vladimir Oltean 2021-02-14  1289  	int err, grp = 0;
0a6f17c6ae21168 Vladimir Oltean 2021-02-14  1290  
0a6f17c6ae21168 Vladimir Oltean 2021-02-14  1291  	if (felix->tag_proto != DSA_TAG_PROTO_OCELOT_8021Q)
0a6f17c6ae21168 Vladimir Oltean 2021-02-14  1292  		return false;
0a6f17c6ae21168 Vladimir Oltean 2021-02-14  1293  
0a6f17c6ae21168 Vladimir Oltean 2021-02-14  1294  	if (!felix->info->quirk_no_xtr_irq)
0a6f17c6ae21168 Vladimir Oltean 2021-02-14  1295  		return false;
0a6f17c6ae21168 Vladimir Oltean 2021-02-14  1296  
0a6f17c6ae21168 Vladimir Oltean 2021-02-14  1297  	if (ptp_type == PTP_CLASS_NONE)
0a6f17c6ae21168 Vladimir Oltean 2021-02-14  1298  		return false;
0a6f17c6ae21168 Vladimir Oltean 2021-02-14  1299  
0a6f17c6ae21168 Vladimir Oltean 2021-02-14  1300  	while (ocelot_read(ocelot, QS_XTR_DATA_PRESENT) & BIT(grp)) {

The static checker can't know whether we always enter this loop.

0a6f17c6ae21168 Vladimir Oltean 2021-02-14  1301  		struct sk_buff *skb;
0a6f17c6ae21168 Vladimir Oltean 2021-02-14  1302  		unsigned int type;
0a6f17c6ae21168 Vladimir Oltean 2021-02-14  1303  
0a6f17c6ae21168 Vladimir Oltean 2021-02-14  1304  		err = ocelot_xtr_poll_frame(ocelot, grp, &skb);
0a6f17c6ae21168 Vladimir Oltean 2021-02-14  1305  		if (err)
0a6f17c6ae21168 Vladimir Oltean 2021-02-14  1306  			goto out;
0a6f17c6ae21168 Vladimir Oltean 2021-02-14  1307  
0a6f17c6ae21168 Vladimir Oltean 2021-02-14  1308  		/* We trap to the CPU port module all PTP frames, but
0a6f17c6ae21168 Vladimir Oltean 2021-02-14  1309  		 * felix_rxtstamp() only gets called for event frames.
0a6f17c6ae21168 Vladimir Oltean 2021-02-14  1310  		 * So we need to avoid sending duplicate general
0a6f17c6ae21168 Vladimir Oltean 2021-02-14  1311  		 * message frames by running a second BPF classifier
0a6f17c6ae21168 Vladimir Oltean 2021-02-14  1312  		 * here and dropping those.
0a6f17c6ae21168 Vladimir Oltean 2021-02-14  1313  		 */
0a6f17c6ae21168 Vladimir Oltean 2021-02-14  1314  		__skb_push(skb, ETH_HLEN);
0a6f17c6ae21168 Vladimir Oltean 2021-02-14  1315  
0a6f17c6ae21168 Vladimir Oltean 2021-02-14  1316  		type = ptp_classify_raw(skb);
0a6f17c6ae21168 Vladimir Oltean 2021-02-14  1317  
0a6f17c6ae21168 Vladimir Oltean 2021-02-14  1318  		__skb_pull(skb, ETH_HLEN);
0a6f17c6ae21168 Vladimir Oltean 2021-02-14  1319  
0a6f17c6ae21168 Vladimir Oltean 2021-02-14  1320  		if (type == PTP_CLASS_NONE) {
0a6f17c6ae21168 Vladimir Oltean 2021-02-14  1321  			kfree_skb(skb);
0a6f17c6ae21168 Vladimir Oltean 2021-02-14  1322  			continue;
0a6f17c6ae21168 Vladimir Oltean 2021-02-14  1323  		}
0a6f17c6ae21168 Vladimir Oltean 2021-02-14  1324  
0a6f17c6ae21168 Vladimir Oltean 2021-02-14  1325  		netif_rx(skb);
0a6f17c6ae21168 Vladimir Oltean 2021-02-14  1326  	}
0a6f17c6ae21168 Vladimir Oltean 2021-02-14  1327  
0a6f17c6ae21168 Vladimir Oltean 2021-02-14  1328  out:
0a6f17c6ae21168 Vladimir Oltean 2021-02-14 @1329  	if (err < 0)
0a6f17c6ae21168 Vladimir Oltean 2021-02-14  1330  		ocelot_drain_cpu_queue(ocelot, 0);
0a6f17c6ae21168 Vladimir Oltean 2021-02-14  1331  
0a6f17c6ae21168 Vladimir Oltean 2021-02-14  1332  	return true;
0a6f17c6ae21168 Vladimir Oltean 2021-02-14  1333  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

