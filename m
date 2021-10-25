Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF4B43A0B5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 21:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236039AbhJYTdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 15:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235724AbhJYT3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 15:29:05 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C9DC0432CB
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 12:19:17 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id gn3so9080692pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 12:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cmBKbr1pVO6dbMfydvliXyo59CprcERpfbJzhNImFLc=;
        b=fwwZDZU0FN3lnxuhDetttx39QzbR4ElCipSxlsC/T9+YeLaXhdEqqIiSLkav8vX0vt
         Yy+BZkmUGwsc++1sMuHbMItULef4Yly+Gh5N9Y2+LZgD00CBRUUQt6fQLEtdQpsQ26D+
         GN5cIqI6Ld5P9PwqHcKWzV6d7hD8Qgj5Wl06A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cmBKbr1pVO6dbMfydvliXyo59CprcERpfbJzhNImFLc=;
        b=FyichIrP+l4xa9YtfSLT/oZdMgLMDDFKNQVT2Z+B6+hQrdDwUqjh1BWOpdraYfJf9T
         v/ssARv/tb+gQkhk1QFtvUTyaplgew9Kz/5EE2SAqNSNGTwh3thXkUwvDALcz3lp8tmY
         HSzqWwNCDJgwQ41tH/WMI5HtxWfFJNhbZeg8lkbxqc8MzTkuWyN6kGyHd7mlckRsDsF6
         dFTVrjShjMcEwHmJYIW4h4EWnS4b3TYP7zNQaHM0uLlkNsSnll57EdVsFy/7macq6eEN
         KkH38IG1URYLDyU4diHchQ7sMy0Up5Rra8zLejwPLr675any+QELvAzG9AzFdxXiFjdH
         CqOQ==
X-Gm-Message-State: AOAM530ZtrBq8KpUexynkFCxJERKbEEv3ZAZscWB9EdkDFKvbWgoZlV1
        5Cx/3o4ghclTj/BdfCnJ0ojxIQ==
X-Google-Smtp-Source: ABdhPJxgVHGOh33uGLvNivBmbSRQgcqL0+T8teg4TQ7u6lEkL9GKYSU5e/cBXObXU4WGovNqhnHI1g==
X-Received: by 2002:a17:90b:3511:: with SMTP id ls17mr10970361pjb.145.1635189556600;
        Mon, 25 Oct 2021 12:19:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z5sm16796394pge.2.2021.10.25.12.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 12:19:16 -0700 (PDT)
Date:   Mon, 25 Oct 2021 12:19:15 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the kspp-gustavo tree
Message-ID: <202110251218.EAB410DC22@keescook>
References: <20211018193048.14517460@canb.auug.org.au>
 <20211025125534.4681416a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025125534.4681416a@canb.auug.org.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 12:55:34PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> On Mon, 18 Oct 2021 19:30:48 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Hi all,
> > 
> > After merging the kspp-gustavo tree, today's linux-next build (sparc64
> > defconfig) failed like this:
> > 
> > sparc64-linux-gcc: error: unrecognized command line option '-Wcast-function-type'; did you mean '-Wbad-function-cast'?
> > 
> > $ sparc64-linux-gcc --version
> > sparc64-linux-gcc (Custom f51944395b6aa154) 7.3.1 20180130
> > 
> > Caused by commit
> > 
> >   21078041965e ("Makefile: Enable -Wcast-function-type")
> > 
> > I have reverted that commit for today.
> 
> I am still reverting that commit ...

Gustavo, can you please switch this to using cc-option?

-- 
Kees Cook
