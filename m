Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6108933FA40
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 22:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233509AbhCQVB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 17:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbhCQVBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 17:01:10 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B03C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 14:01:10 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id r193so39093ior.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 14:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XIuPYjA6l+N0tkJmYvNT6UOMEbB5ifXWgNDr0ucCHII=;
        b=ImORc1nRT/HRASaMXqkXN8BsCBCKfXQItBBAcRUwhtwhwx7T3t4HpX0kKhNIhdJcVD
         hr12+6tl6yzFb6eiNmPL5l7on75J0NnMH9UgvxtxPvdR/1HmYLuG85PHPQlPLPLM8M3S
         9F0JmEediC2gHcPB0KjzghL5IwOT55EEN3eQqrTdP3aNEnbUm9eIQ+9gCSCJnWyiS5M6
         VUfy9DBpyzzy70cB4Yt8O7Fx7Akz/0mCIjK9DMJ06y3t0I6Vaud0shtNs9g4hKa2deX2
         jxCQmQTCUk+Os0qfffc4SFDyIdGj0LHqSbXtc9OTH1jbv64gbrQQWHb8Pd5bzU7p3wAk
         oqYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XIuPYjA6l+N0tkJmYvNT6UOMEbB5ifXWgNDr0ucCHII=;
        b=njnWo0GqCSFfluSbz7043j3Ch8lDnMJYh87lioHtMzWe0aF2Qw6TwW4SvoaXgmSEpd
         tXWEy0AZVKfj1fF3hr3jyZny10zvBRw1i/DsREib6TPI2FkvW2ejyoyH1ufdppNwK7It
         XYdVbstbpYRAzsB178trp2I5/YTTT0eFPN/Pf37Yd4oGDh5iwXlQvvItImgoOU2LjmEn
         nuaAGNRDemIYfjEPjaEzIIBpcGydbee/pK/UXlxx0fK0RB7QZ4dzhEN4fULlzAqDqX+E
         5/SFFzg5W39lQPlmShxgC4POhAK0gerppNTK6x4AZeVhbzBRmft/0iGsW4Scvq7Dtt6v
         +PFg==
X-Gm-Message-State: AOAM533HN6hJFVpQdoYvWUZVtT0MfX+5X/53mf1IeC3Y43r86+6MjH5z
        QHkCYAVPM7zLCa0kniNGE2/1tXdu9T9idpVjKPnr9J2xGyyRCw==
X-Google-Smtp-Source: ABdhPJwDP2lj/gbUKX+TfHoZVhc7uAFCyPe2vkNo1ZpAiZISMMaL+B8kp8uDxM+MMbmRLZGBK3p1cC3U27SktHyGObw=
X-Received: by 2002:a02:9048:: with SMTP id y8mr4339484jaf.66.1616014869772;
 Wed, 17 Mar 2021 14:01:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210315114827.46036-1-psampat@linux.ibm.com> <20210315114827.46036-3-psampat@linux.ibm.com>
In-Reply-To: <20210315114827.46036-3-psampat@linux.ibm.com>
From:   Doug Smythies <dsmythies@telus.net>
Date:   Wed, 17 Mar 2021 14:00:57 -0700
Message-ID: <CAAYoRsW-E_Rek-c=e3xr8dTNUWud1AkndNaNySCZpt=h1qSf7g@mail.gmail.com>
Subject: Re: [RFC 2/2] selftest/cpuidle: Add support for cpuidle latency measurement
To:     Pratik Rajesh Sampat <psampat@linux.ibm.com>
Cc:     rjw@rjwysocki.net, Daniel Lezcano <daniel.lezcano@linaro.org>,
        shuah@kernel.org, ego@linux.vnet.ibm.com, svaidy@linux.ibm.com,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, pratik.r.sampat@gmail.com,
        dsmythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pratik,

It just so happens that I have been trying Artem's version this last
week, so I tried yours.

On Mon, Mar 15, 2021 at 4:49 AM Pratik Rajesh Sampat
<psampat@linux.ibm.com> wrote:
>
...
> To run this test specifically:
> $ make -C tools/testing/selftests TARGETS="cpuidle" run_tests

While I suppose it should have been obvious, I interpreted
the "$" sign to mean I could run as a regular user, which I can not.

> There are a few optinal arguments too that the script can take
>         [-h <help>]
>         [-m <location of the module>]
>         [-o <location of the output>]
>         [-v <verbose> (run on all cpus)]
> Default Output location in: tools/testing/cpuidle/cpuidle.log

Isn't it:

tools/testing/selftests/cpuidle/cpuidle.log

? At least, that is where my file was.

Other notes:

No idle state for CPU 0 ever gets disabled.
I assume this is because CPU 0 can never be offline,
so that bit of code (Disable all stop states) doesn't find its state.
By the way, processor = Intel i5-9600K

The system is left with all idle states disabled, well not for CPU 0
as per the above comment. The suggestion is to restore them,
otherwise my processor hogs 42 watts instead of 2.

My results are highly variable per test.
My system is very idle:
Example (from turbostat at 6 seconds sample rate):
Busy%   Bzy_MHz IRQ     PkgTmp  PkgWatt RAMWatt
0.03    4600    153     28      2.03    1.89
0.01    4600    103     29      2.03    1.89
0.05    4600    115     29      2.08    1.89
0.01    4600    95      28      2.09    1.89
0.03    4600    114     28      2.11    1.89
0.01    4600    107     29      2.07    1.89
0.02    4600    102     29      2.11    1.89

...

... Doug
