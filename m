Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 854F7393BF0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 05:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236328AbhE1DcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 23:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233801AbhE1DcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 23:32:01 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5965DC061574;
        Thu, 27 May 2021 20:30:26 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id o17-20020a17090a9f91b029015cef5b3c50so3673218pjp.4;
        Thu, 27 May 2021 20:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DYyj/O1oTsd8iPKaVYhCgJww9/pqZoeLfUmd7MZl1oU=;
        b=cPmc8KgOTsg3pE5+BSz6K0jniO74D3kCLW+5AppZpT9ifnfOsjpln4Cel8Y27tyWeW
         iO9cHjYF8Y1XwS1VdqjjaQGZUpYJXP0z1JO7PjE67PfIabSv2A2Winze59JtFZVLcVFW
         Yp/MvzIcusBHhYyJWiMnjEvku3/i0zj8KzfQZOiSsUF3MrW1qdp81kPKonzyf1AXfiPg
         Lk9TjmFtwbTEvfszbm1zmAOrSjhzubKytvF+ojKJsVRRyDuLbmvdnaofbtOduTYd3Cy7
         m5mawJJb6XaAHauZlejrrYbLu8Nk4s1EbLNf3+8DkULNem6vEnzSRuSUKz+cdYqt1E9T
         p0lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=DYyj/O1oTsd8iPKaVYhCgJww9/pqZoeLfUmd7MZl1oU=;
        b=Os/zgquyU9P19V3bgaQIJYJjVnIDPUyHopJI9RI1udv0EwoppQzvgGyuZuQKqS2q4o
         9A/mMsBaMH2oPpLMw5Q7UGiepF4d4LPoysvXkQRriLj0odkFlr+NJdobDs0XA+a5WTrz
         kOXoRk1CQ3w8W94panxNHtcTmEkqhRM+tLQQTmdUTwHC2IvglDuDKTDykaryxN7mb2/8
         qxdF5CQ+XUa+1OkYC5rymCRXFhf0iKAKDgtu9cVyheRdfpjUivTHIxzppXzsRuAHUaXj
         sRe86blQF1shpxS8ILts3jxIKa41oujHHvaRyJ8Z9zDmSzRAP0yLHN1SLrI7US1RO1oP
         oZyw==
X-Gm-Message-State: AOAM530oNSD9UcfJGFmMS7XPkj9ONO1/+j4odrsa3LtfaP3vxUSJXYkc
        wxHtZ2NowkjdkxK8JvYceuU=
X-Google-Smtp-Source: ABdhPJwZPI3hO/T0Ck2SsoY0yMUQ5UpwbkRfH2+N+d8eIr44Ev4oXd4X2xtIWgeYpERrVHKj7gzgpg==
X-Received: by 2002:a17:90a:7e84:: with SMTP id j4mr2040025pjl.101.1622172625917;
        Thu, 27 May 2021 20:30:25 -0700 (PDT)
Received: from lenovo ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id z2sm2912359pgz.64.2021.05.27.20.30.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 May 2021 20:30:25 -0700 (PDT)
Date:   Fri, 28 May 2021 11:30:19 +0800
From:   Orson Zhai <orsonzhai@gmail.com>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Orson Zhai <orson.zhai@unisoc.com>
Subject: Re: [PATCH] of: property: Add fw_devlink support for pwms
Message-ID: <20210528033019.GA11683@lenovo>
Mail-Followup-To: Saravana Kannan <saravanak@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Orson Zhai <orson.zhai@unisoc.com>
References: <1622102950-31688-1-git-send-email-orsonzhai@gmail.com>
 <CAGETcx9w-gYrPQuxOf9qQDwzyi8Bjp7cf_uK=Q5UcKuH+vWVFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx9w-gYrPQuxOf9qQDwzyi8Bjp7cf_uK=Q5UcKuH+vWVFw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 02:04:30PM -0700, Saravana Kannan wrote:
> On Thu, May 27, 2021 at 1:09 AM Orson Zhai <orsonzhai@gmail.com> wrote:
> >
> > From: Orson Zhai <orson.zhai@unisoc.com>
> >
> > pwms is often required by backlight in embedded devices. Add device link
> > support for pwms as well.
> >
> > Signed-off-by: Orson Zhai <orson.zhai@unisoc.com>
> > ---
> >  drivers/of/property.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/of/property.c b/drivers/of/property.c
> > index 6c02863..93be977 100644
> > --- a/drivers/of/property.c
> > +++ b/drivers/of/property.c
> > @@ -1287,6 +1287,7 @@ DEFINE_SIMPLE_PROP(pinctrl6, "pinctrl-6", NULL)
> >  DEFINE_SIMPLE_PROP(pinctrl7, "pinctrl-7", NULL)
> >  DEFINE_SIMPLE_PROP(pinctrl8, "pinctrl-8", NULL)
> >  DEFINE_SIMPLE_PROP(remote_endpoint, "remote-endpoint", NULL)
> > +DEFINE_SIMPLE_PROP(pwms, "pwms", NULL)
> >  DEFINE_SUFFIX_PROP(regulators, "-supply", NULL)
> >  DEFINE_SUFFIX_PROP(gpio, "-gpio", "#gpio-cells")
> >
> > @@ -1371,6 +1372,7 @@ static const struct supplier_bindings of_supplier_bindings[] = {
> >         { .parse_prop = parse_pinctrl7, },
> >         { .parse_prop = parse_pinctrl8, },
> >         { .parse_prop = parse_remote_endpoint, .node_not_dev = true, },
> > +       { .parse_prop = parse_pwms, },
> >         { .parse_prop = parse_gpio_compat, },
> >         { .parse_prop = parse_interrupts, },
> >         { .parse_prop = parse_regulators, },
> 
> I already have a local patch for this and "reset" bindings. But I'm
> holding off on adding support for new properties till fw_devlink=on
> fully lands in 5.13. Trying to avoid inadvertently adding new
> dependency issues. For example, the remote_endpoint binding I added to
> fix one issue caused more dependency issues. So far I've fixed them
> all.

Got it. Good to know your plan.

> 
> So, yeah, temporary Nak for this.

No problem.

-Orson

> 
> -Saravana
