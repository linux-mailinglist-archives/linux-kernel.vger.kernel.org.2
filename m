Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 861FD31BA70
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 14:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbhBONfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 08:35:15 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:43468 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbhBONdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 08:33:17 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11FDUHMZ098673;
        Mon, 15 Feb 2021 13:32:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=nwBFTee9trhbqw5xnXcQl+hBcicE81ZcgqQFVTl0iB4=;
 b=xbSuXXzeK6tuZfZEYxm1kYJbhfXQ2F1Drmnie2UXJ6XIQ3lODdTfunn7x5Z82FkvBbwQ
 kdXzIYTYar3bUTxECK7W2G/ZvRPP/GiH5ZuP8mF+NULu3OhKW9X/M42jNa28K+9VyOGW
 X8xB2llz201CLs8nfmMRZW5lkdSTgFJrF+VnzMF2asmpFcQRb3CDbqdPfzUufXIDq6PD
 KB7yPAiVCwFq5gC9ZxhBnukeBNpylhr5X0RSQUppqoOgTZsND46xDg9H5uamz0Bv5v9Q
 uZ337HBMTjvMtcAsjlmxV7cWkfcrTVP7mpPjqJ2B8GVwrEoe006hc/Hy4xk6OXWBkZRz Ag== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 36p7dnc069-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Feb 2021 13:32:17 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11FDU4II189866;
        Mon, 15 Feb 2021 13:32:16 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 36prnwsn6q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Feb 2021 13:32:16 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 11FDWEYh024064;
        Mon, 15 Feb 2021 13:32:15 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 15 Feb 2021 05:31:33 -0800
Date:   Mon, 15 Feb 2021 16:31:25 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Yuval Basson <ybason@marvell.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>,
        Michal Kalderon <mkalderon@marvell.com>
Subject: drivers/infiniband/hw/qedr/verbs.c:1925 qedr_create_user_qp() error:
 we previously assumed 'ctx' could be null (see line 1900)
Message-ID: <20210215133125.GP2087@kadam>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="4oQnj4jcM03NhqPN"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9895 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102150109
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9895 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 spamscore=0 adultscore=0 clxscore=1011 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102150109
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4oQnj4jcM03NhqPN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dcc0b49040c70ad827a7f3d58a21b01fdb14e749
commit: 06e8d1df46ed52eca6915a2a76341ca65cc428b9 RDMA/qedr: Add support for user mode XRC-SRQ's
config: x86_64-randconfig-m001-20210213 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-15) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/infiniband/hw/qedr/verbs.c:1925 qedr_create_user_qp() error: we previously assumed 'ctx' could be null (see line 1900)

vim +/ctx +1925 drivers/infiniband/hw/qedr/verbs.c

df15856132bc83 Amrani, Ram       2016-12-22  1830  static int qedr_create_user_qp(struct qedr_dev *dev,
cecbcddf6461a1 Ram Amrani        2016-10-10  1831  			       struct qedr_qp *qp,
df15856132bc83 Amrani, Ram       2016-12-22  1832  			       struct ib_pd *ibpd,
df15856132bc83 Amrani, Ram       2016-12-22  1833  			       struct ib_udata *udata,
df15856132bc83 Amrani, Ram       2016-12-22  1834  			       struct ib_qp_init_attr *attrs)
cecbcddf6461a1 Ram Amrani        2016-10-10  1835  {
df15856132bc83 Amrani, Ram       2016-12-22  1836  	struct qed_rdma_create_qp_in_params in_params;
df15856132bc83 Amrani, Ram       2016-12-22  1837  	struct qed_rdma_create_qp_out_params out_params;
06e8d1df46ed52 Yuval Basson      2020-07-22  1838  	struct qedr_create_qp_uresp uresp = {};
06e8d1df46ed52 Yuval Basson      2020-07-22  1839  	struct qedr_create_qp_ureq ureq = {};
69ad0e7fe8452a Kalderon, Michal  2017-07-26  1840  	int alloc_and_init = rdma_protocol_roce(&dev->ibdev, 1);
06e8d1df46ed52 Yuval Basson      2020-07-22  1841  	struct qedr_ucontext *ctx = NULL;
06e8d1df46ed52 Yuval Basson      2020-07-22  1842  	struct qedr_pd *pd = NULL;
06e8d1df46ed52 Yuval Basson      2020-07-22  1843  	int rc = 0;
cecbcddf6461a1 Ram Amrani        2016-10-10  1844  
82af6d19d8d922 Michal Kalderon   2019-10-27  1845  	qp->create_type = QEDR_QP_CREATE_USER;
06e8d1df46ed52 Yuval Basson      2020-07-22  1846  
06e8d1df46ed52 Yuval Basson      2020-07-22  1847  	if (ibpd) {
06e8d1df46ed52 Yuval Basson      2020-07-22  1848  		pd = get_qedr_pd(ibpd);
06e8d1df46ed52 Yuval Basson      2020-07-22  1849  		ctx = pd->uctx;
06e8d1df46ed52 Yuval Basson      2020-07-22  1850  	}

"ctx" is NULL on the else path.

06e8d1df46ed52 Yuval Basson      2020-07-22  1851  
06e8d1df46ed52 Yuval Basson      2020-07-22  1852  	if (udata) {
06e8d1df46ed52 Yuval Basson      2020-07-22  1853  		rc = ib_copy_from_udata(&ureq, udata, min(sizeof(ureq),
06e8d1df46ed52 Yuval Basson      2020-07-22  1854  					udata->inlen));
df15856132bc83 Amrani, Ram       2016-12-22  1855  		if (rc) {
df15856132bc83 Amrani, Ram       2016-12-22  1856  			DP_ERR(dev, "Problem copying data from user space\n");
df15856132bc83 Amrani, Ram       2016-12-22  1857  			return rc;
df15856132bc83 Amrani, Ram       2016-12-22  1858  		}
06e8d1df46ed52 Yuval Basson      2020-07-22  1859  	}
cecbcddf6461a1 Ram Amrani        2016-10-10  1860  
06e8d1df46ed52 Yuval Basson      2020-07-22  1861  	if (qedr_qp_has_sq(qp)) {
72b894b09a96b7 Christoph Hellwig 2019-11-13  1862  		/* SQ - read access only (0) */
b0ea0fa5435f9d Jason Gunthorpe   2019-01-09  1863  		rc = qedr_init_user_queue(udata, dev, &qp->usq, ureq.sq_addr,
72b894b09a96b7 Christoph Hellwig 2019-11-13  1864  					  ureq.sq_len, true, 0, alloc_and_init);
df15856132bc83 Amrani, Ram       2016-12-22  1865  		if (rc)
df15856132bc83 Amrani, Ram       2016-12-22  1866  			return rc;
06e8d1df46ed52 Yuval Basson      2020-07-22  1867  	}
cecbcddf6461a1 Ram Amrani        2016-10-10  1868  
06e8d1df46ed52 Yuval Basson      2020-07-22  1869  	if (qedr_qp_has_rq(qp)) {
72b894b09a96b7 Christoph Hellwig 2019-11-13  1870  		/* RQ - read access only (0) */
b0ea0fa5435f9d Jason Gunthorpe   2019-01-09  1871  		rc = qedr_init_user_queue(udata, dev, &qp->urq, ureq.rq_addr,
72b894b09a96b7 Christoph Hellwig 2019-11-13  1872  					  ureq.rq_len, true, 0, alloc_and_init);
df15856132bc83 Amrani, Ram       2016-12-22  1873  		if (rc)
df15856132bc83 Amrani, Ram       2016-12-22  1874  			return rc;
40b173ddce0fc6 Yuval Bason       2018-08-09  1875  	}
df15856132bc83 Amrani, Ram       2016-12-22  1876  
df15856132bc83 Amrani, Ram       2016-12-22  1877  	memset(&in_params, 0, sizeof(in_params));
df15856132bc83 Amrani, Ram       2016-12-22  1878  	qedr_init_common_qp_in_params(dev, pd, qp, attrs, false, &in_params);
df15856132bc83 Amrani, Ram       2016-12-22  1879  	in_params.qp_handle_lo = ureq.qp_handle_lo;
df15856132bc83 Amrani, Ram       2016-12-22  1880  	in_params.qp_handle_hi = ureq.qp_handle_hi;
06e8d1df46ed52 Yuval Basson      2020-07-22  1881  
06e8d1df46ed52 Yuval Basson      2020-07-22  1882  	if (qp->qp_type == IB_QPT_XRC_TGT) {
06e8d1df46ed52 Yuval Basson      2020-07-22  1883  		struct qedr_xrcd *xrcd = get_qedr_xrcd(attrs->xrcd);
06e8d1df46ed52 Yuval Basson      2020-07-22  1884  
06e8d1df46ed52 Yuval Basson      2020-07-22  1885  		in_params.xrcd_id = xrcd->xrcd_id;
06e8d1df46ed52 Yuval Basson      2020-07-22  1886  		in_params.qp_handle_lo = qp->qp_id;
06e8d1df46ed52 Yuval Basson      2020-07-22  1887  		in_params.use_srq = 1;
06e8d1df46ed52 Yuval Basson      2020-07-22  1888  	}
06e8d1df46ed52 Yuval Basson      2020-07-22  1889  
06e8d1df46ed52 Yuval Basson      2020-07-22  1890  	if (qedr_qp_has_sq(qp)) {
df15856132bc83 Amrani, Ram       2016-12-22  1891  		in_params.sq_num_pages = qp->usq.pbl_info.num_pbes;
df15856132bc83 Amrani, Ram       2016-12-22  1892  		in_params.sq_pbl_ptr = qp->usq.pbl_tbl->pa;
06e8d1df46ed52 Yuval Basson      2020-07-22  1893  	}
06e8d1df46ed52 Yuval Basson      2020-07-22  1894  
06e8d1df46ed52 Yuval Basson      2020-07-22  1895  	if (qedr_qp_has_rq(qp)) {
df15856132bc83 Amrani, Ram       2016-12-22  1896  		in_params.rq_num_pages = qp->urq.pbl_info.num_pbes;
df15856132bc83 Amrani, Ram       2016-12-22  1897  		in_params.rq_pbl_ptr = qp->urq.pbl_tbl->pa;
40b173ddce0fc6 Yuval Bason       2018-08-09  1898  	}
df15856132bc83 Amrani, Ram       2016-12-22  1899  
bbe4f4245271bd Michal Kalderon   2020-07-07 @1900  	if (ctx)
                                                            ^^^
Check for NULL

bbe4f4245271bd Michal Kalderon   2020-07-07  1901  		SET_FIELD(in_params.flags, QED_ROCE_EDPM_MODE, ctx->edpm_mode);
bbe4f4245271bd Michal Kalderon   2020-07-07  1902  
df15856132bc83 Amrani, Ram       2016-12-22  1903  	qp->qed_qp = dev->ops->rdma_create_qp(dev->rdma_ctx,
df15856132bc83 Amrani, Ram       2016-12-22  1904  					      &in_params, &out_params);
df15856132bc83 Amrani, Ram       2016-12-22  1905  
df15856132bc83 Amrani, Ram       2016-12-22  1906  	if (!qp->qed_qp) {
df15856132bc83 Amrani, Ram       2016-12-22  1907  		rc = -ENOMEM;
df15856132bc83 Amrani, Ram       2016-12-22  1908  		goto err1;
df15856132bc83 Amrani, Ram       2016-12-22  1909  	}
df15856132bc83 Amrani, Ram       2016-12-22  1910  
69ad0e7fe8452a Kalderon, Michal  2017-07-26  1911  	if (rdma_protocol_iwarp(&dev->ibdev, 1))
69ad0e7fe8452a Kalderon, Michal  2017-07-26  1912  		qedr_iwarp_populate_user_qp(dev, qp, &out_params);
69ad0e7fe8452a Kalderon, Michal  2017-07-26  1913  
df15856132bc83 Amrani, Ram       2016-12-22  1914  	qp->qp_id = out_params.qp_id;
df15856132bc83 Amrani, Ram       2016-12-22  1915  	qp->icid = out_params.icid;
df15856132bc83 Amrani, Ram       2016-12-22  1916  
06e8d1df46ed52 Yuval Basson      2020-07-22  1917  	if (udata) {
97f612509294aa Michal Kalderon   2019-10-30  1918  		rc = qedr_copy_qp_uresp(dev, qp, udata, &uresp);
97f612509294aa Michal Kalderon   2019-10-30  1919  		if (rc)
97f612509294aa Michal Kalderon   2019-10-30  1920  			goto err;
06e8d1df46ed52 Yuval Basson      2020-07-22  1921  	}
97f612509294aa Michal Kalderon   2019-10-30  1922  
97f612509294aa Michal Kalderon   2019-10-30  1923  	/* db offset was calculated in copy_qp_uresp, now set in the user q */
06e8d1df46ed52 Yuval Basson      2020-07-22  1924  	if (qedr_qp_has_sq(qp)) {
97f612509294aa Michal Kalderon   2019-10-30 @1925  		qp->usq.db_addr = ctx->dpi_addr + uresp.sq_db_offset;
                                                                                  ^^^^^^^^^^^^^
Can "ctx" be NULL here?

97f612509294aa Michal Kalderon   2019-10-30  1926  		rc = qedr_db_recovery_add(dev, qp->usq.db_addr,
97f612509294aa Michal Kalderon   2019-10-30  1927  					  &qp->usq.db_rec_data->db_data,
97f612509294aa Michal Kalderon   2019-10-30  1928  					  DB_REC_WIDTH_32B,
97f612509294aa Michal Kalderon   2019-10-30  1929  					  DB_REC_USER);
97f612509294aa Michal Kalderon   2019-10-30  1930  		if (rc)
97f612509294aa Michal Kalderon   2019-10-30  1931  			goto err;
06e8d1df46ed52 Yuval Basson      2020-07-22  1932  	}
97f612509294aa Michal Kalderon   2019-10-30  1933  
06e8d1df46ed52 Yuval Basson      2020-07-22  1934  	if (qedr_qp_has_rq(qp)) {
06e8d1df46ed52 Yuval Basson      2020-07-22  1935  		qp->urq.db_addr = ctx->dpi_addr + uresp.rq_db_offset;
97f612509294aa Michal Kalderon   2019-10-30  1936  		rc = qedr_db_recovery_add(dev, qp->urq.db_addr,
97f612509294aa Michal Kalderon   2019-10-30  1937  					  &qp->urq.db_rec_data->db_data,
97f612509294aa Michal Kalderon   2019-10-30  1938  					  DB_REC_WIDTH_32B,
97f612509294aa Michal Kalderon   2019-10-30  1939  					  DB_REC_USER);
df15856132bc83 Amrani, Ram       2016-12-22  1940  		if (rc)
df15856132bc83 Amrani, Ram       2016-12-22  1941  			goto err;
06e8d1df46ed52 Yuval Basson      2020-07-22  1942  	}
df15856132bc83 Amrani, Ram       2016-12-22  1943  
b4bc76609722f1 Michal Kalderon   2019-10-30  1944  	if (rdma_protocol_iwarp(&dev->ibdev, 1)) {
b4bc76609722f1 Michal Kalderon   2019-10-30  1945  		rc = qedr_db_recovery_add(dev, qp->urq.db_rec_db2_addr,
b4bc76609722f1 Michal Kalderon   2019-10-30  1946  					  &qp->urq.db_rec_db2_data,
b4bc76609722f1 Michal Kalderon   2019-10-30  1947  					  DB_REC_WIDTH_32B,
b4bc76609722f1 Michal Kalderon   2019-10-30  1948  					  DB_REC_USER);
b4bc76609722f1 Michal Kalderon   2019-10-30  1949  		if (rc)
b4bc76609722f1 Michal Kalderon   2019-10-30  1950  			goto err;
b4bc76609722f1 Michal Kalderon   2019-10-30  1951  	}
df15856132bc83 Amrani, Ram       2016-12-22  1952  	qedr_qp_user_print(dev, qp);
97f612509294aa Michal Kalderon   2019-10-30  1953  	return rc;
df15856132bc83 Amrani, Ram       2016-12-22  1954  err:
df15856132bc83 Amrani, Ram       2016-12-22  1955  	rc = dev->ops->rdma_destroy_qp(dev->rdma_ctx, qp->qed_qp);
df15856132bc83 Amrani, Ram       2016-12-22  1956  	if (rc)
df15856132bc83 Amrani, Ram       2016-12-22  1957  		DP_ERR(dev, "create qp: fatal fault. rc=%d", rc);
df15856132bc83 Amrani, Ram       2016-12-22  1958  
df15856132bc83 Amrani, Ram       2016-12-22  1959  err1:
97f612509294aa Michal Kalderon   2019-10-30  1960  	qedr_cleanup_user(dev, ctx, qp);
df15856132bc83 Amrani, Ram       2016-12-22  1961  	return rc;
cecbcddf6461a1 Ram Amrani        2016-10-10  1962  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--4oQnj4jcM03NhqPN
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--4oQnj4jcM03NhqPN--
