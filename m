Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B234344E2CE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 09:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233885AbhKLIJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 03:09:28 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:60232 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233351AbhKLIJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 03:09:27 -0500
X-UUID: 8b8488334d3942d6a19e6ff7e633b693-20211112
X-UUID: 8b8488334d3942d6a19e6ff7e633b693-20211112
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1853858561; Fri, 12 Nov 2021 16:06:33 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 12 Nov 2021 16:06:32 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 12 Nov 2021 16:06:32 +0800
Message-ID: <d59e616a0c106f626d5580ca4878965be332b069.camel@mediatek.com>
Subject: Re: drivers/net/wireless/mediatek/mt76/mt7915/mcu.c:2393:5:
 warning: no previous prototype for 'mt7915_mcu_set_fixed_rate'
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     kernel test robot <lkp@intel.com>
CC:     <kbuild-all@lists.01.org>, <linux-kernel@vger.kernel.org>,
        Felix Fietkau <nbd@nbd.name>
Date:   Fri, 12 Nov 2021 16:06:32 +0800
In-Reply-To: <202111121411.8fGIInOx-lkp@intel.com>
References: <202111121411.8fGIInOx-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-11-12 at 14:41 +0800, kernel test robot wrote:
> tree:   
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> master
> head:   5833291ab6de9c3e2374336b51c814e515e8f3a5
> commit: 9a93364d6595358a11d07e7f4261ae263ae2a02a mt76: mt7915: rework
> debugfs fixed-rate knob
> date:   3 weeks ago
> config: ia64-randconfig-c003-20211025 (attached as .config)
> compiler: ia64-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget 
> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
>  -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9a93364d6595358a11d07e7f4261ae263ae2a02a
>         git remote add linus 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 9a93364d6595358a11d07e7f4261ae263ae2a02a
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0
> make.cross ARCH=ia64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> > > drivers/net/wireless/mediatek/mt76/mt7915/mcu.c:2393:5: warning:
> > > no previous prototype for 'mt7915_mcu_set_fixed_rate' [-Wmissing-
> > > prototypes]
> 
>     2393 | int mt7915_mcu_set_fixed_rate(struct mt7915_dev *dev,
>          |     ^~~~~~~~~~~~~~~~~~~~~~~~

This is fixed by 
https://patchwork.kernel.org/project/linux-wireless/patch/d09619456ba3bf2d83b8929aefe00915ecce6b55.1634996863.git.lorenzo@kernel.org/

