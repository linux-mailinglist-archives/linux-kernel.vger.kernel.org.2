Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A06D308C30
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 19:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbhA2SLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 13:11:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbhA2SKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 13:10:52 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1BDC061573
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 10:10:11 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id l12so11518858ljc.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 10:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XVOCIIwRZW7pyORAPqpv4IHLJXNwE2/mM9ZYH/3WmsQ=;
        b=NTROUFN2LEiEsHdg5XnGTm6I5Afl4pwz6pKlcEPZT0RyJVjc58G6+SGiP71r700CuN
         hM8zr6hFz4QnimUkvgEYnHzkHKB2tHejRtA5dE8bdOpqGd/oFfMJLinaRj0ahT5k1XUQ
         HCSE9qonS0anMseaesWH559kHUgL8yJVkkEQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XVOCIIwRZW7pyORAPqpv4IHLJXNwE2/mM9ZYH/3WmsQ=;
        b=dHvZYgvgZ95e3l1vXGfoIm5/E0W0Pi8ZQ4p1fG9LZ/PZLQFL82S+gxFN9RRxOrmF2a
         PMbmPOWVScLEK/j5jmRfOAtOBOkShLUrlia/1wfdjejdBaS2jw1aaAVfJy+b9Kd+kVcH
         u8B276wLoDzbAPaJqjiXSEYux/4M8ra6pntLbif8AmFQDCOcH0ocAeJ8CNWYR2nxIBQ+
         3JzW1stilwO/gE/OWSh2ppX0FgPxd7Wz+gqKcVw91tlbp5ve0jUPvtxj4TiwGqeEZy/A
         wdLPufUCXdyuohMKEXug/OHLnEv+hnCmMeb01twKHUBX3XgyYT55r4daAi7apTM9NmuR
         jF4g==
X-Gm-Message-State: AOAM530xTedTSaBj6JjEwklqFw1L2D9ezpU+xxZGKebt/i/PpQOk3CYi
        GJRCARSHnu2LID4vd1/SNEW/VmW9NAfrVg==
X-Google-Smtp-Source: ABdhPJxGebdNaPs8bihFEVO2PDjb9aMQkXw5+1Zt25CnrE7IEu+ngd8NSpzU+M4Nduf/AtjCZ6yOWg==
X-Received: by 2002:a05:651c:c9:: with SMTP id 9mr3088416ljr.102.1611943809174;
        Fri, 29 Jan 2021 10:10:09 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id 135sm2090019lfl.93.2021.01.29.10.10.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Jan 2021 10:10:08 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id e2so10108003lfj.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 10:10:07 -0800 (PST)
X-Received: by 2002:a05:6512:516:: with SMTP id o22mr2265823lfb.487.1611943807448;
 Fri, 29 Jan 2021 10:10:07 -0800 (PST)
MIME-Version: 1.0
References: <ce392dc6-d77f-b74c-8569-9a04ef8ad2d6@redhat.com>
In-Reply-To: <ce392dc6-d77f-b74c-8569-9a04ef8ad2d6@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 29 Jan 2021 10:09:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg6AG=1YjDC2gSspPYjEPWqDXkXaiaoPZS6X=Rg_XRUsw@mail.gmail.com>
Message-ID: <CAHk-=wg6AG=1YjDC2gSspPYjEPWqDXkXaiaoPZS6X=Rg_XRUsw@mail.gmail.com>
Subject: Re: [5.11 regression] "tty: implement write_iter" breaks TIOCCONS
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 29, 2021 at 6:54 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> While testing 5.11-rc5 I noticed that flicker-free boot was no longer flicker free,
> when plymouth loads and tells systemd to start logging detailed messages these start
> showing upon the fbcon instead of being redirected to the ptmx which plymouth is
> trying to redirect the messages too.

I think this should already be fixed in current -git by commit 9f12e37cae44.

Can you check?

               Linus
