Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F58E446546
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 15:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbhKEO6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 10:58:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39939 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233105AbhKEO6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 10:58:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636124134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hAzffEp8ZqkwS9sPDpCH7RQdQWnXnUSEpiA8r4JtTzU=;
        b=f0m2Cd2YKb3I74UaAGb6CDD45BirA9TsPHQw9ssc28WA+0ole9XjCLa0T++l68cBaKkzJL
        ckXXcKvqD3XktPTvdLWZaORTLrSlXK1gbytJ3zsarUtDhXflyQ8x8WxXKUGdZRsdAMm/QD
        FUK6rwY7EUIRXxQWbtOj5HW65+5Zn0g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-565-aHMjH2sDPruoTCEzjrzR3Q-1; Fri, 05 Nov 2021 10:55:31 -0400
X-MC-Unique: aHMjH2sDPruoTCEzjrzR3Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EDAA81922962;
        Fri,  5 Nov 2021 14:55:29 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D70091037F38;
        Fri,  5 Nov 2021 14:54:41 +0000 (UTC)
Date:   Fri, 5 Nov 2021 22:54:36 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kbuild-all@lists.01.org, Petr Mladek <pmladek@suse.com>,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Joe Lawrence <joe.lawrence@redhat.com>
Subject: Re: [PATCH 2/2] kobject: wait until kobject is cleaned up before
 freeing module
Message-ID: <YYVFrJe5e1EZHyxS@T590>
References: <20211105063710.4092936-3-ming.lei@redhat.com>
 <202111052230.7LkeiKvG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202111052230.7LkeiKvG-lkp@intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2021 at 10:10:07PM +0800, kernel test robot wrote:
> Hi Ming,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on driver-core/driver-core-testing]
> [also build test ERROR on v5.15 next-20211105]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Ming-Lei/kobject-avoid-to-cleanup-kobject-after-module-is-unloaded/20211105-144026
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git 27e0bcd02990f7291adb0f111e300f06c495d509
> config: mips-buildonly-randconfig-r003-20211105 (attached as .config)
> compiler: mipsel-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/4a9e015dd3d3e39d5723ea46579ba21f5394806a
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Ming-Lei/kobject-avoid-to-cleanup-kobject-after-module-is-unloaded/20211105-144026
>         git checkout 4a9e015dd3d3e39d5723ea46579ba21f5394806a
>         # save the attached .config to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    lib/kobject.c: In function 'kobj_module_callback':
> >> lib/kobject.c:741:20: error: 'MODULE_STATE_GOING' undeclared (first use in this function)
>      741 |         if (val != MODULE_STATE_GOING)
>          |                    ^~~~~~~~~~~~~~~~~~
>    lib/kobject.c:741:20: note: each undeclared identifier is reported only once for each function it appears in

Hello,

Thanks for the report!

This must be triggered when CONFIG_MODULES is off, and the following patch
should kill the failure:


diff --git a/lib/kobject.c b/lib/kobject.c
index f5fd6017d8ce..c054dca0001a 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -738,8 +738,10 @@ static int kobj_module_callback(struct notifier_block *nb,
 {
 	LIST_HEAD(pending);
 
+#ifdef CONFIG_MODULES
 	if (val != MODULE_STATE_GOING)
 		return NOTIFY_DONE;
+#endif
 
 	spin_lock_irq(&kobj_cleanup_lock);
 	list_splice_init(&kobj_cleanup_list, &pending);


Thanks,
Ming

