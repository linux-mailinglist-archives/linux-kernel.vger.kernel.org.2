Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14AFD3CAD4A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 21:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244277AbhGOT4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 15:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245005AbhGOTw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 15:52:27 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5826AC06A328
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 12:35:09 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id g4-20020a17090ace84b029017554809f35so7108504pju.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 12:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tWQzYFArmX7BK0KtHhu7qCMLH8EpJJltCicUZnmhozs=;
        b=x+X7r/05mLeYMY5IOOQXqOPlH4+7oeO79bZ5YPDJ++PHDQKt0r4FcvE/lkq15akq7B
         Ce5RF/y77x9dJasWX7jMdKXiDyCRNfCPc0xcdgmMO0nH9GJ8PcKjDkDCNNwh88V3I8q+
         DVd8W4UyeBtFOTbd2yOFKy6XhIXfiUb4cjWvUYZNsBW6xRsYQlKKhDyHMQ8HR13L0zF5
         yJn4825mzOpNHdMV2eZ72kAoCCdIieowUKQvUmzKFsCD1CehD3TdyOBZuq4PFKBRFYvE
         J7XyrEX7xMecHu4TmiRqBc6ToIEqTL1RABDWAcgFcJqtXWCwwkUwT8cTATLu+1RfuxFH
         zOzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tWQzYFArmX7BK0KtHhu7qCMLH8EpJJltCicUZnmhozs=;
        b=Te9Z3TmXNkQP4jpZc9ZqjR4KlUAxCAm5GPDPY9El/Xp52sAJ0iXf1aER5GxbF8enbL
         BsyiNfEv2YA4Rz9Bci9/stUDckyRS5ZSYWW3cJcxrio0k2QKPLDv5nYqo81DwKC/yc1m
         Ndk+RvChyhsokURCkvqfjjXEoGwxUx+q4Sd668SOl5/78+EX4+4tcq9dShActP4zP4vT
         efu0QYP58OR+RrYG8Yt/VL1KN4rVD6K/Aut6ubRCAUpEgTA2pmFZeXksFJ8kN1/9rcFV
         REAsofWo4+l5rSHWFXwoR2ZUQuSsQFKnfbrBbd6wiy8xaPuJDiofWuGEXFw1Ho3it90t
         X8CQ==
X-Gm-Message-State: AOAM531fghDvnlyPDz/r9urJ8dEHYaYrj6E7YRMgg9U85cCVbNVHzEJX
        nQll+feZmznL0ZIjd59JOGLRaf5i2Vylt8uh9ypwKw==
X-Google-Smtp-Source: ABdhPJwxNVyUFsXl8r6NxD+c6uWM8R2fmbcCrxfwX4wABHvVgCgyv6hXJdQx4qtT/3WKROCvcTTm94Gam5hqhrB02Do=
X-Received: by 2002:a17:90a:8407:: with SMTP id j7mr11756922pjn.13.1626377708767;
 Thu, 15 Jul 2021 12:35:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210712220447.957418-1-iwona.winiarska@intel.com>
 <3b9cfe5f728c40c473a22070029c8790b452daf4.camel@intel.com> <fe9a5191e401b38325aaff11365b5970034d26cc.camel@intel.com>
In-Reply-To: <fe9a5191e401b38325aaff11365b5970034d26cc.camel@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 15 Jul 2021 12:34:58 -0700
Message-ID: <CAPcyv4h-PrBhPU7FcuKwk++o5unKY03H85M-inpDGvmDh-ybGQ@mail.gmail.com>
Subject: Re: [PATCH 00/14] Introduce PECI subsystem
To:     "Winiarska, Iwona" <iwona.winiarska@intel.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "jae.hyun.yoo@linux.intel.com" <jae.hyun.yoo@linux.intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2021 at 10:33 AM Winiarska, Iwona
<iwona.winiarska@intel.com> wrote:
>
> On Wed, 2021-07-14 at 16:51 +0000, Williams, Dan J wrote:
> > On Tue, 2021-07-13 at 00:04 +0200, Iwona Winiarska wrote:
> > > Note: All changes to arch/x86 are contained within patches 01-02.
> >
> > Hi Iwona,
> >
> > One meta question first, who is this submission "To:"? Is there an
> > existing upstream maintainer path for OpenBMC changes? Are you
> > expecting contributions to this subsystem from others? While Greg
> > sometimes ends up as default maintainer for new stuff, I wonder if
> > someone from the OpenBMC commnuity should step up to fill this role?
> >
>
> The intention was to direct it to Greg, but I guess I didn't express
> that through the mail headers.

Usually something like a "Hey Greg, please consider applying..." in
the cover letter lets people know who the upstream path is for the
series.

> I am expecting contributions - for example there is at least one other
> major BMC vendor which also ships PECI controllers.

You're expecting to take patches from them and you'll forward them to
Greg, or they'll go to Greg directly?

>
> From my perspective, the pieces that make up a BMC are pretty loosely
> connected (at least from the kernel perspective - scattered all over
> the kernel tree), so I don't see how that would work in practice.

No worries, Greg continues to scale more than other mere mortals for
these kinds of things. I was more asking because it was not clear from
these patches, nor MAINTAINERS, and it's healthy for Linux to grow new
patch wranglers from time to time.
