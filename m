Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA9FF308C39
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 19:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbhA2SOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 13:14:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbhA2SOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 13:14:17 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C04DC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 10:13:33 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id b2so13795794lfq.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 10:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jbXatH+jIZoABuAUJLGiKBIVUtMrRLBvUtpWT54lNmk=;
        b=KC10zSx5MFsfUUjYlG6FRCOeTyTcwX7GVvNaLYrrrt8YFffoMdY92Rh01gJr6XlSmY
         4I2StG06IDQKqqKiAqu88gHc4seS5CORwF959YMHVWmCmchm1b7Bn3A7fg/tBq+MM9y4
         8yDFzSkj9aLzlG6YxJyYupJOThB0naFT27zWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jbXatH+jIZoABuAUJLGiKBIVUtMrRLBvUtpWT54lNmk=;
        b=Zm+yKck5jcyhh4KerbsluAFFJZlO4qJxWBOo6A9JHzWC8fg/v5zUH6kGV9nUJr7CHo
         5lZxbMriMLU9I8mlY2LuSX8JkinOw3JEBqQkkNRCdO26CX+8OQI1498yjBBM8Dg8/3of
         w6kHJ/3i9OhVf0TejwyusIGzE1lpyOFYx6XWX6a4pWEf+FEn51mcogZLa56sqJ1CZPm8
         aeeErstmjfX6Ul8sPcNniSBfYuO9MjzcnpBvsEUys/5PGaXYShrhc1A2O6g2qjAMqkyx
         zzYfuI8ZCK3hBV2u4t8nJ/SBhH5lv6tFoITObaVEQdvd4Z3hEnnItV/Gz5bvtyGhuLX/
         Kkfw==
X-Gm-Message-State: AOAM532MZiCn93yGHRTXc2cN5eylhBWzvjLtu6efWMbupEkwurtaxdmb
        hOYNBP6H8WOPjFOq1zMK6orR251ghzbbIA==
X-Google-Smtp-Source: ABdhPJzOtD8kKUpK+yOvobkiKeKYnl4cv2nT4JkSmpxJ+mcayabBaTUzjT6VDs1gDH8T9Ax3kLzRoA==
X-Received: by 2002:ac2:43af:: with SMTP id t15mr2823337lfl.25.1611944011719;
        Fri, 29 Jan 2021 10:13:31 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id h189sm2082523lfd.201.2021.01.29.10.13.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Jan 2021 10:13:31 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id i187so13762627lfd.4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 10:13:30 -0800 (PST)
X-Received: by 2002:ac2:5502:: with SMTP id j2mr2617310lfk.421.1611944010487;
 Fri, 29 Jan 2021 10:13:30 -0800 (PST)
MIME-Version: 1.0
References: <CAJZ5v0is8qQ91Nx_hhMgc3Ga8NgFbE-JAu03=M-L9sCpf8pVmQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0is8qQ91Nx_hhMgc3Ga8NgFbE-JAu03=M-L9sCpf8pVmQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 29 Jan 2021 10:13:14 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh2vddZUVEQ4Fn3Oy5q70WNGP3C7bAwxsnXkjP02rVjbA@mail.gmail.com>
Message-ID: <CAHk-=wh2vddZUVEQ4Fn3Oy5q70WNGP3C7bAwxsnXkjP02rVjbA@mail.gmail.com>
Subject: Re: [GIT PULL][Resend] ACPI fixes for v5.11-rc6
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 29, 2021 at 10:11 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> [Resending, because it hasn't made it to the mailing lists, not sure why.]

I see it, and I see the cc to the list, so it is likely something
about the list being slow or subtly broken.

There was another pull request a couple of days ago that apparently
had the same problem (and didn't get a pr-tracker-bot reply due to
it). I forget which one.

               Linus
