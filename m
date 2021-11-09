Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A515A44ABAB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 11:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245402AbhKIKlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 05:41:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245397AbhKIKlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 05:41:49 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CF3C061767
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 02:39:04 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id n66so9306149oia.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 02:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ldgJhtLFT98IBkIN1jWhNxilrDTjAfTFkN6Noabtt8s=;
        b=eU+GfyOuNrewm46/XocyhyP7jDs9h+Uof603d8VUSQt1YbaN/QwogqhWggGClHuQ2U
         /OowXIFSFMsDkC6banVX49OJBv7eV6imZuWS+Jt7ZHVqRi1v6PGClRXd1greAa7ZzHxQ
         Cy3BOfTuHZKx4wqbpPrXC552B+Jzt1LLGXzmvaahD6qq7arTprYcymKTj0wKQ5PuMjdO
         Qg9tr52gjeNsS8z2tEtVNGxG518R/7KAslWxgmjq9P1z783VX+n0Nb2UEL+0Uh4vuoaj
         pDZti3XOHfc6ICIn1v4nKanlzq7dhaeXfu8+1mFBMMK8b2kS5GykWkRGjO29MzXEg7//
         9qeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ldgJhtLFT98IBkIN1jWhNxilrDTjAfTFkN6Noabtt8s=;
        b=aJMPNJwotpeHuiT0O+AtPFLmN2PccV36lvRGv3mdYWebduxVyZvM2zDUqOI3hhiWzF
         QEEscPowskr6QxQeNWz7paKLTnnPpFa1du3ditcwsOrHcf/WBXX3Qsq0ItyCA2VJxaEM
         I1wS5Dzl7ojyM86IYznKvU+KeJjtOZtYyv1NkJ18vA+v+LI44UO9UMOVz0iwVpIPUjEm
         MzHXqGRtpMWYoqljBQfaCwBmDGIuiaL7Cdh46y4pllBalEjv91FoddCBj/wgUBUuxeFh
         dtGi/MEIAnlFklStcRduOpfG6NzkfV8dRJecUqyWnTSxb64vjurQ19BAv/AXt61iCZaE
         Y51Q==
X-Gm-Message-State: AOAM531h4fb3pWgGufGDzEbCnMOxJABRxpO6XQf2Noou8KCvVIN8bLNa
        xkF+2Icp7RTy1KqpOlZe7g12jTnN58xN15R/8Qo=
X-Google-Smtp-Source: ABdhPJz3dUGDEu+ecIq5E4sl55WZkP1F4xHRHYR3fbmJxW7lit1tyU/mZwOHfaSgmj/jcLxSzgC6IDcK13MQ6YZrnR0=
X-Received: by 2002:a54:4e8f:: with SMTP id c15mr4578133oiy.113.1636454343540;
 Tue, 09 Nov 2021 02:39:03 -0800 (PST)
MIME-Version: 1.0
From:   Vihas Mak <makvihas@gmail.com>
Date:   Tue, 9 Nov 2021 16:08:52 +0530
Message-ID: <CAH1kMwT9hZSkFZdjyu3Gybiqqx+Rj0Unmg0+FpY4eF0VQmfs+w@mail.gmail.com>
Subject: 
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        sudipm.mukherjee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Nov 09, 2021 at 12:28:18AM +0530, Vihas Mak wrote:
> > Make sure the mode is a valid IEEE1284 mode.
> What is a valid mode?

The valid IEEE1284 modes are the ones defined in
<uapi/linux/parport.h>. Currently there are 10 modes. Namely nibble
mode, byte mode, ECP, ECPRLE, EPP and some specials.

> How did you test this?  And why is this needed now?  What hardware was
> working that is now not going to work with this driver?

I tested this on my local pc using a parallel port and read the
incoming data on my Raspberry PI.
I also used https://github.com/strezh/VPPSniffer. It's a simple
virtual parallel port used for debugging and sniffing.

The mainline code wasn't validating the mode when a user-space program
does a ioctl call to change the current mode. It might
create some bugs if the new mode isn't one of the IEEE1284 modes
defined in <uapi/linux/parport.h>. So it's better to throw a EINVAL
beforehand, if the mode is invalid.

> > +static int pp_validate_mode(int mode)
> bool?

My bad. Will do a v2.

Thanks,
Vihas
