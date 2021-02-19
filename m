Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC97131FF97
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 20:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbhBSTzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 14:55:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhBSTzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 14:55:00 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C5AC061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 11:54:19 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id w1so15596641ejf.11
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 11:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZjT0uVggNbwgGx3cUhsa/Lc/9GbU7e2hAEdj1ODBpfE=;
        b=a/1LBpSJMULVC3uKX+PgpfK1IabihJDp+/nfA+NlXqSyquvnxBqw6bfTtoSr63try8
         NzavLxZCnwD/D/Dn0XIX/B8HyNP0MHKaMN2iPhaDjBAktQc5jV28ufRdcn+f0he3IJFG
         yEJUedvLSVG1biOjYQL1ufg4gfvBfeY7jt1VMSIle4VXDkF6ft9CObg+PIy+/dmKyxFF
         nI7r0y/Hl5rRKwE8QpxjAcd+1s8crZFvsph9Zxy60RYnpub+NqkGUHEI0Oaqauq2T7n2
         c7uCC9rWS0HbY/FYLd/47R371zyK9XsJIid5L//VftSm9Prhl+IQi2bSo5MMw8CbSOlv
         vkWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZjT0uVggNbwgGx3cUhsa/Lc/9GbU7e2hAEdj1ODBpfE=;
        b=lUWPHCEEYZJmgAsbbYRKLEO21dgMncin+0XpvxcMS1E7Hwo3A1gVRpUY4WOHdjviSV
         gQpl64csyXKjS1dXRUCo8c7XuvcVAu7cdNqWEY63W3ajXRZ9wMeweWroztbnBc5dBVtb
         gKZ/+mZNNTjV5F11oM0qJncpmF8cT/xT5O1UclzaoIXB/yiP0DTgNGPvemcM+aEutzaB
         BZm3E7kjNqvA1gphr4pBgS6eV/jeHDgtQZsB+5/QSON+ChAybH9abxSH+Jt8RE3Np8+s
         rfoPSjNwud4bbqvsDBHiH9cxNVmIT6RXEl1AamLlymzsOTkEkvzIg5rY9oTuwUIL0deu
         +QMQ==
X-Gm-Message-State: AOAM531Dy/zIdCjT+dJFldEH9vrY/5agH65bkbqPag2tMAMhFXBrsK+p
        LepI8n/O5kuURjK8JBI3EiECQ9csGlx0DSzn1+1MTg==
X-Google-Smtp-Source: ABdhPJzDy3bqwBKuzzbRyTnwxvgTOaDw3KZ5xgs64G0spC9/uyZ+JvXTY8rwC930ccRsl+9qv3AZ8jzKwWF6xu2V2mE=
X-Received: by 2002:a17:906:17d5:: with SMTP id u21mr10422133eje.541.1613764458106;
 Fri, 19 Feb 2021 11:54:18 -0800 (PST)
MIME-Version: 1.0
References: <20210215185908.257724-1-pasha.tatashin@soleen.com>
 <20210215185908.257724-2-pasha.tatashin@soleen.com> <20210219175341.GC6352@willie-the-truck>
 <CA+CK2bBpXyobT=rjVtY_pFhug4RcveGk_XB4zDBTX=vZBOkaLw@mail.gmail.com> <20210219191436.GA6683@willie-the-truck>
In-Reply-To: <20210219191436.GA6683@willie-the-truck>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 19 Feb 2021 14:53:41 -0500
Message-ID: <CA+CK2bC0m5=1TW350hZfvd0poujaQ0VTOGnyeUc+sPvLfT+tdw@mail.gmail.com>
Subject: Re: [PATCH 1/1] kexec: move machine_kexec_post_load() to public interface
To:     Will Deacon <will@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        James Morris <jmorris@namei.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        James Morse <james.morse@arm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        kexec mailing list <kexec@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 2:14 PM Will Deacon <will@kernel.org> wrote:
>
> On Fri, Feb 19, 2021 at 02:06:31PM -0500, Pavel Tatashin wrote:
> > On Fri, Feb 19, 2021 at 12:53 PM Will Deacon <will@kernel.org> wrote:
> > >
> > > On Mon, Feb 15, 2021 at 01:59:08PM -0500, Pavel Tatashin wrote:
> > > > machine_kexec_post_load() is called after kexec load is finished. It must
> > > > be declared in public header not in kexec_internal.h
> > >
> > > Could you provide a log of what goes wrong without this patch, please?
> > >
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > >
> > > Do you have a link to the report, or did it not go to the list?
> >
> > Hi Will,
> >
> > https://lore.kernel.org/linux-arm-kernel/202102030727.gqTokACH-lkp@intel.com/
> >
> > It is also linked in the cover letter.
>
> Ah, great. Please add that as a Link: tag in the patch, and in-line the
> compiler warning.

Version 2 of this fix:
https://lore.kernel.org/lkml/20210219195142.13571-1-pasha.tatashin@soleen.com/

With the tag link, and warning in-lined.

Thank you,
Pasha
