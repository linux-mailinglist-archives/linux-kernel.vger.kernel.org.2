Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40F56406A7F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 13:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbhIJLK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 07:10:26 -0400
Received: from mga11.intel.com ([192.55.52.93]:19880 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232415AbhIJLKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 07:10:25 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10102"; a="217886860"
X-IronPort-AV: E=Sophos;i="5.85,282,1624345200"; 
   d="gz'50?scan'50,208,50";a="217886860"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2021 04:09:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,282,1624345200"; 
   d="gz'50?scan'50,208,50";a="549257111"
Received: from lkp-server01.sh.intel.com (HELO 730d49888f40) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 10 Sep 2021 04:09:05 -0700
Received: from kbuild by 730d49888f40 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mOeOp-0004A0-KB; Fri, 10 Sep 2021 11:08:51 +0000
Date:   Fri, 10 Sep 2021 19:08:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leonardo Bras <leobras.c@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: arch/powerpc/platforms/pseries/iommu.c:1405 enable_ddw() warn:
 inconsistent indenting
Message-ID: <202109101900.xGcLmLJf-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   bf9f243f23e6623f310ba03fbb14e10ec3a61290
commit: 381ceda88c4c4c8345cad1cffa6328892f15dca6 powerpc/pseries/iommu: Make use of DDW for indirect mapping
date:   2 weeks ago
config: powerpc64-randconfig-m031-20210910 (attached as .config)
compiler: powerpc64le-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

New smatch warnings:
arch/powerpc/platforms/pseries/iommu.c:1405 enable_ddw() warn: inconsistent indenting

Old smatch warnings:
arch/powerpc/platforms/pseries/iommu.c:1490 enable_ddw() warn: inconsistent indenting

vim +1405 arch/powerpc/platforms/pseries/iommu.c

7ed2ed2db2685a Leonardo Bras        2021-08-17  1211  
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1212  /*
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1213   * If the PE supports dynamic dma windows, and there is space for a table
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1214   * that can map all pages in a linear offset, then setup such a table,
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1215   * and record the dma-offset in the struct device.
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1216   *
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1217   * dev: the pci device we are checking
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1218   * pdn: the parent pe node with the ibm,dma_window property
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1219   * Future: also check if we can remap the base window for our base page size
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1220   *
2ca73c54ce2448 Leonardo Bras        2021-08-17  1221   * returns true if can map all pages (direct mapping), false otherwise..
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1222   */
2ca73c54ce2448 Leonardo Bras        2021-08-17  1223  static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn)
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1224  {
bf6e2d562bbc4d Alexey Kardashevskiy 2020-10-29  1225  	int len = 0, ret;
bf6e2d562bbc4d Alexey Kardashevskiy 2020-10-29  1226  	int max_ram_len = order_base_2(ddw_memory_hotplug_max());
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1227  	struct ddw_query_response query;
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1228  	struct ddw_create_response create;
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1229  	int page_shift;
7ed2ed2db2685a Leonardo Bras        2021-08-17  1230  	u64 win_addr;
381ceda88c4c4c Leonardo Bras        2021-08-17  1231  	const char *win_name;
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1232  	struct device_node *dn;
cac3e629086f1b Leonardo Bras        2020-08-05  1233  	u32 ddw_avail[DDW_APPLICABLE_SIZE];
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1234  	struct direct_window *window;
767303349e052a Nishanth Aravamudan  2011-05-06  1235  	struct property *win64;
2ca73c54ce2448 Leonardo Bras        2021-08-17  1236  	bool ddw_enabled = false;
61435690a9c781 Nishanth Aravamudan  2013-03-07  1237  	struct failed_ddw_pdn *fpdn;
381ceda88c4c4c Leonardo Bras        2021-08-17  1238  	bool default_win_removed = false, direct_mapping = false;
bf6e2d562bbc4d Alexey Kardashevskiy 2020-10-29  1239  	bool pmem_present;
381ceda88c4c4c Leonardo Bras        2021-08-17  1240  	struct pci_dn *pci = PCI_DN(pdn);
381ceda88c4c4c Leonardo Bras        2021-08-17  1241  	struct iommu_table *tbl = pci->table_group->tables[0];
bf6e2d562bbc4d Alexey Kardashevskiy 2020-10-29  1242  
bf6e2d562bbc4d Alexey Kardashevskiy 2020-10-29  1243  	dn = of_find_node_by_type(NULL, "ibm,pmemory");
bf6e2d562bbc4d Alexey Kardashevskiy 2020-10-29  1244  	pmem_present = dn != NULL;
bf6e2d562bbc4d Alexey Kardashevskiy 2020-10-29  1245  	of_node_put(dn);
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1246  
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1247  	mutex_lock(&direct_window_init_mutex);
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1248  
2ca73c54ce2448 Leonardo Bras        2021-08-17  1249  	if (find_existing_ddw(pdn, &dev->dev.archdata.dma_offset, &len)) {
381ceda88c4c4c Leonardo Bras        2021-08-17  1250  		direct_mapping = (len >= max_ram_len);
2ca73c54ce2448 Leonardo Bras        2021-08-17  1251  		ddw_enabled = true;
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1252  		goto out_unlock;
2ca73c54ce2448 Leonardo Bras        2021-08-17  1253  	}
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1254  
61435690a9c781 Nishanth Aravamudan  2013-03-07  1255  	/*
61435690a9c781 Nishanth Aravamudan  2013-03-07  1256  	 * If we already went through this for a previous function of
61435690a9c781 Nishanth Aravamudan  2013-03-07  1257  	 * the same device and failed, we don't want to muck with the
61435690a9c781 Nishanth Aravamudan  2013-03-07  1258  	 * DMA window again, as it will race with in-flight operations
61435690a9c781 Nishanth Aravamudan  2013-03-07  1259  	 * and can lead to EEHs. The above mutex protects access to the
61435690a9c781 Nishanth Aravamudan  2013-03-07  1260  	 * list.
61435690a9c781 Nishanth Aravamudan  2013-03-07  1261  	 */
61435690a9c781 Nishanth Aravamudan  2013-03-07  1262  	list_for_each_entry(fpdn, &failed_ddw_pdn_list, list) {
b7c670d673d118 Rob Herring          2017-08-21  1263  		if (fpdn->pdn == pdn)
61435690a9c781 Nishanth Aravamudan  2013-03-07  1264  			goto out_unlock;
61435690a9c781 Nishanth Aravamudan  2013-03-07  1265  	}
61435690a9c781 Nishanth Aravamudan  2013-03-07  1266  
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1267  	/*
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1268  	 * the ibm,ddw-applicable property holds the tokens for:
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1269  	 * ibm,query-pe-dma-window
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1270  	 * ibm,create-pe-dma-window
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1271  	 * ibm,remove-pe-dma-window
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1272  	 * for the given node in that order.
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1273  	 * the property is actually in the parent, not the PE
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1274  	 */
9410e0185e6539 Alexey Kardashevskiy 2014-09-25  1275  	ret = of_property_read_u32_array(pdn, "ibm,ddw-applicable",
cac3e629086f1b Leonardo Bras        2020-08-05  1276  					 &ddw_avail[0], DDW_APPLICABLE_SIZE);
9410e0185e6539 Alexey Kardashevskiy 2014-09-25  1277  	if (ret)
ae69e1eddc646f Nishanth Aravamudan  2014-01-10  1278  		goto out_failed;
25ebc45b93452d Nishanth Aravamudan  2012-05-15  1279  
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1280         /*
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1281  	 * Query if there is a second window of size to map the
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1282  	 * whole partition.  Query returns number of windows, largest
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1283  	 * block assigned to PE (partition endpoint), and two bitmasks
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1284  	 * of page sizes: supported and supported for migrate-dma.
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1285  	 */
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1286  	dn = pci_device_to_OF_node(dev);
80f0251231131d Leonardo Bras        2020-08-05  1287  	ret = query_ddw(dev, ddw_avail, &query, pdn);
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1288  	if (ret != 0)
ae69e1eddc646f Nishanth Aravamudan  2014-01-10  1289  		goto out_failed;
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1290  
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1291  	/*
8c0d51592f6f01 Leonardo Bras        2020-08-05  1292  	 * If there is no window available, remove the default DMA window,
8c0d51592f6f01 Leonardo Bras        2020-08-05  1293  	 * if it's present. This will make all the resources available to the
8c0d51592f6f01 Leonardo Bras        2020-08-05  1294  	 * new DDW window.
8c0d51592f6f01 Leonardo Bras        2020-08-05  1295  	 * If anything fails after this, we need to restore it, so also check
8c0d51592f6f01 Leonardo Bras        2020-08-05  1296  	 * for extensions presence.
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1297  	 */
8c0d51592f6f01 Leonardo Bras        2020-08-05  1298  	if (query.windows_available == 0) {
8c0d51592f6f01 Leonardo Bras        2020-08-05  1299  		struct property *default_win;
8c0d51592f6f01 Leonardo Bras        2020-08-05  1300  		int reset_win_ext;
8c0d51592f6f01 Leonardo Bras        2020-08-05  1301  
8c0d51592f6f01 Leonardo Bras        2020-08-05  1302  		default_win = of_find_property(pdn, "ibm,dma-window", NULL);
8c0d51592f6f01 Leonardo Bras        2020-08-05  1303  		if (!default_win)
8c0d51592f6f01 Leonardo Bras        2020-08-05  1304  			goto out_failed;
8c0d51592f6f01 Leonardo Bras        2020-08-05  1305  
8c0d51592f6f01 Leonardo Bras        2020-08-05  1306  		reset_win_ext = ddw_read_ext(pdn, DDW_EXT_RESET_DMA_WIN, NULL);
8c0d51592f6f01 Leonardo Bras        2020-08-05  1307  		if (reset_win_ext)
8c0d51592f6f01 Leonardo Bras        2020-08-05  1308  			goto out_failed;
8c0d51592f6f01 Leonardo Bras        2020-08-05  1309  
8c0d51592f6f01 Leonardo Bras        2020-08-05  1310  		remove_dma_window(pdn, ddw_avail, default_win);
8c0d51592f6f01 Leonardo Bras        2020-08-05  1311  		default_win_removed = true;
8c0d51592f6f01 Leonardo Bras        2020-08-05  1312  
8c0d51592f6f01 Leonardo Bras        2020-08-05  1313  		/* Query again, to check if the window is available */
8c0d51592f6f01 Leonardo Bras        2020-08-05  1314  		ret = query_ddw(dev, ddw_avail, &query, pdn);
8c0d51592f6f01 Leonardo Bras        2020-08-05  1315  		if (ret != 0)
8c0d51592f6f01 Leonardo Bras        2020-08-05  1316  			goto out_failed;
8c0d51592f6f01 Leonardo Bras        2020-08-05  1317  
8c0d51592f6f01 Leonardo Bras        2020-08-05  1318  		if (query.windows_available == 0) {
8c0d51592f6f01 Leonardo Bras        2020-08-05  1319  			/* no windows are available for this device. */
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1320  			dev_dbg(&dev->dev, "no free dynamic windows");
ae69e1eddc646f Nishanth Aravamudan  2014-01-10  1321  			goto out_failed;
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1322  		}
8c0d51592f6f01 Leonardo Bras        2020-08-05  1323  	}
472724111f0f72 Leonardo Bras        2021-04-08  1324  
472724111f0f72 Leonardo Bras        2021-04-08  1325  	page_shift = iommu_get_page_shift(query.page_size);
472724111f0f72 Leonardo Bras        2021-04-08  1326  	if (!page_shift) {
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1327  		dev_dbg(&dev->dev, "no supported direct page size in mask %x",
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1328  			  query.page_size);
ae69e1eddc646f Nishanth Aravamudan  2014-01-10  1329  		goto out_failed;
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1330  	}
381ceda88c4c4c Leonardo Bras        2021-08-17  1331  
381ceda88c4c4c Leonardo Bras        2021-08-17  1332  
bf6e2d562bbc4d Alexey Kardashevskiy 2020-10-29  1333  	/*
bf6e2d562bbc4d Alexey Kardashevskiy 2020-10-29  1334  	 * The "ibm,pmemory" can appear anywhere in the address space.
bf6e2d562bbc4d Alexey Kardashevskiy 2020-10-29  1335  	 * Assuming it is still backed by page structs, try MAX_PHYSMEM_BITS
bf6e2d562bbc4d Alexey Kardashevskiy 2020-10-29  1336  	 * for the upper limit and fallback to max RAM otherwise but this
bf6e2d562bbc4d Alexey Kardashevskiy 2020-10-29  1337  	 * disables device::dma_ops_bypass.
bf6e2d562bbc4d Alexey Kardashevskiy 2020-10-29  1338  	 */
bf6e2d562bbc4d Alexey Kardashevskiy 2020-10-29  1339  	len = max_ram_len;
bf6e2d562bbc4d Alexey Kardashevskiy 2020-10-29  1340  	if (pmem_present) {
bf6e2d562bbc4d Alexey Kardashevskiy 2020-10-29  1341  		if (query.largest_available_block >=
bf6e2d562bbc4d Alexey Kardashevskiy 2020-10-29  1342  		    (1ULL << (MAX_PHYSMEM_BITS - page_shift)))
a9d2f9bb225fd2 Leonardo Bras        2021-04-20  1343  			len = MAX_PHYSMEM_BITS;
bf6e2d562bbc4d Alexey Kardashevskiy 2020-10-29  1344  		else
bf6e2d562bbc4d Alexey Kardashevskiy 2020-10-29  1345  			dev_info(&dev->dev, "Skipping ibm,pmemory");
bf6e2d562bbc4d Alexey Kardashevskiy 2020-10-29  1346  	}
bf6e2d562bbc4d Alexey Kardashevskiy 2020-10-29  1347  
381ceda88c4c4c Leonardo Bras        2021-08-17  1348  	/* check if the available block * number of ptes will map everything */
bf6e2d562bbc4d Alexey Kardashevskiy 2020-10-29  1349  	if (query.largest_available_block < (1ULL << (len - page_shift))) {
bf6e2d562bbc4d Alexey Kardashevskiy 2020-10-29  1350  		dev_dbg(&dev->dev,
bf6e2d562bbc4d Alexey Kardashevskiy 2020-10-29  1351  			"can't map partition max 0x%llx with %llu %llu-sized pages\n",
bf6e2d562bbc4d Alexey Kardashevskiy 2020-10-29  1352  			1ULL << len,
bf6e2d562bbc4d Alexey Kardashevskiy 2020-10-29  1353  			query.largest_available_block,
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1354  			1ULL << page_shift);
381ceda88c4c4c Leonardo Bras        2021-08-17  1355  
381ceda88c4c4c Leonardo Bras        2021-08-17  1356  		/* DDW + IOMMU on single window may fail if there is any allocation */
381ceda88c4c4c Leonardo Bras        2021-08-17  1357  		if (default_win_removed && iommu_table_in_use(tbl)) {
381ceda88c4c4c Leonardo Bras        2021-08-17  1358  			dev_dbg(&dev->dev, "current IOMMU table in use, can't be replaced.\n");
ae69e1eddc646f Nishanth Aravamudan  2014-01-10  1359  			goto out_failed;
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1360  		}
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1361  
381ceda88c4c4c Leonardo Bras        2021-08-17  1362  		len = order_base_2(query.largest_available_block << page_shift);
381ceda88c4c4c Leonardo Bras        2021-08-17  1363  		win_name = DMA64_PROPNAME;
381ceda88c4c4c Leonardo Bras        2021-08-17  1364  	} else {
381ceda88c4c4c Leonardo Bras        2021-08-17  1365  		direct_mapping = true;
381ceda88c4c4c Leonardo Bras        2021-08-17  1366  		win_name = DIRECT64_PROPNAME;
381ceda88c4c4c Leonardo Bras        2021-08-17  1367  	}
381ceda88c4c4c Leonardo Bras        2021-08-17  1368  
b73a635f348610 Milton Miller        2011-05-11  1369  	ret = create_ddw(dev, ddw_avail, &create, page_shift, len);
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1370  	if (ret != 0)
7ed2ed2db2685a Leonardo Bras        2021-08-17  1371  		goto out_failed;
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1372  
b7c670d673d118 Rob Herring          2017-08-21  1373  	dev_dbg(&dev->dev, "created tce table LIOBN 0x%x for %pOF\n",
b7c670d673d118 Rob Herring          2017-08-21  1374  		  create.liobn, dn);
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1375  
7ed2ed2db2685a Leonardo Bras        2021-08-17  1376  	win_addr = ((u64)create.addr_hi << 32) | create.addr_lo;
381ceda88c4c4c Leonardo Bras        2021-08-17  1377  	win64 = ddw_property_create(win_name, create.liobn, win_addr, page_shift, len);
381ceda88c4c4c Leonardo Bras        2021-08-17  1378  
7ed2ed2db2685a Leonardo Bras        2021-08-17  1379  	if (!win64) {
7ed2ed2db2685a Leonardo Bras        2021-08-17  1380  		dev_info(&dev->dev,
7ed2ed2db2685a Leonardo Bras        2021-08-17  1381  			 "couldn't allocate property, property name, or value\n");
7ed2ed2db2685a Leonardo Bras        2021-08-17  1382  		goto out_remove_win;
7ed2ed2db2685a Leonardo Bras        2021-08-17  1383  	}
7ed2ed2db2685a Leonardo Bras        2021-08-17  1384  
7ed2ed2db2685a Leonardo Bras        2021-08-17  1385  	ret = of_add_property(pdn, win64);
7ed2ed2db2685a Leonardo Bras        2021-08-17  1386  	if (ret) {
7ed2ed2db2685a Leonardo Bras        2021-08-17  1387  		dev_err(&dev->dev, "unable to add dma window property for %pOF: %d",
7ed2ed2db2685a Leonardo Bras        2021-08-17  1388  			pdn, ret);
7ed2ed2db2685a Leonardo Bras        2021-08-17  1389  		goto out_free_prop;
7ed2ed2db2685a Leonardo Bras        2021-08-17  1390  	}
7ed2ed2db2685a Leonardo Bras        2021-08-17  1391  
7ed2ed2db2685a Leonardo Bras        2021-08-17  1392  	window = ddw_list_new_entry(pdn, win64->value);
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1393  	if (!window)
7ed2ed2db2685a Leonardo Bras        2021-08-17  1394  		goto out_del_prop;
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1395  
381ceda88c4c4c Leonardo Bras        2021-08-17  1396  	if (direct_mapping) {
381ceda88c4c4c Leonardo Bras        2021-08-17  1397  		/* DDW maps the whole partition, so enable direct DMA mapping */
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1398  		ret = walk_system_ram_range(0, memblock_end_of_DRAM() >> PAGE_SHIFT,
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1399  					    win64->value, tce_setrange_multi_pSeriesLP_walk);
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1400  		if (ret) {
b7c670d673d118 Rob Herring          2017-08-21  1401  			dev_info(&dev->dev, "failed to map direct window for %pOF: %d\n",
b7c670d673d118 Rob Herring          2017-08-21  1402  				 dn, ret);
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1403  
7ed2ed2db2685a Leonardo Bras        2021-08-17  1404  		/* Make sure to clean DDW if any TCE was set*/
7ed2ed2db2685a Leonardo Bras        2021-08-17 @1405  		clean_dma_window(pdn, win64->value);
7ed2ed2db2685a Leonardo Bras        2021-08-17  1406  			goto out_del_list;
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1407  		}
381ceda88c4c4c Leonardo Bras        2021-08-17  1408  	} else {
381ceda88c4c4c Leonardo Bras        2021-08-17  1409  		struct iommu_table *newtbl;
381ceda88c4c4c Leonardo Bras        2021-08-17  1410  		int i;
381ceda88c4c4c Leonardo Bras        2021-08-17  1411  
381ceda88c4c4c Leonardo Bras        2021-08-17  1412  		for (i = 0; i < ARRAY_SIZE(pci->phb->mem_resources); i++) {
381ceda88c4c4c Leonardo Bras        2021-08-17  1413  			const unsigned long mask = IORESOURCE_MEM_64 | IORESOURCE_MEM;
381ceda88c4c4c Leonardo Bras        2021-08-17  1414  
381ceda88c4c4c Leonardo Bras        2021-08-17  1415  			/* Look for MMIO32 */
381ceda88c4c4c Leonardo Bras        2021-08-17  1416  			if ((pci->phb->mem_resources[i].flags & mask) == IORESOURCE_MEM)
381ceda88c4c4c Leonardo Bras        2021-08-17  1417  				break;
381ceda88c4c4c Leonardo Bras        2021-08-17  1418  		}
381ceda88c4c4c Leonardo Bras        2021-08-17  1419  
381ceda88c4c4c Leonardo Bras        2021-08-17  1420  		if (i == ARRAY_SIZE(pci->phb->mem_resources))
381ceda88c4c4c Leonardo Bras        2021-08-17  1421  			goto out_del_list;
381ceda88c4c4c Leonardo Bras        2021-08-17  1422  
381ceda88c4c4c Leonardo Bras        2021-08-17  1423  		/* New table for using DDW instead of the default DMA window */
381ceda88c4c4c Leonardo Bras        2021-08-17  1424  		newtbl = iommu_pseries_alloc_table(pci->phb->node);
381ceda88c4c4c Leonardo Bras        2021-08-17  1425  		if (!newtbl) {
381ceda88c4c4c Leonardo Bras        2021-08-17  1426  			dev_dbg(&dev->dev, "couldn't create new IOMMU table\n");
381ceda88c4c4c Leonardo Bras        2021-08-17  1427  			goto out_del_list;
381ceda88c4c4c Leonardo Bras        2021-08-17  1428  		}
381ceda88c4c4c Leonardo Bras        2021-08-17  1429  
381ceda88c4c4c Leonardo Bras        2021-08-17  1430  		iommu_table_setparms_common(newtbl, pci->phb->bus->number, create.liobn, win_addr,
381ceda88c4c4c Leonardo Bras        2021-08-17  1431  					    1UL << len, page_shift, NULL, &iommu_table_lpar_multi_ops);
381ceda88c4c4c Leonardo Bras        2021-08-17  1432  		iommu_init_table(newtbl, pci->phb->node, pci->phb->mem_resources[i].start,
381ceda88c4c4c Leonardo Bras        2021-08-17  1433  				 pci->phb->mem_resources[i].end);
381ceda88c4c4c Leonardo Bras        2021-08-17  1434  
381ceda88c4c4c Leonardo Bras        2021-08-17  1435  		pci->table_group->tables[1] = newtbl;
381ceda88c4c4c Leonardo Bras        2021-08-17  1436  
381ceda88c4c4c Leonardo Bras        2021-08-17  1437  		/* Keep default DMA window stuct if removed */
381ceda88c4c4c Leonardo Bras        2021-08-17  1438  		if (default_win_removed) {
381ceda88c4c4c Leonardo Bras        2021-08-17  1439  			tbl->it_size = 0;
381ceda88c4c4c Leonardo Bras        2021-08-17  1440  			kfree(tbl->it_map);
381ceda88c4c4c Leonardo Bras        2021-08-17  1441  		}
381ceda88c4c4c Leonardo Bras        2021-08-17  1442  
381ceda88c4c4c Leonardo Bras        2021-08-17  1443  		set_iommu_table_base(&dev->dev, newtbl);
381ceda88c4c4c Leonardo Bras        2021-08-17  1444  	}
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1445  
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1446  	spin_lock(&direct_window_list_lock);
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1447  	list_add(&window->list, &direct_window_list);
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1448  	spin_unlock(&direct_window_list_lock);
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1449  
7ed2ed2db2685a Leonardo Bras        2021-08-17  1450  	dev->dev.archdata.dma_offset = win_addr;
2ca73c54ce2448 Leonardo Bras        2021-08-17  1451  	ddw_enabled = true;
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1452  	goto out_unlock;
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1453  
7ed2ed2db2685a Leonardo Bras        2021-08-17  1454  out_del_list:
7a19081fc26581 Julia Lawall         2011-08-08  1455  	kfree(window);
7a19081fc26581 Julia Lawall         2011-08-08  1456  
7ed2ed2db2685a Leonardo Bras        2021-08-17  1457  out_del_prop:
7ed2ed2db2685a Leonardo Bras        2021-08-17  1458  	of_remove_property(pdn, win64);
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1459  
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1460  out_free_prop:
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1461  	kfree(win64->name);
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1462  	kfree(win64->value);
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1463  	kfree(win64);
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1464  
7ed2ed2db2685a Leonardo Bras        2021-08-17  1465  out_remove_win:
7ed2ed2db2685a Leonardo Bras        2021-08-17  1466  	/* DDW is clean, so it's ok to call this directly. */
7ed2ed2db2685a Leonardo Bras        2021-08-17  1467  	__remove_dma_window(pdn, ddw_avail, create.liobn);
7ed2ed2db2685a Leonardo Bras        2021-08-17  1468  
ae69e1eddc646f Nishanth Aravamudan  2014-01-10  1469  out_failed:
8c0d51592f6f01 Leonardo Bras        2020-08-05  1470  	if (default_win_removed)
8c0d51592f6f01 Leonardo Bras        2020-08-05  1471  		reset_dma_window(dev, pdn);
25ebc45b93452d Nishanth Aravamudan  2012-05-15  1472  
61435690a9c781 Nishanth Aravamudan  2013-03-07  1473  	fpdn = kzalloc(sizeof(*fpdn), GFP_KERNEL);
61435690a9c781 Nishanth Aravamudan  2013-03-07  1474  	if (!fpdn)
61435690a9c781 Nishanth Aravamudan  2013-03-07  1475  		goto out_unlock;
61435690a9c781 Nishanth Aravamudan  2013-03-07  1476  	fpdn->pdn = pdn;
61435690a9c781 Nishanth Aravamudan  2013-03-07  1477  	list_add(&fpdn->list, &failed_ddw_pdn_list);
61435690a9c781 Nishanth Aravamudan  2013-03-07  1478  
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1479  out_unlock:
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1480  	mutex_unlock(&direct_window_init_mutex);
bf6e2d562bbc4d Alexey Kardashevskiy 2020-10-29  1481  
bf6e2d562bbc4d Alexey Kardashevskiy 2020-10-29  1482  	/*
bf6e2d562bbc4d Alexey Kardashevskiy 2020-10-29  1483  	 * If we have persistent memory and the window size is only as big
bf6e2d562bbc4d Alexey Kardashevskiy 2020-10-29  1484  	 * as RAM, then we failed to create a window to cover persistent
bf6e2d562bbc4d Alexey Kardashevskiy 2020-10-29  1485  	 * memory and need to set the DMA limit.
bf6e2d562bbc4d Alexey Kardashevskiy 2020-10-29  1486  	 */
381ceda88c4c4c Leonardo Bras        2021-08-17  1487  	if (pmem_present && ddw_enabled && direct_mapping && len == max_ram_len)
2ca73c54ce2448 Leonardo Bras        2021-08-17  1488  		dev->dev.bus_dma_limit = dev->dev.archdata.dma_offset + (1ULL << len);
bf6e2d562bbc4d Alexey Kardashevskiy 2020-10-29  1489  
381ceda88c4c4c Leonardo Bras        2021-08-17  1490      return ddw_enabled && direct_mapping;
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1491  }
4e8b0cf46b2570 Nishanth Aravamudan  2011-02-10  1492  

:::::: The code at line 1405 was first introduced by commit
:::::: 7ed2ed2db2685a285cb09ab330dc4efea0b64022 powerpc/pseries/iommu: Add ddw_property_create() and refactor enable_ddw()

:::::: TO: Leonardo Bras <leobras.c@gmail.com>
:::::: CC: Michael Ellerman <mpe@ellerman.id.au>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--AhhlLboLdkugWU4S
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--AhhlLboLdkugWU4S--
