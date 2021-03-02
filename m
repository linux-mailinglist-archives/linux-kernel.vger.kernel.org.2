Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B66E932AE3B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384604AbhCBWmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 17:42:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349529AbhCBWKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 17:10:09 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F638C06178C
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 14:09:15 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id p15so17094693ljc.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 14:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2BdA81m+7VN+qviulnFkbFU7BcgALjMUUHbqorkGRo8=;
        b=WsYz8n3peJ7kIi0io9tCQIhEuNIC4rbZinEygyAB3gyWr2PbjWuoCnrNcL+oDCkJX4
         D/AwNIX3pC3siEGIJ/HS0jeoF7dSsAyLDYuTCVG64KzlXlo+5rdrJcfOMHhD1qW7yxQ5
         EKdPONHWw5wpyRwpUeDxA5Pp8CScLw6TA+vAepMHPU5Xxekm3bJVhrIYNj4sIZcXuzdG
         iZHEnHzlRXZnn2QhA3nW2l85nhFvGI5IPdO33i8YC4jFDbBdnsKazSPxI5N/B93Txb7C
         Jv7t/kAwK1my77JPDUuLdIXzmlKXSA6iG4nvQeMFIHJ2UIEwsh7cD5nMpjHBBbZo7UI3
         Y3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2BdA81m+7VN+qviulnFkbFU7BcgALjMUUHbqorkGRo8=;
        b=q5oL0FZUyQDSGQDjDF8UHY2CYVVusTX1p83g/uLWtrUTBOsc6h834zeg0KIqBvzFO8
         BZNFsbncOZRBt99rQz9hnctS6ThjrBmA4jjYzszwUhHVcLy3bCJZi3DdjmYYXip9wNMU
         SnE5SQBLDx8EfzCxzx+8tsZwwNiIu7CaPZvLBQoCWblIDD+uf7WtdJ0643tP62vUjs5H
         IgXXRu/zdpc+rLNQ3ET/7dmp5vSLJOewy3uOCY6usNynqvxDj42vfHvuk8O0WyFZWauN
         w8jTQb6Kko/amlLsjZW3LPFGFH3KdBIV0OOaYPQA/vHhh2M8Xl16Ay+s0AF6SFHEJ7m5
         qcjw==
X-Gm-Message-State: AOAM532cQdwHjsLPgPjIhXnwnGJAaP6lOaUmfydNsPiam25ExSd5TPry
        BznmSILbh8yzGSLlc8ft2iWE2v++MzARsBmlgVIi0w==
X-Google-Smtp-Source: ABdhPJzOMRBxvCOCHjHJWr2gSnmjRfJPyHwrPdl/9dG/ul/C330WFSI+UtZGm/U0fn1S1kka1hJi7DGZx/ju6ztdHIw=
X-Received: by 2002:a2e:92d6:: with SMTP id k22mr984745ljh.244.1614722953496;
 Tue, 02 Mar 2021 14:09:13 -0800 (PST)
MIME-Version: 1.0
References: <20210302210646.3044738-1-nathan@kernel.org> <20210302210646.3044738-2-nathan@kernel.org>
 <20210302220252.ulvlsfyp4ordwrky@google.com>
In-Reply-To: <20210302220252.ulvlsfyp4ordwrky@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 2 Mar 2021 14:09:01 -0800
Message-ID: <CAKwvOdmR_p-zbrTUmbObmCVKBcuNLpg_V3NqLeYsEK4xNHfYOA@mail.gmail.com>
Subject: Re: [PATCH 2/2] Makefile: Only specify '--prefix=' when building with
 clang + GNU as
To:     Fangrui Song <maskray@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 2, 2021 at 2:02 PM Fangrui Song <maskray@google.com> wrote:
>
> On 2021-03-02, Nathan Chancellor wrote:
> >When building with LLVM_IAS=1, there is no point to specifying
> >'--prefix=' because that flag is only used to find the cross assembler,
> >which is clang itself when building with LLVM_IAS=1. All of the other
> >tools are invoked directly from PATH or a full path specified via the
> >command line, which does not depend on the value of '--prefix='.
> >
> >Sharing commands to reproduce issues becomes a little bit easier without
> >a '--prefix=' value because that '--prefix=' value is specific to a
> >user's machine due to it being an absolute path.
> >
> >Signed-off-by: Nathan Chancellor <nathan@kernel.org>
>
> Reviewed-by: Fangrui Song <maskray@google.com>
>
> clang can spawn GNU as (if -f?no-integrated-as is specified) and GNU
> objcopy (-f?no-integrated-as and -gsplit-dwarf and -g[123]).

But -g get's set via CONFIG_DEBUG_INFO and -gsplit-dwarf by
DEBUG_INFO_SPLIT.  So if we say:
$ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make CC=clang LLVM_IAS=1

So cross compile, use clang, use the integrated assembler (ie. with
this change, don't set --prefix), with either of the two above
configs, which objcopy get's exec'd?

>
> With LLVM_IAS=1, these cases are ruled out.



-- 
Thanks,
~Nick Desaulniers
