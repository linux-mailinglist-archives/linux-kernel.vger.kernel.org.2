Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 127F532BC9D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376400AbhCCOTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 09:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1842943AbhCCKWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:22:49 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B161C0698E0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 01:22:49 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id a62so12184842vsa.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 01:22:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xuMmmssnQCIH0DO665My10jWyrPxBJ4Rcp+M/3czG9A=;
        b=RqzbFYbIYnc+/jXWjbUQNtieFkAl5uFCZicvyxjBnjvNKG16b9Roqwu2wgqDYl/Qd/
         YlirwPMqRUUCnjfqnjW3+ZAeP98NEkCg+MBij+K6Tk2WJNIYZWbhiIUREzuCmuHvlm5i
         2onhX2Xp+eMlHhRirygDWUxdRtHp8sBJhXDYmD/ToJqITys3jKVATj4tYdexC5+aN/+j
         +XmsCCF5u41mKb5UEvNK/wOkINQHTGo3/pJ+OIAlKA87QSdVpZL51uc9ghBDNzkdvJUC
         0Il1TzPMMJhyiR7TAOFU6K/FT/GXR8o+1yxgmSbYiUSpC1xrx13bAt3f9JAiWRf4yVV6
         Xe0Q==
X-Gm-Message-State: AOAM533Xc3aaHPyfkpD/YOhQUDAd/ub7BCEf9yVj+68HNzzuNlibiYXX
        W+s8WbArYg9ZC7mB6P4jQEiZVdfX1GeJIr09SRA=
X-Google-Smtp-Source: ABdhPJwKKUgjTpZVC+KRUlyhoHKweWrkVaAYLC9XDP74Hj5jyX4O/HRvOsSnc3O+nuz67nL8DEuK8VpdogVFHdyn++s=
X-Received: by 2002:a67:f7c6:: with SMTP id a6mr34995vsp.42.1614763367235;
 Wed, 03 Mar 2021 01:22:47 -0800 (PST)
MIME-Version: 1.0
References: <20210302211133.2244281-1-saravanak@google.com>
In-Reply-To: <20210302211133.2244281-1-saravanak@google.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 3 Mar 2021 10:22:36 +0100
Message-ID: <CAMuHMdU4rJaMFUS8ukUgqYjTGY41Pa3iQQpKiK8qJA6YnDJDkw@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] driver core: Set fw_devlink=on take II
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Jon Hunter <jonathanh@nvidia.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Android Kernel Team <kernel-team@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravana,

On Tue, Mar 2, 2021 at 10:11 PM Saravana Kannan <saravanak@google.com> wrote:
> This series fixes the last few remaining issues reported when fw_devlink=on
> by default.

[...]

Thanks for your series!

> Geert/Marek,
>
> As far as I know, there shouldn't have any more issues you reported that
> are still left unfixed after this series. Please correct me if I'm wrong or
> if you find new issues.

While this fixes the core support, there may still be driver fixes left
that were not developed in time for the v5.12-rc1 merge window.
Personally, I'm aware of "soc: renesas: rmobile-sysc: Mark fwnode
when PM domain is added", which I have queued for v5.13[1].
There may be other fixes for other platforms.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel.git/commit/?h=renesas-drivers-for-v5.13&id=fb13bbd6c90ee4fb983c0e9a341bd2832a3857cf

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
