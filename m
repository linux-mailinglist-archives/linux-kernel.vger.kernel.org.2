Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85ABB321322
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 10:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhBVJaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 04:30:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbhBVJaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 04:30:15 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01466C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 01:29:34 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id l8so12216383ybe.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 01:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q8jxpn8U81BOSDGIdqWNhjKuVlBFdrywKBigHG1mI18=;
        b=ZiOr9xSRYUCuJH8o0nBhrxm0YazakvwOd80y29g+mge2XbE6A+abTXf8m2YKEDjrwZ
         /nwn/PkqYqX5mBwUQ5ajq+gThN31IaqXgtwBS2iBJIdFxtXVcWIOW4+NzlFHpxzgh6R5
         2ej/GW+dttDlIqxOGfTEYvVAd7xi/hTEY3Zl9NYDEITaOKDms/8wZsqjJO3pIBJv8h8Y
         wIbCe+8/tDrY222FE17xKb80euKxcrRLjJEoKafmwsRfWKZ/I59j2Y48RS3AimXrEmIJ
         ovP3jgTaoJbKfB3wh+PxdY78DZDMx3IJaKPh1AxxunMVEVdjuNyq6njYEHohWjmcFnxn
         glyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q8jxpn8U81BOSDGIdqWNhjKuVlBFdrywKBigHG1mI18=;
        b=VsPycUcqwPmrcdWQauX5gVO4dUsdq4xbFuvvotJuf7N+qSidwYVve0Hq/JrrXbsirj
         aVwpVN1zm88catNlR1T/tNbUGeseKhGcGiMrP4bKx/OAq2sUgppAVZNWJZ2w3YF9p7u2
         mnJauRXE1vQ6JLFMjPms50+rFRrGQ5DUbvz6+PIkC5rPgVFS+L+vbx23gZTMxNtlzjHn
         xja8M8EboCZrKMio0VVF8QbjVeM/tNxM3rdbnFUYJFJmqilNG6uL7tsZ1XM+ryhAfXBw
         1j/WVBDO8OOIPu2kAeHImtX8FOwkswIk86Jem0dslAKX15B8suytepMh/d6BZ8MGNi6/
         ZE+w==
X-Gm-Message-State: AOAM532P+MEYAvOfXwcxdKDnjB+lg9nQDuObSwKAseCmu8UXkthW89OK
        tBLw42JQSWC5UcIocBVpoCfPKVEMFnJO6NL59l5IvrUZGyE=
X-Google-Smtp-Source: ABdhPJzNvXewzVC+GXtRA9lzbkkp+LqVoUuimDuPMDblFY3bL1YLoG4H3b0p8nOxbHNsgupc7g8F3KAHAEvGoV5jUfk=
X-Received: by 2002:a25:fa02:: with SMTP id b2mr29308317ybe.382.1613986174173;
 Mon, 22 Feb 2021 01:29:34 -0800 (PST)
MIME-Version: 1.0
References: <80753cbc54ef69b4fc136f791666197fc8b1f8bb.camel@cyberfiber.eu>
In-Reply-To: <80753cbc54ef69b4fc136f791666197fc8b1f8bb.camel@cyberfiber.eu>
From:   Andrew Pinski <pinskia@gmail.com>
Date:   Mon, 22 Feb 2021 01:29:23 -0800
Message-ID: <CA+=Sn1njFZ-XZRHJdmjzOyvXvcMXg+oBao=wK8w3RXN_Ji=fLA@mail.gmail.com>
Subject: Re: problems with memory allocation and the alignment check
To:     "Michael J. Baars" <mjbaars1977.gcc@cyberfiber.eu>
Cc:     GCC Mailing List <gcc@gcc.gnu.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 22, 2021 at 1:17 AM Michael J. Baars
<mjbaars1977.gcc@cyberfiber.eu> wrote:
>
> Hi,
>
> I just wrote this little program to demonstrate a possible flaw in both malloc and calloc.
>
> If I allocate a the simplest memory region from main(), one out of three optimization flags fail.
> If I allocate the same region from a function, three out of three optimization flags fail.
>
> Does someone know if this really is a flaw, and if so, is it a gcc or a kernel flaw?

There is no flaw.  GCC (kernel, glibc) all assume unaligned accesses
on x86 will not cause an exception.

Thanks,
Andrew

>
> Regards,
> Mischa.
