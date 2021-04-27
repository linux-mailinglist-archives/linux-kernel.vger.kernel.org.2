Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A549036CA55
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 19:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237722AbhD0R3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 13:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbhD0R3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 13:29:16 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0673C061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 10:28:32 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id 66so21205379qkf.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 10:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=U3dO6tQm7GZr9mjL5K7Pz/58Q8JHzrXPoB5wA7AxijE=;
        b=wViiZ0csC3vl2T3W49g+9acdPoj/XxXfPY+XdKIF/IBOj1MPV+/biQcY3l+IeyAEaZ
         Qnb329Wi0SC66kFdSxolZHJe81xpUqp8yGgknAoGORKDX39tN2R3YL8kMfGFka2SCtkI
         yWE+zw5tQ9xoH/KDbaeQX5YPEFHBMf8EgSct2ftTwwK9YTmFQ02f5oBt4sKf30+yr0Fh
         jNydbCXM0VH+ISh1epHsMlE1dC3wKv9yNYiB2KicKF9mq4L/Zs4oPKtpS+E3iLwwpyMf
         F1F1u7nrxyPM+uDLpa+HvdhVelOXz6ZsRWXX+f+KXIEB2hnjLab6tvMvBkOiInVnWEcs
         v6kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U3dO6tQm7GZr9mjL5K7Pz/58Q8JHzrXPoB5wA7AxijE=;
        b=mGhYyoXlcaEah/5VpgIKwn3SKXYJ7i/D//KdAktcPs6xeLSrQxP5A3PFBrmqES/lBS
         whuF1V2FF5hvkUQfxn2ViTmYq3jQCr0DmbxUyF0h1X2wq6i2E1Tck273mQeeqD8FoLRM
         ci8dIMCAPnA8WuruOSMf7rzV7/zeMYTd6w9bb6bWMgi9yJRJBMp2xCUFQg39U3K4Fm/Z
         kenNl38L4IJeSkW2GV09X6e5WRt0EIrIPOyX3xEiTLKYaIwl5WUpItElY1BzaZgHM9CV
         ES5P4DHi1AjZMtd9jq502b6cCljTroDSzlm4QAYsbRMHhFIqSH+xfMYuSLLPpr7QZ4x0
         5G3g==
X-Gm-Message-State: AOAM533rU7bCnZeLAZvvU80hLKtu3C0kzngTlv8cMjz1LyjQeuZ1HVRh
        bk2tYbP3ENqzhW4nEtZ+YP9/Sw==
X-Google-Smtp-Source: ABdhPJy26Ni7id6SqqT6SDDQ/Afp5GwN/IHESlD4OZclMF5M6/SYUVdM25sD9XvCvUS4IIs7+x8b/g==
X-Received: by 2002:a37:90a:: with SMTP id 10mr24004370qkj.396.1619544511990;
        Tue, 27 Apr 2021 10:28:31 -0700 (PDT)
Received: from iron-maiden.localnet ([73.251.9.172])
        by smtp.gmail.com with ESMTPSA id y23sm3289387qkb.47.2021.04.27.10.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 10:28:31 -0700 (PDT)
From:   bilbao@vt.edu
To:     Carlos Bilbao <bilbao@vt.edu>, tglx@linutronix.de,
        mingo@redhat.com, peterz@infradead.org, bp@alien8.de,
        x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] Fixed typo in Documentation/x86/x86_64/5level-paging.rst
Date:   Tue, 27 Apr 2021 13:28:29 -0400
Message-ID: <2599991.mvXUDI8C0e@iron-maiden>
In-Reply-To: <871raveno6.fsf@meer.lwn.net>
References: <CACbHsvSta2hogK0E4AKCxsUF3bFrdQTAA-mp2MvO6Q7+rQuKCg@mail.gmail.com> <871raveno6.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jon, thanks a lot for your feedback, it was instructive. I attach changelog and the patch as plain text below. 

I fix two typos in the documentation (Documentation/x86/x86_64/5level-paging.rst), changing 'paing' for 
'paging' and using the right verbal form for plural on 'some vendors offer'. 

Signed-off-by: Carlos Bilbao <bilbao@vt.edu>
---
 Documentation/x86/x86_64/5level-paging.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/x86/x86_64/5level-paging.rst b/Documentation/x86/x86_64/5level-paging.rst
index 44856417e6a5..b792bbdc0b01 100644
--- a/Documentation/x86/x86_64/5level-paging.rst
+++ b/Documentation/x86/x86_64/5level-paging.rst
@@ -6,9 +6,9 @@
 
 Overview
 ========
-Original x86-64 was limited by 4-level paing to 256 TiB of virtual address
+Original x86-64 was limited by 4-level paging to 256 TiB of virtual address
 space and 64 TiB of physical address space. We are already bumping into
-this limit: some vendors offers servers with 64 TiB of memory today.
+this limit: some vendors offer servers with 64 TiB of memory today.
 
 To overcome the limitation upcoming hardware will introduce support for
 5-level paging. It is a straight-forward extension of the current page
-- 
2.25.1

On Tuesday, April 27, 2021 11:45:45 AM EDT Jonathan Corbet wrote:
> Carlos Bilbao <bilbao@vt.edu> writes:
> > Signed-off-by: Carlos Bilbao <bilbao@vt.edu>
> > ---
> > 
> >  Documentation/x86/x86_64/5level-paging.rst | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/x86/x86_64/5level-paging.rst
> > b/Documentation/x86/x86_64/5level-paging.rst
> > index 44856417e6a5..b792bbdc0b01 100644
> > --- a/Documentation/x86/x86_64/5level-paging.rst
> > +++ b/Documentation/x86/x86_64/5level-paging.rst
> > @@ -6,9 +6,9 @@
> > 
> >  Overview
> >  ========
> > 
> > -Original x86-64 was limited by 4-level paing to 256 TiB of virtual
> > address
> > +Original x86-64 was limited by 4-level paging to 256 TiB of virtual
> > address> 
> >  space and 64 TiB of physical address space. We are already bumping into
> > 
> > -this limit: some vendors offers servers with 64 TiB of memory today.
> > +this limit: some vendors offer servers with 64 TiB of memory today.
> 
> So this seems like a good change, but I need to make a couple of
> requests:
> 
>  - Please include a changelog, even with relatively simple patches like
>    this.
> 
>  - Patches should be sent as plain text, inline in the mail - not as
>    attachments and *certainly* not as HTML.  Have a look at
>    Documentation/process/email-clients.rst if you need some guidance on
>    configuring your email setup.
> 
> Thanks,
> 
> jon




