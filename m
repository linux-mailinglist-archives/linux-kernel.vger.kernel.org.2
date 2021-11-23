Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0EB545ACE9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 20:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238684AbhKWUBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 15:01:01 -0500
Received: from mga04.intel.com ([192.55.52.120]:3558 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232735AbhKWUA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 15:00:59 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10177"; a="233838326"
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="233838326"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 11:57:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="497408405"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 23 Nov 2021 11:57:49 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mpbvI-0002EM-SV; Tue, 23 Nov 2021 19:57:48 +0000
Date:   Wed, 24 Nov 2021 03:56:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: drivers/pci/controller/dwc/pcie-qcom.c:1305:30: sparse: sparse:
 incorrect type in initializer (different base types)
Message-ID: <202111240329.0m3Z5QZm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   136057256686de39cc3a07c2e39ef6bc43003ff6
commit: 4c9398822106c366d88c8c68ddf44bd371d39961 PCI: qcom: Add support for configuring BDF to SID mapping for SM8250
date:   12 months ago
config: alpha-randconfig-s032-20211117 (https://download.01.org/0day-ci/archive/20211124/202111240329.0m3Z5QZm-lkp@intel.com/config.gz)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4c9398822106c366d88c8c68ddf44bd371d39961
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 4c9398822106c366d88c8c68ddf44bd371d39961
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=alpha 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/pci/controller/dwc/pcie-qcom.c:1305:30: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned short [usertype] bdf_be @@     got restricted __be16 [usertype] @@
   drivers/pci/controller/dwc/pcie-qcom.c:1305:30: sparse:     expected unsigned short [usertype] bdf_be
   drivers/pci/controller/dwc/pcie-qcom.c:1305:30: sparse:     got restricted __be16 [usertype]

vim +1305 drivers/pci/controller/dwc/pcie-qcom.c

  1266	
  1267	static int qcom_pcie_config_sid_sm8250(struct qcom_pcie *pcie)
  1268	{
  1269		/* iommu map structure */
  1270		struct {
  1271			u32 bdf;
  1272			u32 phandle;
  1273			u32 smmu_sid;
  1274			u32 smmu_sid_len;
  1275		} *map;
  1276		void __iomem *bdf_to_sid_base = pcie->parf + PCIE20_PARF_BDF_TO_SID_TABLE_N;
  1277		struct device *dev = pcie->pci->dev;
  1278		u8 qcom_pcie_crc8_table[CRC8_TABLE_SIZE];
  1279		int i, nr_map, size = 0;
  1280		u32 smmu_sid_base;
  1281	
  1282		of_get_property(dev->of_node, "iommu-map", &size);
  1283		if (!size)
  1284			return 0;
  1285	
  1286		map = kzalloc(size, GFP_KERNEL);
  1287		if (!map)
  1288			return -ENOMEM;
  1289	
  1290		of_property_read_u32_array(dev->of_node,
  1291			"iommu-map", (u32 *)map, size / sizeof(u32));
  1292	
  1293		nr_map = size / (sizeof(*map));
  1294	
  1295		crc8_populate_msb(qcom_pcie_crc8_table, QCOM_PCIE_CRC8_POLYNOMIAL);
  1296	
  1297		/* Registers need to be zero out first */
  1298		memset_io(bdf_to_sid_base, 0, CRC8_TABLE_SIZE * sizeof(u32));
  1299	
  1300		/* Extract the SMMU SID base from the first entry of iommu-map */
  1301		smmu_sid_base = map[0].smmu_sid;
  1302	
  1303		/* Look for an available entry to hold the mapping */
  1304		for (i = 0; i < nr_map; i++) {
> 1305			u16 bdf_be = cpu_to_be16(map[i].bdf);
  1306			u32 val;
  1307			u8 hash;
  1308	
  1309			hash = crc8(qcom_pcie_crc8_table, (u8 *)&bdf_be, sizeof(bdf_be),
  1310				0);
  1311	
  1312			val = readl(bdf_to_sid_base + hash * sizeof(u32));
  1313	
  1314			/* If the register is already populated, look for next available entry */
  1315			while (val) {
  1316				u8 current_hash = hash++;
  1317				u8 next_mask = 0xff;
  1318	
  1319				/* If NEXT field is NULL then update it with next hash */
  1320				if (!(val & next_mask)) {
  1321					val |= (u32)hash;
  1322					writel(val, bdf_to_sid_base + current_hash * sizeof(u32));
  1323				}
  1324	
  1325				val = readl(bdf_to_sid_base + hash * sizeof(u32));
  1326			}
  1327	
  1328			/* BDF [31:16] | SID [15:8] | NEXT [7:0] */
  1329			val = map[i].bdf << 16 | (map[i].smmu_sid - smmu_sid_base) << 8 | 0;
  1330			writel(val, bdf_to_sid_base + hash * sizeof(u32));
  1331		}
  1332	
  1333		kfree(map);
  1334	
  1335		return 0;
  1336	}
  1337	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
