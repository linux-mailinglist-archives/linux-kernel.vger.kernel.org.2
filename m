Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9655E3F18DC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 14:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239115AbhHSMOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 08:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238286AbhHSMOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 08:14:34 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4DEC061575;
        Thu, 19 Aug 2021 05:13:58 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id e15so3786385plh.8;
        Thu, 19 Aug 2021 05:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IM2mYCmkC0prP0hBmF9stY4gtLvEtM2Yq4TDeR9YyUE=;
        b=Cg5DBxLQT2Q7B/7VzYAHrkNDepnxurGaSq0PNIPtLK7A8AkKPV5H2n0tSFFtAbqk1m
         U+aI5r7f0FAzWhW0FQ/2RzyU3mVJyfLJGzVvbW3hfc19EQpQcp9tbr9CZ2Qlx1+Th0sk
         NZ0blc6tcoxWJXQoMzZe3n6h1PgJ2tTITdlk6se8nKwfPFQKLliq93MJ5qcVbjEvbqu2
         gPl306pwN6JoXDud+vMeOpO+xz0Yy2SI0tmFEUppqQ1AhmDnBJ3MVRaJmzwsU00VdDa6
         wu7DCT41mN36Yxl+eouRVNyI9XLWy+NZi3XviBTrcL8V9DHhz+4ngXtDN0hqqFjwS4hY
         V7ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IM2mYCmkC0prP0hBmF9stY4gtLvEtM2Yq4TDeR9YyUE=;
        b=NYg4aguMrcUroYN7nd242qQAAqf1Sg4gizRWMN0Do88YNr+qZcdhS1gB9ybS47ycZO
         H1LVMuldgfqs706XckELf+xbSDkQsmrpPdTwm4pgnbjNrxyTYL1G5My8jV8KDo/oZPJh
         XpfPJs8VHSRaeq4Q1Flf1VFx+r+GSZhl6nthuF32Vf1J/b+0MWJWuoqlLQE5u9oc2MlS
         lxHFvxpsdnGXsVf5wOiOiqtiwyZDlli8fUaTd54PEVdjFuxxseNtiSe0PaapK3OYTSDw
         t9UnMjHVoqQiPDRrlN7pAFhbQ7380yqpJmZPI2Why5W3LcfFU6fcDJRQWsS3PGh6TFdO
         YkWg==
X-Gm-Message-State: AOAM531FCvIJ+zbfOcq9vVx2Z71TVmxPD/xMd5awPl/wcw/ji8Hw81nC
        tOSc5xfVnLrSqrZoXI5sntbDgHs6Adksia/zcLc=
X-Google-Smtp-Source: ABdhPJwrAMhj1+VsMUo9xcKg8irtQT0sHo3dYgi7cP2NtzM7H7G5eEyRJfFdUzNd/JEmfl3MMO2ypChQ6+9Oz396+sY=
X-Received: by 2002:a17:902:bb81:b0:12d:a7ec:3d85 with SMTP id
 m1-20020a170902bb8100b0012da7ec3d85mr11653878pls.17.1629375238446; Thu, 19
 Aug 2021 05:13:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210819033001.20136-1-hpa@redhat.com> <20210819033001.20136-10-hpa@redhat.com>
In-Reply-To: <20210819033001.20136-10-hpa@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 19 Aug 2021 15:13:18 +0300
Message-ID: <CAHp75VetJekXwZmyMu+YTp3o_L3TS9P7hru=WKBM6TKsbGJiRQ@mail.gmail.com>
Subject: Re: [PATCH v3 09/20] platform/x86: intel-rst: Move to intel sub-directory
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

On Thu, Aug 19, 2021 at 6:34 AM Kate Hsuan <hpa@redhat.com> wrote:
>
> Move intel-rst to intel sub-directory to improve readability
> and rename it from intel-rst.c to ips.c


>  # Intel uncore drivers
>
> -obj-$(CONFIG_INTEL_RST)                                += intel-rst.o
> +

Stray change.

...

> -

Ditto.

> +intel-rst-y                                                    := rst.o
> +obj-$(CONFIG_INTEL_RST)                                += intel-rst.o

-- 
With Best Regards,
Andy Shevchenko
