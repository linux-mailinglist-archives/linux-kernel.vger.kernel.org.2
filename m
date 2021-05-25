Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C924F390CDA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 01:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbhEYXRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 19:17:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:36410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230145AbhEYXRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 19:17:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 798A96128B;
        Tue, 25 May 2021 23:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621984562;
        bh=udTOOSMfJAcXktS3DMEoxFOhpDun8Q7Rx/ntvDo0avw=;
        h=Date:From:To:Cc:Subject:From;
        b=gQeIbFm1KUwviw4anAa3NkYIGfFPZoIuWRxKQnf1yu7UXL9a8lsoYnNcQEfO7ufyD
         l1/3NW7dycXQvXZf3zNV+HbYVyuCifzV6wpfJydb4JwZh4i9K8CIdpE4w5sbkwQgtD
         6yvziORankOno1bXr3dybdZ9vPQ88Yq4mCEzCZvmIstBBI3yEMm1t8yPbpm+sdLcbN
         bD1e5robcYs74VpV2cS9XBZTJ6Xkj6A4y/nzqlAwCpCX7ExapWQBuaw4IpAtPcENBF
         pwmUmxzlEb2KFKwjJRdqcbt6F+TZ2sMfSZCjQtwOdFy2KIj4L24L2xVgeb5YmGEGKw
         Ueaaumt97s7PA==
Date:   Tue, 25 May 2021 18:16:58 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>
Cc:     intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] virtchnl: Replace one-element array in struct
 virtchnl_vsi_queue_config_info
Message-ID: <20210525231658.GA176466@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a regular need in the kernel to provide a way to declare having a
dynamically sized set of trailing elements in a structure. Kernel code
should always use “flexible array members”[1] for these cases. The older
style of one-element or zero-length arrays should no longer be used[2].

Refactor the code according to the use of a flexible-array member in struct
virtchnl_vsi_queue_config_info instead of one-element array, and use the
flex_array_size() helper.

[1] https://en.wikipedia.org/wiki/Flexible_array_member
[2] https://www.kernel.org/doc/html/v5.10/process/deprecated.html#zero-length-and-one-element-arrays

Link: https://github.com/KSPP/linux/issues/79
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 include/linux/avf/virtchnl.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
index b554913804bd..ed9c4998f8ac 100644
--- a/include/linux/avf/virtchnl.h
+++ b/include/linux/avf/virtchnl.h
@@ -338,10 +338,10 @@ struct virtchnl_vsi_queue_config_info {
 	u16 vsi_id;
 	u16 num_queue_pairs;
 	u32 pad;
-	struct virtchnl_queue_pair_info qpair[1];
+	struct virtchnl_queue_pair_info qpair[];
 };
 
-VIRTCHNL_CHECK_STRUCT_LEN(72, virtchnl_vsi_queue_config_info);
+VIRTCHNL_CHECK_STRUCT_LEN(8, virtchnl_vsi_queue_config_info);
 
 /* VIRTCHNL_OP_REQUEST_QUEUES
  * VF sends this message to request the PF to allocate additional queues to
@@ -997,9 +997,8 @@ virtchnl_vc_validate_vf_msg(struct virtchnl_version_info *ver, u32 v_opcode,
 		if (msglen >= valid_len) {
 			struct virtchnl_vsi_queue_config_info *vqc =
 			    (struct virtchnl_vsi_queue_config_info *)msg;
-			valid_len += (vqc->num_queue_pairs *
-				      sizeof(struct
-					     virtchnl_queue_pair_info));
+			valid_len += flex_array_size(vqc, qpair,
+						     vqc->num_queue_pairs);
 			if (vqc->num_queue_pairs == 0)
 				err_msg_format = true;
 		}
-- 
2.27.0

