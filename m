Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7305B30EB6C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 05:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbhBDEKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 23:10:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbhBDEKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 23:10:03 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8DFC061788
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 20:09:23 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id y11so2183305otq.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 20:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/aRsTf5r3vSnsChGjvywC+Rom9SLmJFnNQZY7Xwx4AI=;
        b=bKpJK55OP76JeJW0uaw1nOMSa3+jWZRrjnZvyMmllRNGFr91Q1AJLLm9Q+V1wxEaYT
         uLXaaaA2j7ks0baGuJYcT7CKh1Mw9TikKYk5qskkmP3ZNYGJMvJ4dCt8++7ac/n8VLLm
         6Nk2N2EJnLhnTI3AA0HQYZiHqfMM9OkPEvfZekfdIN3U/YhRZujRvL6MbhoJ8T8vdhx+
         Lbw35y6mWowovPGZE7Br2T/kuJnkB+eqoVQUd2xRlKPw2dww4YWP0mEapMGlokt7gDqY
         dSFofes+H2Tg7qYP1keHm49EpQVj87s+fB5aoFGIxzqgnmo1Evxhrx4EwtCKm/SoQuK/
         k7jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/aRsTf5r3vSnsChGjvywC+Rom9SLmJFnNQZY7Xwx4AI=;
        b=TtjXmTiaemGmQ5vKphPpsHXQsqVqASM3xAC80ZgT2lrbHpx5UZnNqSpcR7qQfx+PAg
         hl9FGCs3E7O6RUQpY9VqMY/4/B94tQvS3WaCSejs2/MbAYNZfvRYQ5iZyifId8rabbYP
         yPQFzfJqGOXb70QEMSw4PQmjw/Gjbb14h4pVHyXVegDaMzXUSiH5f9gbvdtIzvNHrVLk
         yunvb0AZPh81sHu1iayEktoIvurDlsOmK/pQR4f+zbQiNqd93LajBfmaYpFcKQWdhAIv
         S8TWAqCyC9sk4Cd3X8sFK3Dg49kZhlHlfcljcRG1fHjnp16AlkMcmqr4udrACchjonxr
         xiEA==
X-Gm-Message-State: AOAM530o5vwLSkGx27muEmsBmcmDL3LDqFXZWF/bdETAFn9qKRoc0Rp9
        FD/8WK5wzZPgTF0DAetrVLsCEjIvw18ddKcl23WBKA==
X-Google-Smtp-Source: ABdhPJztfbblDWJAum0rp2kx4kxYhaBZ/GB/+ARxgQUfogt2/BIgaLUBWRGQB4yqZy5S64oLU9+m7vICK8xHFUU22I4=
X-Received: by 2002:a9d:4544:: with SMTP id p4mr4171854oti.368.1612411762147;
 Wed, 03 Feb 2021 20:09:22 -0800 (PST)
MIME-Version: 1.0
References: <20201201213019.1558738-1-furquan@google.com> <e77e0569-568a-f7fb-9f0d-e64943b467f0@gmail.com>
 <CAJZ5v0jhniqG43F6hCqXdxQiQZRc67GdkdP0BXcRut=P7k7BVQ@mail.gmail.com>
 <X/2fzghPXnuDNBPU@kroah.com> <CAEGmHFEpPTuRuWFt0ba022BmGfaDmSTAgEApW9EzAa5CitmtbA@mail.gmail.com>
 <b4a931cf-5974-64d0-fdf2-693e418f3110@gmail.com> <CAAd53p6PtdCRe50PFdn35S1mXHBACKUpmVVcE2qfZgVT3MKj5Q@mail.gmail.com>
In-Reply-To: <CAAd53p6PtdCRe50PFdn35S1mXHBACKUpmVVcE2qfZgVT3MKj5Q@mail.gmail.com>
From:   Furquan Shaikh <furquan@google.com>
Date:   Wed, 3 Feb 2021 20:09:05 -0800
Message-ID: <CAEGmHFG-XXfhcO2ZJU0HwSmTAsYC-04F6by5td3+Ax4GbYLy+g@mail.gmail.com>
Subject: Re: [PATCH] drivers: core: Detach device from power domain on shutdown
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 3, 2021 at 6:37 PM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> Hi Furquan,
>
> On Wed, Jan 13, 2021 at 10:31 PM Dmitry Osipenko <digetx@gmail.com> wrote:
> [snipped]
> > Thank you all for addressing this problem!
>
> Are you still working on the alternate solution?

Yes, it is in my pipeline, but I have been distracted because of some
other high priority tasks. I plan to push something for review in ~3-4
weeks.

> This patch can
> address S5 power consumption issue for some laptops:
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1912935
>
> Kai-Heng
