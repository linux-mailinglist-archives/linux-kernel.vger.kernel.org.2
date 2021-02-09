Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A771314A79
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 09:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbhBIIjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 03:39:17 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:42900 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbhBIIiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 03:38:50 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1198OchN038878;
        Tue, 9 Feb 2021 08:37:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=Iia/rPnJtxX+nvs9DdoWXvoKu4SjEaYAM5JOD+N9oNc=;
 b=rjNCCoTHhm9xtluN4k0IOeDEJhj4qPd2boPWpMEoL8VclpkSn29GjZNvCLdi/zsES+y1
 WvUbU8avx4aOevlWtpCrEOykJJLRj0I9zYbkgcRAoZHdBHdYWr1hldOT8rTnPhneiCxI
 7zSUw/uVZPjfLgBGZ76PjgfiPY/O+uPK9f4zRxbebbGO3O5gLfkD+hvLPoUFSNDfg2qV
 7WSQe+fiqcb3N3S6EbJE5ejI+yUdPbvhWCzGNprtKOcmP5ubftWKF8apKrvsSVwIOn18
 AbJs/H3F7WqwmuZgQg292UFwm1Kbdv0Y0OmEAM6707YzTAuUyCICposanE8n7tbrwuEw tg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 36hjhqpp3a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Feb 2021 08:37:54 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1198Qaua001258;
        Tue, 9 Feb 2021 08:37:54 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 36j4vr10ym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Feb 2021 08:37:54 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 1198bqu0024425;
        Tue, 9 Feb 2021 08:37:53 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 09 Feb 2021 00:37:46 -0800
Date:   Tue, 9 Feb 2021 11:37:25 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Drew Davenport <ddavenport@chromium.org>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Rob Clark <robdclark@chromium.org>
Subject: drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c:106 dpu_rm_init() warn:
 passing zero to 'PTR_ERR'
Message-ID: <20210209083725.GK2696@kadam>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="pyvFHSWbQ2l30fCA"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9889 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102090040
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9889 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1011 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102090040
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pyvFHSWbQ2l30fCA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   61556703b610a104de324e4f061dc6cf7b218b46
commit: bb00a452d6f77391441ef7df48f7115dd459cd2f drm/msm/dpu: Refactor resource manager
config: arm64-randconfig-m031-20210209 (attached as .config)
compiler: aarch64-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c:106 dpu_rm_init() warn: passing zero to 'PTR_ERR'

Old smatch warnings:
drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c:135 dpu_rm_init() warn: passing zero to 'PTR_ERR'
drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c:157 dpu_rm_init() warn: passing zero to 'PTR_ERR'
drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c:174 dpu_rm_init() warn: passing zero to 'PTR_ERR'

vim +/PTR_ERR +106 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c

25fdd5933e4c0f Jeykumar Sankaran 2018-06-27   74  int dpu_rm_init(struct dpu_rm *rm,
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27   75  		struct dpu_mdss_cfg *cat,
3763f1a5511005 Jeykumar Sankaran 2018-12-07   76  		void __iomem *mmio)
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27   77  {
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27   78  	int rc, i;
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27   79  
3763f1a5511005 Jeykumar Sankaran 2018-12-07   80  	if (!rm || !cat || !mmio) {
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27   81  		DPU_ERROR("invalid kms\n");
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27   82  		return -EINVAL;
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27   83  	}
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27   84  
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27   85  	/* Clear, setup lists */
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27   86  	memset(rm, 0, sizeof(*rm));
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27   87  
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27   88  	mutex_init(&rm->rm_lock);
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27   89  
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27   90  	/* Interrogate HW catalog and create tracking items for hw blocks */
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27   91  	for (i = 0; i < cat->mixer_count; i++) {
bb00a452d6f773 Drew Davenport    2020-02-19   92  		struct dpu_hw_mixer *hw;
abda0d925f9c06 Stephen Boyd      2019-11-19   93  		const struct dpu_lm_cfg *lm = &cat->mixer[i];
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27   94  
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27   95  		if (lm->pingpong == PINGPONG_MAX) {
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27   96  			DPU_DEBUG("skip mixer %d without pingpong\n", lm->id);
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27   97  			continue;
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27   98  		}
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27   99  
bb00a452d6f773 Drew Davenport    2020-02-19  100  		if (lm->id < LM_0 || lm->id >= LM_MAX) {
bb00a452d6f773 Drew Davenport    2020-02-19  101  			DPU_ERROR("skip mixer %d with invalid id\n", lm->id);
bb00a452d6f773 Drew Davenport    2020-02-19  102  			continue;
bb00a452d6f773 Drew Davenport    2020-02-19  103  		}
bb00a452d6f773 Drew Davenport    2020-02-19  104  		hw = dpu_hw_lm_init(lm->id, mmio, cat);
bb00a452d6f773 Drew Davenport    2020-02-19  105  		if (IS_ERR_OR_NULL(hw)) {
bb00a452d6f773 Drew Davenport    2020-02-19 @106  			rc = PTR_ERR(hw);
bb00a452d6f773 Drew Davenport    2020-02-19  107  			DPU_ERROR("failed lm object creation: err %d\n", rc);

The IS_ERR_OR_NULL() function is not a Ultra Strong version of IS_ERR().

When a function returns both error pointers and NULL then the NULL
pointer means the feature is optional and has been deliberately disabled.
It should not generate a warning.  The driver should continue operating
without the optional feature (blinking lights or whatever).

PTR_ERR(NULL) is success/zero.  Of course, the error handling checks for
success and changes that to -EFAULT.  But it's hard to imagine that
-EFAULT is the correct error code either.

25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  108  			goto fail;
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  109  		}
bb00a452d6f773 Drew Davenport    2020-02-19  110  		rm->mixer_blks[lm->id - LM_0] = &hw->base;
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  111  
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  112  		if (!rm->lm_max_width) {
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  113  			rm->lm_max_width = lm->sblk->maxwidth;
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  114  		} else if (rm->lm_max_width != lm->sblk->maxwidth) {
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  115  			/*
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  116  			 * Don't expect to have hw where lm max widths differ.
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  117  			 * If found, take the min.
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  118  			 */
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  119  			DPU_ERROR("unsupported: lm maxwidth differs\n");
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  120  			if (rm->lm_max_width > lm->sblk->maxwidth)
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  121  				rm->lm_max_width = lm->sblk->maxwidth;
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  122  		}
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  123  	}
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  124  
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  125  	for (i = 0; i < cat->pingpong_count; i++) {
bb00a452d6f773 Drew Davenport    2020-02-19  126  		struct dpu_hw_pingpong *hw;
bb00a452d6f773 Drew Davenport    2020-02-19  127  		const struct dpu_pingpong_cfg *pp = &cat->pingpong[i];
bb00a452d6f773 Drew Davenport    2020-02-19  128  
bb00a452d6f773 Drew Davenport    2020-02-19  129  		if (pp->id < PINGPONG_0 || pp->id >= PINGPONG_MAX) {
bb00a452d6f773 Drew Davenport    2020-02-19  130  			DPU_ERROR("skip pingpong %d with invalid id\n", pp->id);
bb00a452d6f773 Drew Davenport    2020-02-19  131  			continue;
bb00a452d6f773 Drew Davenport    2020-02-19  132  		}
bb00a452d6f773 Drew Davenport    2020-02-19  133  		hw = dpu_hw_pingpong_init(pp->id, mmio, cat);
bb00a452d6f773 Drew Davenport    2020-02-19  134  		if (IS_ERR_OR_NULL(hw)) {
bb00a452d6f773 Drew Davenport    2020-02-19  135  			rc = PTR_ERR(hw);
bb00a452d6f773 Drew Davenport    2020-02-19  136  			DPU_ERROR("failed pingpong object creation: err %d\n",
bb00a452d6f773 Drew Davenport    2020-02-19  137  				rc);
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  138  			goto fail;
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  139  		}
bb00a452d6f773 Drew Davenport    2020-02-19  140  		rm->pingpong_blks[pp->id - PINGPONG_0] = &hw->base;
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  141  	}
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  142  
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  143  	for (i = 0; i < cat->intf_count; i++) {
bb00a452d6f773 Drew Davenport    2020-02-19  144  		struct dpu_hw_intf *hw;
bb00a452d6f773 Drew Davenport    2020-02-19  145  		const struct dpu_intf_cfg *intf = &cat->intf[i];
bb00a452d6f773 Drew Davenport    2020-02-19  146  
bb00a452d6f773 Drew Davenport    2020-02-19  147  		if (intf->type == INTF_NONE) {
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  148  			DPU_DEBUG("skip intf %d with type none\n", i);
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  149  			continue;
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  150  		}
bb00a452d6f773 Drew Davenport    2020-02-19  151  		if (intf->id < INTF_0 || intf->id >= INTF_MAX) {
bb00a452d6f773 Drew Davenport    2020-02-19  152  			DPU_ERROR("skip intf %d with invalid id\n", intf->id);
bb00a452d6f773 Drew Davenport    2020-02-19  153  			continue;
bb00a452d6f773 Drew Davenport    2020-02-19  154  		}
bb00a452d6f773 Drew Davenport    2020-02-19  155  		hw = dpu_hw_intf_init(intf->id, mmio, cat);
bb00a452d6f773 Drew Davenport    2020-02-19  156  		if (IS_ERR_OR_NULL(hw)) {
bb00a452d6f773 Drew Davenport    2020-02-19  157  			rc = PTR_ERR(hw);
bb00a452d6f773 Drew Davenport    2020-02-19  158  			DPU_ERROR("failed intf object creation: err %d\n", rc);
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  159  			goto fail;
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  160  		}
bb00a452d6f773 Drew Davenport    2020-02-19  161  		rm->intf_blks[intf->id - INTF_0] = &hw->base;
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  162  	}
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  163  
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  164  	for (i = 0; i < cat->ctl_count; i++) {
bb00a452d6f773 Drew Davenport    2020-02-19  165  		struct dpu_hw_ctl *hw;
bb00a452d6f773 Drew Davenport    2020-02-19  166  		const struct dpu_ctl_cfg *ctl = &cat->ctl[i];
bb00a452d6f773 Drew Davenport    2020-02-19  167  
bb00a452d6f773 Drew Davenport    2020-02-19  168  		if (ctl->id < CTL_0 || ctl->id >= CTL_MAX) {
bb00a452d6f773 Drew Davenport    2020-02-19  169  			DPU_ERROR("skip ctl %d with invalid id\n", ctl->id);
bb00a452d6f773 Drew Davenport    2020-02-19  170  			continue;
bb00a452d6f773 Drew Davenport    2020-02-19  171  		}
bb00a452d6f773 Drew Davenport    2020-02-19  172  		hw = dpu_hw_ctl_init(ctl->id, mmio, cat);
bb00a452d6f773 Drew Davenport    2020-02-19  173  		if (IS_ERR_OR_NULL(hw)) {
bb00a452d6f773 Drew Davenport    2020-02-19  174  			rc = PTR_ERR(hw);
bb00a452d6f773 Drew Davenport    2020-02-19  175  			DPU_ERROR("failed ctl object creation: err %d\n", rc);
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  176  			goto fail;
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  177  		}
bb00a452d6f773 Drew Davenport    2020-02-19  178  		rm->ctl_blks[ctl->id - CTL_0] = &hw->base;
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  179  	}
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  180  
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  181  	return 0;
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  182  
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  183  fail:
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  184  	dpu_rm_destroy(rm);
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  185  
bb00a452d6f773 Drew Davenport    2020-02-19  186  	return rc ? rc : -EFAULT;
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  187  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--pyvFHSWbQ2l30fCA
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
3D8DbMdZnqF73rXyjfX/AATuS8bk3QEA

--pyvFHSWbQ2l30fCA--
