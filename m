Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A35F35725C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 18:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234029AbhDGQtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 12:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354372AbhDGQtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 12:49:17 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9034EC061756
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 09:49:07 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id f6so12614015wrv.12
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 09:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s4obH9YIZgpmzsW+SCrIe4AakWZcXJUvY0gyNebmfoA=;
        b=VtgsnxbpikqPS8uUSFrDn8gWyKhnnnyLZ99c4HgIi+pY8j6cNTYKsrrkougkL7rv92
         XRSOoTa+Qw9Qul+IPJOV6FEUu6kOPQ9KfYGn1ZkyKkJcelFe1SBSCEkPSmwvmrH+wsCa
         fbG4/QcHAFRHsxcl6gGeF21lFAOs0Sx4gI5d2LFBT332RVazDfwdfAFOxEVFokUv9TTz
         MixuGs9qmvKefyn2jfyOjti5tNlo1SdxWALGFKZT+cNiRfQ5T91A1MiFLIkeMhQOn8br
         kC0pquv8urJ+dgfiThUj1NXIusgBL537GxghTZLHqY2u6MemO/aC7L/nNghFymySH5Zi
         D/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s4obH9YIZgpmzsW+SCrIe4AakWZcXJUvY0gyNebmfoA=;
        b=e8lH+TvXiIsx5DoNebDfGGYYlIOOFtPOry6FwnQf11Vfh2aVG/VR6W+1QNEH0l29E0
         2iOQDp5dpOZyzHtlZlBy7qyFAkjAy99F8MiT5It23hN5HnO8ZJM9Zgz1jS8rG7wov+3f
         +lwk92PPPybx32G4F8JoVyZniH97h+JpH7flKTNW0vUf+a2p97mGd7n3wkR4FvEHXfzB
         XDIJrA/Ka9mc6Wvn5P0bX2Gnexh8ui7+1r/K5QtwxpNbIjgT5NgQvi3nb68hzstuA9fC
         lDHy+zT/c7C/ta3fO7iYX/YMzT7EIKeWxXZleEY6sHqj/yhFpmIy7q3eGVhsmM+hWw8r
         wjbQ==
X-Gm-Message-State: AOAM531NU+ELcWWNc6zJMJWzSgWTy7WKXJa3wW0fZ5D+TIoZEKctDxFi
        0cdSG41JGbOxNEaHEciYiGd2wEMBOUA=
X-Google-Smtp-Source: ABdhPJzHWR41KWvKZXmIW2NuUyMinGdiVpqZvO2/fzOf1XQYFyKq8/xBCI0iAuHAPBmYx2EcqyiLXQ==
X-Received: by 2002:adf:b642:: with SMTP id i2mr5348617wre.8.1617814146380;
        Wed, 07 Apr 2021 09:49:06 -0700 (PDT)
Received: from agape.jhs ([5.171.72.134])
        by smtp.gmail.com with ESMTPSA id s8sm40255543wrn.97.2021.04.07.09.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 09:49:05 -0700 (PDT)
Date:   Wed, 7 Apr 2021 18:49:03 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/19] staging: rtl8723bs: remove DBG_871X trace macro
Message-ID: <20210407164901.GA1403@agape.jhs>
References: <cover.1617802415.git.fabioaiuto83@gmail.com>
 <YG3MVGBomCeVicj+@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YG3MVGBomCeVicj+@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 05:14:28PM +0200, Greg KH wrote:
> On Wed, Apr 07, 2021 at 03:49:24PM +0200, Fabio Aiuto wrote:
> > This patchset removes all DBG_871X usages and definitions.
> > 
> > The whole private tracing system is not tied to a configuration
> > symbol and the default behaviour is _trace nothing_.
> > 
> > DBG_871X macros require the code to be modified by
> > hand in order to be turned on. This obviously has not happened
> > since the code was merged, so just remove them as they are unused.
> > 
> > First patch fix a DBG_871X call. It has three args over only two
> > placeholders in the first format string argument.
> > If I would not make this fix, the semantic patch
> > used to bulk remove all macro occurences would ignore the abnormal
> > macro (the one with three args) and all subsequent occurrences in
> > the same file (core/rtw_recv.c).
> > 
> > The second patch applies the cocci script.
> > 
> > This is the semantic patch:
> > 
> > @@
> > expression a, b, c, d, e, f, g, h, i, j, k;
> > constant B, C, D, E;
> > @@
> > 
> > (
> > -	DBG_871X(a);
> > |
> > -	DBG_871X(a, b);
> > |
> > -	DBG_871X(a, B);
> > |
> > -	DBG_871X(a, b, c);
> > |
> > -	DBG_871X(a, B, c);
> > |
> > -	DBG_871X(a, b, C);
> > |
> > -	DBG_871X(a, B, C);
> > |
> > -	DBG_871X(a, b, c, d);
> > |
> > -	DBG_871X(a, B, c, d);
> > |
> > -	DBG_871X(a, b, C, d);
> > |
> > -	DBG_871X(a, b, c, D);
> > |
> > -	DBG_871X(a, B, C, d);
> > |
> > -	DBG_871X(a, B, c, D);
> > |
> > -	DBG_871X(a, b, C, D);
> > |
> > -	DBG_871X(a, B, C, D);
> > |
> > -	DBG_871X(a, b, c, d, e);
> > |
> > -	DBG_871X(a, B, c, d, e);
> > |
> > -	DBG_871X(a, b, C, d, e);
> > |
> > -	DBG_871X(a, b, c, D, e);
> > |
> > -	DBG_871X(a, b, c, d, E);
> > |
> > -	DBG_871X(a, B, C, d, e);
> > |
> > -	DBG_871X(a, B, c, D, e);
> > |
> > -	DBG_871X(a, B, c, d, E);
> > |
> > -	DBG_871X(a, b, C, D, e);
> > |
> > -	DBG_871X(a, b, C, d, E);
> > |
> > -	DBG_871X(a, b, c, D, E);
> > |
> > -	DBG_871X(a, B, C, D, e);
> > |
> > -	DBG_871X(a, B, C, d, E);
> > |
> > -	DBG_871X(a, B, c, D, E);
> > |
> > -	DBG_871X(a, b, C, D, E);
> > |
> > -	DBG_871X(a, B, C, D, E);
> > |
> > -	DBG_871X(a, b, c, d, e, f);
> > |
> > -	DBG_871X(a, b, c, d, e, f, g);
> > |
> > -	DBG_871X(a, b, c, d, e, f, g, h);
> > |
> > -	DBG_871X(a, b, c, d, e, f, g, h, i);
> > |
> > -	DBG_871X(a, b, c, d, e, f, g, h, i, j);
> > |
> > -	DBG_871X(a, b, c, d, e, f, g, h, i, j, k);
> > )
> > 
> > The third one removes an unmatched macro call,
> > maybe due to the trailing \, because the occurrence is
> > inside a macro expansion.
> > 
> > The fourth one deletes all commented out call spread all over
> > the rtl8723bs code.
> > 
> > Fifth one removes definitions.
> > 
> > All remaining patches do some code cleaning on all
> > places where DBG_871X has been removed.
> 
> Nice work, thanks for doing this, all now queued up!
> 
> greg k-h

thank you,

fabio
