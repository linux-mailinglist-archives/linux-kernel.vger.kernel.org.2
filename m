Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C77C839958B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 23:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbhFBVpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 17:45:21 -0400
Received: from mail-pg1-f179.google.com ([209.85.215.179]:44909 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229467AbhFBVpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 17:45:20 -0400
Received: by mail-pg1-f179.google.com with SMTP id 29so3388244pgu.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 14:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8JoSNwGDv96uJN6hZs8YVzh9AT3KWZ5PqUHPJ+OwKFs=;
        b=QprOmp8HsQRvORttDDxp+CdYIRuXcET+7I+gBOwNuEBKu0McM8O+ALFY0o35mXo1dE
         erBvAysWaO4a6JONFAjeDYJqpULwUM/RnldItsZgBsYSuu9KH2lyrU84OQzoTYBmnBB/
         mAB5nbiCJ1vytwF9ERwbFAOiHt+dAFPK7rf74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8JoSNwGDv96uJN6hZs8YVzh9AT3KWZ5PqUHPJ+OwKFs=;
        b=kJO9b0e6DcgRiy8UUlajgzW/huRWxBcr+g+qnMTOcSmtFgSJtS0cqmFJ7oenPk5teb
         ZmoJ04UYBYcvcUIJvMz/LfLo710yMlCPmEjVufBHKWVqVRzJF/X3VSl5I1TBlPVGK7RU
         G4hOWc2v7Ou6qah6NVyYC1F7qxKzvR+cLbI3EZ1p/J5zcKDDpp/TUbpqsm/sr/ibrUK5
         QtcDVd9niG6IG2zw1ndyRTxuFuoDOZ8vvZ50i/cfm5BpyS8Cx3B7zoaR5dxhnYvGYe9c
         GGWlum7Us1xyEY7mVN4cdLRofxPdVvxsrX/PeS1Hkl54fpJ3lS5NUcqMtnFkwQYGoNwl
         7nyQ==
X-Gm-Message-State: AOAM533p/wYEyLnYEOlCBMm6Dl4+AUYIZTVTAZ4RARg1WvFJ7oNUxRa3
        AWQevs9BlFPgVH8k8u6K9PJOqA==
X-Google-Smtp-Source: ABdhPJyOGMFWyl9POXkBD4bFOqrep5Dha2L6yuviYCd7pQ18J6ObgbsQ0OcLjsTIrJvTWmdmg1vZZw==
X-Received: by 2002:a63:dd48:: with SMTP id g8mr35815573pgj.102.1622670140470;
        Wed, 02 Jun 2021 14:42:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id bv3sm404081pjb.1.2021.06.02.14.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 14:42:19 -0700 (PDT)
Date:   Wed, 2 Jun 2021 14:42:18 -0700
From:   Kees Cook <keescook@chromium.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: aarch64-linux-ld: Unexpected GOT/PLT entries detected!
Message-ID: <202106021441.A256AD6FC4@keescook>
References: <202105300926.fX0MYySp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202105300926.fX0MYySp-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 30, 2021 at 09:29:28AM +0800, kernel test robot wrote:
> Hi Kees,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   df8c66c4cfb91f2372d138b9b714f6df6f506966
> commit: be2881824ae9eb92a35b094f734f9ca7339ddf6d arm64/build: Assert for unwanted sections
> date:   9 months ago
> config: arm64-randconfig-r012-20210530 (attached as .config)
> compiler: aarch64-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=be2881824ae9eb92a35b094f734f9ca7339ddf6d
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout be2881824ae9eb92a35b094f734f9ca7339ddf6d
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arm64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
> >> aarch64-linux-ld: Unexpected GOT/PLT entries detected!
> >> aarch64-linux-ld: Unexpected run-time procedure linkages detected!
>    aarch64-linux-ld: drivers/gpu/drm/pl111/pl111_versatile.o: in function `pl111_versatile_init':
>    (.text+0x270): undefined reference to `devm_regmap_init_vexpress_config'

When the other linker failures are fixed the GOT/PLT errors go away from
me. I'll send those patches separately...

-- 
Kees Cook
