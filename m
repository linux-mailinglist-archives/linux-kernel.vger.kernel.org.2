Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87CF332AE6E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2360984AbhCBXIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 18:08:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1575624AbhCBWsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 17:48:31 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A80C061788
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 14:47:50 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id p186so22454015ybg.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 14:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+b9bTCBx0GSzfendYvQgfWHriBf8115UYpKdUN5maGI=;
        b=L8bNH4RgOQKyZI7ULRQT+7/OqFUpnPNuhAHUP5rkEA9KLj9cobpGUDkp+7hVVL/WZC
         GggzD+6du3+CWUd1BTsbFJ3eH+U48Hdld9+/E5hfbDvy6mJHyK1hOJG2+jOSyLn1DSH/
         9bhJpu3L/j7wvDmDcDg9/s8dUaRfxLpzNIke9lkyJCfMOJD2cfxiyKoskfgcCkz7gA3E
         gEY0XsLYe+kACE9q0woVqjceHYqPmuce5/ThSHqLjGPJwYvO8lqAmPqO9sgbCZ9l7a2L
         3L43Rf6yCoMeg7uR2AxW/DJLYVpeKi0UASwVSfwzGL7duiqBoBhBFpD4flDep9G6AAP4
         9iUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+b9bTCBx0GSzfendYvQgfWHriBf8115UYpKdUN5maGI=;
        b=XPDEBx7eG/llmFQklZ34N3/rBSFgnozpYZB+TU/MMxCV3YlqR2izJ8Gg5KSnjMcYbK
         aT5GWQSquWfwY4G9k4XJKBxYFvs2eAsJRXQ+UbvOeBUwi0X36x3gOwwe3OY8yQjziW7U
         0abqZbhbCV8YxreVbcnySxB+3zVUpID7DjR25T99IBXztCR4NIdecs2XBdrI+TBfbnzO
         x3MNnPG9E+LqM1lIwBQC/aFWr/z4OyM9NZOJn8ysxHHQ/v4F7E92pnLWtKeT/ODM1vzf
         soT24qFsVcikRxZzk0Wvy3ZNGSmIqMlrMgdI9QxZaVdJTW5k6KyETR/kWg/dVSA3ojA+
         CQSQ==
X-Gm-Message-State: AOAM530woGzED/3AfHu25fZiwCE8uOE+Q5IkRUwUvinspJ336Uwe0Iq/
        zEgpx9XaZQFjOJQn8mu33Mf98Vq/TG2A7k3nsnJN5w==
X-Google-Smtp-Source: ABdhPJyXnqleihf3N6CfJb1ho0f1rGpJ9s3PmnGWAkh0NtC+rFHiozSOjoDle8e4WIbpQIhcLsHI74gj7+iVkCaQkik=
X-Received: by 2002:a25:2a04:: with SMTP id q4mr36055329ybq.412.1614725269951;
 Tue, 02 Mar 2021 14:47:49 -0800 (PST)
MIME-Version: 1.0
References: <20210302211133.2244281-1-saravanak@google.com>
 <b2dd44c2720fb96093fc4feeb64f0f4e@walle.cc> <CAGETcx_xCpid3QW0gQJWLL6ZfT-VJJq-SYX4tG09GRQWucw=qg@mail.gmail.com>
In-Reply-To: <CAGETcx_xCpid3QW0gQJWLL6ZfT-VJJq-SYX4tG09GRQWucw=qg@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 2 Mar 2021 14:47:14 -0800
Message-ID: <CAGETcx__oG2XrQ8RwZ57cVgV+Ukfni4qUQCe11kbL8E1U+4a_g@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] driver core: Set fw_devlink=on take II
To:     Michael Walle <michael@walle.cc>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 2, 2021 at 2:42 PM Saravana Kannan <saravanak@google.com> wrote:
>
> On Tue, Mar 2, 2021 at 2:24 PM Michael Walle <michael@walle.cc> wrote:
> >
> > Am 2021-03-02 22:11, schrieb Saravana Kannan:
> > > I think Patch 1 should fix [4] without [5]. Can you test the series
> > > please?
> >
> > Mh, I'm on latest linux-next (next-20210302) and I've applied patch 3/3
> > and
> > reverted commit 7007b745a508 ("PCI: layerscape: Convert to
> > builtin_platform_driver()"). I'd assumed that PCIe shouldn't be working,
> > right? But it is. Did I miss something?
>
> You need to revert [5].

My bad. You did revert it. Ah... I wonder if it was due to
fw_devlink.strict that I added. To break PCI again, also set
fw_devlink.strict=1 in the kernel command line.

-Saravana
