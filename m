Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0B1A32DDE7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 00:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbhCDXhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 18:37:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbhCDXhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 18:37:37 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417D6C061574
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 15:37:35 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id d3so693919lfg.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 15:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cgwulWHwm1MDs+ICpQBPD7tM8b4zQh4kzB1wSHVNQH8=;
        b=NmW9oG/5sfp7MEL33QTzTJ0jjyxr8w5jl1+3me8QO/Y8lp3Iq3E1E8vUoObTXScAaK
         HwU6zyO+CH+u7r4c9Q2T37+GP4KtyYQ50FAtKVcIjR7CvPRKnIwyeBzpJAPc5dJP609f
         vs9+ekKihDooog4vC9rIvjW+LwOLRLUJMBMaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cgwulWHwm1MDs+ICpQBPD7tM8b4zQh4kzB1wSHVNQH8=;
        b=Grm+iS7ivkYZdcHie++zApOwmfk4VFwT5MkDuKxCMxuqPmOI/JFH4iiwS6auEIPtJ4
         d3vyQogUu/FEBzh1Dgxj2W6ojglp2GpZdZ1iplA9A+OqBhfXa/UVhS/5ke2UiHxQueVv
         5ST+A1IApWFDYRg1HtatJYVZ5IVuym2uqJdtZ0bAqSEI0hobhpPOozIyaHY+Gme9Onqr
         ni6Yns2yhT6O+hiVT3lAD5eGgMd05fAO2wghujQPHl5drxkp1qzXZqEkmiI9Do1cVY1B
         +UD3N6DR6atPYxdRh+J99CQiZ5ilY3qS49/0ARTgeol1DissgmprFsghvajCdrOU/+4o
         je3A==
X-Gm-Message-State: AOAM530BNbTaNGhr/UsUIFix0vLrEbTNf32VQlyutEOYitljOX+GlNxF
        9fUonhZkMLk85fIJa3+nOGHIJYIXaV3/tA==
X-Google-Smtp-Source: ABdhPJwIXu+4/Q8sO5dB/1ygp1G2tQZLKZLyeZyeqRGfa4PH4v5hVE6r1qsZiMm1YQlkUreZCdp6Ng==
X-Received: by 2002:ac2:5614:: with SMTP id v20mr174781lfd.372.1614901052186;
        Thu, 04 Mar 2021 15:37:32 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id 194sm89677lfd.116.2021.03.04.15.37.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Mar 2021 15:37:31 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id u4so197669ljh.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 15:37:30 -0800 (PST)
X-Received: by 2002:a2e:9bd0:: with SMTP id w16mr3468202ljj.465.1614901050597;
 Thu, 04 Mar 2021 15:37:30 -0800 (PST)
MIME-Version: 1.0
References: <20210304113708.215121-1-masahiroy@kernel.org> <202103041518.22EB819E@keescook>
In-Reply-To: <202103041518.22EB819E@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 4 Mar 2021 15:37:14 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj6t2i1BgmWP1Zb2WVF3zZzkHvsxsALJk7VpfKm6UgLcw@mail.gmail.com>
Message-ID: <CAHk-=wj6t2i1BgmWP1Zb2WVF3zZzkHvsxsALJk7VpfKm6UgLcw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: rebuild GCC plugins when the compiler is upgraded
To:     Kees Cook <keescook@chromium.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 4, 2021 at 3:20 PM Kees Cook <keescook@chromium.org> wrote:
>
> This seems fine to me, but I want to make sure Josh has somewhere to
> actually go with this. Josh, does this get you any closer? It sounds
> like the plugins need to move to another location for packaged kernels?

Well, it might be worth extending the stuff that gets installed with
/lib/modules/<kernel-version>/ with enough information and
infrastruvcture to then build any external modules.

Yeah, yeah, there's the /boot/config-<kernelversion> thing too, but
honestly, that probably shouldn't have been in /boot to begin with.
That, and the plugins - and possibly any hashes needed for randstruct
etc - might be good to squirrell away in a
/lib/modules/<kernelversion>/build/ subdirectory?

I dunno. I obviously don't build external modules to begin with, much
less with distro kernels...

             Linus
