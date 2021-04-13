Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDDD435E6AE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 20:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347869AbhDMSu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 14:50:59 -0400
Received: from mga12.intel.com ([192.55.52.136]:2441 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232517AbhDMSu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 14:50:56 -0400
IronPort-SDR: 7IchoAjGlWWbr1dEo7P3LZkYRHTbyFgRkvO4vlpLC/1wskXOsn3JuR5UNe+Np0uYXimdMzMIEd
 uSWhyZCtoZ+A==
X-IronPort-AV: E=McAfee;i="6200,9189,9953"; a="173975360"
X-IronPort-AV: E=Sophos;i="5.82,220,1613462400"; 
   d="gz'50?scan'50,208,50";a="173975360"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 11:50:29 -0700
IronPort-SDR: ZwNTCl0gS635QjrK0JkgUbq1dvZwGzOl10eE2WvP9glSi5Vr+C4hM4bAfa9z1PV+L4U7HFbYY5
 GdTPnqoY8R9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,220,1613462400"; 
   d="gz'50?scan'50,208,50";a="600440817"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 13 Apr 2021 11:50:25 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lWO7E-0001DL-DL; Tue, 13 Apr 2021 18:50:24 +0000
Date:   Wed, 14 Apr 2021 02:49:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/gpu/drm/bridge/sil-sii8620.c:2355: undefined reference to
 `extcon_unregister_notifier'
Message-ID: <202104140246.sEA7JTJP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Masahiro,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   89698becf06d341a700913c3d89ce2a914af69a2
commit: def2fbffe62c00c330c7f41584a356001179c59c kconfig: allow symbols implied by y to become m
date:   1 year, 1 month ago
config: x86_64-randconfig-r006-20210413 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=def2fbffe62c00c330c7f41584a356001179c59c
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout def2fbffe62c00c330c7f41584a356001179c59c
        # save the attached .config to linux build tree
        make W=1 ARCH=x86_64 

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

--2oS5YaxWCcQjTEyO
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
cirY78MBAA==

--2oS5YaxWCcQjTEyO--
