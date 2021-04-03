Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B14A3535B4
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 00:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236858AbhDCWbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 18:31:14 -0400
Received: from mga12.intel.com ([192.55.52.136]:4213 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236625AbhDCWbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 18:31:13 -0400
IronPort-SDR: it4VJM5juPG8E/mqT8MG1JOG5jh/pTGjRLrydfYQs9vDvq6/hNujxB1spM/yRgm+tujd+Tg3ZS
 2LgtIcyrh3KA==
X-IronPort-AV: E=McAfee;i="6000,8403,9943"; a="172087029"
X-IronPort-AV: E=Sophos;i="5.81,303,1610438400"; 
   d="gz'50?scan'50,208,50";a="172087029"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2021 15:31:09 -0700
IronPort-SDR: 0aUhzZ4pNbsCUGQB0Xr4XBNHgrqscTavsJbQtx/pW+nSoMpxD7HN4g2LL6VWCQ7OAMEKqlFOp+
 EccXi1v+lcyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,303,1610438400"; 
   d="gz'50?scan'50,208,50";a="378488679"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 03 Apr 2021 15:31:07 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lSonK-0007uQ-US; Sat, 03 Apr 2021 22:31:06 +0000
Date:   Sun, 4 Apr 2021 06:30:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/gpu/drm/bridge/sil-sii8620.c:2355: undefined reference to
 `extcon_unregister_notifier'
Message-ID: <202104040604.SSTe2Cxf-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Masahiro,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8e29be3468d4565dd95fbb098df0d7a79ee60d71
commit: def2fbffe62c00c330c7f41584a356001179c59c kconfig: allow symbols implied by y to become m
date:   1 year, 1 month ago
config: i386-randconfig-a003-20210404 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=def2fbffe62c00c330c7f41584a356001179c59c
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout def2fbffe62c00c330c7f41584a356001179c59c
        # save the attached .config to linux build tree
        make W=1 ARCH=i386 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: drivers/gpu/drm/bridge/sil-sii8620.o: in function `sii8620_remove':
>> drivers/gpu/drm/bridge/sil-sii8620.c:2355: undefined reference to `extcon_unregister_notifier'
   ld: drivers/gpu/drm/bridge/sil-sii8620.o: in function `sii8620_extcon_init':
>> drivers/gpu/drm/bridge/sil-sii8620.c:2179: undefined reference to `extcon_find_edev_by_node'
>> ld: drivers/gpu/drm/bridge/sil-sii8620.c:2191: undefined reference to `extcon_register_notifier'
   ld: drivers/gpu/drm/bridge/sil-sii8620.o: in function `sii8620_extcon_work':
>> drivers/gpu/drm/bridge/sil-sii8620.c:2139: undefined reference to `extcon_get_state'


vim +2355 drivers/gpu/drm/bridge/sil-sii8620.c

688838442147d9 Maciej Purski    2018-02-27  2162  
688838442147d9 Maciej Purski    2018-02-27  2163  static int sii8620_extcon_init(struct sii8620 *ctx)
688838442147d9 Maciej Purski    2018-02-27  2164  {
688838442147d9 Maciej Purski    2018-02-27  2165  	struct extcon_dev *edev;
688838442147d9 Maciej Purski    2018-02-27  2166  	struct device_node *musb, *muic;
688838442147d9 Maciej Purski    2018-02-27  2167  	int ret;
688838442147d9 Maciej Purski    2018-02-27  2168  
688838442147d9 Maciej Purski    2018-02-27  2169  	/* get micro-USB connector node */
688838442147d9 Maciej Purski    2018-02-27  2170  	musb = of_graph_get_remote_node(ctx->dev->of_node, 1, -1);
688838442147d9 Maciej Purski    2018-02-27  2171  	/* next get micro-USB Interface Controller node */
688838442147d9 Maciej Purski    2018-02-27  2172  	muic = of_get_next_parent(musb);
688838442147d9 Maciej Purski    2018-02-27  2173  
688838442147d9 Maciej Purski    2018-02-27  2174  	if (!muic) {
688838442147d9 Maciej Purski    2018-02-27  2175  		dev_info(ctx->dev, "no extcon found, switching to 'always on' mode\n");
688838442147d9 Maciej Purski    2018-02-27  2176  		return 0;
688838442147d9 Maciej Purski    2018-02-27  2177  	}
688838442147d9 Maciej Purski    2018-02-27  2178  
688838442147d9 Maciej Purski    2018-02-27 @2179  	edev = extcon_find_edev_by_node(muic);
688838442147d9 Maciej Purski    2018-02-27  2180  	of_node_put(muic);
688838442147d9 Maciej Purski    2018-02-27  2181  	if (IS_ERR(edev)) {
688838442147d9 Maciej Purski    2018-02-27  2182  		if (PTR_ERR(edev) == -EPROBE_DEFER)
688838442147d9 Maciej Purski    2018-02-27  2183  			return -EPROBE_DEFER;
688838442147d9 Maciej Purski    2018-02-27  2184  		dev_err(ctx->dev, "Invalid or missing extcon\n");
688838442147d9 Maciej Purski    2018-02-27  2185  		return PTR_ERR(edev);
688838442147d9 Maciej Purski    2018-02-27  2186  	}
688838442147d9 Maciej Purski    2018-02-27  2187  
688838442147d9 Maciej Purski    2018-02-27  2188  	ctx->extcon = edev;
688838442147d9 Maciej Purski    2018-02-27  2189  	ctx->extcon_nb.notifier_call = sii8620_extcon_notifier;
688838442147d9 Maciej Purski    2018-02-27  2190  	INIT_WORK(&ctx->extcon_wq, sii8620_extcon_work);
688838442147d9 Maciej Purski    2018-02-27 @2191  	ret = extcon_register_notifier(edev, EXTCON_DISP_MHL, &ctx->extcon_nb);
688838442147d9 Maciej Purski    2018-02-27  2192  	if (ret) {
688838442147d9 Maciej Purski    2018-02-27  2193  		dev_err(ctx->dev, "failed to register notifier for MHL\n");
688838442147d9 Maciej Purski    2018-02-27  2194  		return ret;
688838442147d9 Maciej Purski    2018-02-27  2195  	}
688838442147d9 Maciej Purski    2018-02-27  2196  
688838442147d9 Maciej Purski    2018-02-27  2197  	return 0;
688838442147d9 Maciej Purski    2018-02-27  2198  }
688838442147d9 Maciej Purski    2018-02-27  2199  
ce6e153f414a73 Andrzej Hajda    2016-10-10  2200  static inline struct sii8620 *bridge_to_sii8620(struct drm_bridge *bridge)
ce6e153f414a73 Andrzej Hajda    2016-10-10  2201  {
ce6e153f414a73 Andrzej Hajda    2016-10-10  2202  	return container_of(bridge, struct sii8620, bridge);
ce6e153f414a73 Andrzej Hajda    2016-10-10  2203  }
ce6e153f414a73 Andrzej Hajda    2016-10-10  2204  
e25f1f7c94e16d Maciej Purski    2017-08-24  2205  static int sii8620_attach(struct drm_bridge *bridge)
e25f1f7c94e16d Maciej Purski    2017-08-24  2206  {
e25f1f7c94e16d Maciej Purski    2017-08-24  2207  	struct sii8620 *ctx = bridge_to_sii8620(bridge);
e25f1f7c94e16d Maciej Purski    2017-08-24  2208  
e25f1f7c94e16d Maciej Purski    2017-08-24  2209  	sii8620_init_rcp_input_dev(ctx);
e25f1f7c94e16d Maciej Purski    2017-08-24  2210  
e25f1f7c94e16d Maciej Purski    2017-08-24  2211  	return sii8620_clear_error(ctx);
e25f1f7c94e16d Maciej Purski    2017-08-24  2212  }
e25f1f7c94e16d Maciej Purski    2017-08-24  2213  
e25f1f7c94e16d Maciej Purski    2017-08-24  2214  static void sii8620_detach(struct drm_bridge *bridge)
e25f1f7c94e16d Maciej Purski    2017-08-24  2215  {
e25f1f7c94e16d Maciej Purski    2017-08-24  2216  	struct sii8620 *ctx = bridge_to_sii8620(bridge);
e25f1f7c94e16d Maciej Purski    2017-08-24  2217  
710abfe8ead247 Ronald Tschalär  2019-04-19  2218  	if (!IS_ENABLED(CONFIG_RC_CORE))
710abfe8ead247 Ronald Tschalär  2019-04-19  2219  		return;
710abfe8ead247 Ronald Tschalär  2019-04-19  2220  
e25f1f7c94e16d Maciej Purski    2017-08-24  2221  	rc_unregister_device(ctx->rc_dev);
e25f1f7c94e16d Maciej Purski    2017-08-24  2222  }
e25f1f7c94e16d Maciej Purski    2017-08-24  2223  
ecba7cfa3afbe4 Maciej Purski    2018-02-02  2224  static int sii8620_is_packing_required(struct sii8620 *ctx,
ecba7cfa3afbe4 Maciej Purski    2018-02-02  2225  				       const struct drm_display_mode *mode)
ecba7cfa3afbe4 Maciej Purski    2018-02-02  2226  {
ecba7cfa3afbe4 Maciej Purski    2018-02-02  2227  	int max_pclk, max_pclk_pp_mode;
ecba7cfa3afbe4 Maciej Purski    2018-02-02  2228  
ecba7cfa3afbe4 Maciej Purski    2018-02-02  2229  	if (sii8620_is_mhl3(ctx)) {
ecba7cfa3afbe4 Maciej Purski    2018-02-02  2230  		max_pclk = MHL3_MAX_PCLK;
ecba7cfa3afbe4 Maciej Purski    2018-02-02  2231  		max_pclk_pp_mode = MHL3_MAX_PCLK_PP_MODE;
ecba7cfa3afbe4 Maciej Purski    2018-02-02  2232  	} else {
ecba7cfa3afbe4 Maciej Purski    2018-02-02  2233  		max_pclk = MHL1_MAX_PCLK;
ecba7cfa3afbe4 Maciej Purski    2018-02-02  2234  		max_pclk_pp_mode = MHL1_MAX_PCLK_PP_MODE;
ecba7cfa3afbe4 Maciej Purski    2018-02-02  2235  	}
ecba7cfa3afbe4 Maciej Purski    2018-02-02  2236  
ecba7cfa3afbe4 Maciej Purski    2018-02-02  2237  	if (mode->clock < max_pclk)
ecba7cfa3afbe4 Maciej Purski    2018-02-02  2238  		return 0;
ecba7cfa3afbe4 Maciej Purski    2018-02-02  2239  	else if (mode->clock < max_pclk_pp_mode)
ecba7cfa3afbe4 Maciej Purski    2018-02-02  2240  		return 1;
ecba7cfa3afbe4 Maciej Purski    2018-02-02  2241  	else
ecba7cfa3afbe4 Maciej Purski    2018-02-02  2242  		return -1;
ecba7cfa3afbe4 Maciej Purski    2018-02-02  2243  }
ecba7cfa3afbe4 Maciej Purski    2018-02-02  2244  
e7c2e4d368e2ef Marek Szyprowski 2017-11-09  2245  static enum drm_mode_status sii8620_mode_valid(struct drm_bridge *bridge,
e7c2e4d368e2ef Marek Szyprowski 2017-11-09  2246  					 const struct drm_display_mode *mode)
e7c2e4d368e2ef Marek Szyprowski 2017-11-09  2247  {
e7c2e4d368e2ef Marek Szyprowski 2017-11-09  2248  	struct sii8620 *ctx = bridge_to_sii8620(bridge);
ecba7cfa3afbe4 Maciej Purski    2018-02-02  2249  	int pack_required = sii8620_is_packing_required(ctx, mode);
e7c2e4d368e2ef Marek Szyprowski 2017-11-09  2250  	bool can_pack = ctx->devcap[MHL_DCAP_VID_LINK_MODE] &
e7c2e4d368e2ef Marek Szyprowski 2017-11-09  2251  			MHL_DCAP_VID_LINK_PPIXEL;
e7c2e4d368e2ef Marek Szyprowski 2017-11-09  2252  
ecba7cfa3afbe4 Maciej Purski    2018-02-02  2253  	switch (pack_required) {
ecba7cfa3afbe4 Maciej Purski    2018-02-02  2254  	case 0:
ecba7cfa3afbe4 Maciej Purski    2018-02-02  2255  		return MODE_OK;
ecba7cfa3afbe4 Maciej Purski    2018-02-02  2256  	case 1:
ecba7cfa3afbe4 Maciej Purski    2018-02-02  2257  		return (can_pack) ? MODE_OK : MODE_CLOCK_HIGH;
ecba7cfa3afbe4 Maciej Purski    2018-02-02  2258  	default:
ecba7cfa3afbe4 Maciej Purski    2018-02-02  2259  		return MODE_CLOCK_HIGH;
ecba7cfa3afbe4 Maciej Purski    2018-02-02  2260  	}
e7c2e4d368e2ef Marek Szyprowski 2017-11-09  2261  }
e7c2e4d368e2ef Marek Szyprowski 2017-11-09  2262  
ce6e153f414a73 Andrzej Hajda    2016-10-10  2263  static bool sii8620_mode_fixup(struct drm_bridge *bridge,
ce6e153f414a73 Andrzej Hajda    2016-10-10  2264  			       const struct drm_display_mode *mode,
ce6e153f414a73 Andrzej Hajda    2016-10-10  2265  			       struct drm_display_mode *adjusted_mode)
ce6e153f414a73 Andrzej Hajda    2016-10-10  2266  {
ce6e153f414a73 Andrzej Hajda    2016-10-10  2267  	struct sii8620 *ctx = bridge_to_sii8620(bridge);
ce6e153f414a73 Andrzej Hajda    2016-10-10  2268  
bf1722cab55a32 Andrzej Hajda    2017-02-01  2269  	mutex_lock(&ctx->lock);
ce6e153f414a73 Andrzej Hajda    2016-10-10  2270  
ecba7cfa3afbe4 Maciej Purski    2018-02-02  2271  	ctx->use_packed_pixel = sii8620_is_packing_required(ctx, adjusted_mode);
ecba7cfa3afbe4 Maciej Purski    2018-02-02  2272  
ce6e153f414a73 Andrzej Hajda    2016-10-10  2273  	mutex_unlock(&ctx->lock);
ecba7cfa3afbe4 Maciej Purski    2018-02-02  2274  
ecba7cfa3afbe4 Maciej Purski    2018-02-02  2275  	return true;
ce6e153f414a73 Andrzej Hajda    2016-10-10  2276  }
ce6e153f414a73 Andrzej Hajda    2016-10-10  2277  
ce6e153f414a73 Andrzej Hajda    2016-10-10  2278  static const struct drm_bridge_funcs sii8620_bridge_funcs = {
e25f1f7c94e16d Maciej Purski    2017-08-24  2279  	.attach = sii8620_attach,
e25f1f7c94e16d Maciej Purski    2017-08-24  2280  	.detach = sii8620_detach,
ce6e153f414a73 Andrzej Hajda    2016-10-10  2281  	.mode_fixup = sii8620_mode_fixup,
e7c2e4d368e2ef Marek Szyprowski 2017-11-09  2282  	.mode_valid = sii8620_mode_valid,
ce6e153f414a73 Andrzej Hajda    2016-10-10  2283  };
ce6e153f414a73 Andrzej Hajda    2016-10-10  2284  
ce6e153f414a73 Andrzej Hajda    2016-10-10  2285  static int sii8620_probe(struct i2c_client *client,
ce6e153f414a73 Andrzej Hajda    2016-10-10  2286  			 const struct i2c_device_id *id)
ce6e153f414a73 Andrzej Hajda    2016-10-10  2287  {
ce6e153f414a73 Andrzej Hajda    2016-10-10  2288  	struct device *dev = &client->dev;
ce6e153f414a73 Andrzej Hajda    2016-10-10  2289  	struct sii8620 *ctx;
ce6e153f414a73 Andrzej Hajda    2016-10-10  2290  	int ret;
ce6e153f414a73 Andrzej Hajda    2016-10-10  2291  
ce6e153f414a73 Andrzej Hajda    2016-10-10  2292  	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
ce6e153f414a73 Andrzej Hajda    2016-10-10  2293  	if (!ctx)
ce6e153f414a73 Andrzej Hajda    2016-10-10  2294  		return -ENOMEM;
ce6e153f414a73 Andrzej Hajda    2016-10-10  2295  
ce6e153f414a73 Andrzej Hajda    2016-10-10  2296  	ctx->dev = dev;
ce6e153f414a73 Andrzej Hajda    2016-10-10  2297  	mutex_init(&ctx->lock);
ce6e153f414a73 Andrzej Hajda    2016-10-10  2298  	INIT_LIST_HEAD(&ctx->mt_queue);
ce6e153f414a73 Andrzej Hajda    2016-10-10  2299  
ce6e153f414a73 Andrzej Hajda    2016-10-10  2300  	ctx->clk_xtal = devm_clk_get(dev, "xtal");
ce6e153f414a73 Andrzej Hajda    2016-10-10  2301  	if (IS_ERR(ctx->clk_xtal)) {
ce6e153f414a73 Andrzej Hajda    2016-10-10  2302  		dev_err(dev, "failed to get xtal clock from DT\n");
ce6e153f414a73 Andrzej Hajda    2016-10-10  2303  		return PTR_ERR(ctx->clk_xtal);
ce6e153f414a73 Andrzej Hajda    2016-10-10  2304  	}
ce6e153f414a73 Andrzej Hajda    2016-10-10  2305  
ce6e153f414a73 Andrzej Hajda    2016-10-10  2306  	if (!client->irq) {
ce6e153f414a73 Andrzej Hajda    2016-10-10  2307  		dev_err(dev, "no irq provided\n");
ce6e153f414a73 Andrzej Hajda    2016-10-10  2308  		return -EINVAL;
ce6e153f414a73 Andrzej Hajda    2016-10-10  2309  	}
ce6e153f414a73 Andrzej Hajda    2016-10-10  2310  	irq_set_status_flags(client->irq, IRQ_NOAUTOEN);
ce6e153f414a73 Andrzej Hajda    2016-10-10  2311  	ret = devm_request_threaded_irq(dev, client->irq, NULL,
ce6e153f414a73 Andrzej Hajda    2016-10-10  2312  					sii8620_irq_thread,
ce6e153f414a73 Andrzej Hajda    2016-10-10  2313  					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
ce6e153f414a73 Andrzej Hajda    2016-10-10  2314  					"sii8620", ctx);
e0ba12ea5e1329 Andrzej Hajda    2017-02-22  2315  	if (ret < 0) {
e0ba12ea5e1329 Andrzej Hajda    2017-02-22  2316  		dev_err(dev, "failed to install IRQ handler\n");
e0ba12ea5e1329 Andrzej Hajda    2017-02-22  2317  		return ret;
e0ba12ea5e1329 Andrzej Hajda    2017-02-22  2318  	}
ce6e153f414a73 Andrzej Hajda    2016-10-10  2319  
ce6e153f414a73 Andrzej Hajda    2016-10-10  2320  	ctx->gpio_reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
ce6e153f414a73 Andrzej Hajda    2016-10-10  2321  	if (IS_ERR(ctx->gpio_reset)) {
ce6e153f414a73 Andrzej Hajda    2016-10-10  2322  		dev_err(dev, "failed to get reset gpio from DT\n");
ce6e153f414a73 Andrzej Hajda    2016-10-10  2323  		return PTR_ERR(ctx->gpio_reset);
ce6e153f414a73 Andrzej Hajda    2016-10-10  2324  	}
ce6e153f414a73 Andrzej Hajda    2016-10-10  2325  
ce6e153f414a73 Andrzej Hajda    2016-10-10  2326  	ctx->supplies[0].supply = "cvcc10";
ce6e153f414a73 Andrzej Hajda    2016-10-10  2327  	ctx->supplies[1].supply = "iovcc18";
ce6e153f414a73 Andrzej Hajda    2016-10-10  2328  	ret = devm_regulator_bulk_get(dev, 2, ctx->supplies);
ce6e153f414a73 Andrzej Hajda    2016-10-10  2329  	if (ret)
ce6e153f414a73 Andrzej Hajda    2016-10-10  2330  		return ret;
ce6e153f414a73 Andrzej Hajda    2016-10-10  2331  
688838442147d9 Maciej Purski    2018-02-27  2332  	ret = sii8620_extcon_init(ctx);
688838442147d9 Maciej Purski    2018-02-27  2333  	if (ret < 0) {
688838442147d9 Maciej Purski    2018-02-27  2334  		dev_err(ctx->dev, "failed to initialize EXTCON\n");
688838442147d9 Maciej Purski    2018-02-27  2335  		return ret;
688838442147d9 Maciej Purski    2018-02-27  2336  	}
688838442147d9 Maciej Purski    2018-02-27  2337  
ce6e153f414a73 Andrzej Hajda    2016-10-10  2338  	i2c_set_clientdata(client, ctx);
ce6e153f414a73 Andrzej Hajda    2016-10-10  2339  
ce6e153f414a73 Andrzej Hajda    2016-10-10  2340  	ctx->bridge.funcs = &sii8620_bridge_funcs;
ce6e153f414a73 Andrzej Hajda    2016-10-10  2341  	ctx->bridge.of_node = dev->of_node;
ce6e153f414a73 Andrzej Hajda    2016-10-10  2342  	drm_bridge_add(&ctx->bridge);
ce6e153f414a73 Andrzej Hajda    2016-10-10  2343  
688838442147d9 Maciej Purski    2018-02-27  2344  	if (!ctx->extcon)
ce6e153f414a73 Andrzej Hajda    2016-10-10  2345  		sii8620_cable_in(ctx);
ce6e153f414a73 Andrzej Hajda    2016-10-10  2346  
ce6e153f414a73 Andrzej Hajda    2016-10-10  2347  	return 0;
ce6e153f414a73 Andrzej Hajda    2016-10-10  2348  }
ce6e153f414a73 Andrzej Hajda    2016-10-10  2349  
ce6e153f414a73 Andrzej Hajda    2016-10-10  2350  static int sii8620_remove(struct i2c_client *client)
ce6e153f414a73 Andrzej Hajda    2016-10-10  2351  {
ce6e153f414a73 Andrzej Hajda    2016-10-10  2352  	struct sii8620 *ctx = i2c_get_clientdata(client);
ce6e153f414a73 Andrzej Hajda    2016-10-10  2353  
688838442147d9 Maciej Purski    2018-02-27  2354  	if (ctx->extcon) {
688838442147d9 Maciej Purski    2018-02-27 @2355  		extcon_unregister_notifier(ctx->extcon, EXTCON_DISP_MHL,
688838442147d9 Maciej Purski    2018-02-27  2356  					   &ctx->extcon_nb);
688838442147d9 Maciej Purski    2018-02-27  2357  		flush_work(&ctx->extcon_wq);
688838442147d9 Maciej Purski    2018-02-27  2358  		if (ctx->cable_state > 0)
688838442147d9 Maciej Purski    2018-02-27  2359  			sii8620_cable_out(ctx);
688838442147d9 Maciej Purski    2018-02-27  2360  	} else {
688838442147d9 Maciej Purski    2018-02-27  2361  		sii8620_cable_out(ctx);
688838442147d9 Maciej Purski    2018-02-27  2362  	}
e25f1f7c94e16d Maciej Purski    2017-08-24  2363  	drm_bridge_remove(&ctx->bridge);
ce6e153f414a73 Andrzej Hajda    2016-10-10  2364  
ce6e153f414a73 Andrzej Hajda    2016-10-10  2365  	return 0;
ce6e153f414a73 Andrzej Hajda    2016-10-10  2366  }
ce6e153f414a73 Andrzej Hajda    2016-10-10  2367  

:::::: The code at line 2355 was first introduced by commit
:::::: 688838442147d9dd94c2ef7c2c31a35cf150c5fa drm/bridge/sii8620: use micro-USB cable detection logic to detect MHL

:::::: TO: Maciej Purski <m.purski@samsung.com>
:::::: CC: Chanwoo Choi <cw00.choi@samsung.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--NzB8fVQJ5HfG6fxh
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICF3VaGAAAy5jb25maWcAlDxbc9w2r+/9FTvpS/vQfL7FTc8ZP1ASJbEriioprb1+0bjO
JvU0tvP50jb//gCktCIpaNPT6bQWAII3EDeC+/1336/Y68vj/c3L3e3N589fV592D7unm5fd
h9XHu8+7/11lalWrdsUz0b4F4uru4fWf/9ydvj9fvXt7/vbop6fbs9V69/Sw+7xKHx8+3n16
hdZ3jw/fff8d/Ps9AO+/AKOn/1l9ur396ZfVD9nu97ubh9Uvb0+h9cnJj+4voE1VnYuiT9Ne
mL5I04uvIwg++g3XRqj64pej06OjPW3F6mKPOvJYpKzuK1GvJyYALJnpmZF9oVpFIkQNbfgM
dcl03Uu2TXjf1aIWrWCVuOaZR6hq0+oubZU2E1To3/pLpb1BJJ2oslZI3rcsqXhvlG4nbFtq
zjIYRa7gP0BisKldxsJuy+fV8+7l9cu0WIlWa173qu6NbLyOYYw9rzc90wUsgxTtxekJbsY4
WtkI6L3lpl3dPa8eHl+Q8di6UimrxkV984YC96zzl9BOqzesaj36km14v+a65lVfXAtveD4m
AcwJjaquJaMxV9dLLdQS4gwQ+wXwRkXMPxpZ3AqH5beK8VfXh7AwxMPoM2JEGc9ZV7V9qUxb
M8kv3vzw8Piw+/HN1N5szUY0KdG4UUZc9fK3jneeaPtQbJy2lSfOWhnTSy6V3vasbVlaTsjO
8Eok0zfrQDdEy850WjoEsmZVFZFPUCvdcFBWz6+/P399ftndT9Jd8Jprkdpz1GiVeMP3UaZU
lzQmLX2xQ0imJBN1CDNCUkR9KbjGiWznzKURSLmImPXjj0qyVsPaw/zhRIHGoKk0N1xvWIun
TaqMh0PMlU55NmgMURcT1jRMGz6Mbi8ePueMJ12Rm1AMdw8fVo8fo52Y9KxK10Z10CcowzYt
M+X1aDfbJ8lYyw6gUTt5suZhNqBXoTHvK2baPt2mFbHlVn1uZnI1oi0/vuF1aw4iUXeyLIWO
DpNJkASW/dqRdFKZvmtwyKMot3f3u6dnSppbka5BU3MQV49VrfryGjWyVLW/YQBsoA+VCepM
u1Yi89fHwgIWoihRjOyKaXq/Z8Odmjeac9m0wLfmlFoZ0BtVdXXL9NbvekAeaJYqaDUuWtp0
/2lvnv9cvcBwVjcwtOeXm5fn1c3t7ePrw8vdw6doGaFBz1LLIxB+FG8rHwFyP6zEZKhIUg7a
DSio8aHRNS2zwrNvh0A4NhXbzpqFNFeL6MYIcgP+xdTtEum0WxlKqOptD7hpCeCj51cgO56Q
mYDCtolAOOuBz35oYZf7JV67P7xFX+/3VqU+uATdBIJ3cT+5EOgr5KCxRd5enBxNQiHqdg0O
RM4jmuPTwK504GY5xyktQf3ZczoKkbn9Y/fhFVzN1cfdzcvr0+7ZgofJENhAQV2yuu0T1G3A
t6sla/q2Svq86oxn+waHEEZ7fPLeAxdadU0gMmA804KUBEfsZnCIoBGZOYTX2YIfMuBzOGnX
XB8iyfhGpPwQBYjnokiP4+Q6P4RPmoNoa41IAvR0wJrBaaXblzxdNwr2ApUc2FF6Ik5S0F+1
/dE0W5MbGAkoJ7DIC9ui8fwTGiOpUDdsrFnTXkxgv5kExs66ea6xziKPGAAzdxNgi64m4Bbc
TNuKdjEtinIvE6VQIYenGkRdNaBLIdBBb8Nus9KS1Sn3RxmTGfiD6CL2MN1pFtnxuaelLA0o
r5Q31u2B5Ut51KZJTbOG0VSsxeF4MUiTTx+xAox6kuBMC/BjPdfLFLyVqMJnjoUTjhk4L1kd
2F/nUTtb60Gtaou/+1oKP3wKrBSvctiNBXGO5k/SJAwcwLyrKmIj8q7lV94s8BNUjbd0jQpm
L4qaVXnmmw+YoQ+wjpIPMCVoP39GTNASKVTfwXoUxDhZthGGj8vuLSiwTpjWwt+8NZJspZlD
+mDP9lC7QnigW7HhgQx5Gz2tJ4B/hYiaVZdsa8CHI8aL0mSDNH8hrGVBgzENGvjXqd1e7/Qb
HjjrViVaKNERcOJZ5icf3LmA7vvY7bVAGFm/kTbaCFy09PgoUAbWWg6pnGb39PHx6f7m4Xa3
4n/tHsAhYWBHU3RJwF+c/A+yWzd+svPBGv/LbqbRbqTrxfmNkTc7il3VJa5vPzEjGwaG3SZh
Jn1fsWSBQUimEtpeQHvYU13wMTQnuQERGuFKQDCjQVsoGQ9iwpdMZxBV0KbHlF2eg9fTMOhx
HzfSarbl0gZgmBYTuUhtBBn65ioXFX3qrMa1NtX42xVmn0biq/fn/amXu4Fv3/q5hBjq8Yyn
EMB651V1bdO1vbUn7cWb3eePpyc/YVLRTzatwR73pmuaIEcG/l+6tsOc46TsorMn0Y/TNVhX
4UK5i/eH8Ozq4vicJhgF6Rt8ArKA3T4CN6zP/MTWiAjk1nGFeGMwen2epfMmoKhEojFgtsEJ
oXgwUEI9d0XhGLhGmCXl1moTFCAncNb6pgCZiVM8hrfO+XPBmObelGoOLteIsgoLWGkM6cvO
z8kGdFa4STI3HpFwXbt8CJhaI5IqHrLpTMNhExbQ1sW3S8eqvuzA4FfJjIMVKTOqMBjSqLtI
ss6mpTzVl4MLwJmutimmbbjnnzSFi1wq0GNgz06ikMIw3AYUblxrnrq8kNXJzdPj7e75+fFp
9fL1i4sRgwhnYHQNcXq/FBMYSWU68QTnnLWd5s7bDg5zLxubS/LkTlVZLmxA5LnFLXgMgswR
IBMngeDZ6cCmIopftbBdKAKHvBmkBIWEydHG0KEAkjA58SECm73HYfJeJp6/M0Jiy+G0Wy+0
COI6F04oCe5ADt49nE3UlpxSxuUWRBu8GPCKi477+SNYVrYRVnVNanmAzQOi0XkBGxjxcam1
psNEEEhR1Q6+28R0U9LZ5o0cRDzOA8ajibIpVEZnJB2j8SkGPnt/bq5I/oiiEe8OIFqTLuKk
XOjpfIkh6AqIAqQQ30AfxtNCO2LPaOx6YUjrnxfg72l4qjuj6EBB8hysPw+d1Ql7KWrMjqcL
AxnQp7Q/IsGiUE6wLDgY+uLqOJACC+yrhe1Jt1pcLS7yRrD0tD9ZRi4sGDrYC63AdVpWNINl
XdBl9qTXOBtnO12O6swnqY6XcWCti1qiF+sHo4gBwQ4BqWyu0rI4P4s0sqiF7KRVqjmTotpe
vPPx9kxDEC2N520JBnoM1XwfhOBIv5FXMwPgO4qYKcWgnleczJbiOMAYOv3sed0D2O5t4COO
GNDWc2C5LVRNcIEVY52eI8ANrI3k4OtSXXQyJeHXJVNX/t1M2XCn53QQhElBTLi2vopBdx68
lYQXwOiYRoJpm6OGcGGGmAAwwgo9uvCWBDcLl60R6Qwo1BxsL2sJcoi450DNNXjkLn8z3Cjb
lJDQv5nYZsvQrDoHxQvj7h8f7l4en1zKfhKlKUwcbHlXxymORVLNmtCozShSzNh/i5l1ENTl
sMtDZLMw9GApecHSLRwVP7wZvoKlOT4Ht3/ZhVFNhf/hC25Oq0BjJLT3Jt6vFzSS5rhT4HW6
9POo40QKZze4NNyD4rM6IYIzOYHB53OKLw+ycVYYfDUzOHsim/L9tcI7qCgZNIDO6KTvRpqm
Aufq9FtoTDseJDk5zOFkxiEiOPacQRubqDyHoOfi6J+zI/dPuMENW3aBGbr2LcT5IvW2ybpv
OZx2WA5QF4yIaKwDvoy2enm8qMdbYm9jRYWSW40OKl6udnwqkrEDwxQ6BKvKYEZKd82QK/BI
ULzQw5NjLxOhax6rEry1xlucy4vzvfGTrQ50K35jxCNasXRD4VaU3mE7d5dQWVhxA/F4pCel
zbcTUUVrruzS4f4esPs+Yf0NTnjbQI6c57SfY3iKmQMqiLjuj4+OgvNz3Z+8OyLZAOr0aBEF
fI7IHi6OfVle8ytO1pGUWyPQqoAoazwGx/Ep0NxmplBQD7W3bhC0P4maD7mTTWboxUtlZpMV
IJJUZhtWXuTbvsraIIc7KvoDQbQzYo9/755WYAluPu3udw8vloSljVg9fsGCNi/pOeQZvKTU
kHgYrtzmCLMWjc38eipF9qbiPBBKgKHoWDgdlsn+kq25LZmgllgG/KOIFrlnG7zAyQgUFoPN
ZzaOct/AH4pLw+mWlBZwUqsgGrz8zZnf3gYmAt3g5eRpmGbBbfBU3+xrtNFW9AwoH7XumkhX
SjA77VCdhE0aP6FmIUPy1A3SehTGyzFO2gdp7XIUZNjveDWpdsOJO4n33A0GbG1uXNdLLDXf
9GrDtRYZ91NcISeeUvU9PgWL552wFuzDNoZ2bRsqOgveQO9qiXXO5g1aRseQbhlBkJeY2RhH
c5AaY6KxTZGJ8/wW0WGFTIicjVQ0ktbOEVNWFBrkjc7AuzmX4OWxKuo57QyEnn1mQEPlovIv
hPcZ12HJMFHYNYVmWTz8GEeI5YE5pCiAasGq2jEqiLVAyS5OrQR3oOqKKegI25uEzie5tgvX
G/7qQDhXqgNkmmcdKjC8L7lkGo1xRd3KTwedNdxTFyF8uIcNu0AEOYCsafP5GfU0osDLcJAN
sZB1GZcY/ibPp3V65DwWNQtuA2sCB2ispVrlT7v/vu4ebr+unm9vPgflU+OpCuNie84KtcFi
Twz32wX0vE5tj8aDSJvtkWKsYkVGXjXB/6MRLr2BDfz3TfBa1taQLCQvZg1UnXEYVkbO0ScE
3FCguTnIPJrtwsLup0b2+69nEs2A3sJp3Bf3k8x8jGVm9eHp7q/gshfI3DK0U4g3wWz2PeMb
2jduZiF66Opjzb5jtZzhH6zCQSK7kLW67MMUK0nxcxgieIjRxwhzg1fWP5KhevKjjobzDHwI
l7LSolZhB3N87CKEVCItp4UOUQb0VoBqzlz+HUY3C8ntBtW2ZDi8rgVPqS50NwtnEFyCpC+u
Mp8EVs800PMfN0+7D3O3OZyBqyEPuE5Ie2WJBX6scVFmOJKpdpJQdXuJFh8+70LFN7gDwQGz
dyd4MCqWZaTdC6gkr7tFFi1fiFx8ovGehjRaDjXe6fgBzH5GXlrIniwkJJfn2xGNXark9XkE
rH4AD2G1e7l9+2OQvQO3oVCYJlgoSUK0lO7zAEkmNJ1GdmhWez4ogrDHEOI4hLCx4yA4AXha
JydHsOa/dUJTTiZexCed/1zH3cxjgtTnBWA6Zk8xgiVRqmroiyoIfelrkJq3794dHVNel8z6
en5UtiZPyF1f2E631XcPN09fV/z+9fNNdDiH4Pv0xJe5OX3oRoHDhhUNymVbbBf53dP933D+
V9neekzZj4zSnLnQ0npykssgbZNf9mk+1N/R0DEl4N9Qq6Lie54zBCadbW7bKd77CI1Vu2Af
lUXtxz0yxfvepMtzLFgY+BDzmbHaExM8Nw21JDwX+yqCcWHb3aenm9XHcXmdcfYrnBcIRvRs
Y4KtXG+81AHe5nb4xG1WO4T3xqD3taI94A0+UEJZPoDdGBWr8wDv3h7xOhP4hM/G9TMLM9Yj
3Tzd/nH3srvFNM5PH3ZfYKqo52aWJ9XMlFHRnZ22csVQHniEYGQwd8TXrt6DHP6vncSrm4RT
mn1WKGK7nzIhXW2zYlipnGKYGSUvsIwOH9m1ou4Tc8nix3QCpoYlSESdzprseY1lGxRCNTR8
YINPDXOqLjfvalfsZaUDTNOvPA2zyZYsqHudnopZjqVS6wiJ6hhDUlF0qiPe8xhYcmtY3UOo
aNVsCZPSLaYFhxrsOQEEO0NqewHpbE4vZ4vuRu7ebLpit/6yFK2t54t4YemR6bNtzVBh2qci
rkVEd3qSiBYT0f3sRZ2RmOEc3l/GuwMxp+kZJhqxgmiQocGQBXTGj/zCjcO3oosNXS7Ph5SX
fQJTdxX4EU4KdN4mtLEDjIgwoMHqoU7Xfa1gk4KS3riolZAcTAGgy2sfEbiSKduCYkL0P9an
6mHRsk6SOzyd68NYop5Yyq4vGGaDhrwNJohJNL7aoUgGSXQnxz2QGUoD4sEM6mMQRLywirfQ
tXNXwwu4THULdXOiSXv3snB8GUwsxnCNMdQNkhS41BXIRYScVb6NmnuojgvQ9kmal2SP204u
WtgM1kaRJUzT+C5FW4KOdRJhDX4sNvQTs0D6FUqXjCu0R0VX46Ue6nwsQQz3aVpuxCGP3pRs
ZrVAD4zXgzzFGl9PpFTWYQocDQa+I9C+1O7VmsXY+7Og7nMaZlAXGxutK1BRpL4NW70PJUw1
21FZtlXkdYMbHuocCGXxogc2Aby4zKPGy2gjiuGe4nSGYJHR2bu1qFdx2yglD6E4HJnhBba+
vPJFaxEVN3crTzanUNNaN7BHpyfj5Vmo3PfGHyxUYOH3Io4K0C+NJ9P+3jME8KxSvW32Ty+L
VG1++v3mGQL2P11R/penx493YdIQiYZFIBbAYke3KXyTexjj6r/7s/5nP+g4NKJ93Fd1Bb7Q
BocxTePfHMCfi3AEZBH7N5zGkZWGfcPHMb4CsM9GDD5nmOp1hs01GJq4evb4MMYA93gbds4/
QAOqqwfwdFfut3Fouq5tcg6W8HacOt3/hgOZg5jmQ4ximCWZhPRIovczHgbUGRXkhhQnJ2fL
zU/eLZQsBlSn7xcqLwOqd8cnhwcD4l1evHn+4waG9GbGBZWL5oY6cgMFFo9fgjtkDJiJ6UFj
L6S92Jy2v6vhlIMG28pEVTOJMWA3OJ/uNfcDSaqFCzRTH/vM3Q+bgL2AQ4MylMbV9dNVq4vp
IXwmtJD9tYjMsrFX0Msk+pIisOpyfP/UJzzH/6ELFv7AwXSNblUU/2d3+/py8/vnnf1NmpUt
2HrxwrtE1Lls0apNPOAjjPcGIpNq0bQzMGyRZ0Wx5eAO7tXH0ijsEOXu/vHp60pOubZ50cCh
Wp2xCEiyumPB2ZkqgByOSqC4xiG33papunaeWzuxswVJ3pydZ8GlFamh9SzkyfF3GYouYIi1
Uk1rW9lKxqnqx001wUPg2+QB4GwzZa8jmBSFZiHIlaarMH+3Nt4ajFc11idxv+GQ6Yuzo1/O
vZI7whmjaj79Vyprr48UHNnaVvv6O5YuPMG4bui6leuk80rmrg3xVG94OgJTaaIa/In70G52
DxdFzDatNOYLgjRnNj4ww2B8Tdf6uycPm5mjDatjy2vxhxPI4RX4EBxcj1IyMhm7Vw9Ny51b
68cow8QxFG+3fcmrxr2x3R/O5fM3baL/iGyduMcnYyxtD3G9e/n78elPvPqanV4QyjX3rr3c
NwyIFRMQ9Kzn4eEXqJug9tHCsBGxBM4rnoSzMsvPWBDZKv/iKPffQuMXZhFCF8NCWVWoCGQf
Qt8HoKne00tZWozpkh7f+6TUpbulcMc1GhtZ/+i6avDMezWjHP1tLxkzADy+k3KUZKV+1vSY
ZOS+gfWA0a4JJxrTQWjc+3D8aRjq2qCZqqhs2bRfaY+hbwIHSPB+9iMiI9+mGn79i/IbgMjV
YjtS1pYRC4cFFy5RhnzgBCFC3QRDgu8+K9Mm4oRgW925yAViRN2EGyEaEe2VaAqN7w9ldxWT
9m1XByHDnn5iAe4AKH21Fr6f7Og2rQi76jKaZa66GWDq3o81EcnKCAA+WbA0A2w8QHRF9kAE
ByUlF9BNIRRtC7RCP8wixJDAuaz20CMFxtUhwJpdjuBw9AiEfcOkCHWWsRf4s9hL+7Rqe1QC
DoTHdg9PO8DQVe4jySV0fKnIq/Q9TQl/TbOZwKZNG2I05TapGEG/4QUzBH29IYBYOBpeDe1R
FdUpRN6KoN1yX8z2YFGBH66EIVctSyNZIhY2o63/tCMJdYM9OkPjSkwVTQMCXCCqqG9Ej+wv
3vy1+3Tz/Mafl8zemeDXgJrNeahpNueDosRUB/1bMJbI/Y4I2og+Y5RgoNie4/m9DyF4gOeg
vQGMULNTiX1L0fwfZ0+23DiS468o5mGj+6FidFi2tBH9QJEpiWVeJlOH64XhLmumHOOyK2zX
bvffL5DJA0gipYp9qEMAEnkwDwAJIK9dQu9KvR7sQoYH268MpIr1EFJfsywxCM0iUD+MzK3v
C+UgxbrYHmogbBNsIXJh5xgafC0441HflCU5y8F8UPHgwPJqc10nh65uhztiQQ6Uju6egKVz
gTF3DPBpwfYA83Mw9SwUqxqkuqQX75iiE03XHtEU98pCF5hsFNT4NZdMTNlie29si3Dkp4WT
cgxorDVc4Ax9bA3lvUbfwOpdupUP5igM3TMFQe0mb0RZBIzCMI7eB1lZqQhgyiHZ9IznKKWb
iS4H3tr6tjQJP7YPX//DLIst8969nPJ0SpFCVagLuoni7zpabep89TnM5E9taZotzcocdnLA
FiYMtZccbVhMCvURupnzeIlfbIFQM/30tnLnfC8jSbaENR+SowpvdFIFRWvuiUUQIFLIxw2S
GDOydGoYLJdEAk20E/gBiylm36+FYRbDOBQjYZAkCejFD0LSIg9YPfWqnF4vrlzmFgpTZ7ga
e1v6VBSGK012mg0TidOSm+PKOBJNCPYGD1dqxdJkWMB3BwD78qZejKeTOxkVlMvZbCLjVmWY
tm66XoIzReGINhEg39kW1tFsqoOYM5fSeLukvJhU38qI2+qLjMhDleRaxt2Fnmpg+ixn45mM
rD4Hk8l47uu5LoM4EbfxPbBtPtffQ1i92dMZQxApQ0QqzBRzEbKQRnYS6k0SYr6DH1M+54NE
DBqdzkmhoFgRm8Y2z6iN4zrJD0WQUa4N6EyISUuRbcMBJwQajUNiibh1GWwwPv4833qbFzJv
IwCImDRfxUms73014yD7TGuUzrcjtjQboFFHXW+jEpt5piMby23YXETgFmi6craCyCfUSMQ4
tr9MPBDvemlAKYXTdy7fr9gjyRfoEYVS2q0oQ/+QKsfk4tRKrNMAzbbMobyHtv/dizVRukS2
xxKSSDSZEoIs9DQida1EInsp4bKH7BKR8Xs831i03zpSaA57+h62bh1KQuW+tZaR+banxrIz
ZfBSqsCL+n4i76075z4NY8q6xcaljvPLCOkQw4z+jmSRFoljOEIInFM51wQAJqxxUiyriF65
rUp+SNixs9ENBJzM6hQmgMK1uHfEfpg0bs7fBtlkPjWKRelJjUhorOIhKcTmeDjiLch9zdM2
ru7oD5u/0LFzjz5O7zy1smnQrd6ozJFRyhz0/DyLW6t/I6MPGDkIaknve7YN0jKIYklyDAN6
FQTTuQwO7GoFQKtQCvpGzObAC3+eLGfLLsQlyEbR6X+evlLPZEK8D3nsooEdw0AO5EJslZzD
wnw4g8PMS9a4L6flFlrbfUxmrF5hbkMVidolTE/l0DZ7vbzJIL2oOACmUsla29xTtEALrlUY
yZmmKJGThIzSCFuk9Vh//nn6eH39+DZ6tMMxCEqCwtswXukKphTdwCx8F5Se7dmgI51I7ggt
z1k45LhKdioMSmk5WoI9/HGKpeVeuvlDjL7tGt463fu6TIS7NSz7UnztAVC3VMCvdKmC1Lru
kdMVrylK7pxyiEuVMNfjcL3Bo54pu1liQMaggpfY0lpsiuEMByEdb07xBRXYepmpqSMLFbro
Npkq6zzbSXOwoy4VBnQY9wz0dyzVJloNm2x8EVq3LSTBKySha53eXshtO3d09x0oo6D1oDhP
eQABS/IWCUI70N9diLkTLamDX4soQ7zWxs+byNjuBvxXqP74x/enl/ePt9Nz/e3jHwPCVNEs
6B0Y9wt2zLYIv35AWVbtbTPzoeRM2oArF5nl7mM9Haq5HHNzHPQ1J6mqB/kMOnSlA28Ovv6z
6DMc8nB1mUO8qipvE4vqDHsQZs7IioQs0NvL7Ui3h1RI78A+vXXa+ZU6kTisfmEADeXZbuoo
qS7zwa+FXlqYbdWmMSUZRQ4xQIXS5fo2ptKS/T2Yzg04zoqdvK4bgk0hSjMoOi2d+9Nl0ci5
rrC4FDLhdyJDvKYHCv4+S4wMUR51y+wqSf0KVbGt2Ys+LQSNQVrfuymVWyxusbLulq2ZvgQ/
QWrfxFp0X0Jsxo/MBlS7pzdB4yHrVFFtoyQcSBDZ6eFttH46PWNe6e/ff748fTXG6dFvUOb3
5oxlYWrIK1UxmvU9la+p3t4A6ngacmCRzWczNigWZCgZGIOmwpiXtrAh1+xYiMNlwUgvK+bI
crY+lNl8SNOJ7b80VJ29qApgK1J8gsdrApDugFqY+y5Eg44wBKxxqWpAoAnBpEtcPQ/1xDqt
NhwK856/+2ZcmtD1igg/QZzkbMIqvdVA0uqYPcJ6vDsKlE+PsMSxMfF2/VVO/CilLULi8+7+
aN6Q4hGwCmUM6/XWK1RNSg4sgyRCbQgO+EVTA2oitcQ5gyQg2Zdifh8sXhXpgGVlEg8N8voM
ic5nc+BkKF0NiQekUpoF04kidSFREbo0etCZenWQ68N3vvjH8j38hTgTgVw5zL07uEnSonfU
MAuQQPOJYBz/UVzvH+5g3ON87+FdlLFLXASyfcHU40Q+9ZNNBFoPzju6PQ2xdbYvA0mNp6Tx
KvXNchPEfr50WPADwsXVX/R8PhfzobmUjeukj1u1LYanDgZef319+Xh7fcY3hwZaKxZca/jb
Se6GcBMG609EaybmETP4H/sN6f3p3y8HjO7FisNX+E/188eP17cPViVM+4O7Dg6mvsHMBzjm
8zBIXyNs/oHNwVkJIA5k7Cr3TOvsufvweMIEnIA9kVHDZ8naPvDGhUGkYJHLLeyNKBfZdpkS
5K/VfUn18vjj9enFbQhGKZv4RrF6VrBj9f6/Tx9fv12cG9WhMTlqxR7OOM+i54AWCrqBpGEc
uL9NBEodxlQthmL2dGka/Onrw9vj6M+3p8d/n0gT7zElb8/P/Kxz9nyRhcEUziWTs8VqsodY
CMx69FlRLrzJjkpmWnR9M10SP4jFdLyc0i5iX/AK3nV0L4MitiYXDqh1Fd9MJ0O4cc5B/458
p/+YjV20zcyJdlh9rNuwjl5FaJmk2LmNnCe/I+KSdl/DLsXYozgcNg49qrMh2MSX1KHVAuwD
cg8/nh5BT6ns7Hkcpmcg4zC/kdNUdLWC5nYUNSvC43rBfBJIUdjcpMCblqQ8GpIZtYp5mt+n
A3j62ghko9x13t7Z+DjrN94PLwPXxte2jySDkdNpsXa85SysTjHSTvbs0EEWBYnP8QMUKlNn
l/PCvJw7OD26XA3Pr7CHvfU9WR/MomWWvBZkJN0I384jcu1Rl0GfDaPvXl/KREC7QyOiQW5O
EnPVQ8akpzwTDYU5O7owCTcfRdPHzoBpQqbwQTUWhdN9AmM6L+O9eCXeWdZLVQ2LGSO0LQtK
K4bpyh8pre/yqr7d4SvKnjeSDavAmkUsQ/tALZnwtnyL9b623L3lgq+o7HTueegW0ftdgo+X
mJts5i9dqg2L1bG/uZ7ZwKokTnGH/+7CCxpf3wAPkwFdmsb5sCL6FG7LENZIhDblYVVhSIRb
3BhNkLOZums3CTvMXnPUmwwR4jnrWf1dbqNew2/XaIxqK37mVpEiqXNcJRf+yWy4S58rJqNG
8lRH7If5zlW76xYPbx9PRof+8fD2zo55pA3KGzTN02tQBLeZbi2Kcc/XEhRGz2S1OYOyaSxM
QJaJ//s0ITY3l4XJR2LikZWkFwzpMa4bMzEyWWXQdzMkO/jvKH3Fxzjtc1/67eHl3SYYGiUP
fw8GKc8Lp09YZ4y3BTBp7P1rK7GAWvHPMk//uX5+eAcR6dvTD+mkM2O8llQIxHxWkQqdZYhw
WIruM9QNI3Ptnhdt8LZbD0ghmLNFNp02JCs4C+4x9skhdMgSQjZsxkblqdI0kwlicM2tguy2
PsSR3taTs9jpWezVWezC7btbsydyd0g587zd0fQznpxHXygtvYHZIQedkCNkOnrUgeCYFeZE
GlU6chb2GnX7IBhCdzpOnIUbpG5TSjHhudlIVhXIFUxg8q8EG7L68OMHyfKI8ayW6uErJsrm
SxDPduhlG4jnLsftPU+4ToBNBgYZ12YSXzSZxAWSRGV/iAicLWay/DHlg9QS5HKoASVBw70J
DPWMarUK683xyL8WfNeb62OZD75OHG6PpedtGcSrajX1f8HwdjG+Mmy/82JVuJpiSG8l6VFI
kCn9cXrmjUyursYbp+HMZGMBXC3sYXUAitN9ynIumS4ajX+PGVhKhxeo4u2MbYMyL8ww+2rz
6flfn1CVfXh6OT2OgJX3pt9Uk4bz+cQdIgvFF/TWnvx6hOrMNRaOduJYppyJI9utzBamIzsA
PQyfTdC5xpz5eDNloo85FsS5qnl+bzJdNNacp/f/fMpfPoU4VgNbM2tPlIcb2Sf/8rg6u1wG
emzmSS1hdqND7RKY1iQFrp//sv9ORzB/Rt9tNK74AQ0Zn3J3cbbOifzc9OAyY8pkt3ImNwDq
Q2JSzlTbPInc0TcEK7WqQSCO6WPkLQ5j3Z0Y6Ra1SXZq5XmxCkjMw28r0Y0h0kQkz9eUOUh2
qDF41ATAYli/ZtmhAHibrz4zQJNkjMFwi2OeHQBjMnu+5gHS8DuNqKCfr9trPgbDW5Thw5Mk
1b7NGsWf6fQB6oJHvTdQUEBj8eKwLwYa7jqXygLK3ByI97OEqNsJBxyC42Jxs5RyCbcUsG6J
WMSCb03kbePFYLwdesva2+vH69fXZ2r2y4om67C9t9ynihhx+0s6Crcn+dP716GWE0Tz6fxY
RwX1kidAfrMIenZ6b+YEDRNdpZh3TlaSt0GmxcNMx+vUybVoQDfHI1En47BazqbV1Zht5qDq
JXmFr5FhjmrXPa4h2oLCmZC5GRRRtVyMpwFPK5VMl+PxzIVMxyxsSGVVXla1Bpx8G9BSrLaT
mxtmqm8xpvrlWD53tml4PZtLxq6omlwvmMt+4zfbpMcQje5bGHfnjWL5QKLW6VqzRyPt1UFd
RWtFJgAmQKlBkyMyQ7Evgozfe4RT18fJZmhRBQo27+6Vg4XXgZ5e9WwboE3tyT6+RaTB8Xpx
I8VDNQTLWXgkT3E1UBAF68VyWyjTBZepUpPx+Eo8KZ3Gd4r/6mYytvP4O4e5/hA9EFZLtUs7
PbDJ2/rXw/soRueqn9/NE9dNfuwPVHuxytEzHNGjR1jFTz/wv/SQ16gviM3+f/Adzt0krmZe
l4EAA6XMy1WFtP1aWTBVNOi1BcEfHm/ewvVRsn8Tj/HWcBK/gEw7goMMJIC30/PDB/RMuA7a
50XtnLTdCJ1j0U2ecMu8Rs0yCJIQU0mGooGgXSdGnO4dxgPQR0BsjpkATDfmnhKTCJp0R1YA
Ri/xRjQbLCBE1jaley/ZCQWIPXZXOa9P2OFUSo0ms+XV6Lf109vpAH9+H1a3jkvFTXYtpM63
tLsdmAUM9dC8uqei3Nnau5FFP0C852lspq5nYa3SHWokaqWlzdH6POGRQeTAmAiFxpXeHku9
b26eRXJIgDkQKSl2bLOTHX/VnUmXrJygAa2CdAixT4StyjyIMHjER1Ci/RRk4pgFYDk0vjfQ
OBkmVNortNzvCl91aMSHk8f4TlAvVIxX4wDYDljoOSPArB0Uvz8yNFqz9zTtti6cr1yJb49B
W8MmL/ffQ9hQ5s2U5vEQJrTBZNbPM13Cf7iduURbomjn35HWs54Bpt6bOWUSVtOW7ZUmsSRN
XIuTZSZLUvGMBwHaCQO0EBAz5fTwDXY8J8JVA8ToCRcWBoXAPMzT5fivv/z8GwJ6bdpWEsPZ
K7OcjkHcko8Wnbar3OfDKGwCBq71vcjSICvzwpbsJmQIthVrq4HZDzTYMkEN/3h7+vMnHhvN
rWNAUkcKkQhzElkKP4wK1fTDQaDxqUP0uxGgQJ5bCfdbnEaVkSc7QxuxugrTulrLdtCWBiO3
zhOAiB/fDWN+B4SpvpnP5C/dkewXC3U9vpZk7I7GvDm6jQsM+/UGMTOq5dXNzS+QOG6UEhlo
eXOBxDT7SG2AA1S9SXLYOpn3w5CoEM3ILZ0vpPsuDBZCaHSpUDi7bZ6BGdRapSCkNMHOfo9Q
iTiNPPFoLfU+Bm0Cs0BX4c0Mu5UEGp3uRAnsV5dQd45iLmxmiGisEKwZe1BsQD6bhd6jr6EI
oqCw/jPttmMBxu6MwoqHMyjqpXw1TImSICxhMEI57olRat8z7I2IrcVUXpRFGnzhLzEokDbb
4bpUluWThZ+LyWSChT2Ol1B2JmmsjWk4S8OER4XjEyXHzerykIGYBDuK5A5LqcrQ912wv7l0
YlCiXZmXzAPXQupstVh43mshxa1c5rHiczr0QjvflsZPjUznIFzxX8aLfnswqWMcDFMwGNd9
vEs9YxRuVVJ5wxFaIlBiiAFFOVo+pcTnEzI5gDo8gvokRk5HbA0TdpEaVKR3iTejRFuK+2RH
yZS5oFQgKLsPyQ2ZgPaQKJKibqWmjqBlIfAxUs9qbQjgn/Po2Tm0EbE9Z7ulqG7vt8GBJW8w
AkkTRPffoz9P05fTB+J/vp+eT+/vI9hbv73+xBee/oa9F5PUPpqrFhbWQMbiC556l6b4evc5
1tXu/LDad2yIv8peuSdSQ7ndBQfPw4qEKl5M56JnGaVpXjDvN8OJ+LIxgsdkmuNP1joLgS8u
pk2PNytmxNishnOjx+3XRAuC3ZAYHnFvpM01gDPzzOLjwtGFOH7vyaR2NfYkbgDEXoq4iOkG
tU4nYyJvxBtyen5OlbgfpUG5V1TZSvepE4xb3W48mZBu76WjhnIH1kGWk5WbJscr2LOIVooA
bqkzIDe6riUz/ocMPh8Wn5vHUBKHbF1sAqFkTUPmDVRldXm0cVAU3LgUMkrr6CtxjYucxmV1
LbBzY1hjC+4VakSgL7FWqvTlNwEiIMEKfei1FAZBvxEI0nSobqvFYo6Blgz2ZbG4OnpPtU4Y
74vAd7+5mh395JWiTmsgx4ZNXqC6G9O+GwNs8+vSjpTel/KutQYhPPM+59YWzwKNzbxIpjRe
U3ksW4SqzLOcRrNka6bQw886KIp6nXjekm4JglVau+f+WghCFBsrWUYpfh9HMVkn5smAyFpF
JH75rcQQXwIOPSWa/MvWo/qCRFiorEJDmSiR3CX5hlqO7pJghuoeGZa7JISBkus4wqrLWHlF
XH7gh7xlor0Q9VtSLsRbipQ+zl2mzLpKipcR+27l9fjKp1e3JazCyMRiLUsAi8lsKea0RYTO
yTA2gLrgOloLRj/+Wh/iypdvrSVcTKZLT33mXZfyiJfPVKQsF5PrpWdqlApmROA3j7RkmGZG
bhehqoIUxMuLC6JSnidpKU2egNYJfy4IqlWc0DQoVbicjmcTT2er+GJHUb+/UGMeov3zyA2U
BK/Nbnuxot2F3au6z/KiomkYokNYH5MNTnua+KyDei5hCE+ttjvNIr0s5FJjL1PsLymqh/iL
Y9S1kPowl+XRDj2jYmkDxTeQuudNXY6IjLPh+6kSXZCJYct9u7vYsQbVXAgHx9huQN8dRJLA
mDIEY1aGuRM4acwEiJgW8uxcR5EYvxcX/OlV1MVLjBb2r9NqhTK8dFFnA2r2TLw1QCd81sLC
FL1v5Ky0liLWqyCjmacaXrXNfO7ws3BfagBGgy71pdp4ebTpeo+eYTDE5yraxlUM0go7XAzC
BghwRkZOSuNY9CrY3jvB1QggEmp1AAhlmagI0+FvNhgDsR2+5AkVjRDu8/mr1kQeDKI4Qy7k
DiI1zpyEpDExOWTWiWfFaeGb3xjL7Ja5IQB4cWPBwhDgRDGXSbbnvVm/sRtJ3K4Wi4mHXRiH
QeS0trG58MZGAczkhj0NkCgWs8V06nJneB0uJr76TfmrhdtqA76+OVfoeslbvTZvPjrNi8Mi
gVnsa531CzgegntPTQlMXKUn48kk5MORHLXb5kYN9XBqsZPxhrfb6i6ce38x4NbRIfRgRDkR
yvy+DBIm0VGQ8HZgAgeNKUibGckktcV45puQd21NNM7G3g44jW8EI2+7USJqOy1UZO4J2DCB
YDcZH+mdqCoDWBxxWPEGtZcGDNicLhvYAqYl/s3c72SjYFFQ7zrQYlZVZLK5M2Ck0FWSmVwQ
7M3Djci0KJhpyMBw48UNTy6Ts6zGCKBJBgqeoBr5mXgx2egOWBNM5rvdrOTxqJJt2DqSbF/f
Pz69Pz2eRpjnpfGuMGVOp8fTo3G/RkybtS94fPjxcXqTvGoOSTB0IVHGrjg6PGFOnd+GKf5+
H328AvVp9PGtpRJCbw6e7HP79Ij3DrK4YA2RtajoQZeuuPNqZjxBqtjxvSBZP/oNqIoEX5mX
Hz8/vC45JhsQMe7hz0HmIAtdr/ENrMSJiXSI0CvBlyzQUtg3u25TTwSRJUoDOGaPLlEXcPX8
8PI4enqB7/2vByfdTVMePWvOt+Nzfn+eQO0v4R3bAhluX04VW/JW3a/yoGQXWS0MxAJ5URGC
Yj73eCJwosXiV4gkZbUn0bcruZ13cJDNL7QCaW4u0kwn1xdooiZVanm9mJ+nTG6hvedJXNlS
pjAz2ZP4tyPUYXD9f4xdS5ecuJL+K17OLHyaN2JxFySQmXQBiYF8lDd5qm3PtM+47D5u3xn3
v58ISYAeIdILu6oiPvRCSBFSPCKHH5gKYpH/4FWICf+gby0LA3pN0TDhAwysZWkYZw9ABf2Z
r4B+8APac23BdNV1ctwKLBgM5ountQ+q2zq6WF/cqSn39XiUWbYflDidrjkIaw9Q5+7hjBqn
tqdPm9dewlJGx5he50kb3KfTuTgC5QHy2kSew0JlAd2mh+1Gwe7uuJVZQXmPUtw2iA5jq6zF
ijSKf977MSBI97zRnGMX+u65pMh42gk/VTFqZYIEkvd6ijaCCYKglnZxhRTPve5msrJ4TsE5
VfwqKS/8Cm2NXLYUSiMq1Bhq+gUotfFJUZOhNhfQHvOgY510iy4t/32ziHkkjMdtjxUDkPeg
zvNGboBghsRZ6kpji4jiOe/pq3nBx0F1mv8IyGUEDTjfKsS5+Mu+LtNiu6IVZ0QhtIUMzAD1
tAHhWYvoYzAJwJEdQa2rHPer4iurR7rBQ1tH1nWYELFfvn/kMSvq305vUCzU8rsOqsMU4Qhl
IPif95p5UWAS4X/pIbUqAJxRTCwoUp9eyAQEhEXXMiYBBa4AlDLB2U29E0uN8diQXzcKlYZM
RsFmzWPQusLCyWKG4kEZeb/bBghRxAE5jw5fsEPe8tB6qso20+7dCEIfWd4CaSif8oVbtWff
e/LJwvct8wyhQFrPUbNt9W0gdBQh1f/58v3lAyp2lksYKJfqe71Q6yNmKM3YvZ/UY3rhq+Mk
iszz/wriRH8ZeSPjL3WlYTe/HuGe3p9cl6P3g8P3jMcCuY+GYr4+eMYTa4civQg8BmDuFA/2
hHFYzDzsoNqAMkedhlWXJ5F+WTo0f//88oU4yRQDwvPvFmouY8lgQeyRRKgAtlUeikOJMUHg
hOuh+QY4y0/i2MvvlxxILjFPxe/xZI469lBBhWmRrzVGdTZXGdUtH1zNLCgFXwV0A48JqySZ
VrkDzMK6rRYIWQfP+1s69BQVmI89Jn6+OILQam/o2ug5tHTmw6qGKWCMMnpSQSDoOV58W5dE
5RgphjDOFc6l376+xUeBwmcrPyoiDoJkUTgETU0m/JMI3d9TISqzxCz1d8fnLdljva8dEZpm
RFF0N/pQZEH4ST2mDmFcgmDO7KqhzJvNyuQO9/uUH5xJBXToIxi6cz7CyEPSfnyIzAdampHs
oXdvmsDejw1MsEd1cFTd7Zvq9gha4IUyrDU88HMBq+lA7nHGamlMoLaYBhFem5g+GCLMcv1b
dzqMc9pN9A7BWY6jYCORi/TekbOYUtn6tgYRrysb1cuDU3l4yjKfFEsYQUe3WqFxa4eGK2+c
TGstFSNuNbUk3Spbd3ERJPiYXKVdc8xsczqYjUf7odN+r5F3dt1L145X6Y+m9mkh8gCKIHvR
e+gKE7adrzbDMGNfGYeKTkOxIi51Tj9qe/7MIsTFiL6DGlvtMgsfT92zHpBWRs/Ei/A3HwiB
bH30uSv4UR259WEIS8zqFKEd66tNjRQq6DtBdNPf/JzSg/z0nM1TVLerK+IyS8Pk5/xlzoMG
kpP5rR570j0BvpdDcayKJzEt1jKmAv71LTGrdDLH1aMZZ0BQbRjopuhzptooqixY0uquOmlO
DSq/O19OE2mbhyjot17sXJNW1lyHo5Bi2JlPXCaMaT2cbnR6btG8cQrD973qX29ydN8n+LoK
Hv9NF22dqUtgA2qeXR7Wtq6haNHyrQ1njOjen8nSNRCGkxOxJO07gqAgbmLU8IYYOoO/qxMI
y4daFbCRyg/dMM6MtuACQ4Snoo8JkH2E5yoqlDZyheWHMGT495cfn//68uknDAa2lgfvoZoM
G/VOKKlQdtNU3UF3lRfFuuw5Vrao2yA3UxGFXmJ2Ell9kWdxRLmQ6oifdql93eFGbDPQasVo
e1kpT2xU1ja3om80x/bNIVSfl+FIUUvT22ScTPLRbg6nXT3ZxJ4nCV1m16JsYxDI9b3JhfwN
lAz0P7/9/WMzdLMovPbjUPElXIhJSBBvJrEt0zihaPcxYnrEEMlDfy7nDEYTmbanznv4ysc8
Xx8b0H+PJqWdzFr7ur5RRx58teTmvoHeBUmEPmTMGBthLQxT+mzWMtZjHGdUKBDJTULPnOtA
zRJa3kc2bdUnObDYznOCh5gn7q95FUVr7/Z8ifrn7x+fXt/8gXFEZdCz/3iFOfPlnzefXv/4
9BGv4X+TqLeggqGLzn+apRdo97Xx+ZcVpr7iATP03c9gzsqfE8Adpd2P6/HzDe4uf+YJcZ3j
XB0Cz72sVm11cU1JLkK8mpS7SGYlslWowecQ8FS1Yi1RaCd+RaYXBN/8Oiw655brjwNBP8NA
4vCkeiOI2dZOahgdpOmx+aufsD9+BR0HWL+JZeRFWl6Qy8ccHcv4FKYcb54utip/+vGnWC9l
4crk0wuWd1d3mZJFS57+M/A82EJ35C7vXB61gdAyVnCKnF76p9PwHCki5I5rdohYOk6HlBWC
6/gDiDM4jCJRKM+FDiWazDchYyavwq4j32evm8GKPWXq33z48u3D/5BJDqb+7seM3bmoRpep
QfAsgRbyrWoWGd7c1OdI05Jx5wlI1aQjdafJHAoeN/T9GR7TDyexJPiNrkIwFBkU3xYhN6w9
lu3KxzAN6MOMBdKS2Uwkty36IBw9LTr9zBtB7SbV/AVw82PvpveR06d2r5kBL7XltzRNHNYn
M6jPm9bhsjBDhifmUTvhzJcJ0YkWbK7VMwi0sWF4vtQVfVo5w5rn7kakvDBrBKXFZcawVJh3
3alr8idHEPYZVpU5ZvVxfAUSVVbdpRoeVXmo2rqrH1ZZw0g+wjTVtR5354E2r1gmxbkb6rF6
PGBTfcBAik9bMw++82OXH3LllGmdY6A05Ta9GKO0YbE9Wzkj82wGJtds6t0gHMznzxb2X83M
WxJ4iEyeZVDE0Iz9YEac9sbhgAi1K+IbGqXUwzvd70+sBeZRAi/Blf6aM9dEPSqVG+94q6Im
Yoi+vvz1F0hjXM4ixDz+ZBrdhHU+fZPUL/eeG/y27Mmo/1wBlOEBXjVqec37ndVxvDZxV7Of
8IfnU44Q6tAQQqFgD+RoH5srtZByXl0cjYZzT7qLNfw7lozpzcCOeZvHZYCuY7uz8YQ4+DeJ
z2OhKvWceLmxONZuVZF6LcosjGgVgAOEgObqGCpM++Koxi/bmDNiM4eN9a3k4mWtMau0N5X6
jJmjUU8sNfuramEzJfR989Fr3WEQM3sQRj8pIkYLBVvNXZQZTv3086+Xrx/tbkhrSfP7FlQ9
tqzkdL3VxgPmmHJOMPHdetTXHNxoKlExP9QIb9bUlnR8wtWAvtiz2Jq5U18XAfM9dX4QwyXW
mn35C8MYeFbr8qF+f3KE3eCAXZnFqd9eaXNbsY7kmUdGHuXc3/Pu/X2aGqN3UpMy31TTh1kU
uspqepaGN+IhlsYJJbPId6ZvWsuLRGnJfl9uCYnzhyKeYkbbcYrPxzQ51F7qcgVoTJ+pH5M4
8Jk1CYDMEnMacnLmB9ZQTO/aG6OCCAuusE60+nwudn5khqyZlyR7ai05xqwpZ+1J5omRNrUm
drO+L5CKTuZ631s7AE/bh05kfmJ9hpgvDlnqUbV4c2URBr5Z43hCj6em0XIGEZ3Tm3niIQ5X
10otdfnVx2s8SxPz3/7fZ6nYti9//9A+UnhE5Bfh5sYnZS1YOeUYRCygOf5VC+e/spxWdStk
PNTkmyfaq/Zj/PLyv5/0LgilG4MntVozBX0UxismGbvlxcb4KSzaIErD+PTnqJdDfRUaIgiJ
RgODebGj2aFnDLrCoqa9jgidfQ7DO50MVUcxur2a2qgyUua5qkzZo/ayyotcvWWVn25NITlV
FHWE51rNL5SELXiGH75ClHo5zdN1AZODv/JMICSimYogizWLRJUtn6XVKwUnBMhfhC2338RA
DBXPe4RRUxWLF/EYycOI7a3GetX7OZ77vnm2Oyjo7kSxKohHE9KKQLdSMwbIuhFIfSAvi/su
n2C9IS8ZMcsZL0S5fT7mA3rzoujiJcrlgSyGT9tEuZhW6fpM1zj0DYYGcYTdkpCmOoCadKGk
lBky7tRcl7IjGrHNu3wmWj3YvQtSIzaIwTKNoB2oY/mOGB+Q10Jq3LgcZ48ziEp+KkwArOZI
HiX9aZDAv1GPS4EERTSqO/PIgYAMUyAM7TYPNzUc7YyHKhn00WasApDBQBEySG26qa2uNfDX
t9HmZgqT2LdLxOGIYjWY6Mwpq4lfOQhIot7NKQ+D1JqFdJOg01m60SSBYHabYLpEfnyz6+OM
zKMZQZyq71RlpSEljSuImFGlju0ujFJq2h/y86ESKzR5tbzgpNUtMVOm2AuJKTFMWaTr9jOH
32Ocx11PaY4z6FyMvucpUtm8Pqp/3i+1YVOERHn7YATIE2aTLz9ASabOi5ZkEGUa+dTFqAbQ
jp5XTut7ATWKOkK5PdUZiYuRORih8h2oDD/VXrbCygIy0NCKmNKb71GlTtBtJ8OnxwNYCe2o
oCAcSTk4i3Z9XDAgsLg8KWZEAcro1it5YhNozPb4PvkeZxBN2+etHx839uY1sUjfVGPrMuuc
m7jzHVFNVwgaMm+N43TrialQjgmdLQVTlzgcGRcIxloYW8rWb4HwfQ0lELvqOn4CNXVnjyse
n3nxnmoVP1kL9vSJ/AqKwzSmzcwFoi38MGUhbxdVy1gcydulBTCB9nae8qka7X4dmthnY2v3
CxiBRzJAlsqJgmBeElRxUd7ZxRzrY+Kr0sUy0rs2r4h6gd5XN2oEajwYdsTBXN9f7JHfJV7q
4oex9ax2GDpTfy+igGoNfEaDHwRbqxKmUgWpgGrOcqeyOWnE/kZtnTqCaLZkmJF2NHa22fip
ABmA+DqREfgxNSac5bgi1TCP+hQFCbFmC4ZvzxkUkBIvITYozvEzqrGclbCtLxIQGbkjASf0
03Br/DCbECxWdi84I8wcjIj4ujgjJgaEM7KU7Da0LyO/hLbow+3tfiqSOLILbVrVjmylpjSV
niFtSkmkCptRhTFiAUH/eZIakxO+ZdsVZ2QVGfE6gBqS1DgIyWEDRkR9SJxBTFph5Uy8b2RE
QUoNbDcV4qCtHqcTpYcswGKCWU90ABlpGpMM0J+JgUBG5hFd7noe4Yrq2Z7FmTIWvenIvCBb
Oo+hKi4GKTF4O4yptK/IjeVe7Pf9SLC6sT8PGMWWc+2dZwjjYPOTAQTzkojqST30YxyROVQW
yNgkDHZ/euIGoOtSh5XaWp6Sor1kob3sucm3JwZgQ+YT71+urmTngBd4qSPAgQ6Kt0ZALFiM
rj2Moohe/VjCiPWiv1Ww6BNPTP0YeVFATGXgxGGSEqvyuSgzLZq3ygg8Uk69lX3lP9gH3zcJ
Haxx6cW15SKVVfF4nOjtFxibkxT44U/qLQKj2HxQmMMSknpbwTZIztsK5NnIow7FFETg81MZ
6uHkGpjuyWar2rGI0naz4RKSBWS3OXcXkockC6g4xsntNmeFoYpBRPCwjDAhH56mcfvTAGUm
oUQb0BP8gJXMpdSPKQvou5IFA6PMtpe1Lg884qNAun4eqXDC4IGONhWO6BIL4NgWm0kxp7b3
qR2J00OqXZyzJewBwMgJqnK25aW2j31iR73UOTqguPRxYCcsoazCF8TkB/QZxWViAXmlNAOu
LEzT8GBPG2Qwv6QZmZMRlFQXOIu+bNMg2+chAGlg7SdzIeiYpDtQowFM+ACP1KWJDqmO+9kc
y2Vnv3wc6NfzC2cl05Pnk+ZPXBrLdXcsQcI0QFON0UaoHs+gqq2GQ9VhpAN5J4SHG/nzvR3X
xPQz2DhlnMmnvU27DjUPZILhUVUz25lfVsLi/XC6YKDF/n6tx4rqhQrc5/UA20jusJymHsGQ
GBhirth+xF06AdxsLwIwki7/70FBa+O0o/X+PKPINguT6C1EWV32Q/VuE7NOAJTZasfd4Yxy
mgnOFi2bdb07DfV2a/C0LAkoiJIuFV0BXrXgE8vzItQqn8JFk7euUIIIGk/FvZxGZ138kwVo
GHm3B1UihO6WvIneLMtqfXHcLIweBPrSkyhHohZ/6H9MiuFvs5C70zV/Pp31wN0zU7iGc+dG
TNq1a8ij2AWOwd24UyyW51lsbv86r53Xlx8f/vz47b/f9N8//fj8+gkzAB2+Qae/ftOMWOaH
+6GSJePHRXREB8DiqpiHuUDd6dQ/RvVmJmkKqC5LnZGc8Bcfm+vRx8cKLrnuH6f9tBTq/PDi
4DEmoTHz1OM2mevMMow1517xqFF1V09F3tDrwLXMocElZVMsY0VQtbyv6wGNQjZ7Ic2Rt7pR
XtVwAesiKO+LN4vHUzLMGLhR/LJWUn2AF37eenic+rYufCKeQV68O2NaYhg2tcC8vIigc+Z4
roimbtGX0zHgyE59zzcLrnbFHZT4yPEYv8NgojmrlNdj0gCQyfW8SVDSvp764sEErM7DabMn
9S6F0un24BXAqCUiveZ72Hcd6CT0vGrcyeavNWCaS9cz0C1zkDhtyRzRmw7oC4qlfrC3KgOy
o65jT8yAYw/ge8djZxQnTPmsNkUYvTrHbgQFzx681dAGTwP90NGc7mK+08Szx0l94SAhu94U
cNMg8syhBHnImqJriRi2W9qOu4oFSJjuUjGm2ofN7VYdj6Fepc3hWf432wd0lqZ7ZxOBn23x
27w4vncPyb3qb/C9UYFMlrzzRr+6OsOI6q4KYQ9JPZ85qmxhh84DX5Y5W92+/ePl708f1z2n
ePn+UdtqMO5esbF+QXFabqwRvrH+NI71zoiepMdPlNRd0eYqXCHrf92PJzTqKmoHeuFr9h4L
A4RDV+0ia7HuNasyeEKXou0cXM1EUHBk/rY1wMJ//fvrBww27swX0e5LK8k7p41xHNLqL7Lz
YmJZFFOHAJw9hqmvHJfPNM3cseWS5WzPryLzKWCpZ0iPnIOBQu4YTglzqLwabeLMY1OQNliI
4BFCPdVYm1Nn1wBzDPJbH3guEzU+SNJDWIRAUhiLqb5WnqC6437yYY/SxnePO+eTRkkLVz2M
Xoj6ldpKJtPW4ovhxnU3422ZlnVYjhT3zMwoM8fVVCEBUo8k9LmMZPvk+Rof3cIPtbzTClGG
dNEKO9ZJBIsSdozaFSf0LB/rQrmrQxoUpHnOY0li1Xx3zocnwiG/6Qvd9wsJox5Fd9UjzeY4
IPfiOF1/FYjaG+1ovbYeg+Xxs6NfwdFJphDEvWSK9lSqI4AMM+IA0hjrW+Z5FDE23xYngyTg
evmWNaKkWs4xK909kzibJeY3vdgsmlQW2VSWeam9AAA5cH0S0vCRKInbOuolTYlx/K+zq24f
+LvWtXChaqDXY5umzhTTsGehO0JuSCccM0Eo1mo6rnCisGfUacI3ySA+Md0FnRO7eEp86nwc
uWNVEM0Y6yhNbhSjjT1j0+IkY6vl9KdnBhMuMNvjyB2X726xZ25o+S70XcTT1BsVojfWvLXD
H58/fP/26cunDz++f/v6+cPfb4S3Vj0nrCBVd4TYu88cWPDXy9TaNbuZasMw1fe8DcP4dp/G
graJRpjwkjMfRhtm5nqlUHLTnvX3JlzdtKPTfkx8L6ZdWrnTGe36K1jpzXytgs7oNAwrIKPv
kxdAYLqXGAAWpa41Cfs9ew3a5DgxNn3bDW+hCi88u3EZOSIKOyAKA6oeLk1yYFlXjWXn8w5b
ops5+bnULdSBgVk6ragmyrPXxg/SkCi0acNYXcrESC0ei+bLLcKYZa6dRWh0evmzG7Va5RJs
QBdYhV8qSdTjsS0yWRCZr+faxr5H38rPbOe7u7ZyTzEewU3F/UjkWXsmUEPfEoYtSOw9gmQZ
Ze7NF/PTsQVpPPXZzZqiMw9kTfpyWC8gcG4J4tDLWlz3xrYkfeL/pTq1bylU87OLxYp+EieJ
TtekFSHSwl1OzZQflP1pBWAMzrMIGDue20o7h1pReBHE74EWHDlq6wMgYB1YQn0FGoYLbESr
UCFkSUz3Oi/jMKNfmwLq4Ad1hK1AhGJI1s/3TUf18ntryhN19WwDYYbgCRtZj9BsHZwgoN/G
rHhu1j7PfLoEyn/dnl5CayNLcLq365DE0QXgBeQqY0CUT0uZ1HkXh3EcUzxdW1rp9dhkoRc7
WEmQ+jlVHKz9ibpLKhx7iVaYIIqkPt11ztseOe535Rh4sW8/mP18F6f1fgOUPESJDW27vYBJ
0oRu8KxMbZaAoFjdGDWWpXZpXJZE283jmIT80FfVimbFjvnLmSll12VgVA3MZDF3d1niaJKh
NBo8pvpcKTx5bqErKTo/ZaGjq8BkGS0wqKjeB5l1e163PWNxRra+f5dmzncM6qkjxOYK2ohQ
oYCktvkItj+/r2i7RAV0YcyjZxVnMY/qKGdlNEuPVrAyeHJ6jHb3oNlbQTgUFGq+mz1DwYdu
iVCv/5+zJ1tuHMnxfb9CTxPdsTNRPMRrI/ohRVISy7yKpGi6XxgaW93lWJddYbtnuubrF0iS
Uh5IuWMfussCkDeABDKTwNXCrVPUzCL3NES19HbXekUY+KQcCs6xjst3eG9HLsLFNiMG0kKd
lk9HeJGoQscQyuhCha9mbd+9zvro3zjSc3YZB6JjkL/Fi/y4F75nux/J6eLK/RWy0BDIVSED
r+1jMu7CXZ+h+StkykjloRIJxNm5mDHxckQjQcqqy7aZnHq0iY2+YIrhcOc70eWGiVvr304P
j8fV/csrkZd0KhWzAs/kl8I/ZCzYpHkFvmhvIsBkDR2mxDBSNAyDuBiQbdKYUDgNJlRVdg3m
jpTmR8WNSU/de/VZkvI875fVmUD9OnegxQ2miWBi2LkLmiwiebETnCX9+S5KQkzOTZGVqJlY
uRM/+ZsoukMpBk/gLWxz1u55ZvQY/mpV7G0phYjg9WwOW3y9RECTAqZduPKEWVJ2WYQUBRPj
6wFEypjb4c3jHJVVKcgGGD6rO3C/frGF/E6ITO5KhmfyfAKoN5SciAcEb1MeHBSM1ha/upOu
35HqkKe6MznH60Oe1y/6OHtgty9cJdDfH7+//yGJybm5aWHaKq/8gfQA5pW7BfWzVlmku/VD
CuYPZ0EV2/90fD4+vfy+6npzT/bpkB2KOTglqcckuqrJyE8vJ6Ji2KjdSzrX5sc7xu59+vrj
n6+PD3IvpTriwfFCx1arnsEjy1vpdnCeYsYC26WfmAsU/tq05o+/P74fn7BbeEMz56sWeAAZ
h/Xgv0pff1ygY9VSb+2QYHNIdmlHSMqEoGBQqdrMjKjxUt/UkBM78w1vPUr3+xT2rGakZur8
0FX0FsfRHbWvTRhX7XKJjyCNVSXJpslgTFfWLKsP7hhnFWVtgAI7R5ic7/U1jRizbTrGcRZr
2ve8fWlsNsfJ/KH2ZXmxFreZ01CnETpZN+iMavxAfpapA1HGGEMS56BICwdj/lymQCl9Jkh5
Ip3c9Pp6FpP92Kd0Ag1sjUfpmZsyMYK+KJfXQ2ms4amHNrC3E9VMFziT1jg9rIoi/tSChbDE
OBcT4BXtiCgoLAnSZFEsm4ymCy51bx9fT7cYt+qnLE3Tle1G659FrSBx8jZr0qSjjpcWwwK/
IxIS6vEK7l++fcPDUL7bLIntFWUIu66jKI4LnDArOBwWuxI/ebxgcANHKyfbkfUVLM8rVVbO
BdWdX9QnVzQNacxwZbz2VeGbwWMvWFh8KTNWAiPDHMtby/H5/vHp6fj645IC4f2PZ/j377AI
z28v+Mejcw+/vj/+ffXb68vz++n54U1Kg7BYwBtgFZ7mo01zMCCMi8m6jvEXCOfgpenz/csD
b/ThtPw1Nw89fFi98Kj5X09P3+EfTMPwtiT7YH88PL4Ipb6/vtyf3s4Fvz3+KXH1bAL004WP
ahkkLFi7mp0J4CgUczedwXYUiQFHZ3iKOdM9TWFyuByhY9Yube1qcSNljdi6LumDL2jPFb+I
vkBz19HUc5f3rmOxLHbcjd6ZA4zKJSNRTXjwoIJAawuhbqTX1tdO0BY17RYull15N2667aiQ
8dVtkva8toRRyBg4naFWqn98OL2I5VT3AF/0qkOYwC6x3QBiTaZ7vOB9SzM9ZzDqa8JBCcK1
xmczmCqx6UI7UukB6GnyD0BfA960li1/AD9zXh760EufvhcWFIohhbFIYZ4gfiAMgqW3v2Bw
yFca6Prasw3HKgIF+aLmjA+m+FJqwVsntKgbwQUdRRbVcYTT9/EXgiveSl8PrsN1gcCwqK+O
kjpTWZfPdECYN9yyl2M9CRWfnq9U5wTkFhJqMs4FJKDlRg5bcUG4ZBRiAR+RAhe5YURnHZ8p
bsLwGsPt23D6xnzSGcdvp9fjvJ/oaZZndy3zdGHKisGxNclGqKe5lQgNSNqI0PkAd23qFuKC
9og5rXrHJ0N6XdAeoYYRHl4TYU5A3+wsBJ7SMEXwYQ3Upc6C5sFaiK57PvksRUBrrIrQiIAG
jqc5xQCd7s5UqK9v+QgNyE4GwdVlCQlNXfUR2URkmAfbDT2zDdC3vu9o7Fd0UWHJ32cLCPII
+oK3bbpgTZ/MnvGdqcXOtq+22Fu2tjwcrNtkCLZ16raxXKuOXWICy6oqLZsjzX3wiipXzf6x
+eytS70p78ZnmnHFoS4BXafxTuMygHsbttU72xYZq6nXCBM67cL0Jlz0Ww6KTT9xW3SpF1I2
J7sJXEO8vfkY6jYKyMiIZ3RoBWMfF0svtk/Ht69UztSlI3jfZ94N8NGUr0kDXqdzH0fYzR6/
gY3/r9O30/P72RVQjdg6AdFybfq+RqSRb78uHsWnqS1wML+/gjuBT26WtjQTNPCcfbv0Efzu
FXegVHp0yDGky7RXTh7Y49v9CZyv59MLZiuUvRt1RwtcS+OrwnMCcncxvIGa+9yNRVZnifqo
S8iO8P/wx6bR15k6jssTTxUnO4XL0fu0mn+8vb98e/zPCU8TJ39UPUvm9JjQrc7Fh7QCDh00
zJpuxIZOdA0punZ6vYFtxEZhGBiQKfMCX9KOOtrwSlOgKzrHMiRJV8l88mmeSuSaegRYxzc8
PJXJbJe+cRfJvnS2ZXAlRLIhdiz6CZ1E5FlyHCEZi0mYPxr6kEMdXmscPMcHhq/cRMJ4vW5D
y/DpiEiICoDMsaEzmByhRsRvY9hhqS1YI3JoNuQ49xp3m0qmcm5ruVKwig24Igyb1oeinZH1
DyyyDKGLZIF3bI8yI0WirIts1yC9DeyHnaGXQ+5adrOlsV8KO7Fh4taGqeH4DYxxCvC/5Fwm
NJmo4t5OK7wp3S4Ha8u5Fr9AfnsHZXt8fVj99HZ8h53i8f308+UMTj1DbbuNFUaUUzFjMXSW
fMzYdr0VWX8SQP2SBsC+bVt/Gm8jJgLT5QYKk/h9FIeFYdK6UzQratT3x38+nVb/vXo/vcIu
/P76eHy6Mv6kGei0c4hclHbsJKZLJmQtMWQU72EZhuvAoYDnTgPoH+1fWyLw09emw5Qz3qGs
JN5u59pKV37NYU1dnwJGyqp6e3s6flSW2glDfak3Pq0+z4WiyMAf19gDeM2Mxz1XsceU9bOs
UBkp36fF2KYI7NPWHiJXoZwVQyI//7mgpqXRLuCmFqizhqko04VqqsmngIFa/bTgVyYNeNKw
0/P2W9gpTesEoqXskJyJNqHPbCoy4mWauW1z5u1u9ZNRAMWu1qH0OvoMG7SZcAJizgDoECzr
KkCQ8kSG5P46CG2NMWAc60EdfTl0VzgbBMwjBMz1FGZKsg1OrRjxWgTHaqsJj+dg0Sl0BQLK
45vRkc620xBDGcq2kbS1IyyNbZ0PUBxdn9pJp/VIHNgoG3WVALq25Vf/iGi63AkN8SwveMr5
PyteZRy/JjbsxfgcpUpEZoznXcHIhij9oarnprlySCZxlNma1FuwNMq6FtosX17fv67Yt9Pr
4/3x+dPNy+vp+LzqLmLxKeZ7VdL1xp4B7zmWpUhD1XhztDoFaKuMv4nBRbaVgeW7pHNdtdIZ
6pFQn6mrl+9g/o3aHoXQUjYTdgg9x6Fg43TDKD/vmDD92hAra2lFth2my8E2+esKKFIXGOQm
1OSGK0DHOnvsvAl5//7bx+3KajjGjxtM7M3NhbV7fnKUzA9lhLpXL89PP2bz8FOd52oDtSG8
0GX7gqGC3jYtokATnc/F2zRe3cOIXl+elnOb1W8vr5M9I08tKF03Gu4+a5xTbvYOfYx0RpsM
UkDW6oJxmMJX+LnFWuVlDlRLT0BFnNHLd1VBaMNdrkkHAAdtw2DdBqxU8sxwViG+7ykGdDY4
nuX1CtuhC+Ro3Ij62lX6t6+aQ+syhbCNq85Rnj/t0zwt0/OpyfQc4vLJ7E9p6VmOY/+8rPOT
lMZesUQSxzJ7D7WztNK9vDy9rd7xlupfp6eX76vn079NIpkciuJu3KaER6Q5Przy3evx+1f8
+pd4f8d25Inojo2sEbIdzwD+FnJXH+R3kIhsb7MO82dX1PfjiZhsF37wozIwpaT4KghPatBr
A89gk6TUwxVOxJPTFEqV6YAvIMctPmJO266VsVOZNs23iJRxN0WLa16njQ7fbkjUVB30tmi7
savqKq92d2OTblt1RFv++PZ6/ESkyyuWjOD4Jvhqp7hl5KvoeYqku2yEdZ0yGX3DCrLjQEnC
d2kx8vg2hnkw4bBcu8dnXBS2L8T3KPON6epFe3QiFMFgG/Ee7DZfrgrhbZbbPPa3Ai+Hmp8Q
RmJSYQ3paelqTR2aTJSm0K81+XRURZowsS6RVF7VhiXplUVnRQLCpB+Wx/Xqp+kNTvxSL29v
foYfz789/v7H6xGfZImnwH+tgNx2WR36lNEv6vjcRYaYNXxhYd0N/NkDu8ir0Be3u+2gCsYE
BfmIr0zQrmAe7Vjg7KmCXOzYzpH2AgDGWQOKf/wCIihTNzFrMJjfPikyuQjH5H2iCfOXwWAx
AG5TxXvy6SGONWs6zPVcH+SGalam+SIiyePb96fjj1V9fD49KTzHCUEBQ1Vp04ImEY/nLwSb
Kh33GX7X5gRRQlHMo9Lg6pH/BbNNszuMVLu9A0vIWSeZ4zPXSqhKsjzr0hv8JwpDO6Zqy8qy
ykHD11YQ/RozdYInos9JNuYdNFeklmdwLM/EN1m5S7K2xnDEN4kVBYmcDFQYe8oS7F/e3UCt
+wQ8GnJnPheo8qxIhzGPE/yzPAxZWdFVV03Wpjz4YNXh59QRfUkmFGgT/M+27M7xwmD0XDLk
9KUA/J+1VZnFY98PtrW13HWpsvpE2bC23qRNcwdbbFcdgCvjJhW/mxBJ7xJ8T98UfmBH9gck
/PkHuWBNFd/w0X/eW15QWuqRFFGg3FRjs4E1TlxyFC0r2gOwXesntp98QJK6e+aQbH0h8d3P
1mC5H1CFjNFtpdlNNa7d235r70gCMFnqMf8CK9rY7WCRkzkTtZYb9EFy+wHR2u3sPDUQZR3M
YTaAYx0Elk0vC38FyOJh7azZDXkMcibtmkN+N5ad63lRMN5+GXaM5nSQgTqFuRrq2vK82Ano
+05FmYkNTq/rqXU4YyR9eLG8N6+PD7/L9+Bcwycl5mOjvxvhJtOh2HAjNWH0FS43wEAzjnGV
pFRkG767pDuGGRExUUJSD/gp7y4dN6Fn9e64vZUHhFZH3ZXu2idEBq2CsW5Dn/ZugQYsHfgv
C5UvridUFlkOeXY6Y6XUP9zo22cl5r6OfRdGaVuOYkN1VbvPNmx+OShnVyHw5PEWkoG+2dZS
isMZ3Ja+BwskHTTjBs4/xQMmZuXg42PbHyZsIKVjl7BJrRuE+ArOE8MWKIhzaBoK7brmcprl
fbEfZI6bwCPbb6a2zLw5U2ZOq1MSdNiDb7qc6UIiN5N2Jeuz3myJNnG9O5g4f1BsBgBsN5pB
t6kG/hbCUEuO8nOn8VayNZzEoyFmkzfWs62nTnqfUbEruVSwXoq8Im3cadlx12zEAMk3ykjz
bINfNSbV2ZPZvh6/nVb//OO338BfSFQHAfzFuEgw296lHoDxj1/vRJDw9+zvce9PKpUkgg0F
v3n89D5tiW9bsd0tfvGR500a64i4qu+gDaYhwFrcpRsw3CRMe9fSdSGCrAsRYl3nlcFeVU2a
7coxLZOMUd/tLS1WYhIInIB0C4ZMmoyisHKXPD5smDQ3Leh3WCyJbMPimzzb7eUhYPbx2VuV
W0OrGnvfTaGR9dX+enx9+PfxlQi5ipPJ/Qxl5HVBaXikvgMTzbFkg0qE4+LTRUFUpZEz2Cxg
WuVBZkXbqcsAM0ReUQHqgFwl1coBEgsrKWpxGXa0mQsoDOGP3wdRRi2ulp0okT2xBdAeGVPa
mIDGx1cXCu3LWYLmzBAmuibrKR2CExqIz0oBkKch2LqhLFCsAaGpUGPIwUCR7RhYbNS2jc3y
YwKlwAQ0hKq94EUmJ4qbolMh43R3oF+VYhPw45kCOhOqpZ/sIIbrYQNLZLI0wu/R1eSDQ23q
rQ/ybKbwMP+aH3XYWIOLslWlE/E8m1YNG8AGvdc7uuIyrUC1ZbHCmzd3DbXZAcaFXU3qCgLA
FI/TXOkDR1zh7r6qkoqMcYXIDixEV1ZiYEPDjiZriOZGoqkLV8ID2xZZmVIw2AQZWA+9nDxI
QsaHtqvoW1ioZ5eCujWsOI/NKU8pZkbcDd3aM7xpwBrnPOomHuCh1GSNn6KzVBWp0hheWjlk
BC/OafxERGG/Fm9QKQOYjyewHdE4I00Fvq1sjvf/+/T4+9f31d9WeZwskee0L8/x6IEHSMDo
DlksGBWIWT5FvUDPYmsodcHPeWAolBpqUahU0m8EAUbPIWo8xzAjMZ4UM/qC47m/iam+UPCY
PLd5mlBVtwwcaUZhlgjlNCoMxQAxCkrOtC4MnIhppNegxrqT5tx3xSTXCioiMXXoeeS01miy
0oOnwtwKXeSx8EjRE3iHjhIsdKyH6Q3ymm5jk/i2Rb/HFTrSxENcKifDs1x9ID1Lf8Dewexm
Avtz94S2/7gXd5GuaidFLsXfIz8CBPOxpL05gcZkaQkkcX7onDku6Dws7ZpuKdZWh1JMhoc/
RwwiIkfZkeGYHQiUQCYIZCvVUvIAqmJkFgTVcaEBxlQM870AszSOvFCGJwVLyx1uDVo9+9sk
rWVQw24LsMtkIG7HYDe2Y7Xd4qWYjP0MDCI3iZAxK2ueBKmXcTAXePMmriSCi2xIG0SS67iM
T8Er2Gnq5MFLoWBkHN6bgvZM2l9cR25qduVG2NUwRo+5S2DBjFtTl/q02VQtLnpWdjfqgE1G
IC9ZgJRoQ+Hf1W8OW7WmNv1ywDgSZPZeHGd9WFv2eGBNJy9cVecuetMylMVRMB26yXAtbgYH
4r23Uj6fMm/Jy9vVjD7pmLCtT32CM42uyVg+Hmzfkz8XuwzNxBKwhAUrnWGtFuND5Dnn0Pyl
9jPe8mbJ6vpNBtv+mLS1KpKZui4ssUMyPuQ0S638wpwD22xfK7IHZnA21BSMe82FNrZDGJIf
5C5IR230gM8+FNito9a76UJDqDWuIZhlG74T5ugio5MZcDYc7sDy0Rlxgqv9iNu1E5qWHJC+
/LTlAgWP4RbXzVjU89RpmLKzLCEU5Dq7YWtWDAlrcka+V0XsjufNlZvK2V2uAadq1jKQl15T
pRVggRGxZUimANJ4X0lZYEtMQJFkO228E9RwaHohSD5/QJCR/rZYwaB0sWxtN9AkfwIbEgkD
fluERsWw16QXIcreCDa6HTia6uDpOcLBkNFcIKDu4hF/UzU727E1+cqrnD654cjBX/tr8uRm
3jw15V4Wjvgp7qSjhr1iWjRZ3WVJqnamKVLyEeuMi5SKOUh8UMw3sYyFji6MM3hSXqb9Dx3G
qtWYsB8cU9p0wN4VW0XJcL9un/yDP8OQcjTwNWfTYpH27LnUfylFwBDioW/AGf01/cVSuC5r
0tuMfCc0GylxxtR9oh/qKr5JDWnSsFjCVVBMJjDGHalStmrMSrMkFZXNvx8q2WLa6RjMUqNX
ywrcPmsaEf8KKitw7KgYotD1Ap4hzUjadPgl/RUaaMf98xdl5yumrDt6iSK7aSq0tqquUtRo
2ma7kp/nZ06rMpWAhRnS2Kd9iefYO/hkdPt6Or3dH59Oq7g+nL9hmt8jXkjnCE1Ekf8RPpSd
O75tc9j5m1jt2IJrmXmjOZc/gK9k0qznilpiQTmiTrItjUqhdRoDZvU2y6lOZ8XAO3QYSNG6
OqOSCnZaTB/l2Na8blo7O80WnsC8aEZda6hEmM6WqphfCec5XkcdOnqQu2nelHauEEJNH1LW
WYsxo7KK66amxKzYjDptPhea8lBNbx7ztE/z/6PsWrrbxpX0X/G5q+5FT4tvajELiKQktvgK
AcmyNzq+jjrx6djK2Mq58fz6QQF8AGCBzmwSq74CiGehABSqjKnMEa58GZWURGyOc4SwuuQN
v87d8TjLbAGczRKyai5FV4RpY8h67bhis8Od0JmcuB2YzkWaX+HarX6Fa1Pgr/B0rqT6lbyS
9S9xlcVp+4t8hU3R7WV7H4USnEQiU6ADxZ0JiokY6Gu4q02LO66+VJsT32tnyEpSsh3fPiQH
mmIdTev1MHSn0hcNl8R1E4j3KH0IqQbUs0GW0FRmWbtgxai86TCxGMMFKm86pj8RMjjFtJ/t
ryNbNxu4SsPPPe6PJ5batCTRFWAIAX+LSdSpOGAvgxi/j53fb/DnRgjXOZxIvwvQsdCx3IOp
bJ0zKgxx1LBJJnLa3s6AWiikAd35jv6UXEF81KOMwhAEPpplqL4xU+n+RIOXSOBZ4lcpLMF8
aYokCHWn5z20Sl24XZpJvGInmtTTIvcxNPuDnUnWCfWCwqr0jxxIc0gAaT8JBDYgxADfLfCm
FVAwGXQWPvs2YeSZ7yfBg0ayUDlCtHa+O92xDsivVeF4jH+Fz3MsrxFVHt+2Ex4YllgtwK3i
AgGO7sKIwtJDQvufazK5PZjmybVXZEpL6yrbiM2o6cZ5yuD6zjTbjMaeE+JZxp47aXdzZ8XK
cIFkC3bUp3bnLbCBPUTF4dMT2bsQvmFaxIhAFAjfShELFCwmRxQDhloFahxL1Sme/skImegy
V3Rkl7SMl04IAb06O8C5byvMnWv/6cf4ZswJY6SdAYhiZBB1AL48CHB5tAL2VNKJOg5YU3la
BBQDMOPkqjCvs920RmEMHPfnBwOVj0U+mqelaAu+hiAN2zIuTOITTW+xwsF2Hb1BUxnwbGGf
j9Ej8wB8IHeFmEIO+gFOthc7cgIAZxuUblhhedYwsOSbkkxODlUEHwzSaOFE+L8y2AamA+ft
utMrP1LMLHt1SkvX0+P5qlC4cD8YLJzLD8IIzYARz7Wf/fcsqFvSkSE/UTI5fAGIEeoGHyzY
gif8mCdCXwYrHIHmWkMFIgeZ5gJwUYnHIa4E4mEEBh5wtIy6vxw41mQZR4gwU7wXz4L4oBsY
PGd6BKszuEf/g6Ex8uJZUY+4bmS9RhMsUqVBCgoIpnsL/8yYUilCRmJK5RhL0gTKWPMnoNJx
PVsgc6oFMMR4lpGDbpoAQS2nVQZMfAo6skwDHdNugD69KR0Q3BBQZYnmhDwwxMiWjtPjBdZb
go4PUohSurC1/xL1Vqwy4IqIQOa2McAQoUqTQD7oomWMjTxKwE/vFLgXpwXLUHvrr2pTke7F
doBY6AVzSrtgwNRFFoaY4lGBawrfAsTY5BAAVmwJoA3IGsL3ywuCvz/SDyaM1HKRBHMM6/iU
6+OmJc12nvEYYyNYHHus9oM7jG2eTo37tsLcf8iN/zytxCnPHV/B2qzaMPz8jTO2BFcx9vCh
aXEg69HgTx52fT8/go8MSICc30AK4sObPlsReB1b89BdRU3jPR2le/wQSoB7uPaywqus2FmO
wQEGJwQtbpss4Zz/msHrPd84WeGSJKQo7Mmbtk7zXXZnr10i3NvZ4TtxRWbFeddv6gqem1pZ
MvBbgB8FCrjIEou9roDvefGt6CYrV7llOgh83dqz5hmLB6l2hjt7rW5JYcQS1uBDnt2K97H2
ot21dhcMwJBDjBw7yuzYX2TV2ruU3ebVlti/u8sqmvPZPlO0IhEWRHY8s3dJkVX1AbelEHDN
98Rz81xYvpf1fmbElbxv2pnil+ROBHyzMrSZHNf2HHI4VKzX+KWW4KjhDmtm6Jb7guXz469i
+O0nYHXLMvwORsx7UjEueIp6Zm40GSPFXWWXmQ0XTWDPasULUolnv4ldPjQtvP+3wpTkc9Xo
XkLbcQgSVeTVTA4sI3YJwNGsACu7zF4DXoCmmFkeWksIVjHH4aU7oTPylZakZX/Vd7OfYPnM
hOFSiGYz8w1e227sTcC27Z4yaXRpZdrDCn9qLC9phDjM87KeEUnHvCrtdbjP2nq2Be7vUr6+
z0xIyoVW3Z62ezykhFjHi8b4QH9lhugeg5cYXVUaMoTLJ0O50Xy5aMkGwxqF2OtCe7o61dsk
P8FLP64GykeJ40Ui4OPzylGzoisRrpK1OT49gGFfNDmofVYG/mdlM58HnLTJ9rQl9LRNUuPr
lhTSFlS0FDBBVRV9bqA3X9/fnh55mxcP77i7qqpuRIbHJLO8EwYUyn462KrIyPZQm4UdemOm
HMZHCIQUxL9w11ii2kDCtuYdKj1RIc1Vlsq+sLltafaJ60q6Y8mOLLcIuNIPGwOwb8a/IJxP
9Wq/jAQng8FtL29XcMjTewxLp10AyW2m2oDRdKsGTxxIJ4gdlyRcbdTszke8MZPxjUC9FQ3y
rn9e8sOV/VwZ+ErE1iVWknrNxzChRDOl1WFboEGdi6nuSDQovU1Kuk0wtA+SiH57Df+jPudG
njIvVhlRzXQAu13RVKewfF2edBMDIGNP04ySyJZPMOtKYEhWke4kGogHEVaY/2VJtOeFz0M+
+BdGL/NtFDi8mXR/8mkykHofDxPeku3w9jxyvRJfH5TuKgmusitjrQwD/GCz5BsZlic7pNZg
Xs2lsTLY4VcXSxihyXjDY8UEsmrhpVEFb022t+BzrtpkaS9MQaOePPMWyQhhjhbjQFIrb+EG
S2J8nVAv9APtUbP8dlKGHnpEN8KB9jZX0MXTPGwIj6iLJ8I1iR4P0eB0A7pUY/kM1IVznNSr
ScgysMQ/FwyWxU9m2nhL35/kCWTLkX2HB4GLW2eP+Fz9OW457u/wOEDtu3s01p28jA0RYFaS
Axx60/aTLyXtZZHvJe14c4trngIcQrZbh13qxgtkADEvWM40YPee0pZrmThepAcBFHSWkDCw
PASUDEUSLB30ga7MmByjKFQdkfbkeLmMpiM2CH4a07Nmru7EWVB3LHX5mLd9Nqeesy48Zznt
vg4yHhUbAkWYov7729PLP785vwutqN2sbrot/I8X8EiIaMg3v42bi98NkbSCLVlpVJje0aSu
jAqXxZGPgkkPg32dvR/4hjOKV9ZuYFyXLveT90uj9EC6IpRh3YaWYa9PX75MZS1o2xsjVq8K
yGd41oJ1TDWX8duaGU3RoyVLLcg242oe1weY9fPzbhI01qTB3OtoLCThG8+c3VmKA6LTAqXZ
muwLdhL9LRr16fsVfGe/3Vxly45jqzpf/376dgVvl8I95M1v0AHXh9cv56s5sIZmbklFwVOO
5ftdzGpbMzXEOJjDmKqMwQPOZxRsxMF4NZUhfdNZnSxJxdju3iHn/1Zc81Hfxo40aXlakhlQ
fkAtmcKRHZvO8ZF4okmF5rInqHo9+WpWqi2qwMKvRwl/NWSTW85rFH6Spl0fzn+2ZNuEoDUV
iBkzmQsTH20/DgQfNWydtGmpfAx+ndpjZlBofosmz5s6X1kaXWCnBF8JJ3y2HVeWkkRYkedc
VU3aveJbSEATH0xAVTtMcHWdz4Ux+nZX8EwC3stPl2mExsgQaBZp7nM6WuAeJ/nksRtHAWah
3cPLKNCWMkn3FhYfHB3szsKZ57ioiYuAj15slD0PfNVAZyi5rloJchu7oT3rPJBelXSaM6VF
nkprWXLS/EcBgWsufhg78RTpdxpDyYC4TfguynL1AzjHWL3Fjy8At41EwKqDFAcygjPjmfQe
37QjBGDNK7a2DriBAd6TmxUQAO54W5SvPWjHG3DuBkWZ7JN65jhuynihja0eIqtVcJ9RzH5z
ZMnqe8VaZaQfIdP3CZ16ketO6SkFny3TfCT9lPBlbd/e4enU4LM6/XSbMjRNGLlYhbd3ZRyE
uBbd83DNNcRdpyoc8XIRYR+Qai+2pdQ5IrPXO4ir0hZr8p6p3cVowPQBp0HiqXGdeiCnBZcG
8bS5JOBak7jhNM2R04MpuUnWpoWNBi3CubEmWLzQnvyDnhM88Qe96zssnuvc1SfP3U2bgt0W
/sJbYN3WkKIktmku0jY0DMCoFEnMsXixsEQYHPo0CViABpDqOagXeMsFmZZ7XYLBONaiLZ/A
qN8AhSFQzXHVhC7S+VnpLVxkircHTo8xehyrkT+HugQlQky5mIgHwwmuu1mFnvpERuGH6J4f
CsuUeq6Hig6JnLa3ZY09M1TGoAuRxyetI1phmbjYIJDYNG9R9ubbw5VvVp+Ngk8yScp6bhBy
oejGIV4zJ7C4G1JZ0BC3qsiNg9OalHlxZ/mILQ63xoKZTioMkRsHWAsC5H+cfxT/Ag96DDcy
uL5ugT8gk1MhhCHExjvbOREjyAwp/ZjFiPQFuoe2AyDBXBuWtAxdH5H1q09+vEDobRMk+quw
HoFBOyc/endcmPLgOabeB/T7u+pT2Uzp3VumfjZfXv6AjfxH80HeQ8x295rxv2yBW4cmS4Sb
zFkeWh3sKqdoRq7pToNAwdESFdGH58VSf6ehdgPfmEnPcnSSLYdW+3X/KF15gH5XJeBSVvVX
dSuo2j1nlxyrjoSGGC54nTumbUYsd89G+fqykP2xCyKgmeSlvh+hS/aO8q5TFBr5W7gB+u/F
Ty+KDSDNIGvF9VOyJhuQij52sQuPswlN8hzc/GkFYk64Q73MNaQVbqQaEVJivObsgge0smQG
ua1FjwQ6Wd6EnMqMUqI6am+6GBM1G7B//Uup0Za04JVwVYDrLrR3VBZsJVNweWGjf3usVsc4
Evbq0dgenjbkmu8qIDViOGdV3n7CLtM5RwqBbCSHmZigDyUAoVmb1NTTygLXaIPFpQZUGTsa
rO2eUp1UrkPVwQ64KFFcYg3lAo/bmz2fC0jJZMgR1fWdCEFSZtV+QpR3fmO2A7U7vbBmf1qB
exLdc22HCI9s9oRlmdd6BTti7z67c11Je8ErHlm/Xf6+3mzfv59f/zjcfPlxfrtipiLbuyZr
D+js/yiXvkCbNrtb6d6cKbMftR3jcHQygEjGfhCX8kBp7IBeuJ6avNGvrddpv/Sg86Sty2z4
pHLlKRGerqFMOgdUJl8HsRV6kzyudDpBt6fviW1T0o1a4h4ompnMO48p70ay3UqYMOLH6UYO
XWww9NOQdEWw+4Ce5bBCKijOXdZ0Wklp5LRVj/4GCM5XtB7LioJU9XHoFawUxQ6igfEps9sr
usaWHDLAwN8PF9WKyJV3KoD186Bz/5J8uzz+Ix3M/ufy+o86/CGjLU2xa/Mxu2HDj31LvBbw
1ccHCiYOAbTWHzGaB/j7X4MncOwZONhTDJ3F99GScUR3z6pgSZpkkcVpnMG2dDH30iqTiDh4
Uh0TqaVwy4Y6tgoOT3M/Kol1Z6/y3JZoEQ5JgHbrKo2cWD01VrB1fuQTUIhlxSWpZbQpsvaW
728rXqvdRBOUiejlx+sj4jGff5O24og3UBxYc2p2YAh1VaQIFXLoitzPQrAThigtXKIyrlxp
lcEKpExgkhcr1GNczptpr5z3y6CK5xeIW3sjwJvm4ctZXLjd0KmLkI9YlcsJ8aVOHlmuL8Af
iszJbPH2/Hy5nr+/Xh7RzUkGBqNw7IsujUhimen357cvyPZAyP937aeQzSZtUETGL2k5DrsB
8F4L/syGg5PLj5fPt0+vZyXKxrga99xTt2oTDvAS3R9ZU1773+j72/X8fFPzgf316fvvN29w
2/4376BUN5wkz98uXzgZnEipDdpH3UNgmY5neP5sTTZFpU/w18vD58fLsy0diguG6tj8Obq2
+nR5zT/ZMvmIVd4d/1d5tGUwwQT46cfDN140a9lRfOwpMKjru/349O3p5aeRUa9nSVc3h2Sv
jicsxWBq/Ev9PSpooL2t2+xTX5ru583mwhlfLmphOojrcIf+SVldyWvZUcKqTFwrFY58pIUi
xgBvPMBJ7DiHVBguhWlDEgvcEEr5FqEf6X3JU7MRx0qesoN2pZ8dWSIsOEQG2c/rI5f9cvJN
s5HMJ5Im0imzen/YQW1+X1e4KX7HsqaEKxqWe0TJYhqMmXgnECvm+Ut8fe8YuVLj+EGE+akY
OTwvCJCq9JZGs2mjKPaVbeAIdNZIZqbWJb7HWRU4+uvaDmlZvIw8LFJJx0DLIFBP1Dpyb8GN
ZMmhZGbHwTfGtXpHlquLbg47wf16rXqRHmmnRAsVpQBgdVlXdI+b8ADjbp2vBbuecWf1ATsG
5LPyzzVF00xYxecpTM6BxdVLS2+7PR2+IEuOLu1kTSaPj+dv59fL8/mqTR+SHgst5FlHELst
najeqHUEfU+2KokTqzELSuIvJr+7nIeC810gH10yKAnS/Clx1UfnKfF0pTYt+T7MolFLDA2u
CYhu4Sz6odtVicIgpw56a7OOzyPHHNeSdkeaYp/fHZO/ds5C9bNVJp7raYbTJPKDYEIw/agA
OQxxc3IS+6qHWk5YBoEj3fWbVCPPJX7ZUR4T3oVqqY5J6OqyirJd7DkWvxUcW5Fggap+xhiV
4/blgWs3IiL505en68M3sBbjK4A5iqPF0mkDdYBG7tJRR3AULkIN579P+ZqvY4PfSw1eqo5z
ksThey0HlhlNaFWHrKgbOCViWYJbtG6PhneEgiWuH6GGvIDotzuCtMSNU2El8dDrZNg4h6rb
mDJpPN/VbvUqso/iBXZbIxcELqGJGvhNBDk5wDprWlgKhDYQPRBSvE/pB6PdRoQD2DaXpmJF
L+tUWgqPH6Os5O1t5MdERovYwdYMAVI+25Th0d1lg0WdntFtEQJd1B07NlyHzuKktUunDB5l
1cfBPDdw1aG9fr28XG+yl8/axgIETJvRhJjPf/TslcTdVuH7N65STnYIA1V+4+v5Wbx+khcv
2ocJK3jfN9vu0Alpg1WZhbqYh9/6gpEkNFYDX+bkU2KcA0L+eQsBD+mmQR8T0Ibq5gaH+3iJ
+9ed1EhbXbVjNDNcCcKhWPohyQt4U1htimGHuH363F9hcf7usEJtf5xB/UZJh+xlO8pdIm36
dNNMp6CaIV+c9AxxrGuKLtCtHKd8yD7I0YWL2mAR+qpgDbxY6yVO8X3UG0UaBEsXrJVppmUQ
LL1WI4SxJqqDcBkax79wS6KbOaZNzeyRdalv81tUhq6H+oDkQjRwFGMO+B27WoxjLlb9CD2n
40KHlyUIIkUIS+EBxdYip860ujRv40Pm84/n5/duW6kOggnWRYs8/8+P88vj+w19f7l+Pb89
/S9Y7qcp/bMpisGDtziHEodCD9fL65/p09v19enfP+BGUv3GLJ+0z/j68Hb+o+Bs5883xeXy
/eY3/p3fb/4eyvGmlEPN+/+bcgxpNltDbTx/eX+9vD1evp95//TibhBdG0eLsiV+6zNmfSTU
5as/TtN5y2bvLQJVi5MEU2nrZuHmrq2n2mPPwzZe/yrEGCvTGkk5dH74dv2qCPWe+nq9aR+u
55vy8vJ01RqArDPfMOaA3efCQa3/OkgLLodmr4BqiWR5fjw/fX66viu9MYqO0sWjKqZbpqoz
2xT0McX2csuo6zrmb71ztmzvqr6j8mhhOI/jFBdXTSeFljOTT4krvI95Pj+8/Xg9P5/5YvyD
N4JWqVWZd4MKqdj6WNM4UndJPUUv/K48hkrh8+oAYysUY0u9wtQAVWJ2Q66gZZjSo40+DNRe
vthrKN/MiPBnWE+Ct21S4Nsikv6VnqjnYDowSfdHPsSUOUQKD1yxKQtEk9KlZjUtKEttJm8d
8Aim7jM5BbWhSErPdVQrPyB4rvbbE+EtxwsSeHaIXs9wIAwcXIHoYuK1tTJwN41LGl5dslis
Te1ILN60cJcLB/XQpbG4ihWIoDiqgeJflIgALKq9VNMujPeKRsZDAEZlN9IaTxBH6MAlg48/
KCZH39es4TuKEk2wqonjqfa0dcN4Fyst2fAauAudRnPH0UsIFB/dUbCd56kx4fmg3x9y6qq+
zXqSPnVYQj3f8Q1CpJh49y3GeMMHoTZUBAk1XAUkilyD2Q8slrB7Gjixi71YPyRV0QXWGlVl
QfOwljhkpdjkKPYXghKplCLUjnLueXfw1ndU2aDPfWkd8fDl5XyVG/jpakt2nRc69bd69LRb
LJeqmO+OhkqyqdQ1eiAaiy/ZcJGijrIy8QLXVyidsBNpxbo7kYN9tibc9/C2TALteNUADK9/
HdiWurWfTv+/yp5sqZFk1/fzFUQ/3RvRPQfTQMNDP2RVZdk11EYt2PBS4QYP7ZhmCQxxes7X
X0lZSy5Kw32YoS2pck+lpJSUo0Vs8A7hRlGN79uv1+3zr81vQyQnBaJdGUXohP1Zdftr++hM
jcbpGTwRDDGRB18Odq/rxzsQUh83tq5KL3dUbdlwFkh9iNFfYbRwaquJr8UQ5J6fXuH42TI2
zJMjfTeCso9e1Tq3OTnWGTqK7Yd6Kn4EwL6bPmnKlAQdbUg9rWBbCD141WNIs/J8Njyy7ilO
faLE6ZfNDg9bZgcF5eHpYTbXt0hp2EfVb/foH86gQFSatBClC9j4Rv6ICJRu1id+UR4ajC0r
09nsxCPWABL2ora3s/rENEjRb7OdCNOzfvZb0nqrSYeaDKA5Odad6Rfl0eGpVvxNKeBY1zxN
eoC9/ZzhnySdx+3jPbd5XGQ/kU+/tw8oNqLn/d0WF/YtM610XuMj1FNUaxKJClMDye5KX7jB
zPLNL32+YFUcfft2zNr36io+1DT4egV1G6ISEpyxpV6lJ1/TQ+al8HHs9va4dw/YPf3C+HOf
UVfzBdhLqbjT5uEZFVNzv0yrNF2dH57OPKo/IT1pIpqsPDzkzBiE0MIbGuBphzPzGAfIEZ8k
imuvZpRtOD/cq0x2yg2QugY/D4KX7d09cx2KpKE4n4WrY40jIrQB0ej4zITF4mK8qKVSn9Yv
d1yhCVKD+HyiU/uuZI3Xt+FH76RmgCYvv2kpAxgf2YobPmIW8ZSag/U7JqTuwDpAbLfSCc44
yBlUlBzDEy1B3UJTtKctzTI1mwKATr0Qro7j6vLg9uf22U3HChh0HNLEIhiSxJBzIlkJpDM0
NbvAsbwSXyZWSWAnZagQVQSnXJj4wmf7N2iTsggbTxZU4MCywbvLpirSlLl0LBfXB/Xbjx35
PUw9HJ7pA7SmCE3ALktAeYwUempymHUXRS7wivgIyfh5gc/7sAco4QMkC86tGElwKSbZ6iy7
xBq1yaQGrvClKK2ZGrJcie7oLM+6RZ2YC1xHYi/8zYOlV7oJzPQWiLJcFLnssig75cOQkawI
ZVqgubeKpLEAEKlcFqSV0Gni5cbsjaWicwi0zrhLp4Iq30NjSZSif9SfMuTzU2Rh4C6dzQtG
fNHp8aDsStyrV/vIhhZXQuM9MKbHAx8Vj3cvT9s7w2yRR1XhSe83kGuykuDc9IYQaf2nzQJ7
IN6A1ZEY3cIWy4PXl/UtCRI2XwBuY9yCKR9mNKYbz8iMCKixa0yE/XI1gOqirWAfAKQuUsni
pvQjD/aU25mhB2uZ243RulXOtRBNzAtW4fuiwGesa2kHRfxabwK9IpbNq4E0vOKSCxBVUCXR
3HBs77+JKylvZI/nferV9V6JyU3Coi1TT4YaqqeSc19mX8JHnifv4prPJdpI7nyhDLLQkBW5
kdiKIedzCdohaEnzb+dHvBsU4j0ZsRDVR0lw2qXjRVdmXVEa3KH2vH+cJpkSajSAuhkOmyq1
+UsF/84tDtKjYVpy4+l4kCC6y1ZEkTQEe0teUVcl218ghxGL033qQhEuZLcsqmjIqzLJTQKF
cxDMQY8tRVUbFQOoqBMY7FB7klKu0GE3NsI4BlgXoNMyDBlnOMOoKHTVvgAhXz//8wjvxK89
eCgUzrbqusQs0x4wrP+5cR4A9grOXzY1TVznRZPE2jEX2YBEAcg3UKtSjHRTRT2sH1d0eMqS
GtYImxTmsi0azfJLPzF2CRNNqWURG46IZQXAnmwpqtwYGAW2kscoYAN8QIPFWdNdadqqAhxZ
X4WNNsmibYq4Pu70+A0FM0AxjFCnnwQhALQrQhWBpH9RwLyk4rozwzwmKCatTirYGR38YXc3
RyvSpYADIgbBreBz+GtfJXkk+eBPjWgFa4B6/B5hJmHoivLaOfPD9e3PjbYL45q2ob6E1b6s
G9HULniR1E0xr4SRrmhAOklNHIoiQAkFlO66YU+1vnlKPNlt3u6eDv4C7uEwD3RtN6aYABem
1wHBMDVaY3A6ApcCwx6LPOEdiogGVIQ0qmRulViibwIm78Uhau02hGVLTiWKvfaYC1nlemst
SQV0HJNzEWBicz7dGVeEaBpPbul2Dns4YDPDgGBEQWcgcBgRSPhHbSbdVuPOw1hOUqtIX0x3
I/XgtKLCwNKhrIEhE2u0dtkI7CNNLWNLT/VnHNdHxp4dID2zOXTgS2C1cnQaHeub8Bg9jAw5
5tUcRViDPCc8j0yMRTmzYBAMb6HjmVDQ0aCNiSK5UVmHrJLTG36jK2yFCfH24dvA83ZG36ys
iGSXg4LzLhGw/MI+uFhCfLzePw5EEosrkHmha5rCECQWCx8gIFFdoRN9pAZRH6KRxDdKIwEO
7jsUdcNd+ii8wHF2U4CNH9Pksy2rZdh6h23qYtssZN4kof/JihAYridIqCoyKobXYikylEXB
AQ+i14W+ezk9K9UVqrQesg9+/7TdPZ2dnZx/mWlh4UiAr/EQcz3+yntUGkTfPkT0jbcPGURn
tsMrT8TbAyyiD1X3gYafnX6kTaf8XaRF9JGGexIXWUS8ndYi+sgQnPIe4RbR+ftE518/UNL5
Ryb43GNoNomOP9Cms2/+cUrqAtd+x9vvjWJmRx9pNlD5FwFlh3i3Lf7vBwr/yAwU/uUzULw/
Jv6FM1D453qg8G+tgcI/geN4vN8Zz42FQeLvzkWRnHW86DWiWy86w+SGReZ5KmigCGUK58I7
JKChtRV/BI5EVQGHy3uVXVdJmr5T3VzId0lAz+MfjRkoEugXKNj7afI24U2ZxvC916mmrS58
WfqRpm1izu8nSjPjwjbNvBkb2zzBfawJBgoAklWViTS5oWN9zGWjS9aGYUR5I29u317was9J
qoMPjekKxTUqmpeYEaSzNDjQ9mvQr2BdIBko63NDtwj6z7lbN3yuRkZWXb1Fw4HDry5agEQr
1WNbZgqNXvTBPCs1XWM0VcJalgZK3XNDQQyNaSivl1sYjJaE1vtZt4qrjEGXotEy0FCSBso9
kUuVoBd16Q4ToIQUKaFRWkR7UCD5pimmvdhHg8dBXeqP1MQgdaItR1mKdd8qGPWQvkS5eiHT
UrcLsWjVz0//3v3YPv77bbd5eXi623z5ufn1vHn5xEweLFrYh54nekci2Gf8fh9JmiIrrnkW
NdKIshTQVJ6jjlTXIuNiIafGiBhvzBJuDaAVLyqWOTpismtVJ+ikqDyP/5E1kehQr5cpTlHo
alL7qdGwNu/X/XslEzZCHUF4M1tPpdkgfEc6F8AIJYcU9XWWSdyc1vaeSDS2UCljn2E1VkRj
Tpyeal8jKYW3pkolmTB+dJkUdYvXEWHVJdHq++xQqxLwoK1gfZ4oTSDI5yyNRlEnE4lZ+ZBg
fcR+2j6sv+y29584qoWoF129EIZzAkdwdMILPi5txl2+22TfP+1+rmdGk8jg0ZUFHNDXZpcq
KaIJYVQN264S1hOTzEz4lwkQwTHUSrVhVM4w6wC5yowfHSrMoLK2rb5NCRFFSp027fiASQvo
weqEDzTth2U6c4R2lY+b/ROGV9w9/efx8z/rh/XnX0/ru+ft4+fd+q8NlLO9+4wZlu/x4P38
4/mvT+osvti8PG5+Hfxcv9xtyO9oOpPVfdDm4enln4Pt4xa9t7f/XfdBHeNqTxrkwrCjkTPo
GyvB7P3qODHT+Wv7StHg3ZlGwtpMPe0Y0P5ujFFOttAxGgTx3C+G+6/w5Z/n16eD26eXzcHT
y4E6NbQsL0SMlx6CMqJy4CMXDiuTBbqk9UWYlAv9jLMQ7icLI7GcBnRJK/0WY4KxhKMVxGm4
tyXC1/iLsnSpL8rSLQEtYC4pyMBizpTbw90PzOsjk7qLkloEqaTU37VDNY9nR2dZmzqIvE15
oFs9/WGmnIxghitHj2n4pHfD3CeZW9g8bfFKnSSeFYW5qQuFtx+/trdf/t78c3BLa/n+Zf38
8x9nCVe1cIqM3HUkw5CBEaHdBxlWUc3JLcOgtNWVPDo5mZ0PbRVvrz/RZ/V2/bq5O5CP1GDY
nAf/2b7+PBC73dPtllDR+nXt9CAM9WxR/aCEGdOycAHKgzg6hMPhGoMD/G0Ucp5gcl93+8nL
5IoZiYUALnY1cI+AItxQ3ty5zQ3ckQzjwIU17soNm9rpqgzdb9Nq6dAVccAMSQnN8Q/DqjFu
L4YNK6+Xlef9s2H88O3JpmVzxfXNxqQuo5vKevfTN1yZcMdrkQlu96z2duZKfTT4V292r25l
Vfj1iJkeAisXFR7pjDZBYXRTjoOsViyvDlJxIY8CZsQVhs2aNlbXzA6jJHZ3AlvVsANc3hgd
M7ATZrCzBBY9Oa3xFpKBv2TRjH0PTsObb2FMCJ8UOVF8ZbMlD3tVCaoOEIrlwCczdxoB/NWl
zRgYXvgHxZzj6fNqxj661eOXpapZyR3b559mPrmBIbknFMBUfikXnCfjanW2Zt4GbHzogK9C
dwkEabGkZMk+xJDDwdkdAvNHJu4ZEwo05gyJHxxODdg97BnRp85kRcwYxfTXlTkW4kZETMW1
SGuxb1ENZwj3Lf/+54itSsxK5SwxBe/qWh51J2dut+rsmKmskXuO2GZZ9KmtWbh/3AeCE/PF
jH/1GTqfMZLBEPzHoY973dIu0bqwNJFnx+6WS2+OOdgidKB4kTnsm2r9ePf0cJC/PfzYvAyx
5VxL8b2vLixRAnbWTxXMrUTCOmbBnUQKo1is3XXChexduUbhFPlngk+CSXSC1k1smkTbcUrH
gFCtsfs2YjXFwm7vSFOxFg2birQZZhegL43/c9L6kzy2Na1f2x8va9DsXp7eXrePjCCQJgHL
BQmueJaz9gD17tGJRGpTj4mtuSoUCY8aBdr9JUxyL4fmuBfCh6MaJPXkRn6f7SOZqueGghN7
ObqPi8lIPR6odlGLJfOhaVqhZ6+nXmvIsg3SnqZug55srEEjbMpMp2KqRENKF0o0LKPbgZyc
LCfXgYuwPkPHjyvEY3GKhnOWAtJvQ554T1HfSI/DcjjrbTJHI3gplbcl+eT07hDjlsAY+b9I
HdrRo5q77f2jivC5/bm5/Xv7eD9tD0ppJMnEBxV+/3QLH+/+jV8AWQf63x/Pm4fRdKa8Hxgr
pxdfYzJ8EytXDbpHT0PqfO9QkLPM9+PD81PDFF3kkagcoys3aqpc2M2YSbtuvC2fKIjT4L9U
Nv/B6e4DYzsUGSQ5to58QONhclIvo8K4GKNJQQJSISa31wZoCEsBgTEP8Z6kKjLLTKGTpDL3
YHPZdG2T6D4rAypO8gj+V8EgBLrpOSyqSPfth45lssvbLJD6++rqhkukbsElvcmeidJFWWDy
GYQZ6GKU83oH88Q0xoSgusNZZ4BmpyaFq9VAVU3bGXJU+NUwvaDmNd5AGgcUYYCvyOCaV0k0
AutAIYyolj5DvKIIEt58E54aMnVoiDihFvsHHNVVQkPNDmHrjnS7wDH+SuRRkWlDwTQM5K/R
YW9qEUIxNsGGo2sZHt3mLcKNOrwsKEhsTMkkx/FwvkaQ8BhyAnP0q5su0jP9q99kFtNGpodS
4BGb1L8nSIQ+az1QVBlTFkCbBewjf2E1HBVuy4LwT6Y0z2xNPe7mN3pAn4YIAHHk7k7mNlfU
dREmsNWvJDS/EsZtbo37WQ86UiB6icXY5wiP9ButHJSgrqaEmB0wr7l+1YwwevOjKI07j4iu
ZhKv10E9T1UPtKIudfaUFoZtC3/vW/Z52nsxDjssvekaoZnRkuoSpSWtiqxMjLcymWvGKMkM
EvgR608pFklE8TzA1o2xhvEfpukqqgt38uayQa/MIo4EE9+I33RfmTknBLlz6i64cYG6pu3f
SdCz3zr3JRC638NAylCjHdzBw4ulSHXfBARFstQfpEZHiHzO+oM456h5DzVIOQR9ftk+vv6t
QsAfNrt712OEzugL6q4hjSlwKOxw0vFEpDC1Li3mKZzU6XjZ8c1Lcdkmsvl+PC6MXhJ0SjjW
vFDwmrBvCj2YxJ4g0XUu8E1e7y64zgK81exkVQGlkS0bvujgP3yKuailPszeoRt1+u2vzZfX
7UMv/+yI9FbBX9yBVnX1CpwDw3iQNpTG204atgYZgOdsI0m0FFV87Pk+aGLm63kU4EPGSdkY
jjx0t5O1aGZaSN0RJa5g9Cia5/vZ7FxLioyrtQTGiNGVmccDGZReKhioWIKFxGhqDHGB/ZBy
CYjRKz4DaRhI0sQMKFJdBbmYvKiypM5EE2oM1MZQJ7oiT6/t3pVFYoawqaKVi8VSigtKDB2W
RsL5D6+Gf+kPRfRbNtr8eLu/xzvX5HH3+vKGmb20dZOJeUIBKvQElQscL37VxH0//D2bBlWn
U3Hk3kWk+1ERbyV2dQFrRF9T+JvTTgeptQ1qkYO8lycNzpRIDUsqYVkXevxKpHA2ZCoBvfNU
xt7BMnuivGLsGcQolEEV6S/Dx8L0CE1ytQU1DJOiehztVYFISIcr71SPxRTLnNeFSQUukrrI
LVcZE9PlhRpLT4i9SXwjK85kOLUWNmFsD0tVRALD7tQhY6stTdRmRgipgux9kESVq2K4eIo6
bYOBjFsOhLdCy2hJ9vMLAlYKO9HldQNmT7uUr0WLRw/fNuB5UU8lQRskFugdVd1nZYDQfVnv
bGlVDsiK2z4jtpyDOjCvLZmBZEVFAkJgK1KmZIXY03GVsJ98RpgWaMNLfccowTgtlm5NBpqT
DEJq74XALe2Y9RSYyvg+c7xTpg3p1LqwHulTt5FIf1A8Pe8+H2Dq0rdnxXcX68d7w76Qw2LG
uColP3NgjCZuNSuhQpL42GrvJKLvXVuOWca1E6aIGy8S5RhMbZ7pZFTDR2jGpk1npagiqzLP
zCOyW7To6SZqfl8sL+E0hDMxKqyozDFYe98gK4dkOPPu3vCg01mqsaOsYF8FNKUhgg3bfvI7
Yso29w1O0oWUpWKlytaEbgTTWfE/u+ftI7oWQBce3l43vzfwj83r7R9//PG/WnIw8qvEIuck
e9uyflnBsteivE2HTGy4d2uj9tc2cqWbqvuF3b+W5RxXPPlyqTDAI4ul6Y/c17SsjRBLBaUW
Wpog+bHK0t3hPcLbGXyxEKWKVPq+xuGjOxPuaVZ90GDhoi7Y9RanYUWOneTUn//H1A4FNhU+
LgAcxOKuxIcIOcFIMoSh6toc7yVhlSqDEHPaqDPOw5X+VgLL3fp1fYCSyi2aSo1cEP14OVHO
5rn9Dr7mQ6kVkgL8E5CqWRp1/nZ0/ocF5Qx0JB6DB3i6ZK6OEDQZ5YQ8psmqwpZjDGo/VWFr
bzEAKfvzCOfXCdLhG0oM2PpgUkMQhxPOKymAlZc1F6I+JEIzumLtzcteTagGBWFY6gKkyfC6
KTT7D90GTuvP5TZ5UaqWGoEEMDpxmytlZj92XolywdMMCnNsLX0G2S2TZoHWF0cUY8j6jAZo
NLDJe7KMMoRAeWhRt0gwBh/3HVGSGmYXEvYfqlK01UFlhyYbJfuJ/RoQvW9F9Ib6CH+A3TRd
Dd0I3UErKykz2BygRLGNc8ob5Ge7oJ6QMSNZM4HCAFmgpqLHRWrNPy/Fkvy6h0DrEo2J523B
6hKEkXhvTXSQ7yFYLGH5MwSDhpolhdX5fq3068FMeUDFdHUuynpRcOdtANwaprB/yXpwqtb6
reAiB94o8OpMfcA+z9sCdSD7AdImp4wd2LAdbLhVwjQqeNHWJ1/lg6xwCNRyVQm7nGGgVdgF
wFkWmah42U7bBO9QDhWKFO3UdMXKWYxCfFeuH8Nx0U5Ls5+5RgD3LR1zPNusd4nHFeIz72tr
mYyE1nGAZ0oSgTK+CJPZ1/NjspqjGqS3vBb4Xh83E5oGRqnCkpoEqSXZ6uh4+312yh1vptDh
7nkVCdFbNzGx3XTHcXba9RZJ4gT608D6V56yomDu+YDee1tFgflchzq8uMxQUdEG6ejFbn2B
aUPS1oya1Ln1NG9T16cLG+gi3r5EuAL8Fw74uAhN6eHKfNpEQ0g+RHSkaP2W45HGm9+itxCT
HRqVM55PhqXwWp9VCeiVdO2OYZ4l+7qvRomsc7o8UbYY+IFiuK1WtfkSUwRVjjFzFGDMxapf
HTSb3StK1Kjbhfi65fp+o0WWttaOIYBvSyqkXNGucoSwQSxFg3xR9fzNm66NjJssjWlxqIGP
A3dSS640r3RBXKDTFBqCrAd91XheIzOXD5khMvwwOXE06hrm/wBUF4GvSzwCAA==

--NzB8fVQJ5HfG6fxh--
