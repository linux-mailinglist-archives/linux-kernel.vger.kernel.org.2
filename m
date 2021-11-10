Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9BC244CB5A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 22:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbhKJVlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 16:41:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbhKJVlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 16:41:13 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD76C061766
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 13:38:25 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id u11so9301883lfs.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 13:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D1z6yFw1+0sjIG7f/nWzQHi2azAv8rrhzZz6SpWHNuM=;
        b=WEIjO9suAw0S5n0/8xePw/9zyOCQ82BMKNODVfHoR78GTG3zeg6GkhFPCLJIsFCjvz
         bJVm0yam2RSFMl3esknEdAS9ODHTqOy6amhxC12wyjiqlgdEelF/QpVTDjnrApktgtae
         ZNBHIp4VnoNFbkYwJlv8VqK7o/V4J+shWCYxlKqY3dDyttmXnbPccPYE+njowYXo5fJX
         qhDwePaO54X/c5iyD0ah9kw0f52od9wnZA3OOYLBr/7pH/AEmkc5xs5fotAaSDnUS+jK
         P9nXANp5U4MtyprHHDl48a27zc++RXkCphZMYxvelIGof9UepJFEp4Ir631Sdg4LHk4A
         hN1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D1z6yFw1+0sjIG7f/nWzQHi2azAv8rrhzZz6SpWHNuM=;
        b=yzbZj4/oqD3morSC9Cnr2angML0R149LzYGFBhNEHhBEwxZpdNfWgFatd/EzOL0t/O
         jEH+q+ZveDlWmL0o7M9yDjZ3//WRUc2dZ1eM8BVgxz0uJWFdmcrJfHK0er2jN43emvr3
         6dcYzksOq13dX+PXX1QRKklcssBR/1TUwVZGAeWzer+0n52ezF6bqubOAqx77BG4AMsi
         t8J+Y+Jy6bF9WCYMqhlK25a2XdcYRgvtOw3ndQmuOYjKMAp1pybX7X/tSg+xfUWtLzGp
         tZJchi3W94YRfiIikOqi4MGIx5dKPw02uLm+Rr+qA3JHOsYOywHTaSsaLK9CGW8JjYdk
         GoQg==
X-Gm-Message-State: AOAM531NAPt0T0BciHJIakJmmj2NgXF9wWtVkuP2AaOlU5D9M+f8cvvO
        Mkfbjafa+c7b2SKdNpEqX3WU7eahjJDffv6v0Fg1QQ==
X-Google-Smtp-Source: ABdhPJzjaFy5q9lDBd1wo9aZvGBOM/b8VEotHF5YZ79B0EbTM7S5RL5M93fguRMPKxqbWX/iwxlaCKZr5lO5Q3V9YmA=
X-Received: by 2002:a05:6512:607:: with SMTP id b7mr2082726lfe.489.1636580303716;
 Wed, 10 Nov 2021 13:38:23 -0800 (PST)
MIME-Version: 1.0
References: <20211104133735.1223989-1-arnd@kernel.org>
In-Reply-To: <20211104133735.1223989-1-arnd@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 10 Nov 2021 13:38:11 -0800
Message-ID: <CAKwvOd=vrUe7xWohkPZkfui2BM-uP2Q79v02NzTJs9XJJ1CTjw@mail.gmail.com>
Subject: Re: [PATCH] iwlwifi: pcie: fix constant-conversion warning
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Luca Coelho <luciano.coelho@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Yaara Baruch <yaara.baruch@intel.com>,
        Matti Gottlieb <matti.gottlieb@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 4, 2021 at 6:37 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> clang points out a potential issue with integer overflow when
> the iwl_dev_info_table[] array is empty:
>
> drivers/net/wireless/intel/iwlwifi/pcie/drv.c:1344:42: error: implicit conversion from 'unsigned long' to 'int' changes value from 18446744073709551615 to -1 [-Werror,-Wconstant-conversion]
>         for (i = ARRAY_SIZE(iwl_dev_info_table) - 1; i >= 0; i--) {
>                ~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
>
> This is still harmless, as the loop correctly terminates, but adding
> an (int) cast makes that clearer to the compiler.
>
> Fixes: 3f7320428fa4 ("iwlwifi: pcie: simplify iwl_pci_find_dev_info()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
> index c574f041f096..81e8f2fc4982 100644
> --- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
> +++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
> @@ -1341,7 +1341,7 @@ iwl_pci_find_dev_info(u16 device, u16 subsystem_device,
>  {
>         int i;
>
> -       for (i = ARRAY_SIZE(iwl_dev_info_table) - 1; i >= 0; i--) {
> +       for (i = (int)ARRAY_SIZE(iwl_dev_info_table) - 1; i >= 0; i--) {

Perhaps `i` could be a `size_t` instead of an `int`?

size_t i = ARRAY_SIZE(iwl_dev_info_table);
while (i--) {
  ...

>                 const struct iwl_dev_info *dev_info = &iwl_dev_info_table[i];
>
>                 if (dev_info->device != (u16)IWL_CFG_ANY &&
> --
> 2.29.2
>


-- 
Thanks,
~Nick Desaulniers
