Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 124F73D7300
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 12:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236238AbhG0KXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 06:23:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:46858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236209AbhG0KXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 06:23:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D279617E4;
        Tue, 27 Jul 2021 10:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627381392;
        bh=96F8y1n4M8/IsYn82MuiLydb+TZiwtneRNE7zgbE938=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=kyB1BlKz8FjOnMYOBFG5nS9UvbpIJOhvMayrtIq1gKmqSAyVCNvGBJTRzV7rFphsP
         SVRTVf5qvidN11sCI+QBJWY/zeHkDWifsY7drFGbUZIHtEawOZa8nfC+BJnkLd5FsL
         ScBTfx5VkTuOzKuV9n9+ZwHVpmFpVefLK0aEUO0noSRS6myeiPuuyb+au0PXLAuu2Y
         V2L4egtJednkTrvhWAzu4h9xeaLaYQ5sreRduT+kUMMmocdSk8g6trfM3GcVKnk74o
         uL/UDKQAhislF6pQlF2NoOP9miT9nTVQ2g92AQaGTYuGSeAmECVoOnMxijMAfcdO+O
         mRO3+jPThz2ng==
Date:   Tue, 27 Jul 2021 12:23:09 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Michael Zaidman <michael.zaidman@gmail.com>
cc:     kernel test robot <lkp@intel.com>,
        clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: drivers/hid/hid-ft260.c:794:44: warning: format specifies type
 'short' but the argument has type 'int'
In-Reply-To: <20210726090937.GA46429@michael-VirtualBox>
Message-ID: <nycvar.YFH.7.76.2107271222500.8253@cbobk.fhfr.pm>
References: <202107261104.ChOSQbNQ-lkp@intel.com> <20210726090937.GA46429@michael-VirtualBox>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jul 2021, Michael Zaidman wrote:

> > vim +794 drivers/hid/hid-ft260.c
> > 
> >    784	
> >    785	static int ft260_word_show(struct hid_device *hdev, int id, u8 *cfg, int len,
> >    786				   u16 *field, u8 *buf)
> >    787	{
> >    788		int ret;
> >    789	
> >    790		ret = ft260_hid_feature_report_get(hdev, id, cfg, len);
> >    791		if (ret != len && ret >= 0)
> >    792			return -EIO;
> >    793	
> >  > 794		return scnprintf(buf, PAGE_SIZE, "%hi\n", le16_to_cpu(*field));
> >    795	}
> >    796	
> > 
> > ---
> > 0-DAY CI Kernel Test Service, Intel Corporation
> > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 
> The fix was discussed and submitted on May 10 in this commit
> https://patchwork.kernel.org/project/linux-input/patch/20210510163428.2415-1-michael.zaidman@gmail.com/
> But I see that it was not taken into v5.13.
> Jiri, could you please comment?

This one fell in between cracks of my inbox, sorry. Now queued in 
for-5.14/upstream-fixes.

-- 
Jiri Kosina
SUSE Labs

