Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 609473DF1C9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 17:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237038AbhHCPsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 11:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237017AbhHCPsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 11:48:08 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A254C061757
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 08:47:56 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id i9so2234100ilk.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 08:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jXC0Y2g74WJTpUmlqw4J1JBL69dFjmrgLHk6CYQ/AJU=;
        b=lLBaIGQX+cnENyXJ17fooFd1QN3qNiehRZjWS5hN3sL9yMjD5Nx9L2dg+ILkM4u7n+
         le9UodK8+oe+xbCsY/1gHhQasXBg+CrF7EGkvwpgz7PAgX2H0K1hjt37SsNZLONrq+xG
         wxyavtvXfoASZoZi+gwZ6Y73lX6byqRAl8xbBTLyJHTHK52tyYBHjfbzlUsBvzJY3CPq
         pMp2oyzi7+DGSNC8JpAhVSOFVdEg1BAUdJo0fjE9IK5D+EosCtAMwcj1NRdmHgw1+6hG
         5XYx9Ro3eIO0iFt1b6v9S+fvqYBdSn1mF+8WS2CPMta6Ac3lL1pht92SeiQIEZwNsjuo
         ykvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jXC0Y2g74WJTpUmlqw4J1JBL69dFjmrgLHk6CYQ/AJU=;
        b=SU4WHbq845blvjPPi2jtnTmz8laB/6ww3l+pvAzw3588PH/Rj8BXY/4G8kz+gmJ8zQ
         4IIdFlof2JESk2Z3vlbeIHBxASKwxXZj2zANzs5h3o7KVI2+pDPLOztfiKU39OzXdoIE
         uy9wCqBsXTOCKFw72Zzsa/dhGoKwruoBuI8IawZ67qFiajuo3WQzBhkWpNdj/RM5pFH0
         JXTG3SqCuBUf7/xOmTU10X3UlwU5trsOxC4yzIWEG0BYwQKMOTweju0sLM7ZXQsnzoqJ
         1cZ+ITeIy/KWED9WE1rwDQLjhFFWL9qCorF3Vy7c0RBAoFfiZjh/HbXvgiAyniNM+/ax
         brjw==
X-Gm-Message-State: AOAM533ZwyvBs8YBSFyr7zgUZPz8Sq+tYUL0ycWKsWfDAVzMTGnj91eL
        i8ETvydZpH4zb8XXstd5OtpgQPWDtikrwaA57nY=
X-Google-Smtp-Source: ABdhPJztWzZZJMX16AKLg7Qzs5tr1zr84gJzHra2Pcx0lBKSJQTxsCdvh2zRHHhGm0jqp4OAqeHtaDaB5MawJ76qEWI=
X-Received: by 2002:a05:6e02:1c02:: with SMTP id l2mr800069ilh.9.1628005675573;
 Tue, 03 Aug 2021 08:47:55 -0700 (PDT)
MIME-Version: 1.0
References: <202108031920.zQxxab9v-lkp@intel.com>
In-Reply-To: <202108031920.zQxxab9v-lkp@intel.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 3 Aug 2021 18:47:44 +0300
Message-ID: <CAOQ4uxiwVTXMs=Oxx8QUPO_Cqv3Z3oW9kLw0Dipy-rLyD3tViA@mail.gmail.com>
Subject: Re: [amir73il:fsnotify_event_info 2/2] include/linux/fsnotify.h:263:2:
 error: implicit declaration of function 'fsnotify_file'; did you mean 'fsnotify_link'?
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 3, 2021 at 2:31 PM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://github.com/amir73il/linux fsnotify_event_info
> head:   4ad14805402352430e0b98901b97ec9166d9dae4
> commit: 4ad14805402352430e0b98901b97ec9166d9dae4 [2/2] fsnotify: fast path optimization for IO on pipe with no watches
> config: sparc-randconfig-r026-20210803 (attached as .config)
> compiler: sparc-linux-gcc (GCC) 10.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/amir73il/linux/commit/4ad14805402352430e0b98901b97ec9166d9dae4
>         git remote add amir73il https://github.com/amir73il/linux
>         git fetch --no-tags amir73il fsnotify_event_info
>         git checkout 4ad14805402352430e0b98901b97ec9166d9dae4
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-10.3.0 make.cross ARCH=sparc
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    In file included from fs/notify/fsnotify.h:6,
>                     from fs/notify/fsnotify.c:15:
>    include/linux/fsnotify.h: In function 'fsnotify_access':
> >> include/linux/fsnotify.h:263:2: error: implicit declaration of function 'fsnotify_file'; did you mean 'fsnotify_link'? [-Werror=implicit-function-declaration]
>      263 |  fsnotify_file(file, FS_ACCESS);
>          |  ^~~~~~~~~~~~~
>          |  fsnotify_link
>    cc1: some warnings being treated as errors
>

That's odd. fsnotify_event_info is just an arbitrary branch in my tree
where I pushed some WIP code. I don't remember posting it to the
list, I'm not sure why the kernel robot tested it...

Thanks,
Amir.
