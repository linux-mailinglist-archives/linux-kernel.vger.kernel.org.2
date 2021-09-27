Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4951E4197BA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 17:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235241AbhI0PXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 11:23:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:59532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235071AbhI0PWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 11:22:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 19C496101A;
        Mon, 27 Sep 2021 15:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632756076;
        bh=lziEkEubRhQ8bUn3J/w10f68TYGQ6OOJ1Pje7Mukmfg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oa63i8VPgbR/i0K+fCW78NepaYaTvW4XN1lfw0k/hOQDM6fEdvoVdmQEpymaq0Bzk
         EcEFepe/KcmJfwqPN/QeyAstkPQepskOY9QLTn+8XReXv0r7/Q35xeCNufUS2ro/9B
         L0ZVoOwVxeJFzH8+Lhav95WJqxpHQUxgYedDpYYJzVtxkCFu6dOlG5vc4uI2KLoHoL
         rzfJY8VIYkHK/ZppPiqgH7jq6OQWLsOC+RuTQDC3SfrBjn6qUylc7fijeZaaThHTXV
         T9at8VWMk4SMtkbuw/IlR81XmRZ9CKfK/ph1JKdiRwTlpn25yW977TWhnkKaefUYE8
         tCK6J5JkiQHIQ==
Received: by mail-ed1-f52.google.com with SMTP id v10so66318914edj.10;
        Mon, 27 Sep 2021 08:21:16 -0700 (PDT)
X-Gm-Message-State: AOAM533669dpdPb3Ok9qb+VpTbzeVfENe6gnmWyjarl2YT5S7b5DDlnJ
        N8zet01K3dIS/7ixUZJaoPLcgXLfhjbMQo6YXQ==
X-Google-Smtp-Source: ABdhPJz4BwEe1PEy9tCxSr5MzZ4tPnhFsOF47oRWoerA4LsvnEnjdK3MsOsWhDOXvjskiH1Oatv4Pe5QuoYcS07OFSo=
X-Received: by 2002:a17:906:ae83:: with SMTP id md3mr721524ejb.84.1632756074643;
 Mon, 27 Sep 2021 08:21:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210921004627.2786132-1-osk@google.com> <YUzzjYMwNKwMFGSr@robh.at.kernel.org>
 <CABoTLcRpSuUUu-x-S8yTLUJCiN4RERi2kd8XATP_n3ZTRpAWDg@mail.gmail.com>
In-Reply-To: <CABoTLcRpSuUUu-x-S8yTLUJCiN4RERi2kd8XATP_n3ZTRpAWDg@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 27 Sep 2021 10:21:03 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ+hqKfLDzbMpzPks+wJaNuwU6kodqnqWjkOb8aDf92ZQ@mail.gmail.com>
Message-ID: <CAL_JsqJ+hqKfLDzbMpzPks+wJaNuwU6kodqnqWjkOb8aDf92ZQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: Add nct7802 bindings
To:     Oskar Senft <osk@google.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux HWMON List <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2021 at 10:18 AM Oskar Senft <osk@google.com> wrote:
>
> Hi Rob
>
> > > +maintainers:
> > > +  - Guenter Roeck <linux@roeck-us.net>
> >
> > Should be someone that cares about this h/w, not who applies patches.
>
> Hmm, ok. After talking with Guenter, I thought that would be him. But
> I can add myself, too, since we're obviously using that HW. Is that
> what you mean?

Okay, seems it is Guenter in this case.

>
> > > +    properties:
> > > +      ltd:
> > > +        type: object
> > > +        description: Internal Temperature Sensor ("LTD")
> >
> > No child properties?
>
> Yes. We really just want the ability to enable / disable that sensor.
> What's the correct way in the YAML to describe that? Same for RTD3.

Okay, you need a 'additionalProperties: false' in the schema. (status
will automagically be allowed)

>
> > > +          "type":
> > > +            description: Sensor type (3=thermal diode, 4=thermistor).
> >
> > 2nd time I've seen this property this week[1]. Needs to be more specific
> > than just 'type'.
>
> Ha yes, the example in [1] came from this patch. I went with this name
> to stay in-line with the sysfs name, being "tempX_type". In the
> hardware this would be called "mode".
>
> My original proposal [2] was to have this property a string list named
> "nuvoton,rtd-modes" with a set of accepted values, i.e. basically an
> enum. Splitting this string list into individual sensors makes sense.
>
> The other question that remains open (at least in my view), is whether
> naming the sensors "ltd, rtd1, rtd2, rtd3" is the right approach or if
> we should really go to naming them "sensor@X" with a reg property set
> to X. Note that ltd and rtd3 do not accept any additional
> configuration beyond "is enabled" (i.e. "status").

If X is not made up numbering (i.e. corresponds to something in the
datasheet), then using addresses and generic node names are preferred.
Alignment with other similar h/w is also preferred.

> > > +            temperature-sensors {
> > > +                ltd {
> > > +                  status = "disabled";
> >
> > Don't show status in examples.
> Hmm, ok. I found it useful to make clear that a sensor can be
> disabled, but maybe that's just always the case?

Yeah, this case is a bit special. The node not being present also disables it.

The problem is generally we don't want disabled examples as that turns
off some validation. I have a check for this that I plan to add, but I
don't have a way to have exceptions.

What you could do is just comment out the node. Then you show it, but
don't compile it.

Rob
