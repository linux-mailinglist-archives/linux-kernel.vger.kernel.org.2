Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A21944F7AC
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 12:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234736AbhKNLqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 06:46:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233656AbhKNLq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 06:46:27 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4008EC061746
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 03:43:21 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id e3so21919866edu.4
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 03:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H75V4Gyv1omQl5DQYHu02p1pO9X8AXcURgokHKae96Q=;
        b=Sy9hcUWOjTIBSTNwcNQM0Lj2aE1rniLUGyjKZlGEoMV3Za3alcTZqc6FvgXwBeyQOl
         wWCuCY3MToEuDTqqKYU7ATjfR3GYEpIrIeKBEDVH134N2ATrl6ItKCIyZoJ0Ky8br0UF
         oF9/Jjm3useAUO/d+Mbg4kd/8L8blKgXeJpSkOBh85oJ8ssbR5FwCSUCt3kOedaz8yKu
         ts8OYd6QjRQFJfBYB4IR8LFwsjVJVkSOy/TLo+Mp5ZIkYNuDa/XR+6Ag1ZKcS2xXTPzR
         PrFyC7+YzSstJ3/22HjC+hYofwP5AXE+BCfdlLwMlqe9QpoxIvFPQ7em/4ASoqVcIrwu
         IRYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H75V4Gyv1omQl5DQYHu02p1pO9X8AXcURgokHKae96Q=;
        b=npkH7K5H1qwgEf7zHOcYDXgisOvDcCZfYOb8LpYT3wEZYqnZyuOVIRBPUxUPZMzlnU
         5EhEyxAU1H2zQL3H7uZwHQiiJa+leTHjTH/7fDhrkslQOxikRS/aqXkKIfjZSu14gNtl
         YEJxJ+g+N2lIC3RhWraBi+WABZmen9t5XK3iOUbJ68VSNOOMh9doTeZFWfyw0oAQBUZl
         1nNVKT9kztNxojH8DDJOU2o0MPXp/ADr96HH2Ds3mLi3RKrnYj2tn5V1C88ktyOgZF77
         l9TcOaM3S9izcCI8Qkx6sMqfhrxKitMwP9rXm9ba1wZQ8xxz7R3sFnFJshzz54lFV4Kr
         dX9w==
X-Gm-Message-State: AOAM530muuZQUo3ElvV3FYA6oJsLjZXnnT9+6aiu9Up1meA6yMo+XzY/
        kh1PZfeUzt+sb+M6CtRl94kvvzZuhDldaSPOjco=
X-Google-Smtp-Source: ABdhPJy4dgE/S9l1WUJ4J3a7culKJNXrO5gJ4iQLujCNBoag9GqC0h4sQ5SJnyciO596uRtZuDJJjwrBBX1paZWbUlY=
X-Received: by 2002:a50:fd16:: with SMTP id i22mr35107169eds.224.1636890199854;
 Sun, 14 Nov 2021 03:43:19 -0800 (PST)
MIME-Version: 1.0
References: <202111141153.mtggZgGq-lkp@intel.com>
In-Reply-To: <202111141153.mtggZgGq-lkp@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 14 Nov 2021 13:42:43 +0200
Message-ID: <CAHp75VffPmtu-aer8rNA3ctoGTmvjTJYH44CRLsMVHSjcPc+qQ@mail.gmail.com>
Subject: Re: drivers/platform/x86/thinkpad_acpi.c:4475:35: error: unused
 variable 'fwbug_cards_ids'
To:     kernel test robot <lkp@intel.com>
Cc:     Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 14, 2021 at 5:15 AM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   c8c109546a19613d323a319d0c921cb1f317e629
> commit: fd96e35ea7b95f1e216277805be89d66e4ae962d platform/x86: thinkpad_acpi: Fix bitwise vs. logical warning
> date:   4 weeks ago
> config: i386-buildonly-randconfig-r005-20211114 (attached as .config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project c3dddeeafb529e769cde87bd29ef6271ac6bfa5c)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fd96e35ea7b95f1e216277805be89d66e4ae962d
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout fd96e35ea7b95f1e216277805be89d66e4ae962d
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=i386
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
> >> drivers/platform/x86/thinkpad_acpi.c:4475:35: error: unused variable 'fwbug_cards_ids' [-Werror,-Wunused-const-variable]
>    static const struct pci_device_id fwbug_cards_ids[] __initconst = {
>                                      ^
>    1 error generated.

Perhaps something like

  if (!dmi_check_system(bt_fwbug_list))
    return 0;
  if (!pci_dev_present(fwbug_cards_ids))
    return 0;

  vdbg_printk(TPACPI_DBG_INIT | TPACPI_DBG_RFKILL, FW_BUG "disable
bluetooth subdriver for Intel cards\n");
  return 1;

would work?

-- 
With Best Regards,
Andy Shevchenko
