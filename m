Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9723187C7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 11:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbhBKKH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 05:07:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbhBKKDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 05:03:55 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD73C061574;
        Thu, 11 Feb 2021 02:03:15 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id u11so3033706plg.13;
        Thu, 11 Feb 2021 02:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TW9rgByPY6fpHRbv0KoopjlOcx3o7bE39ibwTcjzIG0=;
        b=ELBM7nf5y9iPLer+ZSUeUrYpZpf1euYqlK8yaFFdC4yrYBhyfz3ONX5Yvi39oj7dfu
         PCFWkfaymvH/k9ghrbo3uHaWG/LJylSIXUmIZaFECmn6uan+0/yqs37UmQjn6Rdlg88P
         1TJFyKLmtj+M9Y15xxDa5QTq7xvrfWuNIYOnOgeief0nObT1ba0on5FcaxunD27w7Zv/
         NlQrVKMeZNwEcjYrEk2Iqt4L5y3NCwJsKGhd8beKpyYn/3CdCdBtaf4lG5rbRj6+AsM3
         rpAFiWTwys3XIO2gejabWzVmiKiuLwodH5RkpSEhsk6YMNi0unmN/UBFCJ8gMX67Z1d9
         61Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TW9rgByPY6fpHRbv0KoopjlOcx3o7bE39ibwTcjzIG0=;
        b=dawDBSf7HMa7mmIC8lCjmea/G/qIDB1WbAzZozJgPOJuV166cFzBnSF21fCb4bwpYp
         0qleDH2vBI1ttwxdeD86fEzRRuspuN28PuHWtV2khACzFN/Ix9F6Lqfc1a81OGAu4Iap
         ujujn7SRg+W65+InduUFFbU1DOdS04ry5H6dgHI6o+audHB3su5N69j5qexGS/WK9rnI
         bbTXRDfEmIGN9oDJB84GseGVO+rrsvCjFkKIhIxG5XifLJ7jybnK0Wdew+ddD8HbHfeo
         +NKc0BI1NZ2oGdphV4XxcwCxY00uK1WagVZn2GaIf3iv0gXjxVWyRoRQsZfpjsHkich7
         f0yw==
X-Gm-Message-State: AOAM531nKBlA9OXeM3L+grZ1EM3VkKYBW5y5IVU+s4OZj/Y32FF7ELXh
        dVmdEVAW9ewjPcDsOUVBUw0y5K7K3edOkjYaHg8=
X-Google-Smtp-Source: ABdhPJwTntiKU/E1WDjk5TA+W1MWW1u3EwrTtsrpwGHCjbWIIerBKpkgGcgKS8UeVj9Quy8Y0stwQNVBK6FU895v5Ww=
X-Received: by 2002:a17:902:7b96:b029:de:7ae6:b8db with SMTP id
 w22-20020a1709027b96b02900de7ae6b8dbmr7014640pll.0.1613037794650; Thu, 11 Feb
 2021 02:03:14 -0800 (PST)
MIME-Version: 1.0
References: <20210210192041.17022-1-casey.g.bowman@intel.com>
In-Reply-To: <20210210192041.17022-1-casey.g.bowman@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 11 Feb 2021 12:02:58 +0200
Message-ID: <CAHp75Vdk_6PBRg8=1cfbMwGRWiG39-SL5np82oWLD5-+DJCNWQ@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: intel_scu_ipc: Increase virtual timeout
 from 3 to 5 seconds
To:     Casey Bowman <casey.g.bowman@intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>, azhar.shaikh@intel.com,
        Lee Jones <lee.jones@linaro.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 9:20 PM Casey Bowman <casey.g.bowman@intel.com> wrote:
>
> Increasing the virtual timeout time to account for scenarios
> that may require more time, like DisplayPort Multi-Stream Transport
> (DP MST), where the disconnect time can be extended longer than
> usual.
>
> The recommended timeout range is 5-10 seconds, of which
> we will take the lower bound.

Since the driver is used across several platforms, can we somehow be
more flexible with it on a per platform basis or so (per command?)?
In general I'm not against the patch and I usually don't see the long
timeouts on other platforms, so if Hans thinks it's okay to take,
Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Casey Bowman <casey.g.bowman@intel.com>
> Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/platform/x86/intel_scu_ipc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
> index d9cf7f7602b0..9171a46a9e3f 100644
> --- a/drivers/platform/x86/intel_scu_ipc.c
> +++ b/drivers/platform/x86/intel_scu_ipc.c
> @@ -75,7 +75,7 @@ struct intel_scu_ipc_dev {
>  #define IPC_READ_BUFFER                0x90
>
>  /* Timeout in jiffies */
> -#define IPC_TIMEOUT            (3 * HZ)
> +#define IPC_TIMEOUT            (5 * HZ)
>
>  static struct intel_scu_ipc_dev *ipcdev; /* Only one for now */
>  static DEFINE_MUTEX(ipclock); /* lock used to prevent multiple call to SCU */
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
