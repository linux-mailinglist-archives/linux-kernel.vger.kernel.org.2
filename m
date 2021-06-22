Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5833B00B3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 11:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbhFVJs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 05:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhFVJsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 05:48:55 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F44C061574;
        Tue, 22 Jun 2021 02:46:39 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id h4so5091856pgp.5;
        Tue, 22 Jun 2021 02:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CFYHrKmBO6teOXFvUVEzGM5v3YsBOwUfdzsp+DfrQrM=;
        b=tR5HZiCdz8ja6LgPoyUebl9ojSVhHWK8bsDOTqP/h0hrGnyURV21NeLU1xZN0Dh7aI
         nX7+Rmj1KRNzDC1w2MCjeLPskWufnUuya9IYX8MNCDzHASLlSv5KkWHNyeVSIXRF4W3R
         z8nISAvbgv58nzM4ySTc1ahv/3gniHVlMp8/qm0odSbXnsjA5QDpvrIHgVFaMoRctmp1
         PJ+vflqdGoKKOby5RwmLUAKOqfd2/EYcX3EVYNzIiDkwW3KgV9cFealZWx3/EvdMnHAW
         FXVTM0kuslSlGE3CKKVgzIGRzwlhb0GIohMKh8oqS6sl6b31N2t3Fafv/DogASKF8fxk
         vPQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CFYHrKmBO6teOXFvUVEzGM5v3YsBOwUfdzsp+DfrQrM=;
        b=pg+huI/i0o2CZRpGJfQzsYIL1AlYJXT5TaJdnlOXTuqyFv6wvaD/jdSah/yu6MfaHH
         kE3/3utj4AZLmIJSCP8t1GsGMSUYvGSlXOABqNVzr4iD2ZoLs6ijpMnuPGbRvhA5d3xy
         zyu8b0N4B2JMSfo5pnejN9NP2B1q21b48FmgYtwrNJhPI/o5BcgLMw5Cu1IZaxANnHOJ
         o9Yw4654uDE+OKwx5u9QvAID8QSBdMk1INV2pZuhVMUB6FT9JTJYFE+/nqCzkFd3KLkz
         OQDZFYv8JX1h7lVSsndd1Ds4A8kYNCFGJp0M5JEhqGfVECz5SNcrqLxiUR0GRQjLpSK2
         vsTA==
X-Gm-Message-State: AOAM533sdvUeB/hlkOyBfPd+CVZ9T07Iw5EeQYsY2kb27Ht2ODiPCVq/
        kbDEXZyCQHbdU3q7/f2G8I4WKviPRYw/pQ01ync=
X-Google-Smtp-Source: ABdhPJywcVs/cNEqGHeoNRpJ5Hhh6EYNjx3Xr45ZGfshLu3yr4rbR1TDpiaPBvCJmP5dWXGQRs4hxKo+uJPZQpVjj1o=
X-Received: by 2002:a63:df10:: with SMTP id u16mr2985686pgg.4.1624355199188;
 Tue, 22 Jun 2021 02:46:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210618125516.53510-1-andriy.shevchenko@linux.intel.com> <9f5fc6f7-0979-5767-9929-550be74e608e@redhat.com>
In-Reply-To: <9f5fc6f7-0979-5767-9929-550be74e608e@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 22 Jun 2021 12:46:02 +0300
Message-ID: <CAHp75Vd_MnzbhuH0aKBNZxdQuW8P-iL5f1rFXwMc+vY9toYa+Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] platform/x86: Remove "default n" entries
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Mark Gross <mgross@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2021 at 12:42 PM Hans de Goede <hdegoede@redhat.com> wrote:
> On 6/18/21 2:55 PM, Andy Shevchenko wrote:
> > Linus already once did that for PDx86, don't repeat our mistakes.
> > TL;DR: 'n' *is* the default 'default'.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> Thank you for your patch-series, I've applied the series to my
> review-hans branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans
>
> Note I've squashed in the following fixup to patch 7/8:
>
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9388,7 +9388,7 @@ F:        drivers/platform/x86/intel_scu_*
>  INTEL SKYLAKE INT3472 ACPI DEVICE DRIVER
>  M:     Daniel Scally <djrscally@gmail.com>
>  S:     Maintained
> -F:     drivers/platform/x86/intel-int3472/
> +F:     drivers/platform/x86/intel/int3472/

> (checkpatch complained about MAINTAINERS not being updated)

Thank you, Hans!

-- 
With Best Regards,
Andy Shevchenko
