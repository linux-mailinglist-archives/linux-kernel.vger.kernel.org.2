Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC7B3A2FBA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 17:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbhFJPsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 11:48:03 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:43598 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbhFJPrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 11:47:05 -0400
Received: by mail-oi1-f174.google.com with SMTP id x196so2566613oif.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 08:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bIkOC7ijnAkY9Mv5y+9kSysZ6u0yFrSnVrFQUWyVl0k=;
        b=PoYNHPf/2yuR5K/nzjrK6zwk0D4OD9xdvf7Py80pXwPb5pQTwpnWUb/UmeC49+VD9k
         8jyk2PS5KwoZXvKxZcIf5lnopBxandWalBuxXJ3JuiC/vRN5aQK7PwfM9B0dU/ZkaYQo
         NTgcCS4uI9If9wkCr73EkhnJBZLYw3l+WKS2bfJuoHdpbAysYLLZqMThyvijKJt39uRC
         KLemQgY0EXkvGHgxIyxalj5XyyKC8JCd+i62eoHNmvjOiA9e/9w/9/5ZtxXqISusrwdv
         8TMSzD9kESyYjbGqEBnskid1PlTrV8tvsFGCvHS+lVMm/HoDBWGeBcqQ6TwAqRwnwnq2
         FQdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bIkOC7ijnAkY9Mv5y+9kSysZ6u0yFrSnVrFQUWyVl0k=;
        b=fEBorsa4TpC1I2c8hvV8cE84kcR7hzYBogPVIGCCUoH/EFxde+jo0IlwRfFwF2ZTV9
         0JMR/Yi4IpoRXBOYv3IluDY+pEC0hPj0bnArdz+ILMg3wraD1RseRhEimp2xaZzDWrXe
         xEIZuBfAOQWBVvHcB0qQ5VtJGhRZf5zoOhMv1z3rHeQMImJdO6Nc6sg3gWm1LV8TkjmN
         RoCbIOwiserkOrny4uDkQTQu4qHLsUx1En1Idqf+qBVEkrS3RVVkK30pJl5U3Q+ew4gZ
         7sIeOB5MV6lhWk7qbWND5JQZItfd6tVcPKVOT2SZXha8pAfKFPuproWcvR1M1F4ZPIXZ
         y7UA==
X-Gm-Message-State: AOAM533MeuGj+LjnZfckM0XHCKUNx28YV3azCsOMEBaOhSUo62vfnu1U
        zWmOxPrD3vZx+mqokbuCtxB23elp9L1980AfWs80Lw==
X-Google-Smtp-Source: ABdhPJzOHeoZSvYc1NerQZgvWa/MQnTSIUxyjUv8ITSmLs44wRNwhb1SwHGpge4+SkLY/DhDACQsez6dQfmAKaWL+1M=
X-Received: by 2002:a54:408b:: with SMTP id i11mr3984419oii.132.1623339832419;
 Thu, 10 Jun 2021 08:43:52 -0700 (PDT)
MIME-Version: 1.0
References: <548dd463-3942-00a1-85c3-232897dea1a3@canonical.com> <162332615476.15946.17135355064135638083@jlahtine-mobl.ger.corp.intel.com>
In-Reply-To: <162332615476.15946.17135355064135638083@jlahtine-mobl.ger.corp.intel.com>
From:   Jesse Barnes <jsbarnes@google.com>
Date:   Thu, 10 Jun 2021 08:43:40 -0700
Message-ID: <CAJmaN=ma2vFqB8c=g7YyV6zeKx1dFRDx7o9JmFgse4QTc6C84Q@mail.gmail.com>
Subject: Re: Computation of return value being discarded in get_cpu_power() in drivers/platform/x86/intel_ips.c
To:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Colin Ian King <colin.king@canonical.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Mark Gross <mgross@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        platform-driver-x86@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arg html email sorry.  Resending plain text:

It may be ok to drop this driver entirely now too; I doubt anyone is
relying on GPU turbo in Ironlake for anything critical anymore.  That
would allow for some simplifications in i915 too if it's still
supported.


On Thu, Jun 10, 2021 at 4:56 AM Joonas Lahtinen
<joonas.lahtinen@linux.intel.com> wrote:
>
> (Address for Hans was corrupt in previous message, which confused my mail
> client. Sorry for duplicate message, the other is without From: field).
>
> + Jesse
>
> Quoting Colin Ian King (2021-06-09 14:50:07)
> > Hi,
> >
> > I was reviewing some old unassigned variable warnings from static
> > analysis by Coverity and found an issue introduced with the following
> > commit:
> >
> > commit aa7ffc01d254c91a36bf854d57a14049c6134c72
> > Author: Jesse Barnes <jbarnes@virtuousgeek.org>
> > Date:   Fri May 14 15:41:14 2010 -0700
> >
> >     x86 platform driver: intelligent power sharing driver
> >
> > The analysis is as follows:
> >
> > drivers/platform/x86/intel_ips.c
> >
> >  871 static u32 get_cpu_power(struct ips_driver *ips, u32 *last, int period)
> >  872 {
> >  873        u32 val;
> >  874        u32 ret;
> >  875
> >  876        /*
> >  877         * CEC is in joules/65535.  Take difference over time to
> >  878         * get watts.
> >  879         */
> >  880        val = thm_readl(THM_CEC);
> >  881
> >  882        /* period is in ms and we want mW */
> >  883        ret = (((val - *last) * 1000) / period);
> >
> > Unused value (UNUSED_VALUE)
> > assigned_value:  Assigning value from ret * 1000U / 65535U to ret here,
> > but that stored value is not used.
> >
> >  884        ret = (ret * 1000) / 65535;
> >  885        *last = val;
> >  886
> >  887        return 0;
> >  888 }
> >
> > I'm really not sure why ret is being calculated on lines 883,884 and not
> > being used. Should that be *last = ret on line 885? Looks suspect anyhow.
>
> According to git blame code seems to have been disabled intentionally by the
> following commit:
>
> commit 96f3823f537088c13735cfdfbf284436c802352a
> Author: Jesse Barnes <jbarnes@virtuousgeek.org>
> Date:   Tue Oct 5 14:50:59 2010 -0400
>
>     [PATCH 2/2] IPS driver: disable CPU turbo
>
>     The undocumented interface we're using for reading CPU power seems to be
>     overreporting power.  Until we figure out how to correct it, disable CPU
>     turbo and power reporting to be safe.  This will keep the CPU within default
>     limits and still allow us to increase GPU frequency as needed.
>
> Maybe wrap the code after thm_readl() in #if 0 in case somebody ends up
> wanting to fix it? Or eliminate completely.
>
> In theory the thm_readl() may affect the system behavior so would not
> remove that for extra paranoia.
>
> Regards, Joonas
>
> > Colin
> >
> >
