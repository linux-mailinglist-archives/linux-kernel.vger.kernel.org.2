Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2D33817AB
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 12:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbhEOKga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 06:36:30 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37596 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbhEOKgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 06:36:22 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14FAYxFu026275;
        Sat, 15 May 2021 10:34:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=kkF9TFP6ZnJOmcuxKTNrkdEuRxpeXD1NxVzMOOfg1eo=;
 b=XlAOIP9Ctej9GSjhDrb9c6KzM7c+KBwWvqxSF+rIzR/G6sZytkD5aJRBkPfjsrYVGGyu
 8Ha8vOL09kCNQfUqunWLVCVh+j+luUFoNxRah//XyTNMLqiWMynC8SnadrSsHLrRG7vJ
 RvbuKG21sgsT2fIlr7G5Hr+OueyKxQy3mMS/mXvJX2must/cpO+4+geykuOUtIHiAEMW
 HcQTOzZYbHJIrHfFLW0WtCR8cWFm+N+8rcj4voVc/Fbvhcv2Tu4o6t0sHXqWyG78TfBQ
 nwjHElsW5Q8PuvPWFejWY3YdVOcrC8vUV2AKk3Y/RQ/u5BY6hzNP/eStnKrfYqCa4aA2 Yg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 38j68m8b0v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 15 May 2021 10:34:58 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14FAUFOH044028;
        Sat, 15 May 2021 10:34:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 38j5mj9y2r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 15 May 2021 10:34:58 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14FAYvpp051179;
        Sat, 15 May 2021 10:34:57 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 38j5mj9y26-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 15 May 2021 10:34:57 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 14FAYtS6010923;
        Sat, 15 May 2021 10:34:56 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 15 May 2021 10:34:55 +0000
Date:   Sat, 15 May 2021 13:34:47 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Maxime Ripard <maxime@cerno.tech>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: drivers/gpu/drm/armada/armada_plane.c:124
 armada_drm_plane_atomic_check() warn: variable dereferenced before check
 'state' (see line 111)
Message-ID: <202105150754.JlFEHPkM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: 8-5LwkZmJIGYBZz-I2Yr-isExjOTsTwu
X-Proofpoint-GUID: 8-5LwkZmJIGYBZz-I2Yr-isExjOTsTwu
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9984 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 suspectscore=0 clxscore=1015
 adultscore=0 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105150075
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   25a1298726e97b9d25379986f5d54d9e62ad6e93
commit: dec92020671c48da231189eb06a5f755f492f87f drm: Use the state pointer directly in planes atomic_check
config: arm-randconfig-m031-20210514 (attached as .config)
compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/gpu/drm/armada/armada_plane.c:124 armada_drm_plane_atomic_check() warn: variable dereferenced before check 'state' (see line 111)

vim +/state +124 drivers/gpu/drm/armada/armada_plane.c

d40af7b1ae23da Russell King  2018-07-30  108  int armada_drm_plane_atomic_check(struct drm_plane *plane,
7c11b99a8e58c0 Maxime Ripard 2021-02-19  109  	struct drm_atomic_state *state)
d40af7b1ae23da Russell King  2018-07-30  110  {
7c11b99a8e58c0 Maxime Ripard 2021-02-19 @111  	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
                                                                                                                         ^^^^^
Dereferenced inside the function.

7c11b99a8e58c0 Maxime Ripard 2021-02-19  112  										 plane);
ba5c1649465d40 Maxime Ripard 2021-02-19  113  	struct armada_plane_state *st = to_armada_plane_state(new_plane_state);
ba5c1649465d40 Maxime Ripard 2021-02-19  114  	struct drm_crtc *crtc = new_plane_state->crtc;
d40af7b1ae23da Russell King  2018-07-30  115  	struct drm_crtc_state *crtc_state;
1d1547ec12bc7d Russell King  2019-01-25  116  	bool interlace;
1d1547ec12bc7d Russell King  2019-01-25  117  	int ret;
1d1547ec12bc7d Russell King  2019-01-25  118  
ba5c1649465d40 Maxime Ripard 2021-02-19  119  	if (!new_plane_state->fb || WARN_ON(!new_plane_state->crtc)) {
ba5c1649465d40 Maxime Ripard 2021-02-19  120  		new_plane_state->visible = false;
1d1547ec12bc7d Russell King  2019-01-25  121  		return 0;
1d1547ec12bc7d Russell King  2019-01-25  122  	}
d40af7b1ae23da Russell King  2018-07-30  123  
dec92020671c48 Maxime Ripard 2021-02-19 @124  	if (state)
                                                    ^^^^^
Checked too late.

dec92020671c48 Maxime Ripard 2021-02-19  125  		crtc_state = drm_atomic_get_existing_crtc_state(state,
ba5c1649465d40 Maxime Ripard 2021-02-19  126  								crtc);
d40af7b1ae23da Russell King  2018-07-30  127  	else
d40af7b1ae23da Russell King  2018-07-30  128  		crtc_state = crtc->state;
1d1547ec12bc7d Russell King  2019-01-25  129  
ba5c1649465d40 Maxime Ripard 2021-02-19  130  	ret = drm_atomic_helper_check_plane_state(new_plane_state, crtc_state,
ba5c1649465d40 Maxime Ripard 2021-02-19  131  						  0,

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

