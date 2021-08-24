Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE0B13F6B74
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 23:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238684AbhHXWAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 18:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237178AbhHXWAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 18:00:31 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B30C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 14:59:47 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id mw10-20020a17090b4d0a00b0017b59213831so2798380pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 14:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dV2HwutanGEMSVTHUYToK72cxw7X/GcO81aNccR4QPw=;
        b=F6A829Luql9VwPos1+eSZTb1jv9suIGsQ9Es/k7eT5czwSSzFPjXCHwEWL9hVGWdAq
         33f0ohCHpP1vvs2j64TxoV4jl+0Yy8kb94m3ExVE3r0qKi7eNLA6W9jAVjLNwBDJGH9a
         hPyZEoKEByq9JI3IKvR/mwExVEmxB+ZmuR+RsGwupQZEshercoENGqNV3anIoWQSqYCj
         4wOB+Os0rKDK2gE3ZmtBvRgwZUC2o4rl+vVU7ebW5rMDPcOxDKuUvm3lzAayX8FFe+Qq
         FomCB88pOL9+7Ur0jMnIa4jipU1xPjE8pwfR8H9k9TDQUlG0LMPHuxwmmR49B+ZEf74+
         CRyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dV2HwutanGEMSVTHUYToK72cxw7X/GcO81aNccR4QPw=;
        b=od5LwUa26zOg8BRDbuXFEO2MnYabFfkpEBuAetHTrRNSe0I3QJUwtKdGPeryxMvLhc
         1BJi3hDVbIfZAiyEPBIEI4qSL//KU9hP7hUZM9hohyaKadsXAieuj/dGyLzTYcqqCC9U
         zyr12OQjNUXfPRgbl72DoONb838vA9pYoO5pUQLiwkmVHOofe6fa+qmZP4Y6EueB6svo
         x6QxWigdcHDpbgQ/QbP96Q193FlJWFSOkulCnQi9iNBJY5L7c/+HOlxaXo4IXRUIFdw2
         n0N0ao8RfqaFIqiWfTbeMPjCo4eXEYqBIhvfYcMi0c8ldFC6Srd4RRuHLLyInUNIpwfl
         4htQ==
X-Gm-Message-State: AOAM532EE5q+lJslp+LrlBIkT2DYxKn/GhX+Yo0OX3OqJFaFoO/xMM0s
        s/gvxjvnEbcKcBJIbqUTgKC2omFu4OX5VbSh7xswf7Xwxuu8uw==
X-Google-Smtp-Source: ABdhPJy+DLYO6OTaxf0RcnvBKHSGXpxxWYAoSxW3W2cKgQDk6nNLo91Jd1N006ED3qUtEDGro0cCfvrbp1EZ9B4HOLM=
X-Received: by 2002:a17:90a:1b2e:: with SMTP id q43mr6727425pjq.217.1629842386524;
 Tue, 24 Aug 2021 14:59:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210823223751.25104-1-fmdefrancesco@gmail.com>
 <CAA=Fs0ki91VvBOd2Wd59KqeCN+BmF-eWv+r0sH+e3fUG61Zxsg@mail.gmail.com>
 <15825589.4VbMHeJK9p@localhost.localdomain> <1815496.OexNakQ7IY@localhost.localdomain>
In-Reply-To: <1815496.OexNakQ7IY@localhost.localdomain>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Tue, 24 Aug 2021 22:59:35 +0100
Message-ID: <CAA=Fs0k1RWbHqzW73rox+yN+rMiP0sDeMFdiVCjL92XFJ7=gZQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] staging: r8188eu: Use usb_control_msg_recv/send() in usbctrl_vendorreq()
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pavel Skripkin <paskripkin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Aug 2021 at 02:38, Fabio M. De Francesco
<fmdefrancesco@gmail.com> wrote:
>
> Dear Philip,
>
> I think that I've inadvertently switched the order by which usb_control_msg_send()
> and memcpy() are called. I'm very sorry for not doing my tests, but (as I had said
> before) at the moment I don't have my device with me.
>
> I'm about to send a v2 series.
>
> Thanks very much for testing on my behalf.
>
> Regards,
>
> Fabio
>
>
>

Dear Fabio,

Just going through my e-mails now after the work day, so sorry for not
replying sooner. Don't feel you have to apologise for things like this
honestly, we are all human and there is a huge amount of churn on this
driver at the moment. I know there are subsequent e-mails indicating
this was not the problem anyway, but in any case, I am happy to test
when I'm able to, and don't worry if it doesn't always work - my code
is guilty of the same thing constantly :-)

Regards,
Phil
