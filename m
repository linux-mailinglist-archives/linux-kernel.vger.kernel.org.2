Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE983235D4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 03:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbhBXCjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 21:39:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232735AbhBXCjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 21:39:39 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2162C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 18:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=CfKc8Zl91y/e9nLuryOR1lxmVNVLD/3iL2XJbPBkUqo=; b=tG785LS2wbirihl4sE8m0cI9Gr
        2aJlAkM06ZQASa1k3rFb0sqtPeKSynvNGMcUHoukaTfIjMqnQgFWNcSywZuDWBZNzACk9rfYDSy7S
        mpvLrX7ltXKt6y7KWQo84KKr0rOD76Igx/cdjFlOxVNiEK6PnRxQ2bMc0fHMjmxTiiI/7jtvZ8EK0
        h/8A08SzGbfaHKSkfIiqNxS/fWsvppZgA2uIDQ7Aq/zS6rpKMskRcQzbpgXCH3ujRjij/I1va4aq5
        1UpZHNNpc9UQEpLV8DT2BZjPJQtmqbWi+a3WIVChCyIhf58AMIHwx8RUsrxT2/9GKhrMT9pkwLHU4
        uC2OV7MQ==;
Received: from [2601:1c0:6280:3f0::6d64]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lEk4j-008qGo-VM; Wed, 24 Feb 2021 02:38:54 +0000
Subject: Re: (.text.ks8851_probe_common+0x370): undefined reference to
 `__this_module'
To:     kernel test robot <lkp@intel.com>, Marek Vasut <marex@denx.de>,
        arnd@arndb.de
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>
References: <202102221437.vHlLwHmG-lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <33c7cb1f-b6c0-24bf-0e6c-23d5472e4c29@infradead.org>
Date:   Tue, 23 Feb 2021 18:38:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <202102221437.vHlLwHmG-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/21 10:12 PM, kernel test robot wrote:
> Hi Marek,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   31caf8b2a847214be856f843e251fc2ed2cd1075
> commit: ef3631220d2b3d8d14cf64464760505baa60d6ac net: ks8851: Register MDIO bus and the internal PHY
> date:   7 weeks ago
> config: parisc-randconfig-r034-20210222 (attached as .config)
> compiler: hppa-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ef3631220d2b3d8d14cf64464760505baa60d6ac
>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>          git fetch --no-tags linus master
>          git checkout ef3631220d2b3d8d14cf64464760505baa60d6ac
>          # save the attached .config to linux build tree
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=parisc
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>     hppa-linux-ld: drivers/net/ethernet/micrel/ks8851_common.o: in function `ks8851_probe_common':
>>> (.text.ks8851_probe_common+0x370): undefined reference to `__this_module'
>>> hppa-linux-ld: (.text.ks8851_probe_common+0x374): undefined reference to `__this_module'

Hey Arnd-

I wanted to see if you had any ideas about this problem.

CONFIG_KS8851=y
CONFIG_KS8851_MLL=m

The problem is that 2 drivers share some common code, but in one case
the shared code is builtin and for the other driver it is a loadable
module. The common code is first built as builtin, so it does not have
the "__this_module" symbol.

Thanks.
