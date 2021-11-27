Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFA24601C9
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 22:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347209AbhK0V4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 16:56:24 -0500
Received: from mga07.intel.com ([134.134.136.100]:3876 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356380AbhK0VyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 16:54:24 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10181"; a="299190096"
X-IronPort-AV: E=Sophos;i="5.87,269,1631602800"; 
   d="scan'208";a="299190096"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2021 13:51:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,269,1631602800"; 
   d="scan'208";a="675860427"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 27 Nov 2021 13:51:07 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mr5b8-000A2n-Ps; Sat, 27 Nov 2021 21:51:06 +0000
Date:   Sun, 28 Nov 2021 05:50:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: drivers/thunderbolt/test.c:2209:13: warning: stack frame size
 (10520) exceeds limit (8192) in 'tb_test_credit_alloc_all'
Message-ID: <202111280505.Vvi3B3ru-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mika,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c5c17547b778975b3d83a73c8d84e8fb5ecf3ba5
commit: bfa8f78e06ed0b495a5736380de0e7f833a5efbe thunderbolt: Add KUnit tests for credit allocation
date:   6 months ago
config: x86_64-randconfig-a006-20211128 (https://download.01.org/0day-ci/archive/20211128/202111280505.Vvi3B3ru-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 5162b558d8c0b542e752b037e72a69d5fd51eb1e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bfa8f78e06ed0b495a5736380de0e7f833a5efbe
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout bfa8f78e06ed0b495a5736380de0e7f833a5efbe
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/thunderbolt/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/thunderbolt/test.c:2209:13: warning: stack frame size (10520) exceeds limit (8192) in 'tb_test_credit_alloc_all' [-Wframe-larger-than]
   static void tb_test_credit_alloc_all(struct kunit *test)
               ^
   1 warning generated.


vim +/tb_test_credit_alloc_all +2209 drivers/thunderbolt/test.c

  2208	
> 2209	static void tb_test_credit_alloc_all(struct kunit *test)
  2210	{
  2211		struct tb_port *up, *down, *in, *out, *nhi, *port;
  2212		struct tb_tunnel *pcie_tunnel, *dp_tunnel1, *dp_tunnel2, *usb3_tunnel;
  2213		struct tb_tunnel *dma_tunnel1, *dma_tunnel2;
  2214		struct tb_switch *host, *dev;
  2215		struct tb_path *path;
  2216	
  2217		/*
  2218		 * Create PCIe, 2 x DP, USB 3.x and two DMA tunnels from host to
  2219		 * device. Expectation is that all these can be established with
  2220		 * the default credit allocation found in Intel hardware.
  2221		 */
  2222	
  2223		host = alloc_host_usb4(test);
  2224		dev = alloc_dev_usb4(test, host, 0x1, true);
  2225	
  2226		down = &host->ports[8];
  2227		up = &dev->ports[9];
  2228		pcie_tunnel = tb_tunnel_alloc_pci(NULL, up, down);
  2229		KUNIT_ASSERT_TRUE(test, pcie_tunnel != NULL);
  2230		KUNIT_ASSERT_EQ(test, pcie_tunnel->npaths, (size_t)2);
  2231	
  2232		path = pcie_tunnel->paths[0];
  2233		KUNIT_ASSERT_EQ(test, path->path_length, 2);
  2234		KUNIT_EXPECT_EQ(test, path->hops[0].nfc_credits, 0U);
  2235		KUNIT_EXPECT_EQ(test, path->hops[0].initial_credits, 7U);
  2236		KUNIT_EXPECT_EQ(test, path->hops[1].nfc_credits, 0U);
  2237		KUNIT_EXPECT_EQ(test, path->hops[1].initial_credits, 32U);
  2238	
  2239		path = pcie_tunnel->paths[1];
  2240		KUNIT_ASSERT_EQ(test, path->path_length, 2);
  2241		KUNIT_EXPECT_EQ(test, path->hops[0].nfc_credits, 0U);
  2242		KUNIT_EXPECT_EQ(test, path->hops[0].initial_credits, 7U);
  2243		KUNIT_EXPECT_EQ(test, path->hops[1].nfc_credits, 0U);
  2244		KUNIT_EXPECT_EQ(test, path->hops[1].initial_credits, 64U);
  2245	
  2246		in = &host->ports[5];
  2247		out = &dev->ports[13];
  2248	
  2249		dp_tunnel1 = tb_tunnel_alloc_dp(NULL, in, out, 0, 0);
  2250		KUNIT_ASSERT_TRUE(test, dp_tunnel1 != NULL);
  2251		KUNIT_ASSERT_EQ(test, dp_tunnel1->npaths, (size_t)3);
  2252	
  2253		path = dp_tunnel1->paths[0];
  2254		KUNIT_ASSERT_EQ(test, path->path_length, 2);
  2255		KUNIT_EXPECT_EQ(test, path->hops[0].nfc_credits, 12U);
  2256		KUNIT_EXPECT_EQ(test, path->hops[0].initial_credits, 0U);
  2257		KUNIT_EXPECT_EQ(test, path->hops[1].nfc_credits, 18U);
  2258		KUNIT_EXPECT_EQ(test, path->hops[1].initial_credits, 0U);
  2259	
  2260		path = dp_tunnel1->paths[1];
  2261		KUNIT_ASSERT_EQ(test, path->path_length, 2);
  2262		KUNIT_EXPECT_EQ(test, path->hops[0].nfc_credits, 0U);
  2263		KUNIT_EXPECT_EQ(test, path->hops[0].initial_credits, 1U);
  2264		KUNIT_EXPECT_EQ(test, path->hops[1].nfc_credits, 0U);
  2265		KUNIT_EXPECT_EQ(test, path->hops[1].initial_credits, 1U);
  2266	
  2267		path = dp_tunnel1->paths[2];
  2268		KUNIT_ASSERT_EQ(test, path->path_length, 2);
  2269		KUNIT_EXPECT_EQ(test, path->hops[0].nfc_credits, 0U);
  2270		KUNIT_EXPECT_EQ(test, path->hops[0].initial_credits, 1U);
  2271		KUNIT_EXPECT_EQ(test, path->hops[1].nfc_credits, 0U);
  2272		KUNIT_EXPECT_EQ(test, path->hops[1].initial_credits, 1U);
  2273	
  2274		in = &host->ports[6];
  2275		out = &dev->ports[14];
  2276	
  2277		dp_tunnel2 = tb_tunnel_alloc_dp(NULL, in, out, 0, 0);
  2278		KUNIT_ASSERT_TRUE(test, dp_tunnel2 != NULL);
  2279		KUNIT_ASSERT_EQ(test, dp_tunnel2->npaths, (size_t)3);
  2280	
  2281		path = dp_tunnel2->paths[0];
  2282		KUNIT_ASSERT_EQ(test, path->path_length, 2);
  2283		KUNIT_EXPECT_EQ(test, path->hops[0].nfc_credits, 12U);
  2284		KUNIT_EXPECT_EQ(test, path->hops[0].initial_credits, 0U);
  2285		KUNIT_EXPECT_EQ(test, path->hops[1].nfc_credits, 18U);
  2286		KUNIT_EXPECT_EQ(test, path->hops[1].initial_credits, 0U);
  2287	
  2288		path = dp_tunnel2->paths[1];
  2289		KUNIT_ASSERT_EQ(test, path->path_length, 2);
  2290		KUNIT_EXPECT_EQ(test, path->hops[0].nfc_credits, 0U);
  2291		KUNIT_EXPECT_EQ(test, path->hops[0].initial_credits, 1U);
  2292		KUNIT_EXPECT_EQ(test, path->hops[1].nfc_credits, 0U);
  2293		KUNIT_EXPECT_EQ(test, path->hops[1].initial_credits, 1U);
  2294	
  2295		path = dp_tunnel2->paths[2];
  2296		KUNIT_ASSERT_EQ(test, path->path_length, 2);
  2297		KUNIT_EXPECT_EQ(test, path->hops[0].nfc_credits, 0U);
  2298		KUNIT_EXPECT_EQ(test, path->hops[0].initial_credits, 1U);
  2299		KUNIT_EXPECT_EQ(test, path->hops[1].nfc_credits, 0U);
  2300		KUNIT_EXPECT_EQ(test, path->hops[1].initial_credits, 1U);
  2301	
  2302		down = &host->ports[12];
  2303		up = &dev->ports[16];
  2304		usb3_tunnel = tb_tunnel_alloc_usb3(NULL, up, down, 0, 0);
  2305		KUNIT_ASSERT_TRUE(test, usb3_tunnel != NULL);
  2306		KUNIT_ASSERT_EQ(test, usb3_tunnel->npaths, (size_t)2);
  2307	
  2308		path = usb3_tunnel->paths[0];
  2309		KUNIT_ASSERT_EQ(test, path->path_length, 2);
  2310		KUNIT_EXPECT_EQ(test, path->hops[0].nfc_credits, 0U);
  2311		KUNIT_EXPECT_EQ(test, path->hops[0].initial_credits, 7U);
  2312		KUNIT_EXPECT_EQ(test, path->hops[1].nfc_credits, 0U);
  2313		KUNIT_EXPECT_EQ(test, path->hops[1].initial_credits, 14U);
  2314	
  2315		path = usb3_tunnel->paths[1];
  2316		KUNIT_ASSERT_EQ(test, path->path_length, 2);
  2317		KUNIT_EXPECT_EQ(test, path->hops[0].nfc_credits, 0U);
  2318		KUNIT_EXPECT_EQ(test, path->hops[0].initial_credits, 7U);
  2319		KUNIT_EXPECT_EQ(test, path->hops[1].nfc_credits, 0U);
  2320		KUNIT_EXPECT_EQ(test, path->hops[1].initial_credits, 32U);
  2321	
  2322		nhi = &host->ports[7];
  2323		port = &dev->ports[3];
  2324	
  2325		dma_tunnel1 = tb_tunnel_alloc_dma(NULL, nhi, port, 8, 1, 8, 1);
  2326		KUNIT_ASSERT_TRUE(test, dma_tunnel1 != NULL);
  2327		KUNIT_ASSERT_EQ(test, dma_tunnel1->npaths, (size_t)2);
  2328	
  2329		path = dma_tunnel1->paths[0];
  2330		KUNIT_ASSERT_EQ(test, path->path_length, 2);
  2331		KUNIT_EXPECT_EQ(test, path->hops[0].nfc_credits, 0U);
  2332		KUNIT_EXPECT_EQ(test, path->hops[0].initial_credits, 14U);
  2333		KUNIT_EXPECT_EQ(test, path->hops[1].nfc_credits, 0U);
  2334		KUNIT_EXPECT_EQ(test, path->hops[1].initial_credits, 14U);
  2335	
  2336		path = dma_tunnel1->paths[1];
  2337		KUNIT_ASSERT_EQ(test, path->path_length, 2);
  2338		KUNIT_EXPECT_EQ(test, path->hops[0].nfc_credits, 0U);
  2339		KUNIT_EXPECT_EQ(test, path->hops[0].initial_credits, 0U);
  2340		KUNIT_EXPECT_EQ(test, path->hops[1].nfc_credits, 0U);
  2341		KUNIT_EXPECT_EQ(test, path->hops[1].initial_credits, 14U);
  2342	
  2343		dma_tunnel2 = tb_tunnel_alloc_dma(NULL, nhi, port, 9, 2, 9, 2);
  2344		KUNIT_ASSERT_TRUE(test, dma_tunnel2 != NULL);
  2345		KUNIT_ASSERT_EQ(test, dma_tunnel2->npaths, (size_t)2);
  2346	
  2347		path = dma_tunnel2->paths[0];
  2348		KUNIT_ASSERT_EQ(test, path->path_length, 2);
  2349		KUNIT_EXPECT_EQ(test, path->hops[0].nfc_credits, 0U);
  2350		KUNIT_EXPECT_EQ(test, path->hops[0].initial_credits, 14U);
  2351		KUNIT_EXPECT_EQ(test, path->hops[1].nfc_credits, 0U);
  2352		KUNIT_EXPECT_EQ(test, path->hops[1].initial_credits, 1U);
  2353	
  2354		path = dma_tunnel2->paths[1];
  2355		KUNIT_ASSERT_EQ(test, path->path_length, 2);
  2356		KUNIT_EXPECT_EQ(test, path->hops[0].nfc_credits, 0U);
  2357		KUNIT_EXPECT_EQ(test, path->hops[0].initial_credits, 0U);
  2358		KUNIT_EXPECT_EQ(test, path->hops[1].nfc_credits, 0U);
  2359		KUNIT_EXPECT_EQ(test, path->hops[1].initial_credits, 1U);
  2360	
  2361		tb_tunnel_free(dma_tunnel2);
  2362		tb_tunnel_free(dma_tunnel1);
  2363		tb_tunnel_free(usb3_tunnel);
  2364		tb_tunnel_free(dp_tunnel2);
  2365		tb_tunnel_free(dp_tunnel1);
  2366		tb_tunnel_free(pcie_tunnel);
  2367	}
  2368	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
