Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92F5C3CFBAB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 16:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234333AbhGTNbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 09:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239552AbhGTNT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 09:19:26 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C27FC0613DE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 06:59:13 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id c15so2531690wrs.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 06:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=4PzjYhUEKqwf9rpMim3c4GSraf9DBD8+oBQWlOrJstY=;
        b=AI35rGqFmoDtZhMThgKNFgUNoYDIf/Mv9ZklyKOQZalq+AMl7YLVcjrZWirr9cA4yo
         sKbC4G1SWhrZuNvvWd/s+tASUCHW2urdvLdU/fGsg7m7gz4UJqkLwhSo75ZdBcWM5aan
         ACfNWR23Qn0SiA+6OIT5YQxeAfXWZ5CXMJ0s8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=4PzjYhUEKqwf9rpMim3c4GSraf9DBD8+oBQWlOrJstY=;
        b=BncrXl6p74r7tV2TnIgo8PLTDY+x7CWAIqtnCXxZY1wO3cjRlHFYljpVeQAZHOAkcD
         LV5ReS3uLfXbEXbArs23awHA+iaLD6ZTv6XeCHRuzYBX7j7tcgSUDIdamyaafILYyn9f
         0aPBM1J8XaVQKsFba7ZgOYOtDDqR5sRs7asvEoa6qYxAvLQy03gl41f/trZYcU70ioU8
         d+vR4EubsDlRZOWR4ezGDC6EYetNKG6NUV5ZJRcnQeZob5h6Do3uj9QCqhx/AdanMCIh
         YLLNWUs8Q+owB5tT5aGR+5WhMj/n1AMgzdlMWm66wbMB8IOIYdm0O/mh2F3+YGMvOwDO
         Gpkw==
X-Gm-Message-State: AOAM532rqKvzECwIIaDKmDG0m/f8INYS4QCbxv53UuNnEh3Mg9PJQF3X
        QWr9nFKaP/NGTWe+cxfQzeSLBw==
X-Google-Smtp-Source: ABdhPJwsdFs8q+1yTXrNA7AHfumD9vqplXTE6zNI6BrnjDfVy+jzMEAdzrUlq1Fu/ILnx4cnr5axUA==
X-Received: by 2002:adf:f405:: with SMTP id g5mr17004193wro.277.1626789551781;
        Tue, 20 Jul 2021 06:59:11 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id u2sm2632333wmm.37.2021.07.20.06.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 06:59:11 -0700 (PDT)
Date:   Tue, 20 Jul 2021 15:59:09 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Dave Airlie <airlied@gmail.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Catalin Marinas <catalin.marinas@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Russell King <linux@armlinux.org.uk>,
        Atish Patra <atish.patra@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Will Deacon <will@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Borislav Petkov <bp@suse.de>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hans de Goede <hdegoede@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v3 0/2] allow simple{fb, drm} drivers to be used on
 non-x86 EFI platforms
Message-ID: <YPbWrV/cIODdgu6A@phenom.ffwll.local>
Mail-Followup-To: Javier Martinez Canillas <javierm@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>, Dave Airlie <airlied@gmail.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Catalin Marinas <catalin.marinas@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Russell King <linux@armlinux.org.uk>,
        Atish Patra <atish.patra@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Will Deacon <will@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Robinson <pbrobinson@gmail.com>, Borislav Petkov <bp@suse.de>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hans de Goede <hdegoede@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
References: <20210625130947.1803678-1-javierm@redhat.com>
 <e61cf77c-6bff-dfcc-d3df-2fb6b48e5897@redhat.com>
 <8dd26141-a09c-39e2-5174-4cad8d21c49c@suse.de>
 <CAPM=9tyfNPa2f5PDBLm4w_H_riEQ5P3rEhX73YGE1y_ygRox+w@mail.gmail.com>
 <CAMj1kXErHteZ+MKYvp=yYmwVxV3A=vjtnG351hZHV+3BPwDQvw@mail.gmail.com>
 <YPbJJ/0tSO/fuW7a@phenom.ffwll.local>
 <03f0edef-e54e-8a2a-4b50-683d3d42e249@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03f0edef-e54e-8a2a-4b50-683d3d42e249@redhat.com>
X-Operating-System: Linux phenom 5.10.0-7-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 20, 2021 at 03:42:45PM +0200, Javier Martinez Canillas wrote:
> On 7/20/21 3:01 PM, Daniel Vetter wrote:
> > On Mon, Jul 19, 2021 at 09:10:52AM +0200, Ard Biesheuvel wrote:
> >> On Mon, 19 Jul 2021 at 04:59, Dave Airlie <airlied@gmail.com> wrote:
> 
> [snip]
> 
> >>>
> >>> Can we just merge via drm-misc and make sure the acks are present and
> >>> I'll deal with the fallout if any.
> >>>
> >>
> >> Fine with me. Could you stick it on a separate branch so I can double
> >> check whether there are any issues wrt the EFI tree?
> > 
> > It'll pop up in linux-next for integration testing or you can pick up the
> > patch here for test-merge if you want.
> >
> 
> Thanks a lot Dave and Daniel!

Oh I haven't merged them, I'm assuming Thomas will do that. Just figured
I'll throw my ack on top:

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> > And since Dave has given a blanket cheque for handling fallout he'll deal
> > with the need for fixups too if there's any.
> 
> I also plan to look at any regression that might had been introduced by these.
> 
> Best regards,
> -- 
> Javier Martinez Canillas
> Linux Engineering
> Red Hat
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
