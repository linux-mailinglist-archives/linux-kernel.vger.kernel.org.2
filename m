Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE7F342F9E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 22:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbhCTVDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 17:03:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49879 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229618AbhCTVCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 17:02:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616274175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4UtsOvoM4xZlqiWtz5zs8d1TEHnAI88vYfIqO38Bx+Q=;
        b=ed269u6TNEsWDz1Y8DPIwbDPGs7GeB+iVgMGNgNPiY2x7wRyfx0sbvMDQ1G8mFvPZxKQLa
        8Taj4UcfyyUsXIr4YAKUmHBIcXP+gzL78hv9yYqC2q0mh8UhhxQNy5QWCqc+zkUh/ouxZy
        FLjm5KfKXELD779Y10kmcwQU8PFI9pM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-HYDOwNHvMnOhH-g6gChY8w-1; Sat, 20 Mar 2021 17:02:47 -0400
X-MC-Unique: HYDOwNHvMnOhH-g6gChY8w-1
Received: by mail-wr1-f69.google.com with SMTP id 75so23568130wrl.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 14:02:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4UtsOvoM4xZlqiWtz5zs8d1TEHnAI88vYfIqO38Bx+Q=;
        b=pq6oNe4EEh+afkDdRsLYQkVH1j/YTLDcWnLGEdTygz+q+czb/IeymDgpNKAFUn9Ceh
         pfqVa2L4ch8IzzdAyetka+/ogaxGdNZjDPKMpqoLKhKb4WQ2rVOLMbmq089cPuVg/EjR
         7MAhD6p77reObOuIHRxW72Otcu0H85OeI4Tq9ZDqjwXUFGHaoEHS7ypMDdBrmxGuRWlK
         0XprI21FTzZHyTaz/Tnnq0IaEM6lghhWVK72/16eRpzKd+1ItbaTQ7kZSlts17F5lSc6
         8qn7K0ggUi6e1N1gnFVwP21AoaEEZWqx+bAfeIlVo8jokQ+DuxdNX+d4cjkAydeSTkDh
         iyNw==
X-Gm-Message-State: AOAM530fsOSsvwHJamv9sDBjdo4c48182pYg8Upu7VXVq9b3DR3sZm+x
        QmzIx4OvNf7UNw0htcfS1+zsKUaMwxFVCODMQIoCmicJMn7HvD5NMNKibFruyxalluvbqjpx86Z
        nr7XC+9CK/Ic2QE6iuaqBWJjJ
X-Received: by 2002:adf:e68e:: with SMTP id r14mr10628572wrm.273.1616274165859;
        Sat, 20 Mar 2021 14:02:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwRuMgroq30c9/d+2YMlRsZDC7JjzuyOxlfSj/sa9iZCZM8sB7ozPxnzp1zrhUBm4hTgDwosQ==
X-Received: by 2002:adf:e68e:: with SMTP id r14mr10628550wrm.273.1616274165566;
        Sat, 20 Mar 2021 14:02:45 -0700 (PDT)
Received: from redhat.com ([2a10:800e:f0d3:0:b69b:9fb8:3947:5636])
        by smtp.gmail.com with ESMTPSA id c16sm17536990wrs.81.2021.03.20.14.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 14:02:44 -0700 (PDT)
Date:   Sat, 20 Mar 2021 17:02:41 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: xtensa-linux-ld: section .start VMA overlaps section .image VMA
Message-ID: <20210320170206-mutt-send-email-mst@kernel.org>
References: <202103210427.cW9n5Je3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202103210427.cW9n5Je3-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 21, 2021 at 04:37:29AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   812da4d39463a060738008a46cfc9f775e4bfcf6
> commit: 98701a2a861fa87a5055cf2809758e8725e8b146 vdpa: mlx5: fix vdpa/vhost dependencies
> date:   4 months ago
> config: xtensa-randconfig-r036-20210321 (attached as .config)
> compiler: xtensa-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=98701a2a861fa87a5055cf2809758e8725e8b146
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 98701a2a861fa87a5055cf2809758e8725e8b146
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=xtensa 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
> >> xtensa-linux-ld: section .start VMA [00000000d1000000,00000000d1000007] overlaps section .image VMA [00000000d0003000,00000000d25fe5d7]
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Link error? In response to tweaking some dependencies? Likely some kind
of mistake ...

-- 
MST

