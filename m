Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC52D338491
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 05:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbhCLEHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 23:07:51 -0500
Received: from mga09.intel.com ([134.134.136.24]:28073 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231278AbhCLEHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 23:07:45 -0500
IronPort-SDR: DsISgGKhjfGMjudOrl7H6H8rHjpEWhWMEwO4Qs7rc80d9npdj0TxgTmGMznmHvq0Fgu+iNNAzV
 apiRBUKpf1Ig==
X-IronPort-AV: E=McAfee;i="6000,8403,9920"; a="188875795"
X-IronPort-AV: E=Sophos;i="5.81,242,1610438400"; 
   d="scan'208";a="188875795"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2021 20:07:44 -0800
IronPort-SDR: t71QttoerQbAXxs0ytBVkS2wUw1La7IPLPox+6qW4dPB2wURAPv2P5oKD74UPCk28BsBkaOYL8
 KyP/q3RoSF0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,242,1610438400"; 
   d="scan'208";a="603787380"
Received: from lkp-server02.sh.intel.com (HELO ce64c092ff93) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 11 Mar 2021 20:07:42 -0800
Received: from kbuild by ce64c092ff93 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lKZ5R-00018x-Lt; Fri, 12 Mar 2021 04:07:41 +0000
Date:   Fri, 12 Mar 2021 12:06:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jinzhou Su <Jinzhou.Su@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Huang Rui <ray.huang@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c:141:37: warning:
 Undefined behavior: Variable 'i2c_output' is used as parameter and
 destination in
Message-ID: <202103121240.Yranw2E9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   28806e4d9b97865b450d72156e9ad229f2067f0b
commit: ecaafb7b5ab6406587341d8727f237b3ee00dedf drm/amdgpu: Add secure display TA interface
date:   8 weeks ago
compiler: alpha-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck possible warnings: (new ones prefixed by >>, may not real problems)

>> drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c:141:37: warning: Undefined behavior: Variable 'i2c_output' is used as parameter and destination in s[n]printf(). [sprintfOverlappingData]
        sprintf(i2c_output, "%s 0x%X", i2c_output,
                                       ^

vim +/i2c_output +141 drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c

    85	
    86	static ssize_t amdgpu_securedisplay_debugfs_write(struct file *f, const char __user *buf,
    87			size_t size, loff_t *pos)
    88	{
    89		struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
    90		struct psp_context *psp = &adev->psp;
    91		struct securedisplay_cmd *securedisplay_cmd;
    92		struct drm_device *dev = adev_to_drm(adev);
    93		uint32_t phy_id;
    94		uint32_t op;
    95		int i;
    96		char str[64];
    97		char i2c_output[256];
    98		int ret;
    99	
   100		if (*pos || size > sizeof(str) - 1)
   101			return -EINVAL;
   102	
   103		memset(str,  0, sizeof(str));
   104		ret = copy_from_user(str, buf, size);
   105		if (ret)
   106			return -EFAULT;
   107	
   108		ret = pm_runtime_get_sync(dev->dev);
   109		if (ret < 0) {
   110			pm_runtime_put_autosuspend(dev->dev);
   111			return ret;
   112		}
   113	
   114		if (size < 3)
   115			sscanf(str, "%u ", &op);
   116		else
   117			sscanf(str, "%u %u", &op, &phy_id);
   118	
   119		switch (op) {
   120		case 1:
   121			psp_prep_securedisplay_cmd_buf(psp, &securedisplay_cmd,
   122				TA_SECUREDISPLAY_COMMAND__QUERY_TA);
   123			ret = psp_securedisplay_invoke(psp, TA_SECUREDISPLAY_COMMAND__QUERY_TA);
   124			if (!ret) {
   125				if (securedisplay_cmd->status == TA_SECUREDISPLAY_STATUS__SUCCESS)
   126					dev_info(adev->dev, "SECUREDISPLAY: query securedisplay TA ret is 0x%X\n",
   127						securedisplay_cmd->securedisplay_out_message.query_ta.query_cmd_ret);
   128				else
   129					psp_securedisplay_parse_resp_status(psp, securedisplay_cmd->status);
   130			}
   131			break;
   132		case 2:
   133			psp_prep_securedisplay_cmd_buf(psp, &securedisplay_cmd,
   134				TA_SECUREDISPLAY_COMMAND__SEND_ROI_CRC);
   135			securedisplay_cmd->securedisplay_in_message.send_roi_crc.phy_id = phy_id;
   136			ret = psp_securedisplay_invoke(psp, TA_SECUREDISPLAY_COMMAND__SEND_ROI_CRC);
   137			if (!ret) {
   138				if (securedisplay_cmd->status == TA_SECUREDISPLAY_STATUS__SUCCESS) {
   139					memset(i2c_output,  0, sizeof(i2c_output));
   140					for (i = 0; i < TA_SECUREDISPLAY_I2C_BUFFER_SIZE; i++)
 > 141						sprintf(i2c_output, "%s 0x%X", i2c_output,
   142							securedisplay_cmd->securedisplay_out_message.send_roi_crc.i2c_buf[i]);
   143					dev_info(adev->dev, "SECUREDISPLAY: I2C buffer out put is :%s\n", i2c_output);
   144				} else {
   145					psp_securedisplay_parse_resp_status(psp, securedisplay_cmd->status);
   146				}
   147			}
   148			break;
   149		default:
   150			dev_err(adev->dev, "Invalid input: %s\n", str);
   151		}
   152	
   153		pm_runtime_mark_last_busy(dev->dev);
   154		pm_runtime_put_autosuspend(dev->dev);
   155	
   156		return size;
   157	}
   158	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
