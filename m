Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47B1132F44B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 20:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbhCETzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 14:55:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhCETyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 14:54:52 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F21BC06175F;
        Fri,  5 Mar 2021 11:54:50 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id s1so3070022ilh.12;
        Fri, 05 Mar 2021 11:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=AzEV7WVkaHzKrivdnoz3PwqYrSVrDPw6ZX4edvYhGy0=;
        b=OxP9ZE/4/R/ZdsyB+lwleaNyJYOcXrfYpWjK1XHZUZEfzwVaDRLQM+SXdlIMHlEoCO
         fYJLd238+M6m/3lULyoogj68UJIbvh7y4cyJAFjp/g1zXRiaWsXuwxvTR4EWrdb3Civq
         C1vX/msKbZksOSIh22+lWw3gvPGyIE0oYOqm3xwWy+UwmlwQjLVuTV4j+UpgseW44F1Z
         Kmqz8n+RGZ9A5U/U74nBSoVP2e6wEmJn4ZYfkFBUYkcfpoNHm6ihIa8SCLSUr1kFalys
         aCalSzfNbWKUbHm53Xg5XVbkxec4oN48D4YA0qsz/InhUp8Cdp8HkfTVRn5viWpWQm2T
         V7AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=AzEV7WVkaHzKrivdnoz3PwqYrSVrDPw6ZX4edvYhGy0=;
        b=gdl//QI2HIKT4yoazPwbvbBT14SeJQEEtlLiM56oj4VVQPMAltr1wv7cFm+oRPmDxk
         0Ej23kQWwt6lwyT3rzZabzLQ2HqOQpgVNyahWo9sAKmyu4oBo7OsZdJUMf6WzrhTlE8i
         4SnHBBqQ+lm2a6z59s9GR/Xb0goORt8YNEJRboGRFk7dUfg4qSLAE3mc2Nw/cj2evbNQ
         zR4nu0NyhZe5Nn0TlWpc7VAgRUAjhCrPAc0RePMofU1YSlIX0C7cIYQeFbXm7ypW5hUu
         OACIhrG0j+maQfFzBJBlQWUjQXFR/FGeCZ1EcL/kQQouPZ676PK5gzClzwaGFJP1A7w6
         8MpA==
X-Gm-Message-State: AOAM5301KOlySRdomqHfBiCSN4WNucCG73aCCqlIzCy/w7oyv4k+cIUm
        pXsXTEPpoE3DS5xKUvgv+hozzje0q7zbg0DyOE3V1jkpe7xZcw==
X-Google-Smtp-Source: ABdhPJwYItrSorrg8u39WbwkW+k7wVTmumsurgXSb5SwEX2J+kBZnL/FhDlx2Vs1lknEdUHUkg2C71lXaTajNpm6Gwo=
X-Received: by 2002:a92:444e:: with SMTP id a14mr10146232ilm.215.1614974089395;
 Fri, 05 Mar 2021 11:54:49 -0800 (PST)
MIME-Version: 1.0
References: <CA+icZUWJyPTefHkGEgQtDO9TOM4CN_b2qPJGQVF7NE=Q=fGAEQ@mail.gmail.com>
 <CA+icZUUzBvmi9SvJ4Bh8ER_+Rkm9vv9FkKwoS8ofmRsko_fJhg@mail.gmail.com>
 <CA+icZUXCgW0bPcqNf+DSubBciQeBMbNX5zbjkMXinqRdkE1PfA@mail.gmail.com>
 <20210301155321.GA1490228@rowland.harvard.edu> <CA+icZUVpQtsq8y=rjR3Ad_G1VXWpR4D4xao8DGUkRiuxoT+cPA@mail.gmail.com>
 <20210305160728.GE38200@rowland.harvard.edu> <CA+icZUXnjDwyKEoX_7KOaVd=PpvEQhpJRvwZbW_xocDfXZpUzQ@mail.gmail.com>
 <CA+icZUUFGh5CWH-UJK4T-h_Qd2KNnOCrGuT8fg0+Fvjm0C2kbg@mail.gmail.com>
 <20210305193003.GE48113@rowland.harvard.edu> <CA+icZUXUAVAusGBKSAtUEN1kH2PLchpi0cU+w-m67QznA7+F4A@mail.gmail.com>
 <20210305194745.GF48113@rowland.harvard.edu>
In-Reply-To: <20210305194745.GF48113@rowland.harvard.edu>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 5 Mar 2021 20:54:12 +0100
Message-ID: <CA+icZUXEWh6G-Bm9-2F1X=S=ZYog37PiaMWHUjZWs1g-KDOqJg@mail.gmail.com>
Subject: Re: [xhci] usb 4-1: reset SuperSpeed Gen 1 USB device number 2 using xhci_hcd
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 5, 2021 at 8:47 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Fri, Mar 05, 2021 at 08:41:40PM +0100, Sedat Dilek wrote:
> > On Fri, Mar 5, 2021 at 8:30 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> > > Okay, that indicates the ATA commands are being sent not by the kernel
> > > but by some program.  I'm not sure how you can easily find out which
> > > program; probably the best thing to do is turn them off one by one until
> > > you find the one responsible.
> > >
> >
> > I can hardly imagine which user-space tools other than powertop can
> > interfere here.
> > Any ideas?
>
> No.  Especially since I have no idea what programs are running on your
> computer.
>

Are we talking about things like gvfs - udisks - fuse etc.?
All running via systemd here.

Here I am using KDE/Plasma as DE.
Unsure if this runs apps in the background.

AFAICS I have not seen xhci-resets with Debian-Kernel 5.10.19-1.

- Sedat -
