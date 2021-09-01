Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E51A3FE19B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 19:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344953AbhIAR6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 13:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235811AbhIAR6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 13:58:49 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7CAC061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 10:57:52 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id s12so557835ljg.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 10:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e56BZ5hXZwdZQAhiBk+g+d3p7hy50ZxnDyqlFRLPbEM=;
        b=RQ09MJkGQrhwqn/8fWS6q3ZRok81XPPuE9PHGsJAPyM9/fsl7dQy8cQDsJzGPFWqOI
         TW2C/QFJL9uWMi6kMns1ljR6PA1iLPxony2Q4uzq4iH0xlbwuya43BLSz2XR4OP2tRA5
         LX91IISfhrJsw0PoemGcrYNwtU7KOuq7Vkx+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e56BZ5hXZwdZQAhiBk+g+d3p7hy50ZxnDyqlFRLPbEM=;
        b=JLFwScuHixeJv2Z0PaS8JU1WwlW5tSk9lHB/zO9LByF7UpxHiQ15tEMDumNWqqW9nD
         pEG4urgIgpBXccDFnW/QXZ9zoBpYaVOHZfGX6BjDKPaJU4LrvD9ddfxA5NdOx9ADNJ2J
         /abwKdgsqN+tm354oZy5OV7y2R4Spy/V62tn3VGIKUTQ2y5VB3+mHM53Sd/ynFzgcK7s
         3TB7ZvVm9ADpjqr1HTOGkHa503bONyYQpv9hjwMUfs2GzTzW49+ezc9Rjz3td5m3hrtx
         wxcKp1f7kEEHgjFExlOmChHjWx+MBck+dfl/PZdPILEkivmn0gf+mA2OSWh5WKmPJIRV
         n3Lg==
X-Gm-Message-State: AOAM5304Ms3wAEw0J/qPDHGAqpyFlNZ1zyNvuZ2cy7ZlyoNkvMLXXBcc
        602L7bw4U0JYi/RLAR4fDZomjQxZVr/amSnc
X-Google-Smtp-Source: ABdhPJx0LFreWgVml0Up9cWK/8S4XmVrYKlUkOb8ekWf2Y8YNLKn1RObODLsXpCBhU+cGCJYx66GYg==
X-Received: by 2002:a05:651c:490:: with SMTP id s16mr743783ljc.214.1630519070436;
        Wed, 01 Sep 2021 10:57:50 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id u20sm39985ljl.76.2021.09.01.10.57.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 10:57:49 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id m4so437887ljq.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 10:57:49 -0700 (PDT)
X-Received: by 2002:a2e:84c7:: with SMTP id q7mr737503ljh.61.1630519069193;
 Wed, 01 Sep 2021 10:57:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9txeN-qCRJvYV552zdo2H9iVy1ruVrq=YdZBP5Dmpc3Jmg@mail.gmail.com>
In-Reply-To: <CAPM=9txeN-qCRJvYV552zdo2H9iVy1ruVrq=YdZBP5Dmpc3Jmg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 Sep 2021 10:57:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=whP_v5nrK9B5vefnZS6Xz3-vZDFxUvSmW8W82hhNh67sA@mail.gmail.com>
Message-ID: <CAHk-=whP_v5nrK9B5vefnZS6Xz3-vZDFxUvSmW8W82hhNh67sA@mail.gmail.com>
Subject: Re: [git pull] drm for 5.15-rc1
To:     Dave Airlie <airlied@gmail.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2021 at 10:53 PM Dave Airlie <airlied@gmail.com> wrote:
>
> There are a bunch of conflicts with your tree, but none of them seem
> too serious, but I might have missed something.

No worries. I enjoyed seeing the AMD code-names in the conflicts, they
are using positively kernel-level naming.

That said, I wonder why AMD people can't use consistent formatting,
mixing ALL-CAPS with underscores, spaces, whatever:

        /* Sienna_Cichlid */
        /* Yellow Carp */
        /* Navy_Flounder */
        /* DIMGREY_CAVEFISH */
        /* Aldebaran */
        /* CYAN_SKILLFISH */
        /* BEIGE_GOBY */

which shows a distinct lack of professionalism and caring in the silly naming.

             Linus
