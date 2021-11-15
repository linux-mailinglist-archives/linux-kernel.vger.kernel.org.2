Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CABBE4516C7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 22:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239059AbhKOVo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 16:44:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:36388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241698AbhKOSY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 13:24:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 89DD360E0C;
        Mon, 15 Nov 2021 17:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636998893;
        bh=DNJ55fQmLFwQkadGfD9V50ohFAcQLt09/yqhykWE2oE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lcHjw5o2fC8o43rseMS/go49b7G+pfa9KHg0TDmv4n/RipgZYscr730iySO1RUw2L
         l3MRs7tLHJIbceqrq5vJ2uO6UGZSj9pehJf7sWxy0MqCqxqZEhki4OueA6Lw3C7MKs
         0uNTDyuiu/FPRGEf222hDQcrHNS+cJIo8dXLA/6I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 5.14 099/849] btrfs: fix lost error handling when replaying directory deletes
Date:   Mon, 15 Nov 2021 17:53:02 +0100
Message-Id: <20211115165423.431328969@linuxfoundation.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211115165419.961798833@linuxfoundation.org>
References: <20211115165419.961798833@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

commit 10adb1152d957a4d570ad630f93a88bb961616c1 upstream.

At replay_dir_deletes(), if find_dir_range() returns an error we break out
of the main while loop and then assign a value of 0 (success) to the 'ret'
variable, resulting in completely ignoring that an error happened. Fix
that by jumping to the 'out' label when find_dir_range() returns an error
(negative value).

CC: stable@vger.kernel.org # 4.4+
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/tree-log.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -2505,7 +2505,9 @@ again:
 		else {
 			ret = find_dir_range(log, path, dirid, key_type,
 					     &range_start, &range_end);
-			if (ret != 0)
+			if (ret < 0)
+				goto out;
+			else if (ret > 0)
 				break;
 		}
 


