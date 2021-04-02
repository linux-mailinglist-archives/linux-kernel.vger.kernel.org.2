Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 786C53527A9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 10:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234184AbhDBI5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 04:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbhDBI5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 04:57:07 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E692BC061788
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 01:57:03 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id y124-20020a1c32820000b029010c93864955so4005553wmy.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 01:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S7ce0Vxpg2sR3Lixx6Rl5vj4I10NemweROF9R1wsVX4=;
        b=YsObxn3+33f0x47mw+a2YdWHzIAq5V3WcbiNe7j7zNPdwdnowgW+oxga2m7hqNvI+B
         7rU41kLGQlBEYigBn89HOt0+v80Cmajma8pI6iY347QTK9XQdFbKIoDO/vrvQoJLpHqO
         obXkXNg6VuOLbLbqHSaOpl1pdPXVN8P2YmOQysruh8fNhO/vCv3HnxA5xiu0NPu9/aG/
         fMD1paRHHJg4uHgZj2hvLNSlbizzZpRH2Ec+uz6klP56c4BzTIwQCvlYOAkgC7s7xoRd
         mlLBMWwaqxEOMZ+lH6qZVGj74qd9ehpoTcmROC5A968tecDYHLrm+ea8CwkghCMr10AT
         8f0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S7ce0Vxpg2sR3Lixx6Rl5vj4I10NemweROF9R1wsVX4=;
        b=E0d1rGXWdGji4mQRJb/4kMaRZBs3t574cmioKe3z0NMsZHE71sB5v5H3yembAwFIwO
         jBxa301lEE/IPhvYcB5gEX0koz8qG7hl++YXesW3kqu7aRSh9Ifage3zr02ZEkiCYgxj
         6vLIvHuuOmRPH8gMhNzothCyfO9C7MHXbFNznyHUu7Ig7TWxdelqTtDJEf3biCzhBlm/
         TipFybeVhd9nkxHHIw5uUGWCj22LQBViTWryDFr7Cw6/AVGt2Q3AfrZfrDjwdWMZ866W
         /FEmRcF1Xvd5bqiraw21YnoEiPJApriZh5ireOCf3LWSiqgs87oSYXQC2zbkgB0GGTrH
         I2Nw==
X-Gm-Message-State: AOAM533rEYYM9/j/uFHTWBWMYy7v2ovKI6z/eWdCo28a2WAWEGOT5AK5
        5nJFumGXGpi4Ta3R6y6FicqoOQ==
X-Google-Smtp-Source: ABdhPJyubigy03RcapzbnkfaAKQTZy3/TqkRV465izj294G5yfa90DXKok09jfrNBuiR9P3XMwdkZw==
X-Received: by 2002:a1c:3d46:: with SMTP id k67mr11724458wma.188.1617353822549;
        Fri, 02 Apr 2021 01:57:02 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id h8sm13874239wrt.94.2021.04.02.01.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 01:57:02 -0700 (PDT)
Date:   Fri, 2 Apr 2021 09:57:00 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] zero-fill colormap in drivers/video/fbdev/core/fbcmap.c
Message-ID: <YGbcXMfP5pbCkG/9@equinox>
References: <20210331220719.1499743-1-phil@philpotter.co.uk>
 <CAMuHMdVh9JPZKphSi5+KR+BMJL7cQpVifrPBzhR3ees8QBhBXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVh9JPZKphSi5+KR+BMJL7cQpVifrPBzhR3ees8QBhBXw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 11:55:50AM +0200, Geert Uytterhoeven wrote:
> On Thu, Apr 1, 2021 at 12:09 AM Phillip Potter <phil@philpotter.co.uk> wrote:
> > Use kzalloc() rather than kmalloc() for the dynamically allocated parts
> > of the colormap in fb_alloc_cmap_gfp, to prevent a leak of random kernel
> > data to userspace under certain circumstances.
> >
> > Fixes a KMSAN-found infoleak bug reported by syzbot at:
> > https://syzkaller.appspot.com/bug?id=741578659feabd108ad9e06696f0c1f2e69c4b6e
> >
> > Reported-by: syzbot+47fa9c9c648b765305b9@syzkaller.appspotmail.com
> > Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

Dear Geert

Thank you for your review :-)

Regards,
Phil
