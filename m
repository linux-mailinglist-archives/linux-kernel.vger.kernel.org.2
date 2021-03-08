Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E33E3330CC6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 12:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbhCHLx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 06:53:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:45616 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231184AbhCHLxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 06:53:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B70C5AD21;
        Mon,  8 Mar 2021 11:53:10 +0000 (UTC)
References: <20210308072510.GA902@xsang-OptiPlex-9020>
User-agent: mu4e 1.4.15; emacs 27.1
From:   Richard Palethorpe <rpalethorpe@suse.de>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     "huangjianan@oppo.com" <huangjianan@oppo.com>, lkp@intel.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        Chao Yu <yuchao0@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Guo Weichao <guoweichao@oppo.com>, ltp@lists.linux.it
Subject: Re: [LTP] [f2fs]  02eb84b96b: ltp.swapon03.fail
Reply-To: rpalethorpe@suse.de
In-reply-to: <20210308072510.GA902@xsang-OptiPlex-9020>
Date:   Mon, 08 Mar 2021 11:53:09 +0000
Message-ID: <87h7llhnfe.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> kern  :err   : [  187.461914] F2FS-fs (sda1): Swapfile does not align to section

> commit 02eb84b96bc1b382dd138bf60724edbefe77b025
> Author: huangjianan@oppo.com <huangjianan@oppo.com>
> Date:   Mon Mar 1 12:58:44 2021 +0800

>     f2fs: check if swapfile is section-alligned

>     If the swapfile isn't created by pin and fallocate, it can't be
>     guaranteed section-aligned, so it may be selected by f2fs gc. When
>     gc_pin_file_threshold is reached, the address of swapfile may change,
>     but won't be synchronized to swap_extent, so swap will write to wrong
>     address, which will cause data corruption.

>     Signed-off-by: Huang Jianan <huangjianan@oppo.com>
>     Signed-off-by: Guo Weichao <guoweichao@oppo.com>
>     Reviewed-by: Chao Yu <yuchao0@huawei.com>
>     Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

The test uses fallocate to preallocate the swap file and writes zeros to
it. I'm not sure what pin refers to?

-- 
Thank you,
Richard.
