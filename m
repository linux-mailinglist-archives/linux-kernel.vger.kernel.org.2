Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9D6D45A00F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 11:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235146AbhKWK0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 05:26:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbhKWK0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 05:26:32 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B58C061574;
        Tue, 23 Nov 2021 02:23:24 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id y12so89903162eda.12;
        Tue, 23 Nov 2021 02:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BLa9DhjAB06zjOMfSgJjIOKy1OBWmGUyMeBeCrxhDPM=;
        b=Yjc2DZtoWkfYgFYqWkVHfSCSLMHFkcfkm7+pw8sL6XLkHwLuwvO8ggrni6VWY0ZRxD
         WCWtESQLIpI0YeHSQgB62gWiNSjIggf/NCE47SX0nrpyN1eRCMmdedRqu3ksj6sGV54A
         N84Qcm+vkmmJtyfpNQv13U9QdHT5HYpuAjR9/6Ou9R1zER9lh/yQ55un9Ea2izoRk9mr
         E30YQaUGwdC4QSdhZNIgz3ot3jcFwtYgv15WPrhOvTmAFX4nnSJ2QIbw+N2CbGekkcXN
         MBQtNkPcCMi09ZBiCwwEV0qCi+PC8/IRi4g8GbOgf7hJijHg01L1f6AFZ9jdeM93S+UI
         mfew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BLa9DhjAB06zjOMfSgJjIOKy1OBWmGUyMeBeCrxhDPM=;
        b=Tk8gJH87Yl31MSn3lrMuBJ55zlAyMuNsXzUeg/fp02cGrA/xh0cwhpYnFEUL3PfJQ9
         ZQ5JO9mnzf24oD+8i3Sd5SuA8lXtsNyFMKOfi0M1gkQtlkROrmUbl3XkRcU1nWBvJur/
         Oe5CckAnBqpt3accEl26DIgNKnE6eh/fJU6UdPlefQ/J8Gpk49l4QvmcYgzrIg2U58Mk
         orF/BaNOeP3JVQrX87k0JWZg7Y4VrNhZOcucwKo9NHY13dSRoWVlSp20Gww68bGPAqcB
         QiSj25I3ZJUsef/+yCPffXztLo6SAGCR6QiXSCAg2KDyfCVv3YBapTounD8pysP4zEmW
         A3Og==
X-Gm-Message-State: AOAM532PRorjCLDnr+3YvdIkmifYRe2R+zRdUkxdSq0tDetR54SjqwxI
        8/dsjJPLyosp/4elmwC36+GYkAkQFYvnfOrdBDg=
X-Google-Smtp-Source: ABdhPJxNzJxqvc8wlpj9WXfx7m31SDwbXPR2ckwtQG9sccF7mwI3Y+q6UybbKU4+If9J90VeQTLvwZXeRSqiKpIxUMM=
X-Received: by 2002:a17:906:489b:: with SMTP id v27mr5964462ejq.567.1637663003409;
 Tue, 23 Nov 2021 02:23:23 -0800 (PST)
MIME-Version: 1.0
References: <20211116205744.381790-1-pauk.denis@gmail.com> <f0bf01fa-ccd8-3a6a-8fd2-4c785fa212ef@roeck-us.net>
In-Reply-To: <f0bf01fa-ccd8-3a6a-8fd2-4c785fa212ef@roeck-us.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 23 Nov 2021 12:22:46 +0200
Message-ID: <CAHp75Vfbh+O39C_k9zQqSqsoSro7_gv6QmsxgmdO=woA32Q0HQ@mail.gmail.com>
Subject: Re: [PATCH v12 0/2] Update ASUS WMI supported boards
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Denis Pauk <pauk.denis@gmail.com>,
        Eugene Shalygin <eugene.shalygin@gmail.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        thomas@weissschuh.net, Ed Brindley <kernel@maidavale.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2021 at 1:36 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 11/16/21 12:57 PM, Denis Pauk wrote:
> > Add support by WMI interface provided by Asus for B550/X570 boards:
> > * PRIME X570-PRO,
> > * ROG CROSSHAIR VIII HERO
> > * ROG CROSSHAIR VIII DARK HERO
> > * ROG CROSSHAIR VIII FORMULA
> > * ROG STRIX X570-E GAMING
> > * ROG STRIX B550-I GAMING
> > * ROG STRIX B550-E GAMING
> >
> > Add support by WMI interface provided by Asus for X370/X470/
> > B450/X399 boards:
> > * ROG CROSSHAIR VI HERO,
> > * PRIME X399-A,
> > * PRIME X470-PRO,
> > * ROG CROSSHAIR VI EXTREME,
> > * ROG CROSSHAIR VI HERO (WI-FI AC),
> > * ROG CROSSHAIR VII HERO,
> > * ROG CROSSHAIR VII HERO (WI-FI),
> > * ROG STRIX B450-E GAMING,
> > * ROG STRIX B450-F GAMING,
> > * ROG STRIX B450-I GAMING,
> > * ROG STRIX X399-E GAMING,
> > * ROG STRIX X470-F GAMING,
> > * ROG STRIX X470-I GAMING,
> > * ROG ZENITH EXTREME,
> > * ROG ZENITH EXTREME ALPHA.
> >
> > I have removed "ROG STRIX Z390-F GAMING" from list of supported boards in
> > asus_wmi_sensors that I have added by mistake. I had misunderstood a
> > comment in the [1] issue.
> >
> > I have added separate records for each of modules in MAINTAINERS file.
> > Before it was one shared recors for both of modules.
> >
> > Could you please review?
> >
>
> Series applied to hwmon-next.

What is the repository it has been applied to? I don't see it in
neither Linux Next nor [1]. It might be that I am missing the
workflow.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git/log/?h=hwmon-next

-- 
With Best Regards,
Andy Shevchenko
