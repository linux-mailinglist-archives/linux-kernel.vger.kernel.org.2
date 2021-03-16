Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E522733E24F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 00:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbhCPXnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 19:43:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:44368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229529AbhCPXnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 19:43:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1621864F0F;
        Tue, 16 Mar 2021 23:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615938188;
        bh=1juVaj8zwVwWX/l7s+BY6ME28H2myziVkvLl+Txp3Gs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=MpwrIgBR1JONIv3OUYtDXVfeTsq7QcBLLXYJsAVdiHgnQ7CSWZEQHHZI8MzV8iFLC
         dm7I+ovBE2NAA4WT4zHmHBb63FvPunJdfKiuwFZeJEujpHhaeDVWGcEyTtwaXZtcdO
         Y2ThsOiVqMjzJ8m9Gbwi5TLxuHTVvQj43+K0SElT0g1lB40jYCw7ZQnxDgbomuGFpO
         iNsbQzMxhslC9AeAeQjfRt70J0qR6yNa9CTP6LR0AI3vilA2aBmp/7m+FdmIRnqaKg
         9ObIUyI9I6gpIQ02Vqt/nMIHOsVPqk91nwdmGajifQIn1m8P6hp40kMS82IIfjwv+C
         ycJf4vPWclSNw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B949B3522A5A; Tue, 16 Mar 2021 16:43:07 -0700 (PDT)
Date:   Tue, 16 Mar 2021 16:43:07 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [rcu:rcu/next 33/36] ERROR: modpost: "rcu_read_unlock_longwait"
 undefined!
Message-ID: <20210316234307.GZ2696@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <202103170728.9kxVaZbV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202103170728.9kxVaZbV-lkp@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 07:18:34AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
> head:   9035ae87fcb36d2a7c8872e1cc0a46c0c5b619a8
> commit: bd6ae31d1b1f22ab7ff8376b416f09d93d9ef75d [33/36] rcutorture: Add the ability to torture RCU longsleep
> config: x86_64-randconfig-r015-20210316 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=1 build):
>         # https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?id=bd6ae31d1b1f22ab7ff8376b416f09d93d9ef75d
>         git remote add rcu https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
>         git fetch --no-tags rcu rcu/next
>         git checkout bd6ae31d1b1f22ab7ff8376b416f09d93d9ef75d
>         # save the attached .config to linux build tree
>         make W=1 ARCH=x86_64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>, old ones prefixed by <<):
> 
> >> ERROR: modpost: "rcu_read_unlock_longwait" [kernel/rcu/rcutorture.ko] undefined!
> >> ERROR: modpost: "rcu_read_lock_longwait" [kernel/rcu/rcutorture.ko] undefined!
> >> ERROR: modpost: "rcu_read_lock_longwait_held" [kernel/rcu/rcutorture.ko] undefined!

Good catch, fixed with attribution, thank you!

							Thanx, Paul
