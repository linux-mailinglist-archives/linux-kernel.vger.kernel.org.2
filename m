Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7083F40B5BA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 19:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbhINRMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 13:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbhINRMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 13:12:42 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A49C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 10:11:25 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id w4so25227463ljh.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 10:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZT8P3mQS19BrQefv3EWE24TGiGm5rj3TjmzR3qpVXBE=;
        b=R7/H7gDZMigDeE0/7mL3+Kht1Qq8uEhUZE8eVa7Zr8Sqp0Uiwp5ooulujxnj9DN26r
         iXutHA2s1AR95Ie0uGO7kHklBl2AHrtx54ryEOSTh75NmQZElYFLohJYKbqTIG89cr3S
         JaJUMhWPm4AfWjASiUMMoQ0NizfdQKNT4jYxkvLqSKHDqD+qKYnwntAQIdDoSLQXCb6W
         HZdogmYivHX5NQ5UqfveQ01Mvsr0SQoqlqm5fhrEdfb7kxasv9mQeT8F0dP5E8xQLfya
         ScbmThUzvRoKQSTNd8go1yGe8x+olw73/Xrj2sD/ic+NuiqDgF81lH+MIf/U49Wz/6rL
         66Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZT8P3mQS19BrQefv3EWE24TGiGm5rj3TjmzR3qpVXBE=;
        b=DfgJjcOQJeVVQGAUka9dPXO4peSFOUswjrRUtLENcxkS2OeYy+8BfWTYiGWfLBb++s
         2eEN5CpB3WyJx35KLPWDP4EdmAZVn/dzxVaMqp5VP4hcrGwxKY+MHtyPomnSg3261vlO
         AzU1ceSFz+gnot91sgy7mbU5aRmYm5cbE+fWg+bOoAjoMAWJWCrogP5cJxXT1iAeUai4
         i8g7DAG3eYR/9QyDp9PYrUv545Jbzodds2knZ+4t/iKY+ttc5l1cM/mxbUoqh81kt2Du
         S+pZ4BjUoNX1mIlxcztt9pMxf38KxXPI1lNM3xoFlAeT+Y5U63qkYj68kWhmtlWmrAc0
         +rtw==
X-Gm-Message-State: AOAM531n/YLW7XoNq3REyj+NWEao1IkkG9bAG+z4UTeqRTatEAtG95vg
        0ojAxhBUGr/a8e7/Z/v4g5FQBtlMrxWc8PQWy2VnjQ==
X-Google-Smtp-Source: ABdhPJzbFGFCCGLaoraaVB4YLcpsXIXczCdDgluSLTvBSPzDSrdTaoBGMxoUjtGK6U6TnHPIhPELWTNCwL8e7mqTk/k=
X-Received: by 2002:a05:651c:1209:: with SMTP id i9mr16692284lja.85.1631639483288;
 Tue, 14 Sep 2021 10:11:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210910130337.2025426-1-osk@google.com> <71c17c47-ca9e-e9d2-7b89-cc25b512c06a@roeck-us.net>
 <CABoTLcRZ43EUVzbqWniu64PkB7Yx4RMYKjaBxaSihk+k0Ca-gA@mail.gmail.com>
 <722b27f6-4390-9b5b-f6f2-75ce9e967d12@roeck-us.net> <CABoTLcSdkmuBxd5Yh6z2Oqm1-_Vd4J5Ni1i1qq5s07mWu7Ndew@mail.gmail.com>
 <20210914150859.GB3457579@roeck-us.net>
In-Reply-To: <20210914150859.GB3457579@roeck-us.net>
From:   Oskar Senft <osk@google.com>
Date:   Tue, 14 Sep 2021 13:11:07 -0400
Message-ID: <CABoTLcQfS5-UL92NR9vbc2YrGJv3oQPYCqAm-diNoq-tkHP_hQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: hwmon: Add nct7802 bindings
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter

> > Following the example from tmp421, this could then be like this:
>
> Something like that, only we'll need something to distinguish
> temperature sensors from other sensor types, eg voltage or current.
> Maybe a "type" property. I'd suggest "sensor-type", but we have
> non-sensor attributes such as fan count and pwm values which should
> be covered as well. But it looks like a good start for a set of
> generic sensor properties.
Would it be acceptable to simply number the sensors and document which
sensor has which number?

Something like this:
0 = LTD
1 = RTD1
2 = RTD2
3 = RTD3
4 = FAN1
5 = FAN2
6 = FAN3

Would we also want to be able to define PWMs? From what I can tell the
driver does not support running individual pins in GPIO mode, right?
So I'm not quite clear what "disabling PWM" would actually mean.

Anyway, if we simply go by "sensor number", that would mean that we'd
have different attributes depending on the sensor number. Would that
be ok?

Also, I'm sorry, I think I just realized that in "voltage mode" we
don't seem to get a temperature reading. I hadn't actually looked
through more of the datasheet except for the single MODE register
before. But I don't think this makes a difference for what I proposed
so far?

> >         /* LTD */
> >         input@0 {
> >             reg = <0x0>;
> >             status = "okay";
>
> Not sure what the default is here ('okay' or 'disabled').
> We'd also need to define what to do if there is no data
> for a given sensor.
I think I'd like to keep previous behavior unmodified. From what I can
tell previous behavior was:
- xTDs enabled by default
- RTD modes unmodified, i.e. defaulting to whatever the HW comes up with

The NCT7802Y can self-program from an EEPROM, so I assume we should
honor the "power-up configuration" obtained from there? I.e. if no
configuration is provided in the device tree, the driver should use
whatever configuration the chip has when the driver is loaded.

> >             label = "voltage mode";
>
> That isn't the idea for "label", as "label" would be expected to
> show up as tempX_label (and a label of "voltage mode" would be odd).
> The label should indicate where the sensor is located on a board,
> such as "inlet" or "outlet".
Yes, absolutely. This was a bad example on my part. In my
understanding "label" is just a string that we pass through.

Oskar.
