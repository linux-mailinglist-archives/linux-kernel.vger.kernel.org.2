Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3871A3FA4E4
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 11:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233732AbhH1Jxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 05:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233643AbhH1Jxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 05:53:45 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115CDC061756
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 02:52:55 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id r2so8320487pgl.10
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 02:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pd1wCrv5QkKvtZBw69zGwhPRLcGnV5BAovXo/G5QtIQ=;
        b=utyuOi3XCxSXBhZgl5UWLcgYduC30cmHQZSw/E2Y+S2UCPBEObLDDqpQjfl9N7xaDJ
         dKNDujezutBIeMT6i+GA7B6gWr/RSr9Z90OpbezRMdwyXeijpb5QR61OnNvBUM5lczDr
         Dhc32SX+qFDRG3bEzoKz035GLN1lKJtco/4+08GKge7tSTFjLKcTI+e5vwiEnEHK2txR
         4EX0ttwj6KBETNkzEIzHtBxmmLXPPsPlBX5j0c9s4+tzVpV6RUqt9+I5DXB0c63pQNhL
         AcBWv3nxbPgn+uo7TQN9tJ+qDFOz1A4agl2vgyfgtJp+Z04noT6ybsbLhrfN0dn7eVGJ
         LoBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pd1wCrv5QkKvtZBw69zGwhPRLcGnV5BAovXo/G5QtIQ=;
        b=Z/PMvHrDXe5EABDScduYllbqyNQrOhw3ubl3CzTUeF2asX2gD6HkTpjubys+E8d/Ol
         Qnbs5eI65Z7+HAxI+wMSAugqQy8NPBDgTdwh2Zvuu/zhUuRqO5v53KSOUUrBYMbS7+yr
         aJERjCPQVAXQFPUUugDEMAyWF8PurbnyHAJzQdSnkVdqZIPbvaGu54IPGmpGckiq6c69
         mB5PbUtybGAW2IyLKSv118ZPSw6tGlCyHVsYeqAug17w7eBtoFgJugmWRcXMXeM+CaDf
         6X4ItgTqA47qhbi/tGDFsrgO1T6aDNRK9t533JdW4taRMJLaVINq9fFGJwJGjIjCtqMz
         dl7g==
X-Gm-Message-State: AOAM530Of56TP6Zxa2m3OdnSKx5fXRKcJ76PWWlcUPkVf/cI+v5Md+4I
        raPxTBI8viQFUJRo1J4VFCVQBQ6IJeqpyOb963I=
X-Google-Smtp-Source: ABdhPJyPqZAqmbXScWQg5cLYruq4coSBIYlnDbPPp1EHZ1lnp9ZAUAaJ6r8PevXIREe5PV5n0Ogu1rd5PVi8xD4MgVc=
X-Received: by 2002:a63:fd12:: with SMTP id d18mr11813885pgh.129.1630144373739;
 Sat, 28 Aug 2021 02:52:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAPGkw+x+B1731SL=afoSKiWwH-n-FA5YJ+WOwYdv8iyFhWk1zA@mail.gmail.com>
 <3634721.RBzQ2xsved@localhost.localdomain> <1742120.GgyQvu0Ciu@localhost.localdomain>
 <CAPGkw+yJ=V0OwFE+uqCeWWS8JbJD=YBE3+Uk-OKpmHRnvSTh+A@mail.gmail.com>
 <CAPGkw+w-y+iC3dMDLxi8DR3N+jf8roiJ2Vs_-uHxJ=i57eTiUA@mail.gmail.com>
 <CAPGkw+zyj4e-m19KdrHpAN_vHksNDy=k_cPPAftSN-hNoph0=w@mail.gmail.com>
 <20210827233835.px4az5hyqks2n4o5@h510> <CAPGkw+wq6LcVXSmuoDcTqOo=ULBBT_4DVXqXnpf7S5GW3Vzy2w@mail.gmail.com>
 <YSoF+VcDuW/2ojjF@kroah.com>
In-Reply-To: <YSoF+VcDuW/2ojjF@kroah.com>
From:   Krish Jain <krishjain02939@gmail.com>
Date:   Sat, 28 Aug 2021 11:52:39 +0200
Message-ID: <CAPGkw+wcZRcr0W2ay6ZJY5yW7-EEMpK-yH-3j=UkDpj3kA-ySg@mail.gmail.com>
Subject: Re: [PATCH] Declare the file_operations struct as const
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2021 at 11:46 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> A: http://en.wikipedia.org/wiki/Top_post
> Q: Were do I find info about this thing called top-posting?
> A: Because it messes up the order in which people normally read text.
> Q: Why is top-posting such a bad thing?
> A: Top-posting.
> Q: What is the most annoying thing in e-mail?
>
> A: No.
> Q: Should I include quotations after my reply?
>
> http://daringfireball.net/2007/07/on_top


Now I get it. I've never used this style of email ever before so am a
novice. Forgive me. Also I didn't get what you mean should I include
quotations after my reply?

> On Sat, Aug 28, 2021 at 11:37:50AM +0200, Krish Jain wrote:
> > Hi. Thanks for your response. Changing to  "const static" would fix
> > the first error but looking at the second error indicates that it
> > can't be a const, right? So checkpatch.pl was wrong?
>
> checkpatch.pl is a perl script that does its best here.  You always have
> to then look at the code itself to see if what it is asking you to do is
> correct.
>
> And you always have to at the very least, test build your changes to
> verify that they do not break anything.
>
> thanks,
>
> greg k-h

Thank you so much. I didn't realize that I could have tested it by
just building the driver and not the entire kernel. Anyway, I'd still
love to learn more and contribute to the kernel. Where can I find
"small fixes" I can make?


Warm Regards,

Krish
