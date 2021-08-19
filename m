Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 717D13F18D0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 14:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239117AbhHSMKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 08:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238105AbhHSMKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 08:10:08 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E2BC061575;
        Thu, 19 Aug 2021 05:09:31 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id bo18so4865131pjb.0;
        Thu, 19 Aug 2021 05:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7uXZKtKn5mEESRiEMx9wZAubOh9wcO7ElwkkE5uoIRQ=;
        b=MC2y3QRqWBk+wOI8OeskXUNNzrIJNe8OG2EoTzClSmy40srYQnthO/84qQ3wHQ+Kqq
         VDGREqzBLqb8+Q8pjSnDegyhYuIVNOUYnVfIJHupDG+TGjS8/OdEBFlW0PRHzHhpVDRQ
         9BKmZXd9DQYeKVlwEioJwn6tTtZwQo5iT1nnm+naQuierv61w5Yfc12MqYee8LD87sBr
         SKEka1YuzZhHP9rR1Yl0mVI3Eo6wWYP58tLCoxHkq1lC2oqsAOPWf8TssBxp2QTw25TG
         ct5hYklquc5GZa/6a+xWcrlcvz+YuggZrDCv+D2ID3bLHbp+ZXLBA9Ak37RnDzfKQ2PZ
         ZdgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7uXZKtKn5mEESRiEMx9wZAubOh9wcO7ElwkkE5uoIRQ=;
        b=kzyukOfjE1tLfvxFTrVS06H/cbY7V4fuAdreO6hCx5UG0rPrcAYeXl2WkIm98ONlSU
         86llqFaDmRU/8UhprtqJoYULtyOiCou/9CnEPvDmQp48XcTNJth7XxxuZ7eZS+Y4p783
         YujxOmCO8HZcf/408gRIRgQWsJMHdSvx3XVU9AFs06sFNl+4P0PYal6lmhoHjltGEN5k
         8XF+37FLjs5Xba0j3V1tZFG3w+JH8pgJQHGZOqxDhvfKFTkoQ5EADvWCtosGWSuDKqoF
         kjmG+SvQ7Dx3m819e4jWDH3x36l4TvP7KQnd9lqZQPiGf83BrtasRBZnNGQ3V7ARkceh
         zvYA==
X-Gm-Message-State: AOAM530OMw6zcfCSaMgZhtSQLEjrRpFrpdvPn09M2/GTAnFyEVMDmt8f
        f2WvSugsd0oXc/H8jq8OZn3xYQhpkczk0QXukVs=
X-Google-Smtp-Source: ABdhPJy8KxFALf0J6axJaJlVn7dZh6TFC9TteWgrxVqRQJpfTLSu3OtbmCx/QAxCO1Id5YN9Bk53qAT4aFRmSqm3ADA=
X-Received: by 2002:a17:902:ced0:b029:12d:4ce1:ce3a with SMTP id
 d16-20020a170902ced0b029012d4ce1ce3amr11567603plg.0.1629374971229; Thu, 19
 Aug 2021 05:09:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210819033001.20136-1-hpa@redhat.com> <20210819033001.20136-7-hpa@redhat.com>
In-Reply-To: <20210819033001.20136-7-hpa@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 19 Aug 2021 15:08:51 +0300
Message-ID: <CAHp75VdtXa=WXEFmvDP+zjmodzvJ+FmOpVZ6dq0C=nKnK=_zXA@mail.gmail.com>
Subject: Re: [PATCH v3 06/20] platform/x86: intel_scu: Move to intel sub-directory
To:     Kate Hsuan <hpa@redhat.com>
Cc:     Alex Hung <alex.hung@canonical.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        AceLan Kao <acelan.kao@canonical.com>,
        Jithu Joseph <jithu.joseph@intel.com>,
        Maurice Ma <maurice.ma@intel.com>,
        Sujith Thomas <sujith.thomas@intel.com>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        Zha Qipeng <qipeng.zha@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dell.Client.Kernel@dell.com,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 6:33 AM Kate Hsuan <hpa@redhat.com> wrote:
>
> Move intel_scu to intel sub-directory to improve readability.

Intel SCU

...

> -obj-$(CONFIG_INTEL_SCU_IPC)            += intel_scu_ipc.o
> -obj-$(CONFIG_INTEL_SCU_PCI)            += intel_scu_pcidrv.o
> -obj-$(CONFIG_INTEL_SCU_PLATFORM)       += intel_scu_pltdrv.o
> -obj-$(CONFIG_INTEL_SCU_WDT)            += intel_scu_wdt.o
> -obj-$(CONFIG_INTEL_SCU_IPC_UTIL)       += intel_scu_ipcutil.o

> +

Stray change?

...

> +obj-$(CONFIG_INTEL_SCU_IPC)            += scu/
> +obj-$(CONFIG_INTEL_SCU_PCI)            += scu/
> +obj-$(CONFIG_INTEL_SCU_PLATFORM)       += scu/
> +obj-$(CONFIG_INTEL_SCU_WDT)            += scu/
> +obj-$(CONFIG_INTEL_SCU_IPC_UTIL)       += scu/

One entry is enough.

...

> +obj-$(CONFIG_INTEL_SCU_IPC)            += ipc.o
> +obj-$(CONFIG_INTEL_SCU_PCI)            += pcidrv.o
> +obj-$(CONFIG_INTEL_SCU_WDT)            += wdt.o

This is not an equivalent. Please, use the same approach as below.

> +intel_scu_pltdrv-y                     := pltdrv.o
> +obj-$(CONFIG_INTEL_SCU_PLATFORM)       += intel_scu_pltdrv.o
> +intel_scu_ipcutil-y                    := ipcutil.o
> +obj-$(CONFIG_INTEL_SCU_IPC_UTIL)       += intel_scu_ipcutil.o

-- 
With Best Regards,
Andy Shevchenko
