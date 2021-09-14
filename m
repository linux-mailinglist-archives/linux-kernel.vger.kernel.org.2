Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D74340B33C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 17:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234464AbhINPjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 11:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234817AbhINPjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 11:39:11 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A8FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 08:37:54 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id p29so2828616lfa.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 08:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WrbwJNAShlWZ4ETbZPnZ+MxxaavLpqRSqIx3YNgS+m4=;
        b=c/RjdyCqa86KtG4xvnXuEHEOIhrk1tMaHxds9sa2BTLgFy0hEVkLRtXFVqYoc0txFE
         TecACfDzfJs5hqYx6k9FSEQiZuHaK5GByphOnbEH6XupL3U9zDMJqyYu5/dKpULwBwVy
         vHvd8/Fw2zAIdRc5mfcpuGLsFSH/HpqwOm8ShHk/1Wu7D0R72TYwz8VEv1sJV/NDsRpl
         zi9B2fSMYqgMQcTLcCAlGAuM+z1yJ1OvqWFQi2gQC+mdGkzOrKRiImvm7nSTrCOaID3t
         qwhJbh1au/i/xqf0sdP/ks4bcBQLtcD4qwgRC2PAq1XFgo34FMSQDDfF+nefBzjXuqJM
         qUhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WrbwJNAShlWZ4ETbZPnZ+MxxaavLpqRSqIx3YNgS+m4=;
        b=HTCBSzS99HAPozc7N8VjaUTW3OrH5e05iXo+sG5dXASwssm3/K3XfsRZ1dzyWdad0m
         AklxVHoMAPgrF02UyqkdRwjF5T0EjWyYv/MHxSUs3qprzdpknfKJbgyAPkstwxbx8dif
         a3QqQHArSUCoJ7I1MmYnJe8wfeRN3oRgStxP1L5PykdmsQ1MkDD7+avbFU1kJKPWnPJk
         i5/xE8gfdgiSK2JFLZmiqEDiTJjjrXWQGEsbuho2tOhloHjgI59Q/82pbOT2flw6DLT5
         pobKoPjxv+E0+6PBSvcMoxtVwB6sAj/R9t/yfQjM8fSK/ZY4VfyksvqkCoxrz7zGvI0D
         Ddpg==
X-Gm-Message-State: AOAM533q2aU440ptY14OePr5tVY/VQ4FApEB4kMmwgza6MxaSO8ORF6O
        gT2eVU8TixSvT1TpcwMds2kT1BEdj5lprIFPe8/w4Q==
X-Google-Smtp-Source: ABdhPJztZgqISaoTjywPB2MoF+5xbfLPvpGfnNNuOa7yFYBDX3C62kF6zYqLoIZXITli3nLfezaXZKIQ6NFyS5WcWl8=
X-Received: by 2002:a05:6512:139c:: with SMTP id p28mr12970629lfa.523.1631633872288;
 Tue, 14 Sep 2021 08:37:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAP7CzPcLhtXDyLudfmR2pWR5fzSQ_jhJSoRheH=cytoDnb_ujg@mail.gmail.com>
In-Reply-To: <CAP7CzPcLhtXDyLudfmR2pWR5fzSQ_jhJSoRheH=cytoDnb_ujg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 14 Sep 2021 08:37:41 -0700
Message-ID: <CAKwvOdnUCfPnd8f51gT0hmRS8Zvsy1s=3GhArXO=LjVcSKYUSw@mail.gmail.com>
Subject: Re:
To:     zhao xc <xinchao.zhao.kernelz@gmail.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, nathan@kernel.org, tony.luck@intel.com,
        linux@rasmusvillemoes.dk, mpe@ellerman.id.au,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 12, 2021 at 10:42 PM zhao xc <xinchao.zhao.kernelz@gmail.com> wrote:
>
> Hi maintainer:
>         This is a patch fix the unused macro definition

Hi Zhao,
Thanks for the patch.  Would you mind following the standard procedure
for submitting patches to the list for review.  I wrote up
https://nickdesaulniers.github.io/blog/2017/05/16/submitting-your-first-patch-to-the-linux-kernel-and-responding-to-feedback/
a while ago, but I think it's still helpful.

-- 
Thanks,
~Nick Desaulniers
