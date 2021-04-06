Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422F83556EC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 16:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345263AbhDFOpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 10:45:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:32984 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233235AbhDFOpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 10:45:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 27311B1E7;
        Tue,  6 Apr 2021 14:45:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 15EA9DA732; Tue,  6 Apr 2021 16:43:04 +0200 (CEST)
Date:   Tue, 6 Apr 2021 16:43:03 +0200
From:   David Sterba <dsterba@suse.cz>
To:     kernel test robot <lkp@intel.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, David Sterba <dsterba@suse.com>
Subject: Re: disk-io.c:undefined reference to `atomic64_set_386'
Message-ID: <20210406144303.GF7604@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, kernel test robot <lkp@intel.com>,
        Josef Bacik <josef@toxicpanda.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, David Sterba <dsterba@suse.com>
References: <202104010035.c4LXmhAY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202104010035.c4LXmhAY-lkp@intel.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 12:34:38AM +0800, kernel test robot wrote:
> Hi Josef,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   5e46d1b78a03d52306f21f77a4e4a144b6d31486
> commit: 8260edba67a2e6bd5e709d32188e23aa22cb4a38 btrfs: make the init of static elements in fs_info separate
> date:   1 year ago
> config: um-randconfig-r023-20210330 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=1 build):
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8260edba67a2e6bd5e709d32188e23aa22cb4a38
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 8260edba67a2e6bd5e709d32188e23aa22cb4a38
>         # save the attached .config to linux build tree
>         make W=1 ARCH=um 

All the reports regarding atomic64_*_386 are from ARCH=um build, so
it needs to be fixed there.
