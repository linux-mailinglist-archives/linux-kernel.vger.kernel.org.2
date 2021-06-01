Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E84F397AA6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 21:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234776AbhFATXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 15:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234539AbhFATXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 15:23:51 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CEEC061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 12:22:09 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id ei4so263409pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 12:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=St33BOH+YuaBj7xW0i483ddBsmidH6Woz5Y18MzENkE=;
        b=DCf/MEMGvnxWynrqXM2LY+B5EYcOT/o/M9bm1Ad7GKry15+OFu92f1xFTaMomSqIVB
         DNZfbACS69dlijDmrRGl4oHgeTD1VNexNkE4xJ8JNmnp9tO7VDKTahiOj+LiMG5QeenS
         qjJuOkjpuYpQeHVXSwFGZ43F6+PXT1GNwXgzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=St33BOH+YuaBj7xW0i483ddBsmidH6Woz5Y18MzENkE=;
        b=evPZIzkJ5oj+kYE1Q+Gkj/MhdLKcng2IsLII+DZt/RZ1iwR5SMnQRT5sca2ShPf3HV
         Z0cJGSCIVSMbfbxcf2Bx9hwV0Ozc3p3bb9PpgjQBBcMxepc4cG/Lmsdtyjity2JC+lq1
         NIQRlSNfU24zVyiBME2Ro8M2IyPaLZdlzV9UrxGXC10bdtYl7b9vmw1szXdDWxbIwXnm
         mu+P7BUlmVaTpdWMYisUpX8eHD+N0JNrTzQTT1ECxq30lmaLlAVbhsmaIwo1y48fkOrd
         SrSqLERzFufUKcs/Js9Iwlcak2LkfU8cABS2Kmq/22gz78MR53Rb1d3T/B2L/KyzoA2Y
         ZHOA==
X-Gm-Message-State: AOAM531jnkj2s8alS7VHBOK+QC6DzjpzbOBRrRv51tonJHf6y2/U4GC5
        FShU3JPg1dNDyUMaJxTwRkdEEA==
X-Google-Smtp-Source: ABdhPJygGGHoda2yu7Kz19KMt8cwgE3hz+zhW6FXtlmD/XKrZQVUBtTo1DDDlq5HqKGuQ+GU5mQXLA==
X-Received: by 2002:a17:902:860b:b029:ef:46b8:886e with SMTP id f11-20020a170902860bb02900ef46b8886emr27413701plo.18.1622575329457;
        Tue, 01 Jun 2021 12:22:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v12sm14803089pgi.44.2021.06.01.12.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 12:22:08 -0700 (PDT)
Date:   Tue, 1 Jun 2021 12:22:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Rodrigo Campos <rodrigo@kinvolk.io>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        LKML <linux-kernel@vger.kernel.org>, containers@lists.linux.dev,
        Tycho Andersen <tycho@tycho.pizza>,
        Andy Lutomirski <luto@kernel.org>,
        Mauricio =?iso-8859-1?Q?V=E1squez?= Bernal 
        <mauricio@kinvolk.io>, Giuseppe Scrivano <gscrivan@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>
Subject: Re: [PATCH v2 2/4] seccomp: Refactor notification handler to prepare
 for new semantics
Message-ID: <202106011221.98BC12C78@keescook>
References: <20210517193908.3113-1-sargun@sargun.me>
 <20210517193908.3113-3-sargun@sargun.me>
 <CACaBj2YUiowSKzvh02OjpQNqQViA8N0eyRMimkK=90NagRF40w@mail.gmail.com>
 <202105271137.C491991621@keescook>
 <CACaBj2aaDkJwDM8ugR5LxWEOho3nZuHjYLLsth3XYjf39tpaQQ@mail.gmail.com>
 <202105281014.EECE3D3048@keescook>
 <CACaBj2aM0FxsTSeCDu+3tfdBY9-rbPaLA88YW3Fg-ZQDJRGoXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACaBj2aM0FxsTSeCDu+3tfdBY9-rbPaLA88YW3Fg-ZQDJRGoXQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 29, 2021 at 12:31:55AM +0200, Rodrigo Campos wrote:
> On Fri, May 28, 2021 at 7:14 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Fri, May 28, 2021 at 05:27:39PM +0200, Rodrigo Campos wrote:
> > > On Thu, May 27, 2021 at 8:42 PM Kees Cook <keescook@chromium.org> wrote:
> > > >
> > > > On Thu, May 27, 2021 at 01:51:13PM +0200, Rodrigo Campos wrote:
> > > > >
> > > > > Kees, as I mentioned in the linked thread, this issue is present in
> > > > > 5.9+ kernels. Should we add the cc to stable for this patch? Or should
> > > > > we cc to stable the one linked, that just fixes the issue without
> > > > > semantic changes to userspace?
> > > >
> > > > It sounds like the problem is with Go, using addfd, on 5.9-5.13 kernels,
> > > > yes?
> > >
> > > Yes.
> > >
> > > > Would the semantic change be a problem there? (i.e. it sounds like
> > > > the semantic change was fine for the 5.14+ kernels, so I'm assuming it's
> > > > fine for earlier ones too.)
> > >
> > > No, I don't think it will cause any problem.
> > >
> > > > > Just to be clear, the other patch that fixes the problem without
> > > > > userspace visible changes is this:
> > > > > https://lore.kernel.org/lkml/20210413160151.3301-1-rodrigo@kinvolk.io/
> > > >
> > > > I'd prefer to use the now-in-next fix if we can. Is it possible to build
> > > > a test case that triggers the race so we can have some certainty that
> > > > any fix in -stable covers it appropriately?
> > >
> > > I've verified that Sargun's patch also solves the problem in mainline.
> > > I have now also verified that it applies cleany and fixes the issue
> > > for linux-stable/5.10.y and linux-stable/5.12.y too (without the patch
> > > I see the problem, with the patch I don't see it).  5.11 is already
> > > EOL, so I didn't try it (probably will work as well).
> >
> > Oh, btw, may I add a Tested-by: from you for this fix?
> 
> Oh, right! Yes. Here it goes so it's simpler to add :)
> 
> Tested-by: Rodrigo Campos <rodrigo@kinvolk.io>

Thanks; this is in v5.13-rc4 now:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ddc473916955f7710d1eb17c1273d91c8622a9fe

-- 
Kees Cook
