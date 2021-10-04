Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF164205B9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 08:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbhJDGPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 02:15:48 -0400
Received: from out0.migadu.com ([94.23.1.103]:28028 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232131AbhJDGPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 02:15:44 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1633328032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=42kPSa8+wjB6Mb38BlxBzx2WwiOYF7o9O9jQ+BbpfMs=;
        b=MFtWuB8wefQ1YNEj70qBvdCJlBFI8ypBBF9DW1wnOepkq6PIA4C4tkI4NoyrGQ7qjrq6Ep
        SM19/7zAKJZ0VV5T3h9dRIMhLU6BfWIIhnKdS2OYmG2+VteGqzzh5U00wAgUJg0/K+UzlM
        yWfgHzkNt9/ATBl0R6WmsPfXHv4tVpI=
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Christian Hansen <chansen3@cisco.com>,
        Changbin Du <changbin.du@intel.com>,
        Bin Wang <wangbin224@huawei.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/3] tools/vm/page-types.c: a few improvements
Date:   Mon,  4 Oct 2021 15:13:22 +0900
Message-Id: <20211004061325.1525902-1-naoya.horiguchi@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: naoya.horiguchi@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patchset adds some improvements on tools/vm/page-types.c.
Patch 1/3 makes -a option (specify address range) work with -f
(file cache mode).  Patch 2/3 and 3/3 are to fix minor formatting
issues of this tool.  These would make life a little easier for
the users of this tool.

Please see individual patches for more details about specific issues.

Thanks,
Naoya Horiguchi
---
Summary:

Naoya Horiguchi (3):
      tools/vm/page-types.c: make walk_file() aware of address range option
      tools/vm/page-types.c: move show_file() to summary output
      tools/vm/page-types.c: print file offset in hexadecimal

 tools/vm/page-types.c | 38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)
