Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D68D436E4F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 01:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbhJUX2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 19:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhJUX16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 19:27:58 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB31C061764;
        Thu, 21 Oct 2021 16:25:41 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id y11so2021460qtn.13;
        Thu, 21 Oct 2021 16:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/15db6Apbth6KWgHu9T+Z7/sxzP+v8xElG8h3sD5lB0=;
        b=B0ugykVGeVHNbbq6udchd8maFVM3S/YKsUeCtXOcEPcEBjmDMjCzT+r3RprM9t49Vx
         Huv8OzXgfBcXwHRGDyQ3m91qIX0OQUOaYoxPGANuLLG3PUJn3UmEK4dwt2ipLaWoXYNK
         CX3RKjR2d9XJH39AgdMQitL8pLWQi7qeNcNHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/15db6Apbth6KWgHu9T+Z7/sxzP+v8xElG8h3sD5lB0=;
        b=UVwnPrianvYKSFRGpjVJUn74b4lSU7gI9l35K2zg+tf0gU/RA1w5kn9j1aCFEGsJJL
         pZa2O/6i2gjhwovQaZZVcI5odeYRqK+I/5qFVC1LbF0+78HsVap3aYgXLkfnJF3fdJkc
         j77tvfyCCg1vf2bo1SlZ2gUz2ZjWSZympUsK+C/ExojzNvjeKeWhDTfHo3BwTLE5YSyD
         d8lasktpneQy3SErA0Au2zNlUyD3qmd8IaIPPnMr61gjjVtwea90qTnLm+4M6T7WCu+m
         eXxGw6tlqQom201S7rcKEr8L54BneYcB4RZWujYYlN/jYmz++YXZUjarLOu83uRF1bhK
         rXpg==
X-Gm-Message-State: AOAM533vLdYvzdDhx0qHamvmLZ08bMsSnM3OYrI5idBWWnTJPmbp1gmJ
        Xn6wLr4YjOg9cJNPOGXHMC9Xkb9EtOEroYu2BBM=
X-Google-Smtp-Source: ABdhPJzjwuh9jnD5tusFhcXxstWRpLFH7+vaBwsmdcwqUHV7+REwAoSLrqCb8T2W2yfOBKpGEmJJTZfem/iuv3whScQ=
X-Received: by 2002:ac8:5f06:: with SMTP id x6mr9535444qta.295.1634858740877;
 Thu, 21 Oct 2021 16:25:40 -0700 (PDT)
MIME-Version: 1.0
References: <20211019205307.36946-1-eajames@linux.ibm.com>
In-Reply-To: <20211019205307.36946-1-eajames@linux.ibm.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 21 Oct 2021 23:25:29 +0000
Message-ID: <CACPK8Xcg2Kwh+LTS=E3r5ZgSWD8eyntWp77KabNjt0vFMUTyAg@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] occ: fsi and hwmon: Extract and provide the
 SBEFIFO FFDC
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-fsi@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org, Jeremy Kerr <jk@ozlabs.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Oct 2021 at 20:53, Eddie James <eajames@linux.ibm.com> wrote:
>
> Currently, users have no way to obtain the FFDC (First Failure Data
> Capture) provided by the SBEFIFO when an operation fails. To remedy this,
> add code in the FSI OCC driver to store this FFDC in the user's response
> buffer and set the response length accordingly.
> On the hwmon side, there is a need at the application level to perform
> side-band operations in response to SBE errors. Therefore, add a new
> binary sysfs file that provides the FFDC (or lack thereof) when there is
> an SBEFIFO error. Now applications can take action when an SBE error is
> detected.

Thanks, I've merged these. I took the chance to add some of your
responses to the commit messages as they were useful.

>
> Changes since v3:
>  - Rebase
>  - Add a check for valid FFDC length
>  - Add comments about SBE words being four bytes
>
> Changes since v2:
>  - Add documentation
>
> Changes since v1:
>  - Remove the magic value that indicated an SBE/SBEFIFO error with no
>    FFDC.
>  - Remove binary sysfs state management and intead just clear the error
>    flag when the whole FFDC has been read.
>
> Eddie James (4):
>   fsi: occ: Use a large buffer for responses
>   fsi: occ: Store the SBEFIFO FFDC in the user response buffer
>   docs: ABI: testing: Document the OCC hwmon FFDC binary interface
>   hwmon: (occ) Provide the SBEFIFO FFDC in binary sysfs
>
>  .../sysfs-bus-platform-devices-occ-hwmon      |  13 ++
>  drivers/fsi/fsi-occ.c                         | 164 +++++++++---------
>  drivers/hwmon/occ/p9_sbe.c                    |  86 ++++++++-
>  include/linux/fsi-occ.h                       |   2 +
>  4 files changed, 186 insertions(+), 79 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-platform-devices-occ-hwmon
>
> --
> 2.27.0
>
