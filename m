Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07D733C4767
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 12:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235408AbhGLGcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 02:32:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:45380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235336AbhGLG1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 02:27:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7F3AB61178;
        Mon, 12 Jul 2021 06:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626071065;
        bh=y+y+Tz3rn+OBujU2ibT9TsyGjjxsuHdRA7l1t9cQZ1E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X6FA6lVJIvt9L4mDzKA3/DkbbgNl8Rd7IJlEWhaQvt1u5S3XkPwsyBujSv3q5ZsT6
         lqH4+LEIM+OO1F1eA2wjUuf2FpNYLKJirDvuVuy85YVOSBVbLIr2U/nTSBXVRB6Fd5
         r9zxeoWU2HCU86PWv8IgEfNZi8YMFg2MuWM1hcM4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wang Hai <wanghai38@huawei.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 216/348] samples/bpf: Fix the error return code of xdp_redirects main()
Date:   Mon, 12 Jul 2021 08:10:00 +0200
Message-Id: <20210712060730.240845384@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210712060659.886176320@linuxfoundation.org>
References: <20210712060659.886176320@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Hai <wanghai38@huawei.com>

[ Upstream commit 7c6090ee2a7b3315410cfc83a94c3eb057407b25 ]

Fix to return a negative error code from the error handling
case instead of 0, as done elsewhere in this function.

If bpf_map_update_elem() failed, main() should return a negative error.

Fixes: 832622e6bd18 ("xdp: sample program for new bpf_redirect helper")
Signed-off-by: Wang Hai <wanghai38@huawei.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20210616042534.315097-1-wanghai38@huawei.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 samples/bpf/xdp_redirect_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/bpf/xdp_redirect_user.c b/samples/bpf/xdp_redirect_user.c
index 5440cd620607..b7bc2a339d77 100644
--- a/samples/bpf/xdp_redirect_user.c
+++ b/samples/bpf/xdp_redirect_user.c
@@ -216,5 +216,5 @@ int main(int argc, char **argv)
 	poll_stats(2, ifindex_out);
 
 out:
-	return 0;
+	return ret;
 }
-- 
2.30.2



