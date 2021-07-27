Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D07AB3D6FD1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 08:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235331AbhG0G75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 02:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234349AbhG0G74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 02:59:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC1DC061757
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 23:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rLX6zfIbPohDQgOEqSdMhpF/nS3w/rQF0kd2nfv5ba8=; b=B3PzSadfVZnTZx+2tm0HbiIcfN
        FeXiyRnrP+46cHNbOX/SBqGwic7ZBnAEUwtCFLUecKTTcMRwMnd3PjM9Th5ZCfDK4PnWEE7+MyHQm
        ISrsOSZRTgW3+v/wIPJlQjlLEzCrVEdfeD5A3sodfRWRLAlEOqiytB7OzrCMS3rTtkPavaxDlEKt1
        Mk1v4mLsKBJ7YpdgteTnVFr00BiLAvP5LNbuO+uKWZedQYa15oHrq+2f1kDYcidtXenTYz04pmTZD
        pcyk2J6ZGgvjp3lNsu2Vy4vcDEx/hXTiWuWZ2WPpVccUol/MvH52RPB7njnL/WG//RUM4Ejc8JnvL
        zoA+3lew==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m8H2v-00EldT-KK; Tue, 27 Jul 2021 06:58:46 +0000
Date:   Tue, 27 Jul 2021 07:58:33 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [ext3:generic_block_fiemap_removal 3/4] file.c:undefined
 reference to `iomap_fiemap'
Message-ID: <YP+umZ1/XX969ioH@infradead.org>
References: <202107271057.xwwoSXFy-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202107271057.xwwoSXFy-lkp@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oops, hpfs now needs to select FS_IOMAP:

diff --git a/fs/hpfs/Kconfig b/fs/hpfs/Kconfig
index 2b36dc6f0a10..ec975f466877 100644
--- a/fs/hpfs/Kconfig
+++ b/fs/hpfs/Kconfig
@@ -2,6 +2,7 @@
 config HPFS_FS
 	tristate "OS/2 HPFS file system support"
 	depends on BLOCK
+	select FS_IOMAP
 	help
 	  OS/2 is IBM's operating system for PC's, the same as Warp, and HPFS
 	  is the file system used for organizing files on OS/2 hard disk
