Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42FD44279E1
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 13:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244858AbhJIL7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 07:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244839AbhJIL7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 07:59:33 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF07C061764
        for <linux-kernel@vger.kernel.org>; Sat,  9 Oct 2021 04:57:36 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id j21so32610849lfe.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Oct 2021 04:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ddKTI6gnxdVhQkUnuikMlEViQcCSWc9S4SrlE2LPasM=;
        b=Yg6rDn/QwCnZ4mhkc/514eVzXNnZnBJsuoxUVFlrhZpRt82oMGdPOHTiqm3+XtRIxZ
         RwhlX2vDonxSDsF54dlYxNdjdZ5st2xZg6UDF9Y6azZS2DzXd1a44z7AiXAoReSRQUKP
         Dc6WUjrIY96qhIbo47NxeAk/WuDTgKAGgJbEw5ERZ6y870+1KUF29r5ru+dxsOPZWayB
         +n1TZ9b6jw3syhLy3nDVDCyxYqVb0tSEXN+nzyxiq1fM4uJgTW+CvHYnDoHgrjN7Nfyi
         3fVroAlBduYh/hXHXEUQNR8qFidOFS8cpveEAjcS4aPeILNiZctB27eDCNOc6kxlATt3
         IIBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ddKTI6gnxdVhQkUnuikMlEViQcCSWc9S4SrlE2LPasM=;
        b=XaVvAhjX15IVv6OBYP/3LzZaCiQNgnDK5LngC4V6jHL8p1NM203VZEvp2RfQcK0Ohb
         q11u8Re6j6KXzQOhWKYsWTeHyFlLtfrPkfd+DiGwIGGYATKL6tyudESI4PXZmMrrJ3Ac
         SqZgrPv0+guOqLmB9nPfqWKMaWJi4S0zkZHpqw4ENuuMWbuV7/7eK4C9V5APLH1c5Lpp
         s3msX78P/mq3Faj0eBRn7UkB7W2oexx+hkO1q2gbRVSeZxlfRQGvCheo+DcGJUIPpYkJ
         dVIeoarosj1zv91KAVWD9JeLDk9bjmzCEL2qIwOTlRAQwHMtmcy71Z2AR9fSCAQ9gWqP
         nIcQ==
X-Gm-Message-State: AOAM532vWGxGFUzU70jva+RzAX+8/WvzJ9+akdf1a6r/FqhSpiFTGhpO
        B2chLvzM43zqt23v8om9cjEzeML3TwSaH3MWqCVAog==
X-Google-Smtp-Source: ABdhPJwi87OXKsFksT0f11sHBmIjP1L0dHkYUJoao8hhpCllD6s+7zVPFAfZxfwRJPU4ZrBJgZ13OyJvtYsEL3F0atY=
X-Received: by 2002:a05:651c:140d:: with SMTP id u13mr9541773lje.9.1633780654110;
 Sat, 09 Oct 2021 04:57:34 -0700 (PDT)
MIME-Version: 1.0
References: <20211009024430.3322230-1-osk@google.com> <089c590f-5b35-8a2a-6132-d8d3e2695c15@roeck-us.net>
In-Reply-To: <089c590f-5b35-8a2a-6132-d8d3e2695c15@roeck-us.net>
From:   Oskar Senft <osk@google.com>
Date:   Sat, 9 Oct 2021 07:57:17 -0400
Message-ID: <CABoTLcSMDPQvhgmUL5aE_df++pg4qN+cmf=31J9WPVnKnT6k7g@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: hwmon: Add nct7802 bindings
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone

> > Document bindings for the Nuvoton NCT7802Y driver.
> >
> > Signed-off-by: Oskar Senft <osk@google.com>
>
> Please pdon't expect from reviewers to figure out what changed
> between versions and provide change logs.
Uh, I'm sorry, I'm new to the Linux upstreaming game. I'm used to
using code review tools like Gerrit, which help with that.

Changes from "PATCH v2 1/2" to "PATCH v4 1/2" (v3 was sent with a
typo, so please ignore v3):
- Removed extra layer "temperature-sensors" as discussed.
- Renamed "sensor" to "input" as discussed.
- Renamed "mode" to "sensor-type" to indicate temperature or voltage.
- Added "temperature-mode" to indicate "thermistor" or "thermal-diode".
- Removed description attributes from "sensor-type" and didn't add for
"temperature-mode", since they would have just repeated the names of
the properties.
- Numbered sensors 0 (LTD) and 1..3 (RTD1..3).

Some notes:
- While 1..3 are "natural numberings", there's no equivalent for "0"
in the datasheet - the name "0" is arbitrary. An alternative would be
to name this sensor "ltd" instead of "input", since it's not
configurable (beyond disabling it).
- I wasn't sure what the correct way is to enforce a match from
"input@X" to "reg = <X>", so I listed the inputs individually.
Technically RTD1 and RTD2 could be done as "patternProperties", if we
could enforce the match between @X and reg.

I hope I included all the various comments and discussion points both
from PATCH v2 and from the "tmp421" thread [1]. Please let me know if
I missed anything.

Does this proposal match the general thinking and goals for
dt-bindings for hwmon devices?

Thanks
Oskar.

[1] https://lore.kernel.org/linux-hwmon/20210924114636.GB2694238@roeck-us.net/
