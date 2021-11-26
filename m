Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12BD845E398
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 01:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351103AbhKZAMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 19:12:21 -0500
Received: from mga18.intel.com ([134.134.136.126]:51352 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238885AbhKZAKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 19:10:20 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10179"; a="222451025"
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="222451025"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 16:05:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="675381567"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 25 Nov 2021 16:05:57 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqOkW-00077J-8L; Fri, 26 Nov 2021 00:05:56 +0000
Date:   Fri, 26 Nov 2021 08:05:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Fangzhi Zuo <Jerry.Zuo@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link.c:3187:16:
 warning: no previous prototype for 'dc_link_update_sst_payload'
Message-ID: <202111260725.FgSyDs9i-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8ced7ca3570333998ad2088d5a6275701970e28e
commit: f01ee019586220c86f238263a4fbde6e72085e11 drm/amd/display: Add DP 2.0 SST DC Support
date:   3 months ago
config: powerpc64-buildonly-randconfig-r004-20211026 (https://download.01.org/0day-ci/archive/20211126/202111260725.FgSyDs9i-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f01ee019586220c86f238263a4fbde6e72085e11
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout f01ee019586220c86f238263a4fbde6e72085e11
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=powerpc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link.c:3187:16: warning: no previous prototype for 'dc_link_update_sst_payload' [-Wmissing-prototypes]
    3187 | enum dc_status dc_link_update_sst_payload(struct pipe_ctx *pipe_ctx, bool allocate)
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/dc_link_update_sst_payload +3187 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link.c

  3133	
  3134	static void update_mst_stream_alloc_table(
  3135		struct dc_link *link,
  3136		struct stream_encoder *stream_enc,
  3137		const struct dp_mst_stream_allocation_table *proposed_table)
  3138	{
  3139		struct link_mst_stream_allocation work_table[MAX_CONTROLLER_NUM] = {
  3140				{ 0 } };
  3141		struct link_mst_stream_allocation *dc_alloc;
  3142	
  3143		int i;
  3144		int j;
  3145	
  3146		/* if DRM proposed_table has more than one new payload */
  3147		ASSERT(proposed_table->stream_count -
  3148				link->mst_stream_alloc_table.stream_count < 2);
  3149	
  3150		/* copy proposed_table to link, add stream encoder */
  3151		for (i = 0; i < proposed_table->stream_count; i++) {
  3152	
  3153			for (j = 0; j < link->mst_stream_alloc_table.stream_count; j++) {
  3154				dc_alloc =
  3155				&link->mst_stream_alloc_table.stream_allocations[j];
  3156	
  3157				if (dc_alloc->vcp_id ==
  3158					proposed_table->stream_allocations[i].vcp_id) {
  3159	
  3160					work_table[i] = *dc_alloc;
  3161					work_table[i].slot_count = proposed_table->stream_allocations[i].slot_count;
  3162					break; /* exit j loop */
  3163				}
  3164			}
  3165	
  3166			/* new vcp_id */
  3167			if (j == link->mst_stream_alloc_table.stream_count) {
  3168				work_table[i].vcp_id =
  3169					proposed_table->stream_allocations[i].vcp_id;
  3170				work_table[i].slot_count =
  3171					proposed_table->stream_allocations[i].slot_count;
  3172				work_table[i].stream_enc = stream_enc;
  3173			}
  3174		}
  3175	
  3176		/* update link->mst_stream_alloc_table with work_table */
  3177		link->mst_stream_alloc_table.stream_count =
  3178				proposed_table->stream_count;
  3179		for (i = 0; i < MAX_CONTROLLER_NUM; i++)
  3180			link->mst_stream_alloc_table.stream_allocations[i] =
  3181					work_table[i];
  3182	}
  3183	#if defined(CONFIG_DRM_AMD_DC_DCN)
  3184	/*
  3185	 * Payload allocation/deallocation for SST introduced in DP2.0
  3186	 */
> 3187	enum dc_status dc_link_update_sst_payload(struct pipe_ctx *pipe_ctx, bool allocate)
  3188	{
  3189		struct dc_stream_state *stream = pipe_ctx->stream;
  3190		struct dc_link *link = stream->link;
  3191		struct hpo_dp_link_encoder *hpo_dp_link_encoder = link->hpo_dp_link_enc;
  3192		struct hpo_dp_stream_encoder *hpo_dp_stream_encoder = pipe_ctx->stream_res.hpo_dp_stream_enc;
  3193		struct link_mst_stream_allocation_table proposed_table = {0};
  3194		struct fixed31_32 avg_time_slots_per_mtp;
  3195		DC_LOGGER_INIT(link->ctx->logger);
  3196	
  3197		/* slot X.Y for SST payload deallocate */
  3198		if (!allocate) {
  3199			avg_time_slots_per_mtp = dc_fixpt_from_int(0);
  3200	
  3201			DC_LOG_DP2("SST Update Payload: set_throttled_vcp_size slot X.Y for SST stream"
  3202					"X: %d "
  3203					"Y: %d",
  3204					dc_fixpt_floor(
  3205						avg_time_slots_per_mtp),
  3206					dc_fixpt_ceil(
  3207						dc_fixpt_shl(
  3208							dc_fixpt_sub_int(
  3209								avg_time_slots_per_mtp,
  3210								dc_fixpt_floor(
  3211										avg_time_slots_per_mtp)),
  3212							26)));
  3213	
  3214			hpo_dp_link_encoder->funcs->set_throttled_vcp_size(
  3215					hpo_dp_link_encoder,
  3216					hpo_dp_stream_encoder->inst,
  3217					avg_time_slots_per_mtp);
  3218		}
  3219	
  3220		/* calculate VC payload and update branch with new payload allocation table*/
  3221		if (!dpcd_write_128b_132b_sst_payload_allocation_table(
  3222				stream,
  3223				link,
  3224				&proposed_table,
  3225				allocate)) {
  3226			DC_LOG_ERROR("SST Update Payload: Failed to update "
  3227							"allocation table for "
  3228							"pipe idx: %d\n",
  3229							pipe_ctx->pipe_idx);
  3230		}
  3231	
  3232		proposed_table.stream_allocations[0].hpo_dp_stream_enc = hpo_dp_stream_encoder;
  3233	
  3234		ASSERT(proposed_table.stream_count == 1);
  3235	
  3236		//TODO - DP2.0 Logging: Instead of hpo_dp_stream_enc pointer, log instance id
  3237		DC_LOG_DP2("SST Update Payload: hpo_dp_stream_enc: %p      "
  3238			"vcp_id: %d      "
  3239			"slot_count: %d\n",
  3240			(void *) proposed_table.stream_allocations[0].hpo_dp_stream_enc,
  3241			proposed_table.stream_allocations[0].vcp_id,
  3242			proposed_table.stream_allocations[0].slot_count);
  3243	
  3244		/* program DP source TX for payload */
  3245		hpo_dp_link_encoder->funcs->update_stream_allocation_table(
  3246				hpo_dp_link_encoder,
  3247				&proposed_table);
  3248	
  3249		/* poll for ACT handled */
  3250		if (!dpcd_poll_for_allocation_change_trigger(link)) {
  3251			// Failures will result in blackscreen and errors logged
  3252			BREAK_TO_DEBUGGER();
  3253		}
  3254	
  3255		/* slot X.Y for SST payload allocate */
  3256		if (allocate) {
  3257			avg_time_slots_per_mtp = calculate_sst_avg_time_slots_per_mtp(stream, link);
  3258	
  3259			DC_LOG_DP2("SST Update Payload: "
  3260					"slot.X: %d      "
  3261					"slot.Y: %d",
  3262					dc_fixpt_floor(
  3263						avg_time_slots_per_mtp),
  3264					dc_fixpt_ceil(
  3265						dc_fixpt_shl(
  3266							dc_fixpt_sub_int(
  3267								avg_time_slots_per_mtp,
  3268								dc_fixpt_floor(
  3269										avg_time_slots_per_mtp)),
  3270							26)));
  3271	
  3272			hpo_dp_link_encoder->funcs->set_throttled_vcp_size(
  3273					hpo_dp_link_encoder,
  3274					hpo_dp_stream_encoder->inst,
  3275					avg_time_slots_per_mtp);
  3276		}
  3277	
  3278		/* Always return DC_OK.
  3279		 * If part of sequence fails, log failure(s) and show blackscreen
  3280		 */
  3281		return DC_OK;
  3282	}
  3283	#endif
  3284	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
