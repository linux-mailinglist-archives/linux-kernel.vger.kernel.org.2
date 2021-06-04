Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F61139B39B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 09:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbhFDHM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 03:12:27 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47778 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbhFDHM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 03:12:26 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15479dkh029063;
        Fri, 4 Jun 2021 07:10:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=136TV4DHmdXkgqHRijxe9UB1ln28YETYypx6otIordE=;
 b=Uvb2/S2a/r3dOCCt+dZ/zrqWhFog1J9hd/MWRVZzF5TXqNr3CJLuO5HIDLKPlYwv148Y
 khbKx79egdDOiPu4KSZ1RUi1tvSI+v8PYPNwTp8H/TZiHVFCihwnAwHIdBkJxGkxztb+
 ZlpEBHK1L/kiSdHbFKLe2gy6ndj8UHaE4YmQY1mK14FX2q6eIGYhi+yiaIoMHx+aK7c6
 oSldwIncoRLeUUdMXKP4jeAAgMUmQz3sOxKcC82G6+hVgU4mm4m0uox/CQTrdxqXK76A
 W38t/1eS/OPkn+zrQqnWfY///11RmYVSA+ZUojqixFt66Z8DjbOLv+gZ6oltdc3DIi29 pg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 38udjmw4uh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Jun 2021 07:10:33 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1547A9OU131584;
        Fri, 4 Jun 2021 07:10:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 38uar01gqg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Jun 2021 07:10:32 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 1547AWRu132015;
        Fri, 4 Jun 2021 07:10:32 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 38uar01gq3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Jun 2021 07:10:32 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 1547AT4K004970;
        Fri, 4 Jun 2021 07:10:30 GMT
Received: from kadam (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 04 Jun 2021 00:10:29 -0700
Date:   Fri, 4 Jun 2021 10:10:22 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: drivers/thunderbolt/test.c:266 alloc_dev_default() error: we
 previously assumed 'port->dual_link_port' could be null (see line 258)
Message-ID: <202106041339.3wpPAETC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: zNcQx8nI8PhPbfBQkEfwE0-g2P2Lr4IL
X-Proofpoint-ORIG-GUID: zNcQx8nI8PhPbfBQkEfwE0-g2P2Lr4IL
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10004 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 impostorscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 adultscore=0 spamscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106040056
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f88cd3fb9df228e5ce4e13ec3dbad671ddb2146e
commit: 54509f5005caccd8459c9084535802feeb27bb2c thunderbolt: Add KUnit tests for path walking
config: i386-randconfig-m021-20210604 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/thunderbolt/test.c:266 alloc_dev_default() error: we previously assumed 'port->dual_link_port' could be null (see line 258)
drivers/thunderbolt/test.c:268 alloc_dev_default() error: we previously assumed 'upstream_port->dual_link_port' could be null (see line 258)

vim +266 drivers/thunderbolt/test.c

54509f5005cacc Mika Westerberg 2020-04-29  144  static struct tb_switch *alloc_dev_default(struct kunit *test,
54509f5005cacc Mika Westerberg 2020-04-29  145  					   struct tb_switch *parent,
54509f5005cacc Mika Westerberg 2020-04-29  146  					   u64 route, bool bonded)
54509f5005cacc Mika Westerberg 2020-04-29  147  {
54509f5005cacc Mika Westerberg 2020-04-29  148  	struct tb_port *port, *upstream_port;
54509f5005cacc Mika Westerberg 2020-04-29  149  	struct tb_switch *sw;
54509f5005cacc Mika Westerberg 2020-04-29  150  
54509f5005cacc Mika Westerberg 2020-04-29  151  	sw = alloc_switch(test, route, 1, 19);
54509f5005cacc Mika Westerberg 2020-04-29  152  	if (!sw)
54509f5005cacc Mika Westerberg 2020-04-29  153  		return NULL;
54509f5005cacc Mika Westerberg 2020-04-29  154  
54509f5005cacc Mika Westerberg 2020-04-29  155  	sw->config.vendor_id = 0x8086;
54509f5005cacc Mika Westerberg 2020-04-29  156  	sw->config.device_id = 0x15ef;
54509f5005cacc Mika Westerberg 2020-04-29  157  
54509f5005cacc Mika Westerberg 2020-04-29  158  	sw->ports[0].config.type = TB_TYPE_PORT;
54509f5005cacc Mika Westerberg 2020-04-29  159  	sw->ports[0].config.max_in_hop_id = 8;
54509f5005cacc Mika Westerberg 2020-04-29  160  	sw->ports[0].config.max_out_hop_id = 8;
54509f5005cacc Mika Westerberg 2020-04-29  161  
54509f5005cacc Mika Westerberg 2020-04-29  162  	sw->ports[1].config.type = TB_TYPE_PORT;
54509f5005cacc Mika Westerberg 2020-04-29  163  	sw->ports[1].config.max_in_hop_id = 19;
54509f5005cacc Mika Westerberg 2020-04-29  164  	sw->ports[1].config.max_out_hop_id = 19;
54509f5005cacc Mika Westerberg 2020-04-29  165  	sw->ports[1].dual_link_port = &sw->ports[2];
54509f5005cacc Mika Westerberg 2020-04-29  166  
54509f5005cacc Mika Westerberg 2020-04-29  167  	sw->ports[2].config.type = TB_TYPE_PORT;
54509f5005cacc Mika Westerberg 2020-04-29  168  	sw->ports[2].config.max_in_hop_id = 19;
54509f5005cacc Mika Westerberg 2020-04-29  169  	sw->ports[2].config.max_out_hop_id = 19;
54509f5005cacc Mika Westerberg 2020-04-29  170  	sw->ports[2].dual_link_port = &sw->ports[1];
54509f5005cacc Mika Westerberg 2020-04-29  171  	sw->ports[2].link_nr = 1;
54509f5005cacc Mika Westerberg 2020-04-29  172  
54509f5005cacc Mika Westerberg 2020-04-29  173  	sw->ports[3].config.type = TB_TYPE_PORT;
54509f5005cacc Mika Westerberg 2020-04-29  174  	sw->ports[3].config.max_in_hop_id = 19;
54509f5005cacc Mika Westerberg 2020-04-29  175  	sw->ports[3].config.max_out_hop_id = 19;
54509f5005cacc Mika Westerberg 2020-04-29  176  	sw->ports[3].dual_link_port = &sw->ports[4];
54509f5005cacc Mika Westerberg 2020-04-29  177  
54509f5005cacc Mika Westerberg 2020-04-29  178  	sw->ports[4].config.type = TB_TYPE_PORT;
54509f5005cacc Mika Westerberg 2020-04-29  179  	sw->ports[4].config.max_in_hop_id = 19;
54509f5005cacc Mika Westerberg 2020-04-29  180  	sw->ports[4].config.max_out_hop_id = 19;
54509f5005cacc Mika Westerberg 2020-04-29  181  	sw->ports[4].dual_link_port = &sw->ports[3];
54509f5005cacc Mika Westerberg 2020-04-29  182  	sw->ports[4].link_nr = 1;
54509f5005cacc Mika Westerberg 2020-04-29  183  
54509f5005cacc Mika Westerberg 2020-04-29  184  	sw->ports[5].config.type = TB_TYPE_PORT;
54509f5005cacc Mika Westerberg 2020-04-29  185  	sw->ports[5].config.max_in_hop_id = 19;
54509f5005cacc Mika Westerberg 2020-04-29  186  	sw->ports[5].config.max_out_hop_id = 19;
54509f5005cacc Mika Westerberg 2020-04-29  187  	sw->ports[5].dual_link_port = &sw->ports[6];
54509f5005cacc Mika Westerberg 2020-04-29  188  
54509f5005cacc Mika Westerberg 2020-04-29  189  	sw->ports[6].config.type = TB_TYPE_PORT;
54509f5005cacc Mika Westerberg 2020-04-29  190  	sw->ports[6].config.max_in_hop_id = 19;
54509f5005cacc Mika Westerberg 2020-04-29  191  	sw->ports[6].config.max_out_hop_id = 19;
54509f5005cacc Mika Westerberg 2020-04-29  192  	sw->ports[6].dual_link_port = &sw->ports[5];
54509f5005cacc Mika Westerberg 2020-04-29  193  	sw->ports[6].link_nr = 1;
54509f5005cacc Mika Westerberg 2020-04-29  194  
54509f5005cacc Mika Westerberg 2020-04-29  195  	sw->ports[7].config.type = TB_TYPE_PORT;
54509f5005cacc Mika Westerberg 2020-04-29  196  	sw->ports[7].config.max_in_hop_id = 19;
54509f5005cacc Mika Westerberg 2020-04-29  197  	sw->ports[7].config.max_out_hop_id = 19;
54509f5005cacc Mika Westerberg 2020-04-29  198  	sw->ports[7].dual_link_port = &sw->ports[8];
54509f5005cacc Mika Westerberg 2020-04-29  199  
54509f5005cacc Mika Westerberg 2020-04-29  200  	sw->ports[8].config.type = TB_TYPE_PORT;
54509f5005cacc Mika Westerberg 2020-04-29  201  	sw->ports[8].config.max_in_hop_id = 19;
54509f5005cacc Mika Westerberg 2020-04-29  202  	sw->ports[8].config.max_out_hop_id = 19;
54509f5005cacc Mika Westerberg 2020-04-29  203  	sw->ports[8].dual_link_port = &sw->ports[7];
54509f5005cacc Mika Westerberg 2020-04-29  204  	sw->ports[8].link_nr = 1;
54509f5005cacc Mika Westerberg 2020-04-29  205  
54509f5005cacc Mika Westerberg 2020-04-29  206  	sw->ports[9].config.type = TB_TYPE_PCIE_UP;
54509f5005cacc Mika Westerberg 2020-04-29  207  	sw->ports[9].config.max_in_hop_id = 8;
54509f5005cacc Mika Westerberg 2020-04-29  208  	sw->ports[9].config.max_out_hop_id = 8;
54509f5005cacc Mika Westerberg 2020-04-29  209  
54509f5005cacc Mika Westerberg 2020-04-29  210  	sw->ports[10].config.type = TB_TYPE_PCIE_DOWN;
54509f5005cacc Mika Westerberg 2020-04-29  211  	sw->ports[10].config.max_in_hop_id = 8;
54509f5005cacc Mika Westerberg 2020-04-29  212  	sw->ports[10].config.max_out_hop_id = 8;
54509f5005cacc Mika Westerberg 2020-04-29  213  
54509f5005cacc Mika Westerberg 2020-04-29  214  	sw->ports[11].config.type = TB_TYPE_PCIE_DOWN;
54509f5005cacc Mika Westerberg 2020-04-29  215  	sw->ports[11].config.max_in_hop_id = 8;
54509f5005cacc Mika Westerberg 2020-04-29  216  	sw->ports[11].config.max_out_hop_id = 8;
54509f5005cacc Mika Westerberg 2020-04-29  217  
54509f5005cacc Mika Westerberg 2020-04-29  218  	sw->ports[12].config.type = TB_TYPE_PCIE_DOWN;
54509f5005cacc Mika Westerberg 2020-04-29  219  	sw->ports[12].config.max_in_hop_id = 8;
54509f5005cacc Mika Westerberg 2020-04-29  220  	sw->ports[12].config.max_out_hop_id = 8;
54509f5005cacc Mika Westerberg 2020-04-29  221  
54509f5005cacc Mika Westerberg 2020-04-29  222  	sw->ports[13].config.type = TB_TYPE_DP_HDMI_OUT;
54509f5005cacc Mika Westerberg 2020-04-29  223  	sw->ports[13].config.max_in_hop_id = 9;
54509f5005cacc Mika Westerberg 2020-04-29  224  	sw->ports[13].config.max_out_hop_id = 9;
54509f5005cacc Mika Westerberg 2020-04-29  225  	sw->ports[13].cap_adap = -1;
54509f5005cacc Mika Westerberg 2020-04-29  226  
54509f5005cacc Mika Westerberg 2020-04-29  227  	sw->ports[14].config.type = TB_TYPE_DP_HDMI_OUT;
54509f5005cacc Mika Westerberg 2020-04-29  228  	sw->ports[14].config.max_in_hop_id = 9;
54509f5005cacc Mika Westerberg 2020-04-29  229  	sw->ports[14].config.max_out_hop_id = 9;
54509f5005cacc Mika Westerberg 2020-04-29  230  	sw->ports[14].cap_adap = -1;
54509f5005cacc Mika Westerberg 2020-04-29  231  
54509f5005cacc Mika Westerberg 2020-04-29  232  	sw->ports[15].disabled = true;
54509f5005cacc Mika Westerberg 2020-04-29  233  
54509f5005cacc Mika Westerberg 2020-04-29  234  	sw->ports[16].config.type = TB_TYPE_USB3_UP;
54509f5005cacc Mika Westerberg 2020-04-29  235  	sw->ports[16].config.max_in_hop_id = 8;
54509f5005cacc Mika Westerberg 2020-04-29  236  	sw->ports[16].config.max_out_hop_id = 8;
54509f5005cacc Mika Westerberg 2020-04-29  237  
54509f5005cacc Mika Westerberg 2020-04-29  238  	sw->ports[17].config.type = TB_TYPE_USB3_DOWN;
54509f5005cacc Mika Westerberg 2020-04-29  239  	sw->ports[17].config.max_in_hop_id = 8;
54509f5005cacc Mika Westerberg 2020-04-29  240  	sw->ports[17].config.max_out_hop_id = 8;
54509f5005cacc Mika Westerberg 2020-04-29  241  
54509f5005cacc Mika Westerberg 2020-04-29  242  	sw->ports[18].config.type = TB_TYPE_USB3_DOWN;
54509f5005cacc Mika Westerberg 2020-04-29  243  	sw->ports[18].config.max_in_hop_id = 8;
54509f5005cacc Mika Westerberg 2020-04-29  244  	sw->ports[18].config.max_out_hop_id = 8;
54509f5005cacc Mika Westerberg 2020-04-29  245  
54509f5005cacc Mika Westerberg 2020-04-29  246  	sw->ports[19].config.type = TB_TYPE_USB3_DOWN;
54509f5005cacc Mika Westerberg 2020-04-29  247  	sw->ports[19].config.max_in_hop_id = 8;
54509f5005cacc Mika Westerberg 2020-04-29  248  	sw->ports[19].config.max_out_hop_id = 8;
54509f5005cacc Mika Westerberg 2020-04-29  249  
54509f5005cacc Mika Westerberg 2020-04-29  250  	if (!parent)
54509f5005cacc Mika Westerberg 2020-04-29  251  		return sw;
54509f5005cacc Mika Westerberg 2020-04-29  252  
54509f5005cacc Mika Westerberg 2020-04-29  253  	/* Link them */
54509f5005cacc Mika Westerberg 2020-04-29  254  	upstream_port = tb_upstream_port(sw);
54509f5005cacc Mika Westerberg 2020-04-29  255  	port = tb_port_at(route, parent);
54509f5005cacc Mika Westerberg 2020-04-29  256  	port->remote = upstream_port;
54509f5005cacc Mika Westerberg 2020-04-29  257  	upstream_port->remote = port;
54509f5005cacc Mika Westerberg 2020-04-29 @258  	if (port->dual_link_port && upstream_port->dual_link_port) {
                                                            ^^^^^^^^^^^^^^^^^^^^    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Checks for NULL

54509f5005cacc Mika Westerberg 2020-04-29  259  		port->dual_link_port->remote = upstream_port->dual_link_port;
54509f5005cacc Mika Westerberg 2020-04-29  260  		upstream_port->dual_link_port->remote = port->dual_link_port;
54509f5005cacc Mika Westerberg 2020-04-29  261  	}
54509f5005cacc Mika Westerberg 2020-04-29  262  
54509f5005cacc Mika Westerberg 2020-04-29  263  	if (bonded) {
54509f5005cacc Mika Westerberg 2020-04-29  264  		/* Bonding is used */
54509f5005cacc Mika Westerberg 2020-04-29  265  		port->bonded = true;
54509f5005cacc Mika Westerberg 2020-04-29 @266  		port->dual_link_port->bonded = true;
                                                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Unchecked dereference

54509f5005cacc Mika Westerberg 2020-04-29  267  		upstream_port->bonded = true;
54509f5005cacc Mika Westerberg 2020-04-29 @268  		upstream_port->dual_link_port->bonded = true;
                                                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

It's possible that these warning would go away if we were running
Smatch with the cross function database.  (I'm not sure how the zero
day bot does it).

54509f5005cacc Mika Westerberg 2020-04-29  269  	}
54509f5005cacc Mika Westerberg 2020-04-29  270  
54509f5005cacc Mika Westerberg 2020-04-29  271  	return sw;
54509f5005cacc Mika Westerberg 2020-04-29  272  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

