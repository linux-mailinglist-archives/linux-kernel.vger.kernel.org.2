Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 846FF322129
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 22:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbhBVVOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 16:14:39 -0500
Received: from mga14.intel.com ([192.55.52.115]:50455 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230001AbhBVVOg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 16:14:36 -0500
IronPort-SDR: 9EaXQipVf0UH5CVVvoU8a59RgOpgdq6vn1XdNhJ+1kHuWCVXvWtidBJiIg/bxgEahjvZylTqz2
 t5tM5K/DKjAA==
X-IronPort-AV: E=McAfee;i="6000,8403,9903"; a="183879058"
X-IronPort-AV: E=Sophos;i="5.81,198,1610438400"; 
   d="scan'208";a="183879058"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2021 13:14:19 -0800
IronPort-SDR: c9jcqyPuiPRbP4RprK5ZwRYk4H+uf/bSwytXL9ldX+8cwA4x4gdt+YDS3Mau/CMiGlJKG0fP5Z
 LNhVSSb2U5cw==
X-IronPort-AV: E=Sophos;i="5.81,198,1610438400"; 
   d="scan'208";a="366323793"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2021 13:14:19 -0800
Date:   Mon, 22 Feb 2021 13:14:15 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org
Subject: checkpatch warnings for references to earlier commits
Message-ID: <20210222211415.GA163057@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Would it be possible to teach checkpatch not to warn about
canonical references to earlier commits?  E.g.

WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#7:
commit e80634a75aba ("EDAC, skx: Retrieve and print retry_rd_err_log registers")

Thanks

-Tony
