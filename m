Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE7F426BA1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 15:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241702AbhJHN1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 09:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbhJHN1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 09:27:21 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD03AC061570;
        Fri,  8 Oct 2021 06:25:26 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id o83so6292893oif.4;
        Fri, 08 Oct 2021 06:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9cq3pyd6+P1KyVokp1RRBpzdAal1KEUlphIpxauekP0=;
        b=qXUev3VazEI9TlAGHVK0h0WsqbUqu7Cj9spk7kfk7aP5jxpY6HHO/R/q/ixDYeduCa
         iNdhDYMwAjUCgtm8zt3nGX6fc0c1fJiCuROH41r8xGKKWP6+HIUihTuppj9prYJ5q77o
         KP5sdd+5AK4LY+1top4904cY7UDCE7ygp4VudHfxEKIm5cU9OFyndoUH4iOe8Gqh8BmU
         0v6Af936HPUFZwJPdR7G6B2DExHZ7OTyhDRk6UbD9EScqZVxNfgczesxxzQHbe+VGjTB
         dXDEZjSwAFMb53TLgArilVqgLhR+EDeTq6bzVIG5MFgRbdgPjZpKeNICGnK7VKAcOBqF
         4IeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=9cq3pyd6+P1KyVokp1RRBpzdAal1KEUlphIpxauekP0=;
        b=8Ocq/HKumMhCKxE6WsRUloZXU/4USEdkyceEUGP10a8kPYBo5V/EBhjfSqxJxnkTNs
         qeUE4SN73+LEojVuotV5ZIL0ClKHOEJFUoaJmQD0hFM8jb+afI8DDQqLEMr1W40Dr5Yz
         gNYxGJvxcQpTN1wJlZ4k7tpqE+3dr/Giz5eawU0Pw/F5wvQKa5hzTKjnnG+9VlLGJk27
         EsLRbScP+bb7TdAxAPXTO2zFCLX7pfGkqVFstdTw0A3lkQMyWdhG0+jSJVheJPSKBY9B
         YiUCDneVtJYur2kHLPSXj7EgMVyMlDvX2nU+CezyCa8PfDC2yS4Nh43Bdw8wJeTMQrxs
         lq0A==
X-Gm-Message-State: AOAM532PDCh9dHXjPFKF3zd0NR08kEu/7p8NEJG64RV1WaLf30SPATYD
        GAp9UQyC0KDfNqdt8uKpka8=
X-Google-Smtp-Source: ABdhPJyLcBHzIpbsxUY14a+GCfox1I4n5HlkT8R3ZoDFLwei7IgaqFJ8YOalf1Gnw94YEBm5aT3Zyg==
X-Received: by 2002:aca:4bc4:: with SMTP id y187mr4509447oia.174.1633699526077;
        Fri, 08 Oct 2021 06:25:26 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i127sm603757oia.43.2021.10.08.06.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 06:25:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 8 Oct 2021 06:25:24 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Oskar Senft <osk@google.com>
Cc:     Rob Herring <robh@kernel.org>, Jean Delvare <jdelvare@suse.com>,
        Linux HWMON List <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: Add nct7802 bindings
Message-ID: <20211008132524.GA4171482@roeck-us.net>
References: <20210921004627.2786132-1-osk@google.com>
 <YUzzjYMwNKwMFGSr@robh.at.kernel.org>
 <CABoTLcRpSuUUu-x-S8yTLUJCiN4RERi2kd8XATP_n3ZTRpAWDg@mail.gmail.com>
 <CAL_JsqJ+hqKfLDzbMpzPks+wJaNuwU6kodqnqWjkOb8aDf92ZQ@mail.gmail.com>
 <CABoTLcTTphA4Kpi-qbpUkX4f_V4NjhDv3_vVk8UNgvWfnKVOYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABoTLcTTphA4Kpi-qbpUkX4f_V4NjhDv3_vVk8UNgvWfnKVOYw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2021 at 09:07:47AM -0400, Oskar Senft wrote:
> Hi Rob
> 
> > > > > +            temperature-sensors {
> > > > > +                ltd {
> > > > > +                  status = "disabled";
> > > >
> > > > Don't show status in examples.
> > > Hmm, ok. I found it useful to make clear that a sensor can be
> > > disabled, but maybe that's just always the case?
> >
> > Yeah, this case is a bit special. The node not being present also disables it.
> Oh, I didn't realize that a missing node defaults to "disabled". What
> I want to achieve is that if a node is not present, we don't configure
> it. The reason behind this is that the HW provides a mechanism to
> configure itself at power-up from a connected EEPROM. In that case
> we'd still want the list the nct7802 in the DTS, but without
> configuration. This effectively is the current behavior.
> 
> From what I understand from [1] and follow-ups, having the extra
> "temperature-sensors" level is actually not what we want here and I
> proposed a different solution in [2].
> 

Turns out this chip has another level of complexity, where a channel
can either be a temperature sensor or a voltage sensor. So, from dt
perspective, we don't have separate scoped for the different sensor
types.

I don't really like [2] to indicate voltage vs. temperature using "mode"
(it maps both sensor more and type into a single property),
but I agree that two levels doesn't really make sense here either.
That is where child naming may come in. We have "sensor" in your proposal,
and "input" in the tmp421 proposal. My thought on that was that we could
use the child name to distinguish sensor types.

    temperature-sensor@1 { /* RTD1 */
         reg = <0x1>;
         status = "okay";
         mode = "thermistor"; /* Any of "thermistor", "thermal-diode" */
    };

    voltage-sensor@3 { /* RTD3 */
         reg = <0x3>;
         status = "okay";
    };

or maybe

    sensor@1 { /* RTD1 */
         reg = <0x1>;
         status = "okay";
	 type = "temperature-sensor";
         mode = "thermistor"; /* Any of "thermistor", "thermal-diode" */
    };

    sensor@3 { /* RTD3 */
         reg = <0x3>;
         status = "okay";
	 type = "voltage-sensor";
    };

> On that background, I'm wondering how we could have compatibility with
> the previous behavior, where the individual sensors were not listed,
> and just defaulted to whatever the HW came up with, whether that was
> power-on defaults or loaded from an EEPROM.
> 
> What the code currently does is to check for the presence of
> "temperature-sensors" and only attempt to configure any of them if
> that top level node exists. This enables backwards-compatibility.
> Going forward, I would have done the same for sensor@X and only
> explicitly enable / disable the sensor if the node is present. If it's
> not present, I'd use the power-on / EEPROM-provided defaults.
> 

Makes sense to me.

Guenter

> Thanks
> Oskar.
> 
> [1] https://lore.kernel.org/linux-hwmon/20210924114636.GB2694238@roeck-us.net/
> [2] https://lore.kernel.org/linux-hwmon/CABoTLcQYHZbsgzXN7XXKQdDn8S-YsuE+ks9WShAEKcBJojEfcQ@mail.gmail.com/
