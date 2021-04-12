Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5866C35C501
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 13:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240340AbhDLLXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 07:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240213AbhDLLXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 07:23:52 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2D7C061574;
        Mon, 12 Apr 2021 04:23:35 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id z16so9118141pga.1;
        Mon, 12 Apr 2021 04:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3cLuXC7Cd/cpMSgTO8uwS2vpxElc8R+vCCeDYIOPsLE=;
        b=b9JIMdYA2EytzlJ9hkjW4LHokDAoiyrTcPh5kwMhQZD8+j1zNiu9FE5Eijv6YQ/BCn
         EyDYDmSbEt7Am7eYi+IM3zCYqoTI3AijAICZHytYzVPy65S2gPDQUy+1gZeObTZD1LSM
         OdcjabPF3TsaAokvJfhK+kQpLSPGRPtmU9791TTSs7qsDqFisTOmkwdb2nguVkFTLMb/
         SxGy3uVq4DGpmz6PkidX9lO++FC6pWpd0GgShdexXaBm0vQ7z0EiIgwl3BQZF5khrJRP
         RtvtpVDrxMO9jubFpW9/rYJ30NsjF99RyzS/vEzEM+BTGNw7K9gPwtWqs0UxC+3Ikg3j
         STSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3cLuXC7Cd/cpMSgTO8uwS2vpxElc8R+vCCeDYIOPsLE=;
        b=r2B5jCk2rJgWNsqGquO66dLDMFqCzuYIwCZZfIMgtj8XUTBPMS+Hd/DYQgU+ZVVIdr
         UYBVnJhivdR5uk8wt4OSNNtGirUIHmFkfuCav6a1pgoP37iCA1wqlAY/FUXqeC1UtHP5
         kmpdMJEs5/q+RR2tuA4YgKHKA/8PQJJMsVKkQaMsXi0uh0ltHZcU9Y4uQkfD7/H1ptSR
         Diunh63P+6UGbtdkgR493vx0LIRezpYAwia7yiMvaNJalTqd2UnJbyK35yu3PRSUYYJK
         f/V5UbC6KU6uoJtPvbULgFUWeMtM6oSSeL0IR7QJs7PIKjqyIdUB2NkYwJFtBl/Ad9NT
         cDIg==
X-Gm-Message-State: AOAM533eWJMBLmx0640plu3R7c8VUgD3bOoYCxQI5S+5XxB7hWGqBRkA
        iq1rm1ISd28TX69zM1vmpKm9iZS26m3jA426c3g=
X-Google-Smtp-Source: ABdhPJwbzQU7LC1EQQLqrGvIAJQ7Sin3z72YDVQwNU970kkPd2w2uhKy3+2N9PVr24cjHxa2R6q1t0Db8jcEQUlp0yM=
X-Received: by 2002:a62:5c6:0:b029:24d:e97f:1b1d with SMTP id
 189-20020a6205c60000b029024de97f1b1dmr2942611pff.40.1618226614660; Mon, 12
 Apr 2021 04:23:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210412090430.167463-1-linux-kernel-dev@beckhoff.com>
 <CAHp75VfLQBDv-Bcj5=Ksv6kp2XH2v8msDvNjsdj6=WZiCk=Q9w@mail.gmail.com>
 <f406a5a6c6bfe0e458925821b6830e9dc5a151c1.camel@beckhoff.com>
 <CAHp75VcKYc4BWCM_8Zm7NONceAm2BbhTgDKOweu-qM9yLUHUJw@mail.gmail.com> <7af45968aa0f0909ba39eeac3b7fa4947b6e38a6.camel@beckhoff.com>
In-Reply-To: <7af45968aa0f0909ba39eeac3b7fa4947b6e38a6.camel@beckhoff.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 12 Apr 2021 14:23:18 +0300
Message-ID: <CAHp75VeTK9TstuRCqOkVit9U7sV7TA_xcTQ1yZPGfLdZSt7_Gg@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: pmc_atom: Match all Beckhoff Automation
 baytrail boards with critclk_systems DMI table
To:     linux-kernel-dev <linux-kernel-dev@beckhoff.com>
Cc:     "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 2:07 PM linux-kernel-dev
<linux-kernel-dev@beckhoff.com> wrote:
> On Mo, 2021-04-12 at 13:54 +0300, Andy Shevchenko wrote:
> > CAUTION: External Email!!
> > On Mon, Apr 12, 2021 at 1:39 PM linux-kernel-dev
> > <linux-kernel-dev@beckhoff.com> wrote:
> > > On Mo, 2021-04-12 at 12:43 +0300, Andy Shevchenko wrote:
> > > > On Mon, Apr 12, 2021 at 12:29 PM Steffen Dirkwinkel
> > > > <linux-kernel-dev@beckhoff.com> wrote:

...

> > > > I'm afraid it's a bit too much. Is there any guarantee all the boards
> > > > based on x86 will be Baytrail only?
> > > >
> > > Sorry, I guess I should make this clearer in the message.
> > > All boards with "CBxx63" are Baytrail.
> >
> > Exactly! And this supports my idea that this shouldn't be done like in
> > this patch.
> > Are you guaranteeing that *all x86-based* boards produced by your
> > company will be Baytrail only?
> > Above tells that the answer is rather "no". So, I think we can't apply
> > this patch in its current form.
>
> All boards with DMI_PRODUCT_FAMILY="CBxx63" are Baytrail boards. We do produce other x86 boards but the family
> is exclusive to Baytrail.
> I might be misunderstanding how the matching works. Does this match anything other than CBxx63?
>
>  .matches = {
>  DMI_MATCH(DMI_SYS_VENDOR, "Beckhoff Automation"),
> DMI_MATCH(DMI_PRODUCT_FAMILY, "CBxx63"),
> },
>
> I can switch it to DMI_EXACT_MATCH but even substring matching works.

Sorry, I missed the second match line. Yes, looks correct to me now.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

-- 
With Best Regards,
Andy Shevchenko
