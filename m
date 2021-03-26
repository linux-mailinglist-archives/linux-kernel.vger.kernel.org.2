Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9F6C34A40D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbhCZJQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbhCZJQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:16:40 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED353C0613AA;
        Fri, 26 Mar 2021 02:16:39 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id w8so2265194pjf.4;
        Fri, 26 Mar 2021 02:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZJU8eQTrHMk3jqYitTK0s9c/y4olgE5eR7itETLxMTs=;
        b=Pd0ExQXC3mxg2j0U3TrIN62e91Ss1UD89tIF6YsQtKtbQOwyFBGLxDCHiQC4mfcFpB
         CqAuCghwR99X9CaWGfNHYJoacATVqOVye3ARLpHFuOrsK8mOQC+NLSKztkvLgfPD3zRz
         4qUZ9TApnuXmNT+c58G9yi3Hrz2L9N+VdGsyMANuDBh1AdoQA59K5Tymrwr+8YVFNSr6
         iOdxcfmfpohdRQ8vHcK4kEFi7685+YBbDWio7YQwJOMJgT26K6/X66eTIcCHAYG3aG5M
         AIn2xWZR5ZtNJide87rLoxUEr842vXcXk3qe0wNLVRHyxdeo4jZfS5TkZpR/xZPFNXbx
         2TZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZJU8eQTrHMk3jqYitTK0s9c/y4olgE5eR7itETLxMTs=;
        b=sLD33XzZvw2nxEX+G7fxc38ilVWRYnTDwA8pfaTRmzqZOwo3tzWndoQGEEGKtjHY0+
         m98SvLwzutcw2KEqm2HCPBUPzhigqNH1Jb6m07g1fUIz1KLN3JugwwY93dVxPZeyl0BR
         Z3q9t5l+feY/2ZQurRFZo4x5W+lGcnIQkXXaxQT3mzCVUoR8IP43VFnmX4l6GM9X9wm3
         y1duZfW2f0njCHw9J5iZzNpTCdhEQBqUtnGQ2LencBJa1nVpV9ELK3JUJygZ3Wc8+F9R
         X777jtSEbpL/u4gCKEaV4ktm4YQ1kJVpUICMLq0YV0bcAIwB+BmRaSMeD4dT0NgYKg7J
         JdCw==
X-Gm-Message-State: AOAM533VWsnqaL/+ncmbZwSST5+kO6eF1UixyRsFKm32F24FF69wRkkL
        c3xbSs5/INBDsfCmHvYh0Fc=
X-Google-Smtp-Source: ABdhPJxGEMfaZ0tGnNRtBHpxDycvnPtIYnQH7soeehKdm3LHDGp6mAVVr2luWLqKf0DPBBmngmQXyQ==
X-Received: by 2002:a17:90b:3553:: with SMTP id lt19mr12707460pjb.222.1616750199589;
        Fri, 26 Mar 2021 02:16:39 -0700 (PDT)
Received: from localhost ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id d8sm8930729pfq.27.2021.03.26.02.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 02:16:39 -0700 (PDT)
Date:   Fri, 26 Mar 2021 17:16:34 +0800
From:   carlis <zhangxuezhi3@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     zhangxuezhi1@yulong.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: fix a typo
Message-ID: <20210326171634.000011f5@gmail.com>
In-Reply-To: <YF2dXIxMOUyLzfnQ@kroah.com>
References: <1616745915-194644-1-git-send-email-zhangxuezhi3@gmail.com>
        <YF2dXIxMOUyLzfnQ@kroah.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Mar 2021 09:37:48 +0100
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Fri, Mar 26, 2021 at 04:05:15PM +0800, Carlis wrote:
> > From: "Carlis" <zhangxuezhi1@yulong.com>
> > 
> > Change 'tft' to 'TFT'  
> 
> Why?  What is wrong with "tft"?
> 
I think abbreviations should be capitalized.
> > 
> > Signed-off-by: Carlis <zhangxuezhi1@yulong.com>  
> 
> Full name please.
> 
OK, i will use my full name next patch
> thanks,
> 
> greg k-h

