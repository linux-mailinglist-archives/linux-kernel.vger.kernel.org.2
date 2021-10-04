Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 018B9421881
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 22:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236572AbhJDUjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 16:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234781AbhJDUjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 16:39:46 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27BD8C061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 13:37:57 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id 138so17796465qko.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 13:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CX1j6QPWdzTav0JhzNdk61SxjtPOxgeGBL6WebgSoXQ=;
        b=JAYK+moTXi2oGJWzpp9Ojk5yqH7FI8/WtawZMXvQ0ZPJrSUOTd001Xrry2opxRWZYT
         abL3GSImEeXHFD2ODiMyMUg6cRS/yeEU1LL6YJPuEv3xn2/DllUdoM5YbIhVY0oBui/A
         mzwNPMIFoku/87mCS9IpgqH6vbV998n8cErF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CX1j6QPWdzTav0JhzNdk61SxjtPOxgeGBL6WebgSoXQ=;
        b=e8jyjwQS4uEKub9voDR75dcEnBpOF8ur+T7IQQieccjcy+Qqkdd61NPU06j7jmihSe
         nk0lPDD08XiTw1kX0MGbKP6w3skcGmMVl8Ym/bn7NhuJIe2u6PjfgXNsDJzCJwAS293X
         dlHq/f3TzFMNAEMhBJGEADVJydaXqJleFaxaree5dqA2HvCY5fQMZzCGYGwU7Vam8xMs
         hYtYLfKxamXXtblfs52CAzQB/0BCJzltC2MLluKK7RAnYzvJjW4PtKWvwRXVPmYqC9K9
         TANB292ss/VoEWJM+OCWCCqPUxuHuZixP1v+kQPMtZqKcuB0ie/O9+QeFDY7mmoJwipK
         6rzQ==
X-Gm-Message-State: AOAM530UPw1Y09YHPzjeiaQSKlZ+mcOd20hefHPtNYK4d7Z+7SjtNvyO
        84VGcGoA8b3zwBVYiKMGulKiSdiwrUZ04A==
X-Google-Smtp-Source: ABdhPJwTrv9BZoyx/I2xA7g8ZthUIkg4qVsCm0+zLSp9kddZiOEYy+tgLwaXHBfSzQJlXn77VvD8Zg==
X-Received: by 2002:a37:9fc1:: with SMTP id i184mr12034554qke.247.1633379876284;
        Mon, 04 Oct 2021 13:37:56 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-32-216-209-220-181.dsl.bell.ca. [216.209.220.181])
        by smtp.gmail.com with ESMTPSA id g11sm5472570qts.63.2021.10.04.13.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 13:37:55 -0700 (PDT)
Date:   Mon, 4 Oct 2021 16:37:54 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] kallsyms: strip LTO suffixes from static functions
Message-ID: <20211004203754.nvk4aijql7tevbnh@meerkat.local>
References: <202110020501.RKX4zca7-lkp@intel.com>
 <20211004162936.21961-1-ndesaulniers@google.com>
 <163337043811.3396838.458236649388694225.b4-ty@chromium.org>
 <CAKwvOdm5bBUE0df8jbXq+bSCf9U0AM3Wm4NsZeHu=Nuhi0yd-A@mail.gmail.com>
 <20211004183806.5weyuk554ppe5olb@meerkat.local>
 <CAKwvOdkzviryHByOZj1K6r6HVKcC+4Tc43jXn4Eqk9EXGVpucg@mail.gmail.com>
 <20211004194521.e2syd25qzrgn5mzg@meerkat.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211004194521.e2syd25qzrgn5mzg@meerkat.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 03:45:21PM -0400, Konstantin Ryabitsev wrote:
> So, this line:
> 
> > fatal: command 'git hook run sendemail-validate -- <patch>' died with exit code 1
> 
> Suggests to me that your git version is patched to carry the
> new-and-not-yet-accepted "git hook" changes. It seems that it both opens a
> stdin and passes the file as the parameter. When we find a stdin, we always
> grab that instead of the passed parameter, but that's only a problem with this
> change to git.

Patatt version 0.4.9 is out and should fix this problem. Glad we caught it
before the fancy new git-hook patches are in upstream git. :)

-K
