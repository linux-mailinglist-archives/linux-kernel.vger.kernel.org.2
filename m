Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D23703899D5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 01:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbhESX3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 19:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbhESX3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 19:29:11 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D961EC061760
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 16:27:50 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id i9so21578119lfe.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 16:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JJEJbgRPnMBu2f8ndkVjFvRlGE1bDrbkWqaeWQqS4qg=;
        b=bmyI9zT7D6VywVO0FZYWVtTHDbNrUjUkXVxolFMUdDeEnMBLdC7WLCM/qVZf0gLrkB
         38HpWU/YBYXIVw+em1s8JK6FdLxutwITf2ueNcN/OWecZUzx/KS1Owa3erdFfzZ+6Hav
         wu04qZHdyorG6YixuVe8bV4KC7/lhYqGR6n4nUKIVpoy/qnlZLarxH5nK/Dvrv4Thd9v
         z/rT9lCJaKw1mGQhS78Y3ElvmGHjB0ZaByGVboZCovpnGqQbItihDjlHUJa7jbsm5Kni
         axIuR+6wNTXGZ4a/azftCRWKmCsWltEhdasogAMhU6AALm/SucRIVdDJ3C+/LAocPs+Y
         Gahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JJEJbgRPnMBu2f8ndkVjFvRlGE1bDrbkWqaeWQqS4qg=;
        b=qqO6iW6hKBl0SSh/ItW4R4OGb3g5Bx5zsQJFRPdEr855+vUhsN9nEWCqw1tzS/I1Zz
         QNAl62ZsEFwbo1N5cvrVIK5Oq8Y6cPlq7T8JprPPM+D5xkJB0ow/TND/jNQmVV2iSfyA
         AmN7KUaEfM/BZ2rkyc978H36qb//wnTWEEP6fkJXaEQb5kjAQG2VI8jGX+vNJhPBz8Py
         ZKvq4FZ9qVZq+yQoD/oiuEg4hW3htp57Vb/Q2zbHrIjSgaKuK4dp2EN681amlB1oaJSA
         9z+hpF0SUsyd9hbWCWJ8CdUYoWgVoCOAWfCIcSqdgm0lOGRPw5hNg3ZKY1HieFoVQ5Qo
         pemA==
X-Gm-Message-State: AOAM533VdPBy5tTzVaCNThmr1HR9CY8PX1roiT+FPBqdaU/5MoLrqw5b
        aDPG32Yp1LHmgUbWaqMUpOpIFHXDmmYLFLML7ImbpA==
X-Google-Smtp-Source: ABdhPJz/cPPzI7GxXKzBS+Gom60rdG2Gq8Pyt5scUUUDZl7Es1gZjna7v+VwnSx19MRL4DcKqfOm3IcmAfkZkzaM/VM=
X-Received: by 2002:a05:6512:1185:: with SMTP id g5mr584031lfr.586.1621466869121;
 Wed, 19 May 2021 16:27:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210508142000.85116-1-kettenis@openbsd.org> <20210508142000.85116-2-kettenis@openbsd.org>
 <20210510141955.GA58072@robh.at.kernel.org> <5612be5a12568600@bloch.sibelius.xs4all.nl>
In-Reply-To: <5612be5a12568600@bloch.sibelius.xs4all.nl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 20 May 2021 01:27:37 +0200
Message-ID: <CACRpkdYPsL+5ZN3WOovwqkGydaGoJZCskwMkT6rhZ1BYpYVgrw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: Add DT bindings for apple,pinctrl
To:     Mark Kettenis <mark.kettenis@xs4all.nl>
Cc:     Rob Herring <robh@kernel.org>, kettenis@openbsd.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Hector Martin <marcan@marcan.st>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 7:06 PM Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
> > From: Rob Herring <robh@kernel.org>

> > > +properties:
> > > +  compatible:
> > > +    items:
> > > +      - const: apple,t8103-pinctrl
> > > +      - const: apple,pinctrl
> >
> > A genericish fallback is maybe questionable for pinctrl. That's not
> > often the same from one SoC to the next.
>
> Krzysztof raised a similar point.  It seems that Apple isn't in the
> habit of changing this aspect of their SoCs.

Rob what's your stance on this? Does it need to be changed?
Else I'll apply the patch.

Yours,
Linus Walleij
