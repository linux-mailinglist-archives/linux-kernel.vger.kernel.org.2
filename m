Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 847B03448FB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 16:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbhCVPOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 11:14:54 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46746 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbhCVPOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 11:14:25 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12MEwqnM082490;
        Mon, 22 Mar 2021 15:14:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=YzAtSM/e/NthzKmla9UiEyXff05IeN3A8Hv2nPOcmF8=;
 b=IO6gP7Rfc/LPHsM1upP6zDHyTLZlOzLF0mcFNz+942bfCvB8kQA/EL14nnoCWkATiPJ4
 gvenViErCl3+TDG3kbRFDlYk02g+8H96uaXwkPIh7OoHNDbYJ/fnScElXiGLtUsqJIPx
 hS3nJHY4YZPb4MJ6tZr9lGorF2PNOJlJSdNsaU6Yhmmm9SlzSI0ySyEXGuFD/EZu1ofR
 1wK3Irtj3RXLzwR0McrpBI6Yhyy1RdAzVbkNtcpb37J6Cl0ZEWASPQ8bkPNyfgleGIPb
 ZoF199lla1T+dFrO5Hq/r6D2SnRmq0zvY/zDeqwlvi8eOW99d0TIrFw6XeInecw5XApl DQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 37d8fr3uq0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Mar 2021 15:14:19 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12MF0bt4079261;
        Mon, 22 Mar 2021 15:14:18 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 37dtyw7ccp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Mar 2021 15:14:18 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 12MFEGwD030953;
        Mon, 22 Mar 2021 15:14:16 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 22 Mar 2021 08:14:16 -0700
Date:   Mon, 22 Mar 2021 18:14:08 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Coiby Xu <coiby.xu@gmail.com>
Cc:     kbuild@lists.01.org, lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: drivers/staging/qlge/qlge_main.c:4564 qlge_probe() warn: missing
 error code 'err'
Message-ID: <20210322151408.GH1667@kadam>
References: <20210225100303.GW2087@kadam>
 <20210310002137.chikq3biol5vyxgp@Rk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310002137.chikq3biol5vyxgp@Rk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9931 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103220109
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9931 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103220109
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 08:21:37AM +0800, Coiby Xu wrote:
> Hi Dan,
> 
> Thanks for finding this issue! I'll submit all the patches including the
> one for the previous issue reported by you ("[bug report] staging: qlge:
> Initialize devlink health dump framework") after finishing all items listed
> in drivers/staging/qlge/TODO.
> 

I just sent a patch for this.

Part of my QC process before I send a patch is to search my inbox to
see if I have already sent the patch before.  I have the memory of a
gnat and static checker warnings all look the same after a while so I
once wrote the same patch three times before I implemented this as part
of my QC process.

Anyway, it turns out that I did report this bug already but since you
hadn't sent a fix, I decided to just send my fix instead of deleting it.

When kbuild detects a bug in your patch then please fix it as soon as
you can.  Certainly don't wait until "all the TODO items" are done.  (0_0)
Just do what I do and promise to "fix it tomorrow morning" and then
forget about it forever.  ;)

regards,
dan carpenter

> On Thu, Feb 25, 2021 at 01:03:03PM +0300, Dan Carpenter wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master
> > head:   29c395c77a9a514c5857c45ceae2665e9bd99ac7
> > commit: 953b94009377419f28fd0153f91fcd5b5a347608 staging: qlge: Initialize devlink health dump framework
> > config: i386-randconfig-m021-20210225 (attached as .config)
> > compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > 
> > smatch warnings:
> > drivers/staging/qlge/qlge_main.c:4564 qlge_probe() warn: missing error code 'err'
> > 
> > vim +/err +4564 drivers/staging/qlge/qlge_main.c
> > 
> > 5d8e87265715a1 drivers/net/ethernet/qlogic/qlge/qlge_main.c Bill Pemberton     2012-12-03  4544  static int qlge_probe(struct pci_dev *pdev,
> > c4e84bde1d595d drivers/net/qlge/qlge_main.c                 Ron Mercer         2008-09-18  4545  		      const struct pci_device_id *pci_entry)
> > c4e84bde1d595d drivers/net/qlge/qlge_main.c                 Ron Mercer         2008-09-18  4546  {
> > 953b9400937741 drivers/staging/qlge/qlge_main.c             Coiby Xu           2021-01-23  4547  	struct qlge_netdev_priv *ndev_priv;
> > f8c047be540197 drivers/staging/qlge/qlge_main.c             Coiby Xu           2021-01-23  4548  	struct qlge_adapter *qdev = NULL;
> > 953b9400937741 drivers/staging/qlge/qlge_main.c             Coiby Xu           2021-01-23  4549  	struct net_device *ndev = NULL;
> > 953b9400937741 drivers/staging/qlge/qlge_main.c             Coiby Xu           2021-01-23  4550  	struct devlink *devlink;
> > f41e1a0a9462fc drivers/staging/qlge/qlge_main.c             Dorothea Ehrl      2019-11-27  4551  	static int cards_found;
> > c4e84bde1d595d drivers/net/qlge/qlge_main.c                 Ron Mercer         2008-09-18  4552  	int err = 0;
> > c4e84bde1d595d drivers/net/qlge/qlge_main.c                 Ron Mercer         2008-09-18  4553
> > 953b9400937741 drivers/staging/qlge/qlge_main.c             Coiby Xu           2021-01-23  4554  	devlink = devlink_alloc(&qlge_devlink_ops, sizeof(struct qlge_adapter));
> > 953b9400937741 drivers/staging/qlge/qlge_main.c             Coiby Xu           2021-01-23  4555  	if (!devlink)
> > 953b9400937741 drivers/staging/qlge/qlge_main.c             Coiby Xu           2021-01-23  4556  		return -ENOMEM;
> > 953b9400937741 drivers/staging/qlge/qlge_main.c             Coiby Xu           2021-01-23  4557
> > 953b9400937741 drivers/staging/qlge/qlge_main.c             Coiby Xu           2021-01-23  4558  	qdev = devlink_priv(devlink);
> > 953b9400937741 drivers/staging/qlge/qlge_main.c             Coiby Xu           2021-01-23  4559
> > 953b9400937741 drivers/staging/qlge/qlge_main.c             Coiby Xu           2021-01-23  4560  	ndev = alloc_etherdev_mq(sizeof(struct qlge_netdev_priv),
> > 1b998958b301fb drivers/staging/qlge/qlge_main.c             Scott Schafer      2019-12-11  4561  				 min(MAX_CPUS,
> > 1b998958b301fb drivers/staging/qlge/qlge_main.c             Scott Schafer      2019-12-11  4562  				     netif_get_num_default_rss_queues()));
> > c4e84bde1d595d drivers/net/qlge/qlge_main.c                 Ron Mercer         2008-09-18  4563  	if (!ndev)
> > 953b9400937741 drivers/staging/qlge/qlge_main.c             Coiby Xu           2021-01-23 @4564  		goto devlink_free;
> > 
> > "err = -ENOMEM;"
> > 
> > c4e84bde1d595d drivers/net/qlge/qlge_main.c                 Ron Mercer         2008-09-18  4565
> > 953b9400937741 drivers/staging/qlge/qlge_main.c             Coiby Xu           2021-01-23  4566  	ndev_priv = netdev_priv(ndev);
> > 953b9400937741 drivers/staging/qlge/qlge_main.c             Coiby Xu           2021-01-23  4567  	ndev_priv->qdev = qdev;
> > 953b9400937741 drivers/staging/qlge/qlge_main.c             Coiby Xu           2021-01-23  4568  	ndev_priv->ndev = ndev;
> > 953b9400937741 drivers/staging/qlge/qlge_main.c             Coiby Xu           2021-01-23  4569  	qdev->ndev = ndev;
> > 953b9400937741 drivers/staging/qlge/qlge_main.c             Coiby Xu           2021-01-23  4570  	err = qlge_init_device(pdev, qdev, cards_found);
> > 953b9400937741 drivers/staging/qlge/qlge_main.c             Coiby Xu           2021-01-23  4571  	if (err < 0)
> > 953b9400937741 drivers/staging/qlge/qlge_main.c             Coiby Xu           2021-01-23  4572  		goto netdev_free;
> > c4e84bde1d595d drivers/net/qlge/qlge_main.c                 Ron Mercer         2008-09-18  4573
> > c4e84bde1d595d drivers/net/qlge/qlge_main.c                 Ron Mercer         2008-09-18  4574  	SET_NETDEV_DEV(ndev, &pdev->dev);
> > a45adbe8d35247 drivers/net/ethernet/qlogic/qlge/qlge_main.c Jitendra Kalsaria  2013-09-27  4575  	ndev->hw_features = NETIF_F_SG |
> > a45adbe8d35247 drivers/net/ethernet/qlogic/qlge/qlge_main.c Jitendra Kalsaria  2013-09-27  4576  		NETIF_F_IP_CSUM |
> > a45adbe8d35247 drivers/net/ethernet/qlogic/qlge/qlge_main.c Jitendra Kalsaria  2013-09-27  4577  		NETIF_F_TSO |
> > a45adbe8d35247 drivers/net/ethernet/qlogic/qlge/qlge_main.c Jitendra Kalsaria  2013-09-27  4578  		NETIF_F_TSO_ECN |
> > a45adbe8d35247 drivers/net/ethernet/qlogic/qlge/qlge_main.c Jitendra Kalsaria  2013-09-27  4579  		NETIF_F_HW_VLAN_CTAG_TX |
> > a45adbe8d35247 drivers/net/ethernet/qlogic/qlge/qlge_main.c Jitendra Kalsaria  2013-09-27  4580  		NETIF_F_HW_VLAN_CTAG_RX |
> > a45adbe8d35247 drivers/net/ethernet/qlogic/qlge/qlge_main.c Jitendra Kalsaria  2013-09-27  4581  		NETIF_F_HW_VLAN_CTAG_FILTER |
> > a45adbe8d35247 drivers/net/ethernet/qlogic/qlge/qlge_main.c Jitendra Kalsaria  2013-09-27  4582  		NETIF_F_RXCSUM;
> > a45adbe8d35247 drivers/net/ethernet/qlogic/qlge/qlge_main.c Jitendra Kalsaria  2013-09-27  4583  	ndev->features = ndev->hw_features;
> > 1a0150a93c4969 drivers/net/ethernet/qlogic/qlge/qlge_main.c brenohl@br.ibm.com 2012-07-27  4584  	ndev->vlan_features = ndev->hw_features;
> > 51bb352f15595f drivers/net/ethernet/qlogic/qlge/qlge_main.c Jitendra Kalsaria  2014-01-14  4585  	/* vlan gets same features (except vlan filter) */
> > f6d1ac4b5f15f5 drivers/net/ethernet/qlogic/qlge/qlge_main.c Vlad Yasevich      2014-03-27  4586  	ndev->vlan_features &= ~(NETIF_F_HW_VLAN_CTAG_FILTER |
> > f6d1ac4b5f15f5 drivers/net/ethernet/qlogic/qlge/qlge_main.c Vlad Yasevich      2014-03-27  4587  				 NETIF_F_HW_VLAN_CTAG_TX |
> > f6d1ac4b5f15f5 drivers/net/ethernet/qlogic/qlge/qlge_main.c Vlad Yasevich      2014-03-27  4588  				 NETIF_F_HW_VLAN_CTAG_RX);
> > c4e84bde1d595d drivers/net/qlge/qlge_main.c                 Ron Mercer         2008-09-18  4589
> > c4e84bde1d595d drivers/net/qlge/qlge_main.c                 Ron Mercer         2008-09-18  4590  	if (test_bit(QL_DMA64, &qdev->flags))
> > c4e84bde1d595d drivers/net/qlge/qlge_main.c                 Ron Mercer         2008-09-18  4591  		ndev->features |= NETIF_F_HIGHDMA;
> > c4e84bde1d595d drivers/net/qlge/qlge_main.c                 Ron Mercer         2008-09-18  4592
> > c4e84bde1d595d drivers/net/qlge/qlge_main.c                 Ron Mercer         2008-09-18  4593  	/*
> > c4e84bde1d595d drivers/net/qlge/qlge_main.c                 Ron Mercer         2008-09-18  4594  	 * Set up net_device structure.
> > c4e84bde1d595d drivers/net/qlge/qlge_main.c                 Ron Mercer         2008-09-18  4595  	 */
> > c4e84bde1d595d drivers/net/qlge/qlge_main.c                 Ron Mercer         2008-09-18  4596  	ndev->tx_queue_len = qdev->tx_ring_size;
> > c4e84bde1d595d drivers/net/qlge/qlge_main.c                 Ron Mercer         2008-09-18  4597  	ndev->irq = pdev->irq;
> > 25ed784910e43e drivers/net/qlge/qlge_main.c                 Stephen Hemminger  2008-11-21  4598
> > 25ed784910e43e drivers/net/qlge/qlge_main.c                 Stephen Hemminger  2008-11-21  4599  	ndev->netdev_ops = &qlge_netdev_ops;
> > 7ad24ea4bf620a drivers/net/ethernet/qlogic/qlge/qlge_main.c Wilfried Klaebe    2014-05-11  4600  	ndev->ethtool_ops = &qlge_ethtool_ops;
> > c4e84bde1d595d drivers/net/qlge/qlge_main.c                 Ron Mercer         2008-09-18  4601  	ndev->watchdog_timeo = 10 * HZ;
> > 25ed784910e43e drivers/net/qlge/qlge_main.c                 Stephen Hemminger  2008-11-21  4602
> > d894be57ca92c8 drivers/net/ethernet/qlogic/qlge/qlge_main.c Jarod Wilson       2016-10-20  4603  	/* MTU range: this driver only supports 1500 or 9000, so this only
> > d894be57ca92c8 drivers/net/ethernet/qlogic/qlge/qlge_main.c Jarod Wilson       2016-10-20  4604  	 * filters out values above or below, and we'll rely on
> > d894be57ca92c8 drivers/net/ethernet/qlogic/qlge/qlge_main.c Jarod Wilson       2016-10-20  4605  	 * qlge_change_mtu to make sure only 1500 or 9000 are allowed
> > d894be57ca92c8 drivers/net/ethernet/qlogic/qlge/qlge_main.c Jarod Wilson       2016-10-20  4606  	 */
> > d894be57ca92c8 drivers/net/ethernet/qlogic/qlge/qlge_main.c Jarod Wilson       2016-10-20  4607  	ndev->min_mtu = ETH_DATA_LEN;
> > d894be57ca92c8 drivers/net/ethernet/qlogic/qlge/qlge_main.c Jarod Wilson       2016-10-20  4608  	ndev->max_mtu = 9000;
> > d894be57ca92c8 drivers/net/ethernet/qlogic/qlge/qlge_main.c Jarod Wilson       2016-10-20  4609
> > c4e84bde1d595d drivers/net/qlge/qlge_main.c                 Ron Mercer         2008-09-18  4610  	err = register_netdev(ndev);
> > c4e84bde1d595d drivers/net/qlge/qlge_main.c                 Ron Mercer         2008-09-18  4611  	if (err) {
> > c4e84bde1d595d drivers/net/qlge/qlge_main.c                 Ron Mercer         2008-09-18  4612  		dev_err(&pdev->dev, "net device registration failed.\n");
> > f8c047be540197 drivers/staging/qlge/qlge_main.c             Coiby Xu           2021-01-23  4613  		qlge_release_all(pdev);
> > c4e84bde1d595d drivers/net/qlge/qlge_main.c                 Ron Mercer         2008-09-18  4614  		pci_disable_device(pdev);
> > 953b9400937741 drivers/staging/qlge/qlge_main.c             Coiby Xu           2021-01-23  4615  		goto netdev_free;
> > c4e84bde1d595d drivers/net/qlge/qlge_main.c                 Ron Mercer         2008-09-18  4616  	}
> > 953b9400937741 drivers/staging/qlge/qlge_main.c             Coiby Xu           2021-01-23  4617
> > 953b9400937741 drivers/staging/qlge/qlge_main.c             Coiby Xu           2021-01-23  4618  	err = devlink_register(devlink, &pdev->dev);
> > 953b9400937741 drivers/staging/qlge/qlge_main.c             Coiby Xu           2021-01-23  4619  	if (err)
> > 953b9400937741 drivers/staging/qlge/qlge_main.c             Coiby Xu           2021-01-23  4620  		goto netdev_free;
> > 953b9400937741 drivers/staging/qlge/qlge_main.c             Coiby Xu           2021-01-23  4621
> > 953b9400937741 drivers/staging/qlge/qlge_main.c             Coiby Xu           2021-01-23  4622  	qlge_health_create_reporters(qdev);
> > 15c052fc7f4a1b drivers/net/qlge/qlge_main.c                 Ron Mercer         2010-02-04  4623  	/* Start up the timer to trigger EEH if
> > 15c052fc7f4a1b drivers/net/qlge/qlge_main.c                 Ron Mercer         2010-02-04  4624  	 * the bus goes dead
> > 15c052fc7f4a1b drivers/net/qlge/qlge_main.c                 Ron Mercer         2010-02-04  4625  	 */
> > f8c047be540197 drivers/staging/qlge/qlge_main.c             Coiby Xu           2021-01-23  4626  	timer_setup(&qdev->timer, qlge_timer, TIMER_DEFERRABLE);
> > df7e828c1b6997 drivers/net/ethernet/qlogic/qlge/qlge_main.c Kees Cook          2017-10-04  4627  	mod_timer(&qdev->timer, jiffies + (5 * HZ));
> > f8c047be540197 drivers/staging/qlge/qlge_main.c             Coiby Xu           2021-01-23  4628  	qlge_link_off(qdev);
> > f8c047be540197 drivers/staging/qlge/qlge_main.c             Coiby Xu           2021-01-23  4629  	qlge_display_dev_info(ndev);
> > 9dfbbaa6b0b9f7 drivers/net/qlge/qlge_main.c                 Ron Mercer         2009-10-30  4630  	atomic_set(&qdev->lb_count, 0);
> > c4e84bde1d595d drivers/net/qlge/qlge_main.c                 Ron Mercer         2008-09-18  4631  	cards_found++;
> > c4e84bde1d595d drivers/net/qlge/qlge_main.c                 Ron Mercer         2008-09-18  4632  	return 0;
> > 953b9400937741 drivers/staging/qlge/qlge_main.c             Coiby Xu           2021-01-23  4633
> > 953b9400937741 drivers/staging/qlge/qlge_main.c             Coiby Xu           2021-01-23  4634  netdev_free:
> > 953b9400937741 drivers/staging/qlge/qlge_main.c             Coiby Xu           2021-01-23  4635  	free_netdev(ndev);
> > 953b9400937741 drivers/staging/qlge/qlge_main.c             Coiby Xu           2021-01-23  4636  devlink_free:
> > 953b9400937741 drivers/staging/qlge/qlge_main.c             Coiby Xu           2021-01-23  4637  	devlink_free(devlink);
> > 953b9400937741 drivers/staging/qlge/qlge_main.c             Coiby Xu           2021-01-23  4638
> > 953b9400937741 drivers/staging/qlge/qlge_main.c             Coiby Xu           2021-01-23  4639  	return err;
> > c4e84bde1d595d drivers/net/qlge/qlge_main.c                 Ron Mercer         2008-09-18  4640  }
> > 
> > ---
> > 0-DAY CI Kernel Test Service, Intel Corporation
> > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 
> 
> 
> -- 
> Best regards,
> Coiby
