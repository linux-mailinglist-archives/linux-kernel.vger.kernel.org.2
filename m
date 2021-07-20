Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E20633CF94B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 14:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236430AbhGTLWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 07:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233914AbhGTLWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 07:22:04 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0215C061574
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 05:02:35 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id d12so25678184wre.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 05:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KSiJsnUuOX0r0Lgojs8G2Q91OzMNE5KM3tiGawrK5jM=;
        b=sB1i15Ce4mTZPF8pEls4REDN1JgblW0KrPjRk9a575dmflajkUNmwvGU08arEdXPa6
         M836nQUI2rRERB63mp7mhQEqJ7qTBkZLoZWL2THK5jCeLAGr4aGrzk+XPQ0yJYmMvkdt
         z6YggE0HchTbTLLkqMouvusmXtqqQ2yX2pooI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KSiJsnUuOX0r0Lgojs8G2Q91OzMNE5KM3tiGawrK5jM=;
        b=GHB5eREclzJ+mZzmVGstcH5mH68QaoGxhAFwxpUSSq+9zYv8ZdWda4AElBeKNAMNZt
         zhQIxA9rnwMlCZBdNvA/+U70QSi6FjUBs9YSfCfQ8QdZaoH342GyFnyztrbn07p3b9LV
         Rb8/PvUtWLQ7r1ar7ApHgZ9NO6vxaQURe/sDNoA2+Qor/Ik9VfQZ7IOq6LvYOtMVx/L2
         VXmxQ14YElVrrxhLcqq5/1NIEVV872s/VV3O7S6VNVwPXNm/+6FmVYwOi0OPuspPR/Cp
         vk2BrA+0qIER5iG4b+rdtsv9gjHPLML61Ozlj62bnhFTJC5jLbtzq57i8Wb0N4VgNoF9
         3zYQ==
X-Gm-Message-State: AOAM530NTy9j8O4rEstjbmUUCqKsWP+HEelubRVX/s0K9SPpQL1wpEpO
        zwstTGmgKA8QklygPY/KT9xbXQ==
X-Google-Smtp-Source: ABdhPJyDxT66WmcNFlOB9EiOMeaSPCNrI54rGzoeAU2hvfC/PY2ATiwCEK7rQ4fJcTDn+7nQTNNPCQ==
X-Received: by 2002:a5d:6506:: with SMTP id x6mr34427918wru.86.1626782554228;
        Tue, 20 Jul 2021 05:02:34 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:d571])
        by smtp.gmail.com with ESMTPSA id a8sm23585683wrt.61.2021.07.20.05.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 05:02:33 -0700 (PDT)
Date:   Tue, 20 Jul 2021 13:02:33 +0100
From:   Chris Down <chris@chrisdown.name>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: Re: [printk:for-5.15-printk-index 4/5] kernel/printk/index.c:140:6:
 warning: no previous prototype for 'pi_create_file'
Message-ID: <YPa7WTw2rmYpI1uE@chrisdown.name>
References: <202107192303.qeABbFBe-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <202107192303.qeABbFBe-lkp@intel.com>
User-Agent: Mutt/2.1 (4b100969) (2021-06-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot writes:
>tree:   https://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git for-5.15-printk-index
>head:   ad7d61f159db73974f1b0352f21afe04b0bbd920
>commit: 337015573718b161891a3473d25f59273f2e626b [4/5] printk: Userspace format indexing support
>config: arc-allyesconfig (attached as .config)
>compiler: arceb-elf-gcc (GCC) 10.3.0
>reproduce (this is a W=1 build):
>        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>        chmod +x ~/bin/make.cross
>        # https://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git/commit/?id=337015573718b161891a3473d25f59273f2e626b
>        git remote add printk https://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git
>        git fetch --no-tags printk for-5.15-printk-index
>        git checkout 337015573718b161891a3473d25f59273f2e626b
>        # save the attached .config to linux build tree
>        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-10.3.0 make.cross ARCH=arc
>
>If you fix the issue, kindly add following tag as appropriate
>Reported-by: kernel test robot <lkp@intel.com>
>
>All warnings (new ones prefixed by >>):
>
>>> kernel/printk/index.c:140:6: warning: no previous prototype for 'pi_create_file' [-Wmissing-prototypes]
>     140 | void pi_create_file(struct module *mod)
>         |      ^~~~~~~~~~~~~~
>>> kernel/printk/index.c:146:6: warning: no previous prototype for 'pi_remove_file' [-Wmissing-prototypes]
>     146 | void pi_remove_file(struct module *mod)
>         |      ^~~~~~~~~~~~~~

Ah, I missed `static inline', which causes the compiler to think we want to 
export it even though we don't.

diff --git kernel/printk/index.c kernel/printk/index.c
index ca062f5e1779..e340e0a8b847 100644
--- kernel/printk/index.c
+++ kernel/printk/index.c
@@ -137,13 +137,13 @@ static const char *pi_get_module_name(struct module *mod)
  }
  #endif
  
-void pi_create_file(struct module *mod)
+static inline void pi_create_file(struct module *mod)
  {
  	debugfs_create_file(pi_get_module_name(mod), 0444, dfs_index,
  				       mod, &dfs_index_fops);
  }
  
-void pi_remove_file(struct module *mod)
+static inline void pi_remove_file(struct module *mod)
  {
  	debugfs_remove(debugfs_lookup(pi_get_module_name(mod), dfs_index));
  }
