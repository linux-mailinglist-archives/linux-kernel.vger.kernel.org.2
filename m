Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8D0352F29
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 20:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235987AbhDBSZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 14:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhDBSZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 14:25:46 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03E1C0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 11:25:44 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id f2-20020a17090a4a82b02900c67bf8dc69so4955304pjh.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 11:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7WB9dyBxJfyi+dnN/pUTcNGEGmQQ19of2/quWexK5LI=;
        b=S6NXdtr+LlK6Nx57Jl5hfAvwLV62rZq1q9FrJPkyMVNZcnp6YgfAJ0ljinGEeEojZL
         542zCwNZXfoWy1Ucv+WcLme19/ihTv0HTdcMLHfon7tz7nivoz3RFfhLKvd4pdkzVuhR
         5HVoI7ahUuhXAv+n/q9uCCpZVw9CCf5emX71w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7WB9dyBxJfyi+dnN/pUTcNGEGmQQ19of2/quWexK5LI=;
        b=eL5lgrrJsF26pI1FcxitplnCuJlP37knwFwOgRK/rTd1gwT7yiSqUyjwVPUCkj5Ecc
         8C2Z0p0ktXJvyHL2gtb3GYXHoM5+3mv0pfIlnaSJNAlUlgMES/FPr2mIf708ROdm6PCW
         qSaTMlzMWoNkNBq+EHJ8rDI322djU9jL2qQJuotMiUBXlTCqgV6VwWbHFXnc1yYbQ5Aq
         jtNqByh2aqtVd7MITSI9vv4EJ29lm+H7Vac7ihJtZbJS1m2JOJOjD7VJj8GN3BJQv7I/
         4SDFyT26URQrCUbflcYx9NSHTyay7u+x1Z0WWh0EBr+d2SkMa7GkjHDSzKgKBVuACXRG
         J7yA==
X-Gm-Message-State: AOAM5312XGL+bAIiIQl9iapPks0ar8hxJ5+unZ+56ehbjPLWcpwXLw+F
        ALNSVmO2kLiiHh4q/qGl5j3aAA==
X-Google-Smtp-Source: ABdhPJxFdQIKTxzrvLroVyzxnLHiDY5q50gwTx44nmerTmTqVhmwikVsbTgh8V9WzpbDCaKSwEXltw==
X-Received: by 2002:a17:90a:9413:: with SMTP id r19mr14769842pjo.65.1617387944473;
        Fri, 02 Apr 2021 11:25:44 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p17sm8464878pjv.49.2021.04.02.11.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 11:25:43 -0700 (PDT)
Date:   Fri, 2 Apr 2021 11:25:42 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Gabriel Somlo <somlo@cmu.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        qemu-devel@nongnu.org,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH] qemu_fw_cfg: Make fw_cfg_rev_attr a proper kobj_attribute
Message-ID: <202104021125.53164550A@keescook>
References: <20210211194258.4137998-1-nathan@kernel.org>
 <161428829728.2305454.15456455443457551559.b4-ty@chromium.org>
 <CA+icZUWdeWSy52bU4cjHau1hn5NiFAozaHgDb=geaaCYOET9+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUWdeWSy52bU4cjHau1hn5NiFAozaHgDb=geaaCYOET9+w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02, 2021 at 08:42:07AM +0200, Sedat Dilek wrote:
> On Thu, Feb 25, 2021 at 10:25 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Thu, 11 Feb 2021 12:42:58 -0700, Nathan Chancellor wrote:
> > > fw_cfg_showrev() is called by an indirect call in kobj_attr_show(),
> > > which violates clang's CFI checking because fw_cfg_showrev()'s second
> > > parameter is 'struct attribute', whereas the ->show() member of 'struct
> > > kobj_structure' expects the second parameter to be of type 'struct
> > > kobj_attribute'.
> > >
> > > $ cat /sys/firmware/qemu_fw_cfg/rev
> > > 3
> > >
> > > [...]
> >
> > Applied to kspp/cfi/cleanups, thanks!
> >
> > [1/1] qemu_fw_cfg: Make fw_cfg_rev_attr a proper kobj_attribute
> >       https://git.kernel.org/kees/c/f5c4679d6c49
> >
> 
> I have queued this up in my custom patchset
> (for-5.12/kspp-cfi-cleanups-20210225).
> 
> What is the plan to get this upstream?

I haven't sent it to Linus yet -- I was expecting to batch more of these
and send them for v5.13. (But if the kvm folks snag it, that's good
too.)

-Kees

> 
> Feel free to add my:
> 
> Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
> 
> - Sedat -

-- 
Kees Cook
