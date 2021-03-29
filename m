Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8E334CF33
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 13:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbhC2Lht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 07:37:49 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45716 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbhC2Lhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 07:37:45 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12TBYMu0085326;
        Mon, 29 Mar 2021 11:37:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=OOb1Fya1Wf9CaCNPMc9ECGWVI3ep7Ep6tFPKBV5qXYk=;
 b=a+epRsriwQQO20nE46uhMPO6GkPeIGLqeWqzLnRk+XWs50TLmucDhTbGQh4JKi4xPX/M
 Ao9sUHnOUmWPFPWkjX+Fk4cV40ru7Hme9F/DZeSuUB1zlCwIxiWtdWLurY6+fjqndv/P
 xqS/KO4+NWVBMeC/ywn5Sp+BvOLzIb4I76zHbklcKs6W3zKCE/IpGRyd97ugMlMwjORv
 EtwRDFruRl2J3XhkrfzPQGhLH3DGUZqrE87UcRjB0qAUUTFQTUC77kbuQR/noLZFIaZD
 royMmauqUnG/TvhLjV7QlNCSuVGNjQWIOIaTNN12b9mznFQ9nZJ1AKBGobJWALxax7K4 4g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 37hwbnb6sk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Mar 2021 11:37:40 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12TBYkN9046505;
        Mon, 29 Mar 2021 11:37:39 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 37jekx1ngr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Mar 2021 11:37:39 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 12TBbaqT008839;
        Mon, 29 Mar 2021 11:37:36 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 29 Mar 2021 04:37:35 -0700
Date:   Mon, 29 Mar 2021 14:37:28 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Alex Deucher <alexander.deucher@amd.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Evan Quan <evan.quan@amd.com>
Subject: [kbuild] drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c:1370:4: warning:
 Variable 'num_of_active_display' is modified but its new value is never
 used. [unreadVariable]
Message-ID: <20210329113728.GQ1667@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-ID-Hash: MNKFTVQD4P54ZIAC2EMA5V4OLTLOSIH6
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9937 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103290091
X-Proofpoint-GUID: b0wxVL1a2WD0sNp4KHK9c_WM6iXT2FEV
X-Proofpoint-ORIG-GUID: b0wxVL1a2WD0sNp4KHK9c_WM6iXT2FEV
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9937 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 clxscore=1011
 phishscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103290091
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master
head:   a5e13c6df0e41702d2b2c77c8ad41677ebb065b3
commit: 75145aab7a0d865b361de687b201e8c4b76425eb drm/amdgpu/swsmu: clean up a bunch of stale interfaces
compiler: alpha-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

cppcheck possible warnings: (new ones prefixed by >>, may not real problems)

   In file included from drivers/gpu/drm/amd/amdgpu/../pm/swsmu/amdgpu_smu.c:
>> drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c:1370:4: warning: Variable 'num_of_active_display' is modified but its new value is never used. [unreadVariable]
      num_of_active_display++;
      ^

vim +/num_of_active_display +1370 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c

94ed6d0cfdb867 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c Huang Rui 2019-01-11  1351  int smu_display_configuration_change(struct smu_context *smu,
94ed6d0cfdb867 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c Huang Rui 2019-01-11  1352  				     const struct amd_pp_display_configuration *display_config)
94ed6d0cfdb867 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c Huang Rui 2019-01-11  1353  {
94ed6d0cfdb867 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c Huang Rui 2019-01-11  1354  	int index = 0;
94ed6d0cfdb867 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c Huang Rui 2019-01-11  1355  	int num_of_active_display = 0;
94ed6d0cfdb867 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c Huang Rui 2019-01-11  1356  
2b7ad277e96577 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c Evan Quan 2020-05-25  1357  	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
2b7ad277e96577 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c Evan Quan 2020-05-25  1358  		return -EOPNOTSUPP;
94ed6d0cfdb867 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c Huang Rui 2019-01-11  1359  
94ed6d0cfdb867 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c Huang Rui 2019-01-11  1360  	if (!display_config)
94ed6d0cfdb867 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c Huang Rui 2019-01-11  1361  		return -EINVAL;
94ed6d0cfdb867 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c Huang Rui 2019-01-11  1362  
94ed6d0cfdb867 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c Huang Rui 2019-01-11  1363  	mutex_lock(&smu->mutex);
94ed6d0cfdb867 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c Huang Rui 2019-01-11  1364  
ce63d8f8b55d28 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c Evan Quan 2020-06-08  1365  	smu_set_min_dcef_deep_sleep(smu,
94ed6d0cfdb867 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c Huang Rui 2019-01-11  1366  				    display_config->min_dcef_deep_sleep_set_clk / 100);
94ed6d0cfdb867 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c Huang Rui 2019-01-11  1367  
94ed6d0cfdb867 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c Huang Rui 2019-01-11  1368  	for (index = 0; index < display_config->num_path_including_non_display; index++) {
94ed6d0cfdb867 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c Huang Rui 2019-01-11  1369  		if (display_config->displays[index].controller_id != 0)
94ed6d0cfdb867 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c Huang Rui 2019-01-11 @1370  			num_of_active_display++;
                                                                                                        ^^^^^^^^^^^^^^^^^^^^^^^
unused

94ed6d0cfdb867 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c Huang Rui 2019-01-11  1371  	}
94ed6d0cfdb867 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c Huang Rui 2019-01-11  1372  
94ed6d0cfdb867 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c Huang Rui 2019-01-11  1373  	mutex_unlock(&smu->mutex);
94ed6d0cfdb867 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c Huang Rui 2019-01-11  1374  
94ed6d0cfdb867 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c Huang Rui 2019-01-11  1375  	return 0;
94ed6d0cfdb867 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c Huang Rui 2019-01-11  1376  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org 
_______________________________________________
kbuild mailing list -- kbuild@lists.01.org
To unsubscribe send an email to kbuild-leave@lists.01.org
