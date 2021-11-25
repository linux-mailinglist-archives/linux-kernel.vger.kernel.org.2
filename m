Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 352DF45DF6D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 18:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241205AbhKYRQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 12:16:18 -0500
Received: from mga09.intel.com ([134.134.136.24]:11030 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241288AbhKYROQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 12:14:16 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10179"; a="235366702"
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="235366702"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 09:08:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="539030792"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 25 Nov 2021 09:08:45 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqIEm-0006gV-Hk; Thu, 25 Nov 2021 17:08:44 +0000
Date:   Fri, 26 Nov 2021 01:08:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     kbuild-all@lists.01.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:for-next/kspp-misc-fixes 3/3]
 sound/soc/sof/topology.c:2230:47: error: invalid use of flexible array
 member
Message-ID: <202111260100.ucJw3jNQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git for-next/kspp-misc-fixes
head:   004a9cea9666ecd470e442ef776a22d24870bba9
commit: 004a9cea9666ecd470e442ef776a22d24870bba9 [3/3] treewide: Replace zero-length arrays with flexible-array members
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20211126/202111260100.ucJw3jNQ-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git/commit/?id=004a9cea9666ecd470e442ef776a22d24870bba9
        git remote add gustavoars https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git
        git fetch --no-tags gustavoars for-next/kspp-misc-fixes
        git checkout 004a9cea9666ecd470e442ef776a22d24870bba9
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   sound/soc/sof/topology.c: In function 'sof_process_load':
>> sound/soc/sof/topology.c:2230:47: error: invalid use of flexible array member
    2230 |                         memcpy(&process->data + offset,
         |                                               ^


vim +2230 sound/soc/sof/topology.c

311ce4fe7637d96 Liam Girdwood         2019-04-12  2160  
cac974a51ebb955 Jaska Uimonen         2019-08-09  2161  static int sof_process_load(struct snd_soc_component *scomp, int index,
cac974a51ebb955 Jaska Uimonen         2019-08-09  2162  			    struct snd_sof_widget *swidget,
cac974a51ebb955 Jaska Uimonen         2019-08-09  2163  			    struct snd_soc_tplg_dapm_widget *tw,
cac974a51ebb955 Jaska Uimonen         2019-08-09  2164  			    int type)
cac974a51ebb955 Jaska Uimonen         2019-08-09  2165  {
cac974a51ebb955 Jaska Uimonen         2019-08-09  2166  	struct snd_soc_dapm_widget *widget = swidget->widget;
cac974a51ebb955 Jaska Uimonen         2019-08-09  2167  	struct snd_soc_tplg_private *private = &tw->priv;
c81a4ef725362db Guennadi Liakhovetski 2020-08-24  2168  	struct sof_ipc_comp_process *process;
cac974a51ebb955 Jaska Uimonen         2019-08-09  2169  	struct sof_widget_data *wdata = NULL;
cac974a51ebb955 Jaska Uimonen         2019-08-09  2170  	size_t ipc_data_size = 0;
cac974a51ebb955 Jaska Uimonen         2019-08-09  2171  	size_t ipc_size;
cac974a51ebb955 Jaska Uimonen         2019-08-09  2172  	int offset = 0;
c81a4ef725362db Guennadi Liakhovetski 2020-08-24  2173  	int ret;
cac974a51ebb955 Jaska Uimonen         2019-08-09  2174  	int i;
cac974a51ebb955 Jaska Uimonen         2019-08-09  2175  
cac974a51ebb955 Jaska Uimonen         2019-08-09  2176  	/* allocate struct for widget control data sizes and types */
cac974a51ebb955 Jaska Uimonen         2019-08-09  2177  	if (widget->num_kcontrols) {
cac974a51ebb955 Jaska Uimonen         2019-08-09  2178  		wdata = kcalloc(widget->num_kcontrols,
cac974a51ebb955 Jaska Uimonen         2019-08-09  2179  				sizeof(*wdata),
cac974a51ebb955 Jaska Uimonen         2019-08-09  2180  				GFP_KERNEL);
cac974a51ebb955 Jaska Uimonen         2019-08-09  2181  
cac974a51ebb955 Jaska Uimonen         2019-08-09  2182  		if (!wdata)
cac974a51ebb955 Jaska Uimonen         2019-08-09  2183  			return -ENOMEM;
cac974a51ebb955 Jaska Uimonen         2019-08-09  2184  
cac974a51ebb955 Jaska Uimonen         2019-08-09  2185  		/* get possible component controls and get size of all pdata */
ee1e79b72e3cf5e Ranjani Sridharan     2019-12-04  2186  		ret = sof_get_control_data(scomp, widget, wdata,
b2f3e0c9e4ee2e0 Jaska Uimonen         2019-08-22  2187  					   &ipc_data_size);
cac974a51ebb955 Jaska Uimonen         2019-08-09  2188  
b2f3e0c9e4ee2e0 Jaska Uimonen         2019-08-22  2189  		if (ret < 0)
cac974a51ebb955 Jaska Uimonen         2019-08-09  2190  			goto out;
cac974a51ebb955 Jaska Uimonen         2019-08-09  2191  	}
311ce4fe7637d96 Liam Girdwood         2019-04-12  2192  
878694dcbe51794 Keyon Jie             2020-08-25  2193  	ipc_size = sizeof(struct sof_ipc_comp_process) + ipc_data_size;
311ce4fe7637d96 Liam Girdwood         2019-04-12  2194  
cac974a51ebb955 Jaska Uimonen         2019-08-09  2195  	/* we are exceeding max ipc size, config needs to be sent separately */
cac974a51ebb955 Jaska Uimonen         2019-08-09  2196  	if (ipc_size > SOF_IPC_MSG_MAX_SIZE) {
cac974a51ebb955 Jaska Uimonen         2019-08-09  2197  		ipc_size -= ipc_data_size;
cac974a51ebb955 Jaska Uimonen         2019-08-09  2198  		ipc_data_size = 0;
cac974a51ebb955 Jaska Uimonen         2019-08-09  2199  	}
cac974a51ebb955 Jaska Uimonen         2019-08-09  2200  
783898ce68de526 Keyon Jie             2020-09-04  2201  	process = (struct sof_ipc_comp_process *)
2263063fc4880d5 Keyon Jie             2020-09-21  2202  		  sof_comp_alloc(swidget, &ipc_size, index);
cac974a51ebb955 Jaska Uimonen         2019-08-09  2203  	if (!process) {
cac974a51ebb955 Jaska Uimonen         2019-08-09  2204  		ret = -ENOMEM;
cac974a51ebb955 Jaska Uimonen         2019-08-09  2205  		goto out;
cac974a51ebb955 Jaska Uimonen         2019-08-09  2206  	}
311ce4fe7637d96 Liam Girdwood         2019-04-12  2207  
311ce4fe7637d96 Liam Girdwood         2019-04-12  2208  	/* configure iir IPC message */
311ce4fe7637d96 Liam Girdwood         2019-04-12  2209  	process->comp.type = type;
311ce4fe7637d96 Liam Girdwood         2019-04-12  2210  	process->config.hdr.size = sizeof(process->config);
311ce4fe7637d96 Liam Girdwood         2019-04-12  2211  
311ce4fe7637d96 Liam Girdwood         2019-04-12  2212  	ret = sof_parse_tokens(scomp, &process->config, comp_tokens,
311ce4fe7637d96 Liam Girdwood         2019-04-12  2213  			       ARRAY_SIZE(comp_tokens), private->array,
311ce4fe7637d96 Liam Girdwood         2019-04-12  2214  			       le32_to_cpu(private->size));
311ce4fe7637d96 Liam Girdwood         2019-04-12  2215  	if (ret != 0) {
ee1e79b72e3cf5e Ranjani Sridharan     2019-12-04  2216  		dev_err(scomp->dev, "error: parse process.cfg tokens failed %d\n",
311ce4fe7637d96 Liam Girdwood         2019-04-12  2217  			le32_to_cpu(private->size));
311ce4fe7637d96 Liam Girdwood         2019-04-12  2218  		goto err;
311ce4fe7637d96 Liam Girdwood         2019-04-12  2219  	}
311ce4fe7637d96 Liam Girdwood         2019-04-12  2220  
311ce4fe7637d96 Liam Girdwood         2019-04-12  2221  	sof_dbg_comp_config(scomp, &process->config);
311ce4fe7637d96 Liam Girdwood         2019-04-12  2222  
311ce4fe7637d96 Liam Girdwood         2019-04-12  2223  	/*
311ce4fe7637d96 Liam Girdwood         2019-04-12  2224  	 * found private data in control, so copy it.
311ce4fe7637d96 Liam Girdwood         2019-04-12  2225  	 * get possible component controls - get size of all pdata,
311ce4fe7637d96 Liam Girdwood         2019-04-12  2226  	 * then memcpy with headers
311ce4fe7637d96 Liam Girdwood         2019-04-12  2227  	 */
cac974a51ebb955 Jaska Uimonen         2019-08-09  2228  	if (ipc_data_size) {
311ce4fe7637d96 Liam Girdwood         2019-04-12  2229  		for (i = 0; i < widget->num_kcontrols; i++) {
cac974a51ebb955 Jaska Uimonen         2019-08-09 @2230  			memcpy(&process->data + offset,
cac974a51ebb955 Jaska Uimonen         2019-08-09  2231  			       wdata[i].pdata->data,
cac974a51ebb955 Jaska Uimonen         2019-08-09  2232  			       wdata[i].pdata->size);
cac974a51ebb955 Jaska Uimonen         2019-08-09  2233  			offset += wdata[i].pdata->size;
311ce4fe7637d96 Liam Girdwood         2019-04-12  2234  		}
311ce4fe7637d96 Liam Girdwood         2019-04-12  2235  	}
311ce4fe7637d96 Liam Girdwood         2019-04-12  2236  
311ce4fe7637d96 Liam Girdwood         2019-04-12  2237  	process->size = ipc_data_size;
311ce4fe7637d96 Liam Girdwood         2019-04-12  2238  	swidget->private = process;
311ce4fe7637d96 Liam Girdwood         2019-04-12  2239  err:
cac974a51ebb955 Jaska Uimonen         2019-08-09  2240  	if (ret < 0)
311ce4fe7637d96 Liam Girdwood         2019-04-12  2241  		kfree(process);
cac974a51ebb955 Jaska Uimonen         2019-08-09  2242  out:
cac974a51ebb955 Jaska Uimonen         2019-08-09  2243  	kfree(wdata);
311ce4fe7637d96 Liam Girdwood         2019-04-12  2244  	return ret;
311ce4fe7637d96 Liam Girdwood         2019-04-12  2245  }
311ce4fe7637d96 Liam Girdwood         2019-04-12  2246  

:::::: The code at line 2230 was first introduced by commit
:::::: cac974a51ebb955f3be260a9633836e1413c8672 ASoC: SOF: topology: use set_get_data in process load

:::::: TO: Jaska Uimonen <jaska.uimonen@intel.com>
:::::: CC: Mark Brown <broonie@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
