Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF4B349AB1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 20:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbhCYTyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 15:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbhCYTxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 15:53:54 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31E3C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 12:53:53 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id l3so3144342pfc.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 12:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SMXveMJUu2K3SYSoG4+HgFXbFezhk7moeOiAOToDCdM=;
        b=dRW+0DvkoAWcMQGsozTGvDi6CE5mAPeWnXusqyZ8Q6+HdrIjXkbnV/2Aj5Bnh+7S12
         1Er2hSTHwjv5nbpFFGpM3ylBiD8t29UrmhumsGDmJvG+abz7z6AdjrnJMhZOwnxl5MY0
         i3+2SkjJ17yEQ7DRMpP5FLIe+dPJXq9/7ZCAD7vU8KNn9TGXn9ejqhA9t1flHGJ9Rj7r
         Ww6OxveHnf0ZQtP+n1K10HOFmv/zJmRQvns6+mPYFLd0K8cvFVWbVeKfpn0qOptAfRbw
         yDe5equPhfY4YAxwGeYBju2bj+zWAg9GXAvG9YAg6UIEI3Tl0xFlvKdgvs6tx+Vds+o9
         husQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SMXveMJUu2K3SYSoG4+HgFXbFezhk7moeOiAOToDCdM=;
        b=RUM4OdAqFwwC+ElUTeROZ34EYrsuHIIKoG86inlc7XLdO/7MxP/9XMq9z25UiYcDeW
         UBWBh9g6L2Qa8D1b4HQAQ2Taty9ce3BwKeVlNTRCKAE7bs9ZyJ39PmngmPCiXuxFf4Xm
         OqcIkmGRvZy6bRW323dW2VgBsPokUrC8qMA1QLFOxc5F3pVfoq9yjJYiAHpwtL0m6C7/
         X5sVFMiHRaa7msivyZVMsWlK51FHGrFCBdaq2qI5MBGDg82aHthMDsWKYEONTP3pcTaL
         MkT4zcKRZba8VcnINbPcWQNAFGcEzf5W6Ro7k+RX7uKK2zudjK8LokL/hOFpUtWLTFfw
         tH3Q==
X-Gm-Message-State: AOAM532jsYRRL8QsgFKlyV1PaO16YiAxkouEGvBFyJ+2LV7nlpnmhABI
        LyIMeh+j6uWheEJsv9Nd0XCh90TIGoc7Kye1IAeJcI5jfY1keg==
X-Google-Smtp-Source: ABdhPJxsisWpkNpPneWldsJEwb+APfz6eDO0APn4t14SEXEavjyvL6bn0noDd8NucvCeH129Kugz1rcw0YaLbMsz6gU=
X-Received: by 2002:a65:4c08:: with SMTP id u8mr8773270pgq.203.1616702033418;
 Thu, 25 Mar 2021 12:53:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210325192347.67326-1-andriy.shevchenko@linux.intel.com> <CAHk-=whDQ_YFwXi2aC5r=mswSdkERxX0kQ=D-c_pFawSoQJ96Q@mail.gmail.com>
In-Reply-To: <CAHk-=whDQ_YFwXi2aC5r=mswSdkERxX0kQ=D-c_pFawSoQJ96Q@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 25 Mar 2021 21:53:37 +0200
Message-ID: <CAHp75Vdh4dVwH9GedyUSR6V8gjU8F-Bp7gbVmn-bOsn7eYg7xQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] mfd: intel_quark_i2c_gpio: Don't play dirty trick
 with const
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 9:31 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Mar 25, 2021 at 12:23 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > Replace cell parameter by bar and assign local pointer res to the
> > respective non-const place holder in the intel_quark_i2c_setup()
> > and intel_quark_gpio_setup().
>
> Thanks. I assume/hope this got tested on hardware too?

Yes. On exact hardware this driver is for.

>  It looks
> ObviouslyCorrect(tm), but that's never stopped bugs before ;)


-- 
With Best Regards,
Andy Shevchenko
