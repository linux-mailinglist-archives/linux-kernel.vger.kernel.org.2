Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5244C3E14DE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 14:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241404AbhHEMhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 08:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240432AbhHEMhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 08:37:31 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03EF9C061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 05:37:18 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id pj14-20020a17090b4f4eb029017786cf98f9so9031260pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 05:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q2YXDV7/eiOsz+RdfvqIBMFLQSgaD3AIo5p13mxr6fs=;
        b=TYDIuOhc9quWsDJhIHvMu9yH6z3Tlgs/N5jUgUxE5l5+R9skl+ni+YA6FoSdT320D6
         OTQabJjyUqZgP9Pr7WLz7qfL/ocqaTgQQO1gdwJm9il4vf19nuhdNN8JGLlbTkWdw7dJ
         GrY9fdsVWqm0YO/TuvrlfyxVeC/oYRKBUqObn+aybmLzjsnoMGcNC+TIgkV8ABFIx8q5
         IP/P77qa9hxX+3JibroT8uzbezQdE2LTIjgu7reXD2UbiLFUioOfpezdSGp+c7TePE/A
         qOdbBNyT9ZNMQ0V7lcBRiF1wAyUHgPjNDzbVrTVvr1mZ4tH6tuzzLY22kvDxPBOdPHvC
         g10A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q2YXDV7/eiOsz+RdfvqIBMFLQSgaD3AIo5p13mxr6fs=;
        b=LgYMgwByj+ZKWrC5Qf7sjSgXVHxg9ZqGO0A9hquOm34dyAxTCbH36AD3duXrPpW5AF
         xvfzkGfkeKo11slr13M8x+QH8s6lDwj/+ui3yD+DDKXeYycx8b+++uGV6Ukkjj53b9Ck
         WOfpfLEan76t2ybi0vpOH8xy0sFpyIhgpOw5YFuizde1qwuomaDPvXymcsVMY+Q7N06S
         /pDcthvVWeTP+w23TaEkVb3vsE37j3R5hP+RXD0rnRBJ6+Hl6BzOERhxr6SQmM2lU5e7
         k42cxsXMXNexWZXIoxUbIJeNn+EujyOm7MDyR6O5352V1gPdYavMoQkXMBFtIPJHoczn
         Ka2w==
X-Gm-Message-State: AOAM53077AciMAOb04dwLQdf3YXscKFPuRlBVNF67CyxhBkY9aEIA7pH
        1LYcmWtk4TLGeGmOivTazVmkMfXZH5wG5OI1mlyPAtUuKmAi1Q==
X-Google-Smtp-Source: ABdhPJxUF+xyeus5HBOYkG5CKzPEPP88JY3Zsh2ItnOjHMSm14sy6km+w7mlZg6IG7CxyWUqjnZ8I3mNNvBitbE4T9A=
X-Received: by 2002:a17:90a:1f49:: with SMTP id y9mr15060436pjy.225.1628167037508;
 Thu, 05 Aug 2021 05:37:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210801190437.82017-1-phil@philpotter.co.uk> <YQvAyd2meIE8btpR@kroah.com>
In-Reply-To: <YQvAyd2meIE8btpR@kroah.com>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Thu, 5 Aug 2021 13:37:06 +0100
Message-ID: <CAA=Fs0mViTb_vys9t1DKhFW-1fXxhLRuJM8o=BWqT6MrY9BXsQ@mail.gmail.com>
Subject: Re: [PATCH 00/15] staging: r8188eu: remove core dir RT_TRACE calls
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Martin Kaiser <martin@kaiser.cx>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Aug 2021 at 11:43, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sun, Aug 01, 2021 at 08:04:22PM +0100, Phillip Potter wrote:
> > This series removes all RT_TRACE calls from code within the core directory.
> >
> > Phillip Potter (15):
> >   staging: r8188eu: remove RT_TRACE calls from core/rtw_cmd.c
> >   staging: r8188eu: remove RT_TRACE calls from core/rtw_pwrctrl.c
> >   staging: r8188eu: remove RT_TRACE calls from core/rtw_wlan_util.c
> >   staging: r8188eu: remove RT_TRACE calls from core/rtw_ieee80211.c
> >   staging: r8188eu: remove RT_TRACE calls from core/rtw_io.c
> >   staging: r8188eu: remove RT_TRACE calls from core/rtw_ioctl_set.c
> >   staging: r8188eu: remove RT_TRACE calls from core/rtw_mlme.c
> >   staging: r8188eu: remove RT_TRACE calls from core/rtw_mlme_ext.c
> >   staging: r8188eu: remove RT_TRACE calls from core/rtw_mp.c
> >   staging: r8188eu: remove RT_TRACE calls from core/rtw_security.c
> >   staging: r8188eu: remove RT_TRACE calls from core/rtw_sta_mgt.c
> >   staging: r8188eu: remove RT_TRACE calls from core/rtw_xmit.c
> >   staging: r8188eu: remove RT_TRACE calls from core/rtw_led.c
> >   staging: r8188eu: remove RT_TRACE calls from core/rtw_mp_ioctl.c
> >   staging: r8188eu: remove RT_TRACE calls from core/rtw_recv.c
>
> I applied the patches here that I could, others conflicted with other
> changes I have taken recently.  Can you rebase and resend the remaining
> ones now?
>
> thanks,
>
> greg k-h

Dear Greg,

Many thanks, and of course - will be this evening though after work
though (BST). Hope that's ok.

Regards,
Phil
