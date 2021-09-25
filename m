Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D02441825F
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 15:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245520AbhIYNig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 09:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239261AbhIYNif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 09:38:35 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E09C061570;
        Sat, 25 Sep 2021 06:37:00 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id t189so18677898oie.7;
        Sat, 25 Sep 2021 06:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hOZ6JIcb8uf4b9WKGfs+BDqn+pjUAFeDvp/C9XwGPuU=;
        b=Nx642B3chumpXp5giHidtUzTIaZz4pCgMsv7p555+KwRIOlVpJCnvSfxy13wvTNgps
         2kukFPj5EoS4Zfx/jvClpnoOtunim1FlBBcobImF4y8kQtHYqsSElDgGzYDXiTxg7WyM
         swXz5B75hZb+KqXtRPzvuiNjkbRRvTVZaf55Hem1UrbSayuV1CM316rqEuF1IsOv/EC4
         bZeGJFEWC5xClMJ/f3MBny7HUjmMM168bZXA3W68X/7kz+fRgQdXjdkt456bHKyaIk/R
         SkIjfXy6rRe0yAecvJxxU8o09RBwHtmEFr3WcjoGhgPyURvkgWc/LSJ1O0nY4cJGXt+O
         6XPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=hOZ6JIcb8uf4b9WKGfs+BDqn+pjUAFeDvp/C9XwGPuU=;
        b=2m8VfWyKx9QPKk/4Y7h+3RCMoLSqR4EJh4XAuvXMkRDihVVQZ+ON3XinwOqVhF2js7
         qwOSHiKy3R52KLUdZi6HHicDglod4ZZl9I9cWmyaUGNxHSA8LJM99Q3PgkFjRtUQxTMn
         y9riUm3lPLCqpyRrR3fduuaXrz2GJaVpsbHgn+YA9SxtKs2dWQ2LboiNcryLjDtVZZ8X
         GSmiota730vDqbwcpH/Rg8xmyn0tBisOuhQAaRVe8USgjUo1QuTCXO0h9IEdhARzsGuv
         9y9kIloylsZvTRJJbkRkrY4KAb5Sx7iCYBMVdJF67pXVBp1QhXZv4BEyeLMJ1nzYk9eU
         45jQ==
X-Gm-Message-State: AOAM533wEYS5XpLhW+fgjdMwfDdalxEOFvPp9K1V7lS7yrRZpXlmyxjg
        ANFIVXCf+/ul1HKX/DhHce4=
X-Google-Smtp-Source: ABdhPJwlVIMztVT8P9TBXddRQKENy4FyJ74MNxgPiEAOAlw18RmnN+dI+7lvL1tl9iQ5j451CcfkpA==
X-Received: by 2002:a54:4692:: with SMTP id k18mr789280oic.145.1632577019791;
        Sat, 25 Sep 2021 06:36:59 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f13sm2869616oto.49.2021.09.25.06.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Sep 2021 06:36:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 25 Sep 2021 06:36:58 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Oskar Senft <osk@google.com>
Cc:     Rob Herring <robh@kernel.org>, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: Add nct7802 bindings
Message-ID: <20210925133658.GA1740158@roeck-us.net>
References: <20210921004627.2786132-1-osk@google.com>
 <YUzzjYMwNKwMFGSr@robh.at.kernel.org>
 <CABoTLcRpSuUUu-x-S8yTLUJCiN4RERi2kd8XATP_n3ZTRpAWDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABoTLcRpSuUUu-x-S8yTLUJCiN4RERi2kd8XATP_n3ZTRpAWDg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2021 at 11:17:51AM -0400, Oskar Senft wrote:
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

FWIW, this happens to be one of the cases where I am also the driver 
author, and I still have a test board with the chip.

Guenter

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
> 
> > > +            temperature-sensors {
> > > +                ltd {
> > > +                  status = "disabled";
> >
> > Don't show status in examples.
> Hmm, ok. I found it useful to make clear that a sensor can be
> disabled, but maybe that's just always the case?
> 
> I appreciate your other comments and will fix them in the next version
> of the patch. But I'd like to get clarity wrt. recommended sensor and
> property naming in the device tree before sending that.
> 
> Thoughts?
> 
> Thanks
> Oskar.
> 
> > [1] https://lore.kernel.org/all/CAL_Jsq+NXuF+F7OE3vyEbTUj6sxyMHVWHXbCuPPoFaKjpyZREQ@mail.gmail.com/
> [2] https://lore.kernel.org/all/20210910130337.2025426-1-osk@google.com/
