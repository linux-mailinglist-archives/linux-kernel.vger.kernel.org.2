Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21CCA356A9D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 12:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351724AbhDGKz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 06:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245237AbhDGKzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:55:48 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BD7C061756
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 03:55:37 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id w18so20359025edc.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 03:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AqNQY1ixLetmewTjICsW+YaSFij9TTn42Daz5HdD3Pg=;
        b=ETUqbaLUzbAE3Y8O3a2aWNuZM2fNtZXVOnTOTIvLJyTmLANl0Xlyq3xpmQC4ux+NV4
         3HDoi63y6Ygcekx9uhF2052T6F+4Di4wGYcA0dYKPLmWHTSsQl4CvGc+c+lQ9MNk/cmL
         p6nb35pX3EseVu2sdDqArH6EuA2dEbmCRJD+I0nqxr7z4rsOTpd9MdJebkdKiJOlU4Tf
         zeYjseMmGUsXOoc8hpVZB4UxhDBQN8X0VHjOwKr+PUckDXcT7eqr6A9gGTIx4lzkzAvY
         nWh5rRFJ4mCnMJOlfvdLAyzjrJofbtHdo2X+6a/xi8dhDgRROGCZLb9yqKknptOKduA7
         P1FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AqNQY1ixLetmewTjICsW+YaSFij9TTn42Daz5HdD3Pg=;
        b=hV5Fw87mXeEOIixHJ+yKk0y8R5HLdXOfB3EJYKgr8Gbz5aA2pNkAeqlaAru4N7IeXG
         hJworAqnpDT/p9aHxQ8+sx0d5mdlQx+0z3u1XDa/DEUeBbbGMc6YnuZEPO5Mb5bk7Bek
         UXCNKTaOew8vpr9ir8mJANSN1s0iyy8Mbr4cU48LMY9CoC3kLpAbFj0+NySQdyMzKMt6
         lXN/vNAIJbzCYkl6rrfpBHdcFvNp8192MGLffTEw7VkC68fnD8bouc5FPzvyk4qkvW5S
         UChXU/MvJ5f7bVg02vABLlMqXgsz96RH//OZpDXmy+AT18khWMVTee1KfPUswG17IGec
         ZyNA==
X-Gm-Message-State: AOAM533HmhUZbydKFCvxoDLt1cRDV21oV6bdcBAjR2PRAiqZwNBIO9Yc
        Pen1q8bMo9nkZxBVVSxVTqk67tvJA932/P3G
X-Google-Smtp-Source: ABdhPJyAI/4AoBC0fEt/G7MG/ZMpDH4GqDWCh5w4iapkXMB13W/olZeYoIT+Zra5SSP3IhYjyEwqDw==
X-Received: by 2002:a05:6402:51d0:: with SMTP id r16mr3638808edd.48.1617792936158;
        Wed, 07 Apr 2021 03:55:36 -0700 (PDT)
Received: from localhost.localdomain (hst-221-20.medicom.bg. [84.238.221.20])
        by smtp.gmail.com with ESMTPSA id ka11sm4252365ejb.43.2021.04.07.03.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 03:55:35 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH] venus: core: Fix kerneldoc warnings
Date:   Wed,  7 Apr 2021 13:55:02 +0300
Message-Id: <20210407105502.348082-1-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix kerneldoc warnings in description of venus_core and venus_inst
structures

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/core.h | 40 ++++++++++++++++++------
 1 file changed, 31 insertions(+), 9 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index 426e3a0c630e..745f226a523f 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -90,18 +90,25 @@ struct venus_format {
  * struct venus_core - holds core parameters valid for all instances
  *
  * @base:	IO memory base address
- * @vbif_base	IO memory vbif base address
- * @cpu_base	IO memory cpu base address
- * @cpu_cs_base	IO memory cpu_cs base address
- * @cpu_ic_base	IO memory cpu_ic base address
- * @wrapper_base	IO memory wrapper base address
- * @wrapper_base	IO memory wrapper TZ base address
- * @aon_base	AON base address
+ * @vbif_base:	IO memory vbif base address
+ * @cpu_base:	IO memory cpu base address
+ * @cpu_cs_base:	IO memory cpu_cs base address
+ * @cpu_ic_base:	IO memory cpu_ic base address
+ * @wrapper_base:	IO memory wrapper base address
+ * @wrapper_tz_base:	IO memory wrapper TZ base address
+ * @aon_base:	AON base address
  * @irq:		Venus irq
  * @clks:	an array of struct clk pointers
  * @vcodec0_clks: an array of vcodec0 struct clk pointers
  * @vcodec1_clks: an array of vcodec1 struct clk pointers
+ * @video_path: an interconnect handle to video to/from memory path
+ * @cpucfg_path: an interconnect handle to cpu configuration path
+ * @opp_table: an device OPP table handle
+ * @has_opp_table: does OPP table exist
  * @pmdomains:	an array of pmdomains struct device pointers
+ * @opp_dl_venus: an device-link for device OPP
+ * @opp_pmdomain: an OPP power-domain
+ * @resets: an array of reset signals
  * @vdev_dec:	a reference to video device structure for decoder instances
  * @vdev_enc:	a reference to video device structure for encoder instances
  * @v4l2_dev:	a holder for v4l2 device structure
@@ -110,6 +117,7 @@ struct venus_format {
  * @dev_dec:	convenience struct device pointer for decoder device
  * @dev_enc:	convenience struct device pointer for encoder device
  * @use_tz:	a flag that suggests presence of trustzone
+ * @fw:		structure of firmware parameters
  * @lock:	a lock for this strucure
  * @instances:	a list_head of all instances
  * @insts_count:	num of instances
@@ -118,6 +126,7 @@ struct venus_format {
  * @error:	an error returned during last HFI sync operations
  * @sys_error:	an error flag that signal system error event
  * @core_ops:	the core operations
+ * @pm_ops:	a pointer to pm operations
  * @pm_lock:	a lock for PM operations
  * @enc_codecs:	encoders supported by this core
  * @dec_codecs:	decoders supported by this core
@@ -125,6 +134,10 @@ struct venus_format {
  * @priv:	a private filed for HFI operations
  * @ops:		the core HFI operations
  * @work:	a delayed work for handling system fatal error
+ * @caps:	an array of supported HFI capabilities
+ * @codecs_count: platform codecs count
+ * @core0_usage_count: usage counter for core0
+ * @core1_usage_count: usage counter for core1
  * @root:	debugfs root directory
  */
 struct venus_core {
@@ -309,10 +322,11 @@ struct venus_ts_metadata {
  * @list:	used for attach an instance to the core
  * @lock:	instance lock
  * @core:	a reference to the core struct
+ * @clk_data:	clock data per core ID
  * @dpbbufs:	a list of decoded picture buffers
  * @internalbufs:	a list of internal bufferes
  * @registeredbufs:	a list of registered capture bufferes
- * @delayed_process	a list of delayed buffers
+ * @delayed_process:	a list of delayed buffers
  * @delayed_process_work:	a work_struct for process delayed buffers
  * @ctrl_handler:	v4l control handler
  * @controls:	a union of decoder and encoder control parameters
@@ -321,22 +335,26 @@ struct venus_ts_metadata {
  * @streamon_out: stream on flag for output queue
  * @width:	current capture width
  * @height:	current capture height
+ * @crop:	current crop rectangle
  * @out_width:	current output width
  * @out_height:	current output height
  * @colorspace:	current color space
+ * @ycbcr_enc:	current YCbCr encoding
  * @quantization:	current quantization
  * @xfer_func:	current xfer function
  * @codec_state:	current codec API state (see DEC/ENC_STATE_)
  * @reconf_wait:	wait queue for resolution change event
  * @subscriptions:	used to hold current events subscriptions
  * @buf_count:		used to count number of buffers (reqbuf(0))
+ * @tss:		timestamp metadata
+ * @payloads:		cache plane payload to use it for clock/BW scaling
  * @fps:		holds current FPS
  * @timeperframe:	holds current time per frame structure
  * @fmt_out:	a reference to output format structure
  * @fmt_cap:	a reference to capture format structure
  * @num_input_bufs:	holds number of input buffers
  * @num_output_bufs:	holds number of output buffers
- * @input_buf_size	holds input buffer size
+ * @input_buf_size:	holds input buffer size
  * @output_buf_size:	holds output buffer size
  * @output2_buf_size:	holds secondary decoder output buffer size
  * @dpb_buftype:	decoded picture buffer type
@@ -357,7 +375,11 @@ struct venus_ts_metadata {
  * @priv:	a private for HFI operations callbacks
  * @session_type:	the type of the session (decoder or encoder)
  * @hprop:	a union used as a holder by get property
+ * @core_acquired:	the Core has been acquired
+ * @bit_depth:		current bitstream bit-depth
+ * @pic_struct:		bitstream progressive vs interlaced
  * @next_buf_last: a flag to mark next queued capture buffer as last
+ * @drain_active:	Drain sequence is in progress
  */
 struct venus_inst {
 	struct list_head list;
-- 
2.25.1

