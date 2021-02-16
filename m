Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 380D131D09E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 20:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbhBPTEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 14:04:22 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:10287 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbhBPTET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 14:04:19 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B602c17060000>; Tue, 16 Feb 2021 11:03:34 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 16 Feb
 2021 19:03:25 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 16 Feb 2021 19:03:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=To7ukUjR1f2DZn5pJRiTuGSqsOIIfWOEdxQPUsJAPlFUOnqVVDjoa2LvwV+5vkuZeKzxubBgKbyYLj9JPXiLr5ulX/H9o7AiNPxb/0jaggk5jLMcqlviGMQPKFl6Sc9C3n4wbY63DMMONKwqgBG89Mzu1EeYD/hHNE65eIWWNtw476zhxPjC2yDXNa4ikAN/D+D9GZUMFxwPdNjisqGkc8at3faEoAUhxt86spWIMiHjnvHJtAjci8cUQsSNF72n7PEr6b4IWccC4xBQEcEOYnFt6P24+iy3LpbPtyV2RQtK07V9m3KuoVSuzv2khfRlXjt6bNrlRdnrk3Zc5zXNZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txoonUC9Vp1Go+JPrnZwGzCDN9quSgVrDqbuJ28DZX8=;
 b=SE6X2/2mqb7zOAmBRNnzE+fOa1H187xp1jXtz11CZ5j48BBc0H9ZIseQxiLt3c7eeacmE6ZzzTTEqXzSoF2/KMlkOn7MxoqHLxDgu2vPnL6TjZELDdul/7sF52hMERQ3etPBsLrTHDN0N0ismEjLQx2wgLlj1gtpufYKKgBjdpx947AkqZXs2qaQfUueGXZjVveH9HcBeEEdNsTNC/bprrPzLCrCVOQU7RAYVA2XT2wQgepAxIujzOglqpx56uyknDepVjuZfWLO6fclq9rs+EYwZMqF3Kj3yGUqWtaB/pmdmxN5Tk7l+KLN01GzNjswhFXogXpNyspa0tcOVFF4Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4513.namprd12.prod.outlook.com (2603:10b6:5:2ad::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27; Tue, 16 Feb
 2021 19:03:23 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4%7]) with mapi id 15.20.3846.041; Tue, 16 Feb 2021
 19:03:23 +0000
Date:   Tue, 16 Feb 2021 15:03:21 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     <kbuild@lists.01.org>, Yuval Basson <ybason@marvell.com>,
        <lkp@intel.com>, <kbuild-all@lists.01.org>,
        <linux-kernel@vger.kernel.org>,
        Michal Kalderon <mkalderon@marvell.com>
Subject: Re: drivers/infiniband/hw/qedr/verbs.c:1925 qedr_create_user_qp()
 error: we previously assumed 'ctx' could be null (see line 1900)
Message-ID: <20210216190321.GG4247@nvidia.com>
References: <20210215133125.GP2087@kadam>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210215133125.GP2087@kadam>
X-ClientProxiedBy: BL1PR13CA0177.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::32) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0177.namprd13.prod.outlook.com (2603:10b6:208:2bd::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.11 via Frontend Transport; Tue, 16 Feb 2021 19:03:22 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lC5d3-009In8-HA; Tue, 16 Feb 2021 15:03:21 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1613502214; bh=txoonUC9Vp1Go+JPrnZwGzCDN9quSgVrDqbuJ28DZX8=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=fP894WnMDMWdOznnq6zi6MmjI0MTbU9t24qlXRncMxvDvyiLQzzpRzDMIqPkIA6Qr
         PTP3oOK3fbp8vW3F0kU5if4pWHwP/gPWeYBy5EpafwBd67CPwMDgxcksMfBw0qINYJ
         tdd+DArgvY1Os21XlRYbtXvFXlyBb8fspNxmqMJ6JCl821cxjlZcKPjGW2w5MPTM1U
         vc42dw+ih5npCXjBtEDEnQVmjdWutAJkAuyTl+dxsbcpyFthiYSMU204SApcjiOO0k
         n7UIRoF6Ll2yRQubzuBtgzdXy5DJqhRFiiZWGsnmSwl38kazw837MEteau37WD7n8R
         oKFy3qkZ40LdQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 15, 2021 at 04:31:25PM +0300, Dan Carpenter wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   dcc0b49040c70ad827a7f3d58a21b01fdb14e749
> commit: 06e8d1df46ed52eca6915a2a76341ca65cc428b9 RDMA/qedr: Add support for user mode XRC-SRQ's
> config: x86_64-randconfig-m001-20210213 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> smatch warnings:
> drivers/infiniband/hw/qedr/verbs.c:1925 qedr_create_user_qp() error: we previously assumed 'ctx' could be null (see line 1900)
> 
> vim +/ctx +1925 drivers/infiniband/hw/qedr/verbs.c
> 
> df15856132bc83 Amrani, Ram       2016-12-22  1830  static int qedr_create_user_qp(struct qedr_dev *dev,
> cecbcddf6461a1 Ram Amrani        2016-10-10  1831  			       struct qedr_qp *qp,
> df15856132bc83 Amrani, Ram       2016-12-22  1832  			       struct ib_pd *ibpd,
> df15856132bc83 Amrani, Ram       2016-12-22  1833  			       struct ib_udata *udata,
> df15856132bc83 Amrani, Ram       2016-12-22  1834  			       struct ib_qp_init_attr *attrs)
> cecbcddf6461a1 Ram Amrani        2016-10-10  1835  {
> df15856132bc83 Amrani, Ram       2016-12-22  1836  	struct qed_rdma_create_qp_in_params in_params;
> df15856132bc83 Amrani, Ram       2016-12-22  1837  	struct qed_rdma_create_qp_out_params out_params;
> 06e8d1df46ed52 Yuval Basson      2020-07-22  1838  	struct qedr_create_qp_uresp uresp = {};
> 06e8d1df46ed52 Yuval Basson      2020-07-22  1839  	struct qedr_create_qp_ureq ureq = {};
> 69ad0e7fe8452a Kalderon, Michal  2017-07-26  1840  	int alloc_and_init = rdma_protocol_roce(&dev->ibdev, 1);
> 06e8d1df46ed52 Yuval Basson      2020-07-22  1841  	struct qedr_ucontext *ctx = NULL;
> 06e8d1df46ed52 Yuval Basson      2020-07-22  1842  	struct qedr_pd *pd = NULL;
> 06e8d1df46ed52 Yuval Basson      2020-07-22  1843  	int rc = 0;
> cecbcddf6461a1 Ram Amrani        2016-10-10  1844  
> 82af6d19d8d922 Michal Kalderon   2019-10-27  1845  	qp->create_type = QEDR_QP_CREATE_USER;
> 06e8d1df46ed52 Yuval Basson      2020-07-22  1846  
> 06e8d1df46ed52 Yuval Basson      2020-07-22  1847  	if (ibpd) {
> 06e8d1df46ed52 Yuval Basson      2020-07-22  1848  		pd = get_qedr_pd(ibpd);
> 06e8d1df46ed52 Yuval Basson      2020-07-22  1849  		ctx = pd->uctx;
> 06e8d1df46ed52 Yuval Basson      2020-07-22  1850  	}
> 
> "ctx" is NULL on the else path.

Looks like ibpd can never be NULL, so this is dead code

> 06e8d1df46ed52 Yuval Basson      2020-07-22  1851  
> 06e8d1df46ed52 Yuval Basson      2020-07-22  1852  	if (udata) {

udata also can never be null because this is called 'qedr_create_user_qp' ?

It is confusingly called with a xrcd test too, but xrcd's are only
currently possible if udata is set.

> 06e8d1df46ed52 Yuval Basson      2020-07-22  1853  		rc = ib_copy_from_udata(&ureq, udata, min(sizeof(ureq),
> 06e8d1df46ed52 Yuval Basson      2020-07-22  1854  					udata->inlen));
> df15856132bc83 Amrani, Ram       2016-12-22  1855  		if (rc) {
> df15856132bc83 Amrani, Ram       2016-12-22  1856  			DP_ERR(dev, "Problem copying data from user space\n");
> df15856132bc83 Amrani, Ram       2016-12-22  1857  			return rc;
> df15856132bc83 Amrani, Ram       2016-12-22  1858  		}
> 06e8d1df46ed52 Yuval Basson      2020-07-22  1859  	}
> cecbcddf6461a1 Ram Amrani        2016-10-10  1860  
> 06e8d1df46ed52 Yuval Basson      2020-07-22  1861  	if (qedr_qp_has_sq(qp)) {
> 72b894b09a96b7 Christoph Hellwig 2019-11-13  1862  		/* SQ - read access only (0) */
> b0ea0fa5435f9d Jason Gunthorpe   2019-01-09  1863  		rc = qedr_init_user_queue(udata, dev, &qp->usq, ureq.sq_addr,
> 72b894b09a96b7 Christoph Hellwig 2019-11-13  1864  					  ureq.sq_len, true, 0, alloc_and_init);
> df15856132bc83 Amrani, Ram       2016-12-22  1865  		if (rc)
> df15856132bc83 Amrani, Ram       2016-12-22  1866  			return rc;
> 06e8d1df46ed52 Yuval Basson      2020-07-22  1867  	}
> cecbcddf6461a1 Ram Amrani        2016-10-10  1868  
> 06e8d1df46ed52 Yuval Basson      2020-07-22  1869  	if (qedr_qp_has_rq(qp)) {
> 72b894b09a96b7 Christoph Hellwig 2019-11-13  1870  		/* RQ - read access only (0) */
> b0ea0fa5435f9d Jason Gunthorpe   2019-01-09  1871  		rc = qedr_init_user_queue(udata, dev, &qp->urq, ureq.rq_addr,
> 72b894b09a96b7 Christoph Hellwig 2019-11-13  1872  					  ureq.rq_len, true, 0, alloc_and_init);
> df15856132bc83 Amrani, Ram       2016-12-22  1873  		if (rc)
> df15856132bc83 Amrani, Ram       2016-12-22  1874  			return rc;
> 40b173ddce0fc6 Yuval Bason       2018-08-09  1875  	}
> df15856132bc83 Amrani, Ram       2016-12-22  1876  
> df15856132bc83 Amrani, Ram       2016-12-22  1877  	memset(&in_params, 0, sizeof(in_params));
> df15856132bc83 Amrani, Ram       2016-12-22  1878  	qedr_init_common_qp_in_params(dev, pd, qp, attrs, false, &in_params);
> df15856132bc83 Amrani, Ram       2016-12-22  1879  	in_params.qp_handle_lo = ureq.qp_handle_lo;
> df15856132bc83 Amrani, Ram       2016-12-22  1880  	in_params.qp_handle_hi = ureq.qp_handle_hi;
> 06e8d1df46ed52 Yuval Basson      2020-07-22  1881  
> 06e8d1df46ed52 Yuval Basson      2020-07-22  1882  	if (qp->qp_type == IB_QPT_XRC_TGT) {
> 06e8d1df46ed52 Yuval Basson      2020-07-22  1883  		struct qedr_xrcd *xrcd = get_qedr_xrcd(attrs->xrcd);
> 06e8d1df46ed52 Yuval Basson      2020-07-22  1884  
> 06e8d1df46ed52 Yuval Basson      2020-07-22  1885  		in_params.xrcd_id = xrcd->xrcd_id;
> 06e8d1df46ed52 Yuval Basson      2020-07-22  1886  		in_params.qp_handle_lo = qp->qp_id;
> 06e8d1df46ed52 Yuval Basson      2020-07-22  1887  		in_params.use_srq = 1;
> 06e8d1df46ed52 Yuval Basson      2020-07-22  1888  	}
> 06e8d1df46ed52 Yuval Basson      2020-07-22  1889  
> 06e8d1df46ed52 Yuval Basson      2020-07-22  1890  	if (qedr_qp_has_sq(qp)) {
> df15856132bc83 Amrani, Ram       2016-12-22  1891  		in_params.sq_num_pages = qp->usq.pbl_info.num_pbes;
> df15856132bc83 Amrani, Ram       2016-12-22  1892  		in_params.sq_pbl_ptr = qp->usq.pbl_tbl->pa;
> 06e8d1df46ed52 Yuval Basson      2020-07-22  1893  	}
> 06e8d1df46ed52 Yuval Basson      2020-07-22  1894  
> 06e8d1df46ed52 Yuval Basson      2020-07-22  1895  	if (qedr_qp_has_rq(qp)) {
> df15856132bc83 Amrani, Ram       2016-12-22  1896  		in_params.rq_num_pages = qp->urq.pbl_info.num_pbes;
> df15856132bc83 Amrani, Ram       2016-12-22  1897  		in_params.rq_pbl_ptr = qp->urq.pbl_tbl->pa;
> 40b173ddce0fc6 Yuval Bason       2018-08-09  1898  	}
> df15856132bc83 Amrani, Ram       2016-12-22  1899  
> bbe4f4245271bd Michal Kalderon   2020-07-07 @1900  	if (ctx)
>                                                             ^^^
> Check for NULL
> 
> bbe4f4245271bd Michal Kalderon   2020-07-07  1901  		SET_FIELD(in_params.flags, QED_ROCE_EDPM_MODE, ctx->edpm_mode);
> bbe4f4245271bd Michal Kalderon   2020-07-07  1902  
> df15856132bc83 Amrani, Ram       2016-12-22  1903  	qp->qed_qp = dev->ops->rdma_create_qp(dev->rdma_ctx,
> df15856132bc83 Amrani, Ram       2016-12-22  1904  					      &in_params, &out_params);
> df15856132bc83 Amrani, Ram       2016-12-22  1905  
> df15856132bc83 Amrani, Ram       2016-12-22  1906  	if (!qp->qed_qp) {
> df15856132bc83 Amrani, Ram       2016-12-22  1907  		rc = -ENOMEM;
> df15856132bc83 Amrani, Ram       2016-12-22  1908  		goto err1;
> df15856132bc83 Amrani, Ram       2016-12-22  1909  	}
> df15856132bc83 Amrani, Ram       2016-12-22  1910  
> 69ad0e7fe8452a Kalderon, Michal  2017-07-26  1911  	if (rdma_protocol_iwarp(&dev->ibdev, 1))
> 69ad0e7fe8452a Kalderon, Michal  2017-07-26  1912  		qedr_iwarp_populate_user_qp(dev, qp, &out_params);
> 69ad0e7fe8452a Kalderon, Michal  2017-07-26  1913  
> df15856132bc83 Amrani, Ram       2016-12-22  1914  	qp->qp_id = out_params.qp_id;
> df15856132bc83 Amrani, Ram       2016-12-22  1915  	qp->icid = out_params.icid;
> df15856132bc83 Amrani, Ram       2016-12-22  1916  
> 06e8d1df46ed52 Yuval Basson      2020-07-22  1917  	if (udata) {
> 97f612509294aa Michal Kalderon   2019-10-30  1918  		rc = qedr_copy_qp_uresp(dev, qp, udata, &uresp);
> 97f612509294aa Michal Kalderon   2019-10-30  1919  		if (rc)
> 97f612509294aa Michal Kalderon   2019-10-30  1920  			goto err;
> 06e8d1df46ed52 Yuval Basson      2020-07-22  1921  	}
> 97f612509294aa Michal Kalderon   2019-10-30  1922  
> 97f612509294aa Michal Kalderon   2019-10-30  1923  	/* db offset was calculated in copy_qp_uresp, now set in the user q */
> 06e8d1df46ed52 Yuval Basson      2020-07-22  1924  	if (qedr_qp_has_sq(qp)) {
> 97f612509294aa Michal Kalderon   2019-10-30 @1925  		qp->usq.db_addr = ctx->dpi_addr + uresp.sq_db_offset;
>                                                                                   ^^^^^^^^^^^^^
> Can "ctx" be NULL here?

This would also not work right if udata == NULL

Whole function needs cleaning, but doesn't look buggy

Jason
