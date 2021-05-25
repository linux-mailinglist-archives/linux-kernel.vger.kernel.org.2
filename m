Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD06390CCE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 01:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbhEYXNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 19:13:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:35674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229790AbhEYXNH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 19:13:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9DC5D61004;
        Tue, 25 May 2021 23:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621984297;
        bh=Uzh0etZChhdTjIEdr3/rkY9HSftUCeqcBhcG8mn+BIQ=;
        h=Date:From:To:Cc:Subject:From;
        b=OB1hfq/rnv76bl5crHxy8InXeSOrh2TEnrau4nPBavXwQ2SHauqOhGa5RFH7B+62M
         cGBVpfiM/TWCLXk/JnovAXjDjxcl1xihjLK9banQIyy/2vEvX2kB3n0vmvxbj1Sh1n
         jgKBWbbE8hjRpkzCmrzgaLqKxBWxQS72/wEr1IcQ2qZw9mgQNyO37AI9CPyMw0Nd+n
         A9+AhCE7QhdMkd7xepQJVv5wK13Ru5H3XCF9Wrgl8DkKr1qJw2VKcuq3HbgOOAqAo9
         j547Ad0hn2PloRQUVSHlYgd2Vsg4IOqpuzV/MIiggq0SVehip3k96clkyrZCwe3fjS
         QCzP3cUcdSNzA==
Date:   Tue, 25 May 2021 18:12:33 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>
Cc:     intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] virtchnl: Replace one-element array in struct
 virtchnl_ether_addr_list
Message-ID: <20210525231233.GA175955@embeddedor>
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
virtchnl_ether_addr_list instead of one-element array, and use the
flex_array_size() helper.

[1] https://en.wikipedia.org/wiki/Flexible_array_member
[2] https://www.kernel.org/doc/html/v5.10/process/deprecated.html#zero-length-and-one-element-arrays

Link: https://github.com/KSPP/linux/issues/79
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 include/linux/avf/virtchnl.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
index 7ded2b454122..c2e7ffc8ada7 100644
--- a/include/linux/avf/virtchnl.h
+++ b/include/linux/avf/virtchnl.h
@@ -422,10 +422,10 @@ VIRTCHNL_CHECK_STRUCT_LEN(8, virtchnl_ether_addr);
 struct virtchnl_ether_addr_list {
 	u16 vsi_id;
 	u16 num_elements;
-	struct virtchnl_ether_addr list[1];
+	struct virtchnl_ether_addr list[];
 };
 
-VIRTCHNL_CHECK_STRUCT_LEN(12, virtchnl_ether_addr_list);
+VIRTCHNL_CHECK_STRUCT_LEN(4, virtchnl_ether_addr_list);
 
 /* VIRTCHNL_OP_ADD_VLAN
  * VF sends this message to add one or more VLAN tag filters for receives.
@@ -1024,8 +1024,8 @@ virtchnl_vc_validate_vf_msg(struct virtchnl_version_info *ver, u32 v_opcode,
 		if (msglen >= valid_len) {
 			struct virtchnl_ether_addr_list *veal =
 			    (struct virtchnl_ether_addr_list *)msg;
-			valid_len += veal->num_elements *
-			    sizeof(struct virtchnl_ether_addr);
+			valid_len += flex_array_size(veal, list,
+						     veal->num_elements);
 			if (veal->num_elements == 0)
 				err_msg_format = true;
 		}
-- 
2.27.0

