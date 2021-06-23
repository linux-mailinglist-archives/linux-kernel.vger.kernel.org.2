Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2B273B22B3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 23:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhFWVrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 17:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhFWVrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 17:47:32 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DBDC061574
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 14:45:14 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id g14so3307223qtv.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 14:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eO/gYbfA6Dk3fvPEfq//UAVbrBE1Hl+b3nbIln7zxCo=;
        b=IWYpWrmxb6b5oYYzL2CGARVvY1cJdnFmp0pf3q3Bz5VW+Yv5HFpsH4M9Bq+Nw/sjHK
         2L0nDVw45GcJe7nQTlZ28k/miOGGntJR8W5J4Voi7MO1jrBUJgB5Ea0Esw50VWRmm45Y
         38AF8mhKCT8oJimpI7VLn2vlR+sGga5+4DD9qedz7Z2rFAxEOHAA6DcEET+mez1x3J6+
         GOvlJYnOt+dfs+bJsq/MHUwUv+NMt525B239rkOXryVQEIrngwee2HEu7obvBb4/uncB
         6O+ax7RxC2XTTn3FxGkC3LYkt9ImH0/OqEC7GesBlxBxvHieu9Z9J226aKdj5hGBSXcE
         O9ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eO/gYbfA6Dk3fvPEfq//UAVbrBE1Hl+b3nbIln7zxCo=;
        b=FZ4Vz65mt0keqMHnlVKqiItsyzpwxTs0zuIXqN1HFvLIrVoVzqRg5yDRZ9k0khz67d
         Dby6coRjEmcGuRHUsD0LMTd5jC7UVJ3ykgPfzWE3/YxppkyVyMT1/SilZn0q4TesJg9Y
         QDMC+3mVquUtYUJt/gr6QVr5TzFJ4K9Bypjuiks72g6798DqfOgJq79jEM0hze2LGkFh
         lgcSrJeXztiRQRMaUyYV2vL/inhtUk4EryzuRIxCkicAzr0uIfFUYIQRGAQMcqQ+dS8j
         JzHB1YxUcemh5lCITsrqtM8wQqsnfk2aanlZhLcy1gaovkR5/SrIYkdp4FetocC8I30L
         3t3Q==
X-Gm-Message-State: AOAM531MLtvgHcQ+3R+AHqE6VRLxM4hGgtF62vq6+VJG/9Ydpi8QvdWI
        lOL5KJxzieakX2MpzTpkfjGJ3KLVET7ieByHMKRGMA==
X-Google-Smtp-Source: ABdhPJw3GtJtGKNZUWMs5ocfXyKukzULEu9ZrESDoOs8YOI4F1k7sQ982AKQG9jIeOCBC6M9JqVFAyAKPrwT60U/sRM=
X-Received: by 2002:aed:2064:: with SMTP id 91mr1931402qta.318.1624484713483;
 Wed, 23 Jun 2021 14:45:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210621173028.3541424-1-mw@semihalf.com> <20210621173028.3541424-6-mw@semihalf.com>
 <YNObfrJN0Qk5RO+x@lunn.ch>
In-Reply-To: <YNObfrJN0Qk5RO+x@lunn.ch>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Wed, 23 Jun 2021 23:45:04 +0200
Message-ID: <CAPv3WKfdCwq=AYhARGxfRA92XcZjXYwdOj6_JLP+wOmPV8xxzQ@mail.gmail.com>
Subject: Re: [net-next: PATCH v3 5/6] net: mvpp2: enable using phylink with ACPI
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Grzegorz Bernacki <gjb@semihalf.com>, upstream@semihalf.com,
        Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>,
        Jon Nettleton <jon@solid-run.com>,
        Tomasz Nowicki <tn@semihalf.com>, rjw@rjwysocki.net,
        lenb@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

=C5=9Br., 23 cze 2021 o 22:37 Andrew Lunn <andrew@lunn.ch> napisa=C5=82(a):
>
> > +static bool mvpp2_use_acpi_compat_mode(struct fwnode_handle *port_fwno=
de)
> > +{
> > +     if (!is_acpi_node(port_fwnode))
> > +             return false;
> > +
> > +     return (!fwnode_property_present(port_fwnode, "phy-handle") &&
> > +             !fwnode_property_present(port_fwnode, "managed") &&
> > +             !fwnode_get_named_child_node(port_fwnode, "fixed-link"));
>
> I'm not too sure about this last one. You only use fixed-link when
> connecting to an Ethernet switch. I doubt anybody will try ACPI and a
> switch. It has been agreed, ACPI is for simple hardware, and you need
> to use DT for advanced hardware configurations.
>
> What is your use case for fixed-link?
>

Regardless of the "simple hardware" definition or whether DSA + ACPI
feasibility, you can still have e.g. the switch left in "unmanaged"
mode (or whatever the firmware configures), connected via fixed-link
to the MAC. The same effect as booting with DT, but not loading the
DSA/switch driver - the "CPU port" can be used as a normal netdev
interface.

I'd also prefer to have all 3 major interface types supported in
phylink, explicitly checked in the driver - it has not been supported
yet, but can be in the future, so let's have them covered in the
backward compatibility check.

Best regards,
Marcin
