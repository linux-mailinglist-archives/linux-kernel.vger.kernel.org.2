Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F37140ED62
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 00:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241119AbhIPWeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 18:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241102AbhIPWeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 18:34:13 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77660C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 15:32:52 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id i7so24442665lfr.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 15:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vvjuc1s471hi8ZajeNQIG3gv1AZTpgaS2fHSkCO9Sdg=;
        b=SU/f5lVFG8+UduenFccb3j4t/4459qRZdQFoXW3xdfwGszV6YLPbsyZfOrGBKmzNXl
         Aryi+aJCoxa1YoHNGecjiRQOKIY67VrWWKG2E6dppRysGxE9ch4McoVq7pzN4y42cHby
         lprcUNOVw6E2K5i6Q8pV07ATIdO0//4IynMZKvlatXCtBV2DOdtoiPdU3559pPDtv3AJ
         0lVBWYiJeKQQzJwnQxH9r2gW3lu9WgPRd1ykp8QbAQXYaeMdqeVyk2wckMvd+HOXEke6
         MCIo0MtZ666Cp84+mscFmrrebmYXf20pWmYYy8rsqHqgWTDBOJXCoFK1G6zpOAGcZPSV
         E0mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vvjuc1s471hi8ZajeNQIG3gv1AZTpgaS2fHSkCO9Sdg=;
        b=ZENYf44YuqFrdR+mOmXou3gtxzIU/gaK/75wClE6sJwc11eEDmUyW7wcR9Ti1xaQFN
         JlBHqsg7xQ+84Jpt+/mwvC0FB/xghOQexB3uWnV3GtVH3mt/CNwnG6sUrBQKifmMDVl0
         jvNvH4JtfPHaAoM4dALJQrMsgqc1rwqlMiCa4U+t2tQt9cCgN0+TZCV20RrI3VFIaDUk
         uhNSaVpjlknM0XugKMzYJVpAUJP+gKcXo3h40pypCXnFGZZwCNV17O4ErwiU0Bqs3TId
         D4aia3oZILHn2qRQJVnGm+XTPc73dUaNgeA0/D+VnqH8UEPjZZURyOe03VlbWeTFzidt
         OcZg==
X-Gm-Message-State: AOAM5339CwDwf+pHSua+5qB5W6mlopu32Gch/NdJQaxnPTsFtjWv17kR
        tGe9wpWb7F6YtQIbgpPFPjcL8P6S0NP/RFo9glr9iw==
X-Google-Smtp-Source: ABdhPJwgjMmIQzlXmQHLtgvCZkUpo9vo2GfEJk26S1z4D0S2a9/AW/wcO3CNjhYEhcL3MTUShlwwpkmKAb3JFwEyBwc=
X-Received: by 2002:ac2:4f85:: with SMTP id z5mr5630159lfs.125.1631831570795;
 Thu, 16 Sep 2021 15:32:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210802215408.804942-1-pasha.tatashin@soleen.com>
 <20210824180555.GD623@arm.com> <CA+CK2bCakwsqS1RqXPJr+ewe=gsO98cOxhXye8-AcRLwtqhZ+g@mail.gmail.com>
 <YUMQZGLQl+82fL6G@arm.com>
In-Reply-To: <YUMQZGLQl+82fL6G@arm.com>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 16 Sep 2021 18:32:14 -0400
Message-ID: <CA+CK2bB-BV2tzeq8M_B+5M9YRJX-GmT-9ZM0fnvrfnuWhSk46g@mail.gmail.com>
Subject: Re: [PATCH v16 00/15] arm64: MMU enabled kexec relocation
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mm <linux-mm@kvack.org>,
        Mark Rutland <mark.rutland@arm.com>, steve.capper@arm.com,
        rfontana@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        Selin Dag <selindag@gmail.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Pingfan Liu <kernelfans@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        madvenka@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > In case we are so low on memory that trans_pgd_create_copy() fails to
> > allocate the linear map that uses the large pages (the size of the
> > page table is tiny) the kexec fails during kexec load time (not during
> > reboot time), as out of memory. The MMU enabled kexec reboot is always
> > on, and we should not have several ways to do kexec reboot as it makes
> > the kexec reboot unpredictable in terms of performance, and also prone
> > to bugs by having a common MMU enabled path and less common path when
> > we are low on memory which is never tested.
>
> I think this makes sense, especially since it will fail during the kexec
> load time rather than reboot.
>
> I'm ok in principle with this series but I'd need to convince James
> Morse to have a another look since he followed it more closely than me.
> Could you please rebase it against 5.15-rc1?

Sure, I will send it out soon.

Thanks,
Pasha
