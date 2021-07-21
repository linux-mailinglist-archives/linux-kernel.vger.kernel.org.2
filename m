Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1DA3D0B51
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 11:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237106AbhGUI2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 04:28:17 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50930 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237562AbhGUISg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 04:18:36 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 616251FE7D;
        Wed, 21 Jul 2021 08:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626857952; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NznU6xKs/9iKJoPj5kORi+c1038vgtLi4Nu5X7STyDI=;
        b=VhDRil+WfKukoxDEG3BpPDiQJGGWI8U97xtg/7+WRZ4bCPSKbFsTnFp6IsZ3m4lWpbYOyT
        0a8EBT67dVP+c/CXK5DINfWiYbtSLgrgSyroYGIjihznsNYnDkuVZ54AHpnleSay8lVUrW
        HeWwHsxZrfqueoa7JaeI5Odqn3RQHoc=
Received: from suse.cz (pathway.suse.cz [10.100.12.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4135DA3B88;
        Wed, 21 Jul 2021 08:59:12 +0000 (UTC)
Date:   Wed, 21 Jul 2021 10:59:12 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Chris Down <chris@chrisdown.name>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [printk:for-5.15-printk-index 4/5] kernel/printk/index.c:140:6:
 warning: no previous prototype for 'pi_create_file'
Message-ID: <20210721085912.3hsjrmumqfy6fx3k@pathway.suse.cz>
References: <202107192303.qeABbFBe-lkp@intel.com>
 <YPa7WTw2rmYpI1uE@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPa7WTw2rmYpI1uE@chrisdown.name>
User-Agent: NeoMutt/20170912 (1.9.0)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-07-20 13:02:33, Chris Down wrote:
> kernel test robot writes:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git for-5.15-printk-index
> > head:   ad7d61f159db73974f1b0352f21afe04b0bbd920
> > commit: 337015573718b161891a3473d25f59273f2e626b [4/5] printk: Userspace format indexing support
> > config: arc-allyesconfig (attached as .config)
> > compiler: arceb-elf-gcc (GCC) 10.3.0
> > reproduce (this is a W=1 build):
> >        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >        chmod +x ~/bin/make.cross
> >        # https://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git/commit/?id=337015573718b161891a3473d25f59273f2e626b
> >        git remote add printk https://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git
> >        git fetch --no-tags printk for-5.15-printk-index
> >        git checkout 337015573718b161891a3473d25f59273f2e626b
> >        # save the attached .config to linux build tree
> >        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-10.3.0 make.cross ARCH=arc
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All warnings (new ones prefixed by >>):
> > 
> > > > kernel/printk/index.c:140:6: warning: no previous prototype for 'pi_create_file' [-Wmissing-prototypes]
> >     140 | void pi_create_file(struct module *mod)
> >         |      ^~~~~~~~~~~~~~
> > > > kernel/printk/index.c:146:6: warning: no previous prototype for 'pi_remove_file' [-Wmissing-prototypes]
> >     146 | void pi_remove_file(struct module *mod)
> >         |      ^~~~~~~~~~~~~~
> 
> Ah, I missed `static inline', which causes the compiler to think we want to
> export it even though we don't.
> 
> diff --git kernel/printk/index.c kernel/printk/index.c
> index ca062f5e1779..e340e0a8b847 100644
> --- kernel/printk/index.c
> +++ kernel/printk/index.c
> @@ -137,13 +137,13 @@ static const char *pi_get_module_name(struct module *mod)
>  }
>  #endif
> -void pi_create_file(struct module *mod)
> +static inline void pi_create_file(struct module *mod)
>  {
>  	debugfs_create_file(pi_get_module_name(mod), 0444, dfs_index,
>  				       mod, &dfs_index_fops);
>  }
> -void pi_remove_file(struct module *mod)
> +static inline void pi_remove_file(struct module *mod)
>  {
>  	debugfs_remove(debugfs_lookup(pi_get_module_name(mod), dfs_index));
>  }

Chris, please send this one as a proper patch as well.

Best Regards,
Petr
