Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEBAE3D3533
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 09:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbhGWGpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 02:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbhGWGpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 02:45:16 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF816C061575
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 00:25:49 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id l11-20020a7bc34b0000b029021f84fcaf75so2929890wmj.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 00:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=LSB6ElobvnZif22qSHOWfFwFG7LyXyc6oTWXzgtxMJo=;
        b=Wdp46bdnm+/jd66vTK3+1LTogO0yi/hQZgtuUXVvODkHGQrIyVr36yVGv+hY7ci0fi
         beRJ2KGgTupxUDSUkQna/xfQ/wqXfnH0lqlm08Mpv+bwqcHzWLRDPNerLVwmOOArzTdS
         N17RTh0K5e7ffEvCssSvHyADruCOfUhlTuKW3d6k3WtxPY9TS7RMEdDHSQzjpt9UWWac
         mgB0HxTbrtvv4dxxdJGPagkzuz3n39pN1EyIg4a1JBFKmlDTHz73zd7/hGRnc6gLMc21
         g9kSMrwjXJxlIy1Uwulyz1DJ64UrwsSS+uI5sJs5dhg9AS4i0doulGW8ZVkkTJloDRsc
         QlPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LSB6ElobvnZif22qSHOWfFwFG7LyXyc6oTWXzgtxMJo=;
        b=FaBh0mZ5An5blHFuoLFjeiOfpure7oTji5z5Kyv2RI1TwmWexMJKFiFO59xWf0a65q
         2A0C5CtYxRPVzPF/OK+jiU7HFwB7/vqAOL0Kzp9DFsVXWVgGUYw+k4+/uYkAtsZ1jOMU
         zPL3DcQ4jvC3XUs/hzwNlvkZSpv5QxU+emE91H5Ou8zYKqwsXeV1KCwxjq8baSuaWSS/
         5KwiIvvKr5vpLrUbgEGGCqFiKOD4mxu0B47LYulA0PwJydZNdLwDrW1Pxw32T4K07m+g
         TBxiCG4RS0LnqDf1TxbtJLnqtBejAFflIZikSImUngYxvs1AE6pIc7MohQKT75GXomr2
         em6Q==
X-Gm-Message-State: AOAM533RfLcDCx4HL64QAsINEnjGihJiumGu2RWzk6zHcr9Soo9g4OYM
        LeId97BZgOsRGWwXkjhgkESRkA==
X-Google-Smtp-Source: ABdhPJxOswHm66JUyUsfTqdmOv6JcYGhhj1ilWXuulmuGuE2TVnJFklEq8yQWBWa2Iu/gYlHvT66BA==
X-Received: by 2002:a1c:4c16:: with SMTP id z22mr12506553wmf.176.1627025148463;
        Fri, 23 Jul 2021 00:25:48 -0700 (PDT)
Received: from google.com ([31.124.24.141])
        by smtp.gmail.com with ESMTPSA id c2sm32071869wrn.28.2021.07.23.00.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 00:25:47 -0700 (PDT)
Date:   Fri, 23 Jul 2021 08:25:46 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-kernel@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Remy Card <card@masi.ibp.fr>,
        "David S. Miller" <davem@caip.rutgers.edu>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/1] fs: ext4: namei: trivial: Fix a couple of small
 whitespace issues
Message-ID: <YPpu+qe9HyJUskaY@google.com>
References: <20210520125558.3476318-1-lee.jones@linaro.org>
 <YPlYD1BXyjIgh++K@google.com>
 <YPnubECqbX47V3TK@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YPnubECqbX47V3TK@mit.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jul 2021, Theodore Ts'o wrote:

> On Thu, Jul 22, 2021 at 12:35:43PM +0100, Lee Jones wrote:
> > On Thu, 20 May 2021, Lee Jones wrote:
> > 
> > > Cc: "Theodore Ts'o" <tytso@mit.edu>
> > > Cc: Andreas Dilger <adilger.kernel@dilger.ca>
> > > Cc: Remy Card <card@masi.ibp.fr>
> > > Cc: "David S. Miller" <davem@caip.rutgers.edu>
> > > Cc: linux-ext4@vger.kernel.org
> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > ---
> > >  fs/ext4/namei.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > Any news on this please?
> > 
> > Would you like me to submit a [RESEND]?
> 
> Please don't send "checkpatch.pl --file" patches for the ext4 file
> system; if you must, please focus on files in the drivers directory,
> where they are more welcome.  If developers are making changes to a
> file, fixing some checkpatch.pl whines is fine, but white-sapace only
> changes just obfuscates "git blame" code archology, and so the costs
> far outwieghs the costs.  "Fix" is also not the right verb to use.
> For more information please see [1].
> 
> [1] https://gist.github.com/17twenty/8154928
> 
> If you are looking for subtantive ways of contributing to the ext4
> file system, feel free to look at various syzbot warnings[2] and try
> to figure out what is going on there.
> 
> [2] https://syzkaller.appspot.com/upstream
> 
> (In some cases, the syzbot complaint has already been fixed, and it's
> just a matter of letting syzbot knoww that it has since been fixed by
> a particular commit.  See [3] for more details.)
> 
> [3] https://github.com/google/syzkaller/blob/master/docs/syzbot.md

This patch doesn't have anything to do with checkpatch.

Daniel, who was making more 'substantive' changes to ext4, fixed these
whitespace issues in his first submission [0], but were dropped from
the second revision for some reason and thus didn't make it into
Mainline [1].

This is an attempt to realign his development repo (Android) with
Mainline.  I had the choice of either backporting the issues back into
the Android kernel or upstreaming the original whitespace cleanup.

It made more sense to me to draft a patch making one codebase better
than another one worse.

[0] https://lore.kernel.org/linux-fsdevel/20210203090745.4103054-2-drosen@google.com/
[1] 471fbbea7ff70 ext4: handle casefolding with encryption

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
