Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8135C35EA26
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 03:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348922AbhDNBAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 21:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348903AbhDNBAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 21:00:48 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4231EC06175F
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 18:00:28 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id k124so9531667vsk.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 18:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c4u9Tmp7ZH5AX/rlmzOqTLYd8P3KJj0zG0wbcgk2yAg=;
        b=o2jSaxaynSzILqsenU5eU94XstdDEfcr+8Qslmm/mklm5VuSsLkPrNRYCMhErZuLSI
         +rib2nSDOqgvO5oB+cXyFVnaY95iSY728Ze0VwRhgpbvJaUIDH0g3ExjNtYJz9M+TtS8
         Kke/f4yYgKs1QuJK8QjeYVg9qNv7JC14pbvfHg5ZUSKF9MdarZUcy34CdI2+DrevJcls
         0/iyrqvTDT/ZKCGexUDcycfXPZxKitln1l6AgKmDP+aKavq7V5Oe7uGTOv3SY1PZv+T5
         Fxi8bBc6IQGq3UMP2hdtaKCfwQ0ETvAKLkuRiM2Dj/umSwJ+F9XXwbFYd0hPt87Bc0CV
         /rmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c4u9Tmp7ZH5AX/rlmzOqTLYd8P3KJj0zG0wbcgk2yAg=;
        b=h8PEcWE0vR3TaXyD78grhSEXDUFxXc+MwZ3aGzKORPB1voquUfXZsiAuhXqSsR3YR9
         XcYlyFrMMpOSQykbq9exhxG2HLIWV9siWJqw0obYAmeAr+ae3qRSI09YSnLuTFN7yHFu
         P1wVDIgRWDzMs/UOaWlBPfC/pT2Y7/hQsRDe4dbYz4+02lsuDAA34aJFcEKC4QZz9bE6
         sKMA4d+vqr4uQosRkNDRGbm9Hn02BuNlvWkakgPwIKEQ4YYQ5z4z0TnqTjOK6yMU8XGd
         YmnEdyXiLQ/S4MFF8SAoqjE9udP11HF/CDSkfA92FXLMCm8oikyZcb8ljkc3v83q8N8c
         l4bQ==
X-Gm-Message-State: AOAM533Q4ivEGLV3YVWO3/+vQukhszcSMhBD5Oy+zLLaNiqWdszd9Tei
        WxrpqE6glzV1mMnkl0J3ZEfnzihXLf8znY/SNEpVnA==
X-Google-Smtp-Source: ABdhPJxx+HyTkPb6szIljEpB1Joai25x8+XQS4HEhkQ3iuldNfeqR0oKtzhrObVZzzYf5l3UpP0abhVEAxAZ0RjTK9s=
X-Received: by 2002:a67:2d14:: with SMTP id t20mr23340021vst.48.1618362027253;
 Tue, 13 Apr 2021 18:00:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210407200723.1914388-1-badhri@google.com> <20210407200723.1914388-5-badhri@google.com>
 <YG67d/YOuoBwK+bF@kuha.fi.intel.com> <YG69UKTSgyHQHeFd@kuha.fi.intel.com>
In-Reply-To: <YG69UKTSgyHQHeFd@kuha.fi.intel.com>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Tue, 13 Apr 2021 17:59:52 -0700
Message-ID: <CAPTae5J2K_=VaL2mQOZxBgaSEGDavW=Rm8XNNDM4n=JPgqbjaw@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] usb: typec: tcpm: Allow slow charging loops to
 comply to pSnkStby
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        USB <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Kyle Tso <kyletso@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 8, 2021 at 1:22 AM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> > > @@ -4047,9 +4053,12 @@ static void run_state_machine(struct tcpm_port *port)
> > >             break;
> > >     case SNK_DISCOVERY:
> > >             if (port->vbus_present) {
> > > -                   tcpm_set_current_limit(port,
> > > -                                          tcpm_get_current_limit(port),
> > > -                                          5000);
> > > +                   u32 current_lim = (!port->slow_charger_loop ||
> > > +                                      (tcpm_get_current_limit(port) <=
> > > +                                       PD_P_SNK_STDBY_MW / 5)) ?
> > > +                           tcpm_get_current_limit(port) :
> > > +                           PD_P_SNK_STDBY_MW / 5;
> >
> > Here the use of the ternary operator is not appropriate. Please try to
> > clean that up somehow. Maybe something like this would be better?
> >
> >                         u32 current_lim = tcpm_get_current_limit(port);
> >
> >                       if (port->slow_charger_loop || (current_lim < PD_P_SNK_STDBY_MW / 5))
> >                               current_lim = PD_P_SNK_STDBY_MW / 5;
>
> Sorry, I mean:
>
>                         if (port->slow_charger_loop || (current_lim > PD_P_SNK_STDBY_MW / 5))
>                                 current_lim = PD_P_SNK_STDBY_MW / 5;

Ack. Updating in my next version: V3.

Thanks,
Badhri

>
> thanks,
>
> --
> heikki
