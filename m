Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64B82393581
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 20:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235820AbhE0SjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 14:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbhE0SjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 14:39:22 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97728C061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 11:37:49 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso5869847pjx.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 11:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wo61vuP8itAsZbt2t1dPCmKidBoeF2uLqMWDtAxwKzg=;
        b=Pyn+69PDHkODviT5Ornz6p2X8/CXaFeyRyt/FTNk7L408ugYRNR/1y341aGCjilncc
         WdZLfizUfUDIAIe77e8hMEQEhCy//CgKsmcWhn7ThIX8qR+azD+RqTUMTHynK2NS0qhe
         w2mr/gmsaVNv3zMjGs/EGpImpmVp/SfyZvPLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wo61vuP8itAsZbt2t1dPCmKidBoeF2uLqMWDtAxwKzg=;
        b=HWLXTSVptJV3tPCU2AA4gAX6NIBclV45mlWA9hvwUvGEpQ/tqdFho6QhI8nbRgWgPM
         ybOJdq19tFy1DNWc9V+4FL2KNpOF63buHMuayYSaCTBI0tWSJW/UHADDbFaRebZaNKeL
         bXG4PGWlcsJ4wFpDL+r2uHmNmOYRtWsbXg6IcRU4nAgAoZMBXgkmomwkqe+yAMEvG6eR
         CvD7WMsBP46WHHuoOAEqptflePy25JxpD9iBygegTIz/HJLZTV1MbWwftYegwkwC00hM
         QsMx0Xngi46QUK2TE54tES1/ZwuexVqK8YkzFraKS6BcXzOiJwjSeeuun/LKR00mxmXa
         2deg==
X-Gm-Message-State: AOAM531VUVDgqbDv97UdM4jb6+kkG2wDfU9yv17wK1M9G4PM3qB3ueP/
        zD8OUqlk1mS7hriiM0xS2NlfQQ==
X-Google-Smtp-Source: ABdhPJx7gUhC+H++qqo1KLIfawtDGiTJkGG2lpEYBgdm1042nL2trg7RmeYBjaIl/Zl20wf2FOmbTA==
X-Received: by 2002:a17:902:bf46:b029:ee:b949:bd0 with SMTP id u6-20020a170902bf46b02900eeb9490bd0mr4383042pls.14.1622140669177;
        Thu, 27 May 2021 11:37:49 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h3sm2296385pgp.10.2021.05.27.11.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 11:37:48 -0700 (PDT)
Date:   Thu, 27 May 2021 11:37:47 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Rodrigo Campos <rodrigo@kinvolk.io>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sargun Dhillon <sargun@sargun.me>, containers@lists.linux.dev,
        Tycho Andersen <tycho@tycho.pizza>,
        Mauricio =?iso-8859-1?Q?V=E1squez?= Bernal 
        <mauricio@kinvolk.io>, Giuseppe Scrivano <gscrivan@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>
Subject: Re: [PATCH] selftests/seccomp: More closely track fds being assigned
Message-ID: <202105271137.251E14ACB2@keescook>
References: <20210527032948.3730953-1-keescook@chromium.org>
 <CACaBj2atO=2aAyK+BO5MPS0B3CQNwc98CSHiuy8X2wvkdvJNDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACaBj2atO=2aAyK+BO5MPS0B3CQNwc98CSHiuy8X2wvkdvJNDQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 02:45:26PM +0200, Rodrigo Campos wrote:
> On Thu, May 27, 2021 at 5:29 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > Since the open fds might not always start at "4" (especially when
> > running under kselftest, etc), start counting from the first assigned
> > fd, rather than using the more permissive EXPECT_GE(fd, 0).
> >
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Nice cleanup, thanks! Just in case, tested it here, works fine. Feel
> free to add:
> 
> Reviewed-by: Rodrigo Campos <rodrigo@kinvolk.io>

Thanks!

> I can improve the selftest to test the new addfd flag we just added
> also in combination existing flags (like setting the fd number to
> use), and maybe also split the big chunk test, if you think that is
> valuable.

Yeah, I was pondering splitting the test up, but I think it's okay how
it is for now.

-- 
Kees Cook
