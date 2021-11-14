Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A518D44F66F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 05:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236117AbhKNEzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 23:55:24 -0500
Received: from mga05.intel.com ([192.55.52.43]:49238 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230441AbhKNEzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 23:55:23 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10167"; a="319506782"
X-IronPort-AV: E=Sophos;i="5.87,233,1631602800"; 
   d="gz'50?scan'50,208,50";a="319506782"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2021 20:52:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,233,1631602800"; 
   d="gz'50?scan'50,208,50";a="453619482"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 13 Nov 2021 20:52:27 -0800
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mm7VC-000KxV-RL; Sun, 14 Nov 2021 04:52:26 +0000
Date:   Sun, 14 Nov 2021 12:52:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leonardo Bras <leobras.c@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: arch/powerpc/platforms/pseries/iommu.c:1405 enable_ddw() warn:
 inconsistent indenting
Message-ID: <202111141257.WBieW8cx-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c8c109546a19613d323a319d0c921cb1f317e629
commit: 381ceda88c4c4c8345cad1cffa6328892f15dca6 powerpc/pseries/iommu: Make use of DDW for indirect mapping
date:   3 months ago
config: powerpc64-randconfig-m031-20211020 (attached as .config)
compiler: powerpc64-linux-gcc (GCC) 11.2.0

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

--6c2NcOVqGQ03X4Wi
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--6c2NcOVqGQ03X4Wi--
