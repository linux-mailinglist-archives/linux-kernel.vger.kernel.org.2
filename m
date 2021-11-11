Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBB8044CE5D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 01:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbhKKAiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 19:38:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbhKKAiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 19:38:07 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72433C061766
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 16:35:19 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id k1so4254393ilo.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 16:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pOJYYQzh0bVlep55TmKFCTAd7KKLyblma7Rn8UFg7nI=;
        b=2MdBWGoeE3yVms7sYpCu7U6toMvipaYD3ktIogdAC2dZC6PHW1Ue4/y2tzlXWJ+jX7
         FgCtASLx8tsoK9XCUKob+9Z/S7JLGMdLfZbiOJvQ09FhDTmxANF9MfKUk/LgYGlZfdJy
         QkSWsPXt92h25xqo+fDhufwoIZMNz1lrOPRcmCz0M8sImr30aQMhmYCMkwRhow+rGSfK
         NX5QIxCDrswlUBC4Nk9t+qB2UU5F4LtY+lCT0iREo7zJ9rEcxKWCnQED8fXN1Qm/1WLu
         sI5CjCo1MsrqIx2rxNMgjEcCgXuVFlYToNXFqkmvZaPC5JGC4OwJitYKLiA9Mvb7ZKJb
         49Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pOJYYQzh0bVlep55TmKFCTAd7KKLyblma7Rn8UFg7nI=;
        b=03is5IXIcoIwNN29JBYrbMNlDH6SU22RsFYGj0lRcSet+evf3wMGdsOwGOOqMFsSRV
         WnjRuqu3Z6frNdZjMB1nQO0rcfAn6GR/XXoK+FuWz7WIj4ebiNvKAN625X5rVVfjasDS
         lb6fhyR4PlOP45SCAV9wPj3aFVNdW3WodfvJ/DVu+XvtB18Y+8D3Lo6CleZJvNscQOcR
         81NTzvhtkm9GIyR2gSlcXEqMVRzQpxDJuJhMzJYTjIOjGRAQiYm8c25SRV6OOV7GG6y6
         jIyPCAJ3V6kOH/Vmd0Tli8fopiarzW7EAVSFEE8p1gP6fO2dAPJ+XrjpuJj7cvWZJAph
         +a2Q==
X-Gm-Message-State: AOAM533N0kbMuBWkI4rP6uQwl8gHZpqBXHSsHsotXfDle5cPXjRlvwAA
        aLvhPKNAQuDno8MA1g28XxR6Fg==
X-Google-Smtp-Source: ABdhPJy3VMbu2vyw+AG+xhyAO+gZ+wamDWef9idR5+n24XxFBdiDk595peueDXLYHCk4m/2+Ko6BRA==
X-Received: by 2002:a05:6e02:2166:: with SMTP id s6mr1887052ilv.170.1636590918829;
        Wed, 10 Nov 2021 16:35:18 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id o14sm723630ioo.36.2021.11.10.16.35.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Nov 2021 16:35:18 -0800 (PST)
Subject: Re: block/blk-ia-ranges.c:119: warning: expecting prototype for
 disk_register_ia_ranges(). Prototype was for
 disk_register_independent_access_ranges() instead
To:     kernel test robot <lkp@intel.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Keith Busch <kbusch@kernel.org>
References: <202111110829.XuUWn4Km-lkp@intel.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f5ec9cf3-8d7a-4142-dee6-cfbf5bd81129@kernel.dk>
Date:   Wed, 10 Nov 2021 17:35:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <202111110829.XuUWn4Km-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/21 5:26 PM, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   881007522c8fcc3785c75432dbb149ca1b78e106
> commit: a2247f19ee1c5ad75ef095cdfb909a3244b88aa8 block: Add independent access ranges support
> date:   2 weeks ago
> config: m68k-randconfig-r036-20211027 (attached as .config)
> compiler: m68k-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a2247f19ee1c5ad75ef095cdfb909a3244b88aa8
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout a2247f19ee1c5ad75ef095cdfb909a3244b88aa8
>         # save the attached .config to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>>> block/blk-ia-ranges.c:119: warning: expecting prototype for disk_register_ia_ranges(). Prototype was for disk_register_independent_access_ranges() instead

Thanks, fixed here:

https://git.kernel.dk/cgit/linux-block/commit/?h=block-5.16&id=68636e242d45453d48a7d30a18a49f80d4ae08c0

-- 
Jens Axboe

