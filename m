Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE16A44C61E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 18:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbhKJRoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 12:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbhKJRoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 12:44:24 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612EDC061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 09:41:36 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id i5so5436441wrb.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 09:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=immu-ne.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m3+k//Nw67MSP2v/Is5OlRANaMhMhhGq5VfcqBVvIeI=;
        b=h0TnXrD4xWQ+vuoN/VoZapw9MGYZH6Bzdw4vSjINkEqJJtqiL7jRWbZKk2Q0vmMAI8
         1mZ0ixZmDX4yMo9d87EaJpB4wU1QLhxjix19LfJb0TSlKXcn8oNf9zdKMHrTKBowDLAS
         qKmBrK/d/igVl4OisJ6xoOAJOuUtqjyIPJu6InPmaHc5feX514lsYg2vaJRujmDbx51b
         FnkTz4b6pg7wcI8GwA20p8x20faTwAY9TPNtjMAh7NxAREkrXjKhOsCv3cqolysvOrTm
         teo6l3u3sgTRf+9wZtzznWdOf7Dnt1T6PEgY8v+CSCo0krQQHk8VOm94AWcsqtxZm0vL
         8C8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m3+k//Nw67MSP2v/Is5OlRANaMhMhhGq5VfcqBVvIeI=;
        b=KDHGIBgAUNCogsJRh4zep/8J2AoArYf48Y4vtbEQR8G8daskeHa86cTxV0ohF5KdDU
         K2vnHI6Zn9iJXQTXsVVrFFKh0jvPiBoDUlJsNWETaRqrxiL1wtu3EN9iwvEq7y+CE+uh
         +MoDktJh515iQWQCqfUscP91lEaWFZNBduTj4SddxTEuXGhMhwMn7LdI77HL6qzOu2/P
         JVIXEbPsg3by/tFyQtxFDAOTgxbuijf31E+e3B0iy8Ufs0t+1/SIiF65KIYnKrWTCer3
         NZRMzklDgAckMlI5bZvp9A39o5Te3QCj4PxTQXlTn1bzlfihsQwnhhMvov5SHFUxYHPS
         BlOQ==
X-Gm-Message-State: AOAM5318pKHJe7oabKlqHXhbebD05LLXnfmnJKHAX2IU9h7MamfuPELc
        vd19DQDQjmVAs7BiMjmarpKUt+6+nNZ/EruJYOgafg==
X-Google-Smtp-Source: ABdhPJyji08Osmbo8jcHLe3P6SPGfKGQxGSCchRvUfkB1TcfZeMkaHCGFi4DFTbQb1Gf/AUBJBAIvEb7YplPbDdi46A=
X-Received: by 2002:adf:dd0d:: with SMTP id a13mr847349wrm.259.1636566094916;
 Wed, 10 Nov 2021 09:41:34 -0800 (PST)
MIME-Version: 1.0
References: <20211109000130.42361-1-hans-gert.dahmen@immu.ne>
 <YYoSPjF3M05dR0PX@kroah.com> <42cea157-55a2-bd12-335b-6348f0ff6525@immu.ne>
 <YYpNOMtp7Kwf0fho@kroah.com> <CAHifhD4f676jiQ52siiKQTjUFXFm6Sto8pQjF07w5y+gqrUvFQ@mail.gmail.com>
 <YYpsq/umygfTb8mM@kroah.com> <CAHifhD6K5hbpHS-X+2L=pfUe+7OpyTbB7uyh8WGbdaeBMwoYPg@mail.gmail.com>
 <CAHp75VfbYsyC=7Ncnex1f_jiwrZhExDF7iy4oSGZgS1cHmsN0Q@mail.gmail.com>
 <CAHifhD5V9vwJenRLcPRH5ZMeLa_JnjZKfdcFZw1CjceBtC6=Ew@mail.gmail.com>
 <CAHp75VeyQEaABFOnEUh2pdFx9ROJvRcud-BuEbKWmaEWpL9_Uw@mail.gmail.com>
 <CAHifhD7Qf7+dc7K-MjNguqmiCWUxOJZmQoCTRUZOR-RWMm_JPw@mail.gmail.com>
 <CAHp75Ve9BMNy3gP=-Dajm+Lgu+E4FCqc4phLgV1_cr2qUnTX_w@mail.gmail.com>
 <CAHifhD4n7O5eWFPOjRAmHYL52tW0K=uXXzVj7L5+enTFwFXW2A@mail.gmail.com>
 <CAArk9MP5cKJ+VhAZUseW4LnQNRvux=MZe2eSy3rQkbHKnUsGig@mail.gmail.com> <CAHp75VdRwvU5WjFP5E4gg8U+_e34A0Lwze+nz_wVHoB49jLeLg@mail.gmail.com>
In-Reply-To: <CAHp75VdRwvU5WjFP5E4gg8U+_e34A0Lwze+nz_wVHoB49jLeLg@mail.gmail.com>
From:   Hans-Gert Dahmen <hans-gert.dahmen@immu.ne>
Date:   Wed, 10 Nov 2021 18:41:23 +0100
Message-ID: <CAHifhD7baCPKnRsM3Vfc_EDJoa=Lzqgq=K68_+WS59n9bvCOvw@mail.gmail.com>
Subject: Re: [PATCH] firmware: export x86_64 platform flash bios region via sysfs
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Mauro Lima <mauro.lima@eclypsium.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Philipp Deppenwiese <philipp.deppenwiese@immu.ne>,
        Richard Hughes <hughsient@gmail.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mi., 10. Nov. 2021 um 17:32 Uhr schrieb Andy Shevchenko
<andy.shevchenko@gmail.com>:
> Why do we see this instead?

I personally do not need this patch to be in the kernel. This is my
first ever submission to the LKML and all I was trying to do is do
other open source tools a favor in my spare time during my HOLIDAY. At
least for me that is it. After this horrible experience you can be
sure to never ever see anything again from me in the Linux community.

Hans-Gert
