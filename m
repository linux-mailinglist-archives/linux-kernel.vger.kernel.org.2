Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F588374EF4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 07:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbhEFFnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 01:43:22 -0400
Received: from mga03.intel.com ([134.134.136.65]:41212 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229622AbhEFFnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 01:43:13 -0400
IronPort-SDR: n20ssUwdSdbVPZVUQ4yfQ8R1DvKqhNtVdBEFnJBa3+WmmY7P5hBtIvgRMmnSJ0TKnfGJ12vByq
 WHnRPuZwoovQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9975"; a="198436145"
X-IronPort-AV: E=Sophos;i="5.82,276,1613462400"; 
   d="gz'50?scan'50,208,50";a="198436145"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2021 22:42:10 -0700
IronPort-SDR: WHy/ay00ZR+F2aJEpsEkIvB+Reed66k4Bv3PRonf3wjl2oc1RXsQohwALoB5T8dAFQvMtE8+nL
 qgSDInxS+O1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,276,1613462400"; 
   d="gz'50?scan'50,208,50";a="469294536"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 05 May 2021 22:42:08 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1leWlz-000ANL-FE; Thu, 06 May 2021 05:42:07 +0000
Date:   Thu, 6 May 2021 13:42:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/gpu/drm/bridge/sil-sii8620.c:2355: undefined reference to
 `extcon_unregister_notifier'
Message-ID: <202105061353.G3x3UcCm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Masahiro,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8404c9fbc84b741f66cff7d4934a25dd2c344452
commit: def2fbffe62c00c330c7f41584a356001179c59c kconfig: allow symbols implied by y to become m
date:   1 year, 2 months ago
config: i386-randconfig-a004-20210506 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=def2fbffe62c00c330c7f41584a356001179c59c
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout def2fbffe62c00c330c7f41584a356001179c59c
        # save the attached .config to linux build tree
        make W=1 W=1 ARCH=i386 

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

--opJtzjQTFsWo+cga
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--opJtzjQTFsWo+cga--
