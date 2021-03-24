Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43D5734827D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 21:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238128AbhCXUCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 16:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237909AbhCXUCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 16:02:25 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284BFC061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 13:02:24 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id h34so8244356uah.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 13:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L71/S95zyMXln0afxkBYB5ecQb9oQgPfUTdLdtQNpqM=;
        b=LCsBAiOC+y06xN3oDZidZ6bb6lX3Yx+f23Y5uftO1CK55yFBsI5/nl1jACgNP3pG+X
         ok4YyEiZZGyWE2mn/s1jsasO3Ne+RqB+DEeiPbQfHWHpphR9qr14QWDBOnuREjFrCS9F
         5asp3O1NORHpJlr3Cg4A11M/Oj8nuwNHLiLwGZ/M+JYv5S6Z8PGjutcQj5nrwRz7Z8C4
         zMwbYUosBD+upB9muVU97vydBn7eHis5WSh6v/BHg5LZMFnQm8O/eJkS+7mk8WXAG+5f
         2mWm5JXf97DKyr3aFv4NVlpoGLsGFsi7OIysv1HFejKGvBBcTefHwyHo1R3Ia0pd/0Nn
         bLaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L71/S95zyMXln0afxkBYB5ecQb9oQgPfUTdLdtQNpqM=;
        b=e+iG/f3e01Rsqt7qn1s1N2r+HrDT5AJVYCQwIBDiBkcbtxo8D9/vJR+VJ+A4NVgZ1N
         HPmbEoJXwOR0Pe05CUMmkVZ0Mumz3FsU7rZmVBa73PjTMl+gNPgjcS+1fP+2++860rXW
         kXHaVMSo0W2b7xbm8peIGqk2MI94PfoaL9nYJVs+M9npDYAtPDw7gZHmfEuzE4SIrLSl
         rQ+aIieOSwS7WA4449o2zff+EqT/XY8jlgmQXsrTXkVvms/X/nf1BYPsHyUsIBlr4dMN
         VCvYUvZ4DclURV6SZbtISiQSAhofqWD3vFxiOuEb7uRPopPafdeQocxtuB4H5UrESq7n
         vVIQ==
X-Gm-Message-State: AOAM532wcd3imVHi/jWn2d8W+fQBUvECuWgP9BKmv1MiOKa99DtfBc3/
        +GvMXaAxdIexIdeE8hIoX83EXtcRqdWyHNWqCdpPdA==
X-Google-Smtp-Source: ABdhPJwJ5tqbbKkbNKAssimRu1mg50OYnYGjGxnnFswA4GlfmVCV27jhf+B+w0+kbm5rRm38C7W/01CfWNUnuhT1NdA=
X-Received: by 2002:a9f:3d89:: with SMTP id c9mr3068324uai.65.1616616143142;
 Wed, 24 Mar 2021 13:02:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210311100313.3591254-1-badhri@google.com> <20210311100313.3591254-4-badhri@google.com>
 <20210324145042.GA3036037@robh.at.kernel.org>
In-Reply-To: <20210324145042.GA3036037@robh.at.kernel.org>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Wed, 24 Mar 2021 13:01:46 -0700
Message-ID: <CAPTae5KZGPz8jF_C=UjobDe_SotvtR1PecNinOQWUjnLMyF4rQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] dt-bindings: usb: Add chg-psy-name property Maxim
 33359 binding
To:     Rob Herring <robh@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kyle Tso <kyletso@google.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thanks for the feedback !
From the feedback that I received from the other patches in the stack,
we have identified an alternate approach of doing this without
introducing this device tree addition.
So, for now this patch is no longer needed. While the alternate
approach is still being validated, will resurface this patch if I
identify any drawbacks of the alternate approach.

Regards,
Badhri


On Wed, Mar 24, 2021 at 7:50 AM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Mar 11, 2021 at 02:03:13AM -0800, Badhri Jagan Sridharan wrote:
> > chg-psy-name is an optional string property used to indicate the
> > power supply object for which the current/voltage_max limits have
> > to be set.
> >
> > Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> > ---
> >  Documentation/devicetree/bindings/usb/maxim,max33359.yaml | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/usb/maxim,max33359.yaml b/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
> > index 93a19eda610b..3a278969109e 100644
> > --- a/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
> > +++ b/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
> > @@ -28,6 +28,11 @@ properties:
> >      description:
> >        Properties for usb c connector.
> >
> > +  chg-psy-name:
> > +    description: Power supply whose current/voltage_max values to be
> > +      configured.
> > +    $ref: /schemas/types.yaml#definitions/string
>
> If you want a non-vendor specific property, this needs to be documented
> in a common binding. I think this needs a better explaination and
> examples of multiple chargers.
>
> Rob
