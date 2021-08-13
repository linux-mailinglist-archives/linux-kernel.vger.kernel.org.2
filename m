Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04B923EBB64
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 19:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbhHMRYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 13:24:39 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:39344 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbhHMRYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 13:24:38 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 345401FFE7;
        Fri, 13 Aug 2021 17:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1628875450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IaoDX9vjNunz+khPUACQq4xbH9srsHzOAkpAeQHb2aA=;
        b=HklHC8PL9MAPXvU6kqy6g9gqpbynGPvuhchfGawPJK+qeWzRC0DrAGYi+a9HKr2PpktCNw
        qelJ0yl+6/gV5dzPz8fGcGewI+nmiVw6Hude4oyp4QbgGglqpCGgOrYC/Js1z0dshmht0X
        6xiuKxn/hJg27XPN3rXrvoT+5ioSpjg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1628875450;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IaoDX9vjNunz+khPUACQq4xbH9srsHzOAkpAeQHb2aA=;
        b=Uh0DN6LUaZttpmZpycg5sObldaRdn07j97ybdiKQq790Ujkw27yTwq51axzUQIYEb38ZKv
        m/wY9Oh069Bew8Bw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 1AB0B13668;
        Fri, 13 Aug 2021 17:24:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id JG40BrqqFmG3KQAAGKfGzw
        (envelope-from <bp@suse.de>); Fri, 13 Aug 2021 17:24:10 +0000
Date:   Fri, 13 Aug 2021 19:24:43 +0200
From:   Borislav Petkov <bp@suse.de>
To:     kernel test robot <lkp@intel.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, x86-ml <x86@kernel.org>
Subject: Re: vmlinux.o: warning: objtool: do_machine_check()+0x5dc: call to
 memset() leaves .noinstr.text section
Message-ID: <YRaq0YjECPNA1/D0@zn.tnic>
References: <202108140113.JJqRVW2H-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202108140113.JJqRVW2H-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 14, 2021 at 01:00:21AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   f8e6dfc64f6135d1b6c5215c14cd30b9b60a0008
> commit: 7bb39313cd6239e7eb95198950a02b4ad2a08316 x86/mce: Make mce_timed_out() identify holdout CPUs
> date:   7 months ago
> config: x86_64-buildonly-randconfig-r001-20210812 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=1 build):
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7bb39313cd6239e7eb95198950a02b4ad2a08316
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 7bb39313cd6239e7eb95198950a02b4ad2a08316
>         # save the attached .config to linux build tree
>         mkdir build_dir
>         make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> vmlinux.o: warning: objtool: do_machine_check()+0x5dc: call to memset() leaves .noinstr.text section

I cannot trigger this particular warning with your config ontop of
latest tip/master so you can drop this.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
