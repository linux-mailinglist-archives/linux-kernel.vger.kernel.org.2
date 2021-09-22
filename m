Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57F1A415284
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 23:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237882AbhIVVRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 17:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237904AbhIVVRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 17:17:24 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C29CC061756
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 14:15:54 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id g41so17318295lfv.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 14:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7XJav0dfWNxK79pvtGX/UV/+fzNxl315YNj5Lb0kUtk=;
        b=QA/EzrWbAIrSwOaNV4uqMw33DYIddOpz6ZYLeSLgSw/6W5sXis/SfJPUXmmq3UhODG
         6HTHGK+Pi7RNxhY6fHDq1cECQSdwskC8x9GDOcCAMch8XMogspIaioLO3jy91LAe9v+p
         zPQysb2+nkIu4xF1pvfTRTKDEaNJCficfXCxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7XJav0dfWNxK79pvtGX/UV/+fzNxl315YNj5Lb0kUtk=;
        b=B1VbZcGu9BrvZqXZvAlyS8r4I+zKTnwL5q5DcqmKe/w0K6Hr4A9Uz+CLEhvX0x6+/l
         q3pvgIFI20IGy1nedmq0/dt3kR1vHVuP90iiYILfa5sSJvGcttrft1ZaNYNeXaCeqtZe
         QcAVu0qj/HBYIc+vfUJz7wTy2E4JMLMbln7R6f/0xV1UUtxw+v5Q4/Kna/r3IV48HMc+
         jtL0mxohs4PcMQO8b4RyVCy8WTzK48IYAF8CsyifT2K5pzjUa1lcqOGBAt0STflct+kL
         AyOH6BO9QDUk3YQLd5xaft40rStL1+moTzgNHS39yqKqvsLdP3rnw/eL0qHiJZ+gx/JI
         T6ZQ==
X-Gm-Message-State: AOAM533W008PXDrV4g7c12IBo56LjITgEqc343PPgvBESrxqsJciTrAq
        AJuqTtT46fvEXi4Ej+ypL8p03nC3NnZDoDViBDU=
X-Google-Smtp-Source: ABdhPJyAfkoKy9Pyo35CfgiRSxpUA+5EZLWTrlT1IXuQvUPWp3RJy2rtt96YC1XxZXy/JcfF+MO5AQ==
X-Received: by 2002:a2e:8915:: with SMTP id d21mr1474028lji.45.1632345352248;
        Wed, 22 Sep 2021 14:15:52 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id s14sm369789ljh.38.2021.09.22.14.15.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Sep 2021 14:15:50 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id u8so16856927lff.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 14:15:49 -0700 (PDT)
X-Received: by 2002:a05:6512:12c4:: with SMTP id p4mr1044332lfg.280.1632345349597;
 Wed, 22 Sep 2021 14:15:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210909200948.090d4e213ca34b5ad1325a7e@linux-foundation.org>
 <20210910031046.G76dQvPhV%akpm@linux-foundation.org> <CAHk-=wgfbSyW6QYd5rmhSHRoOQ=ZvV+jLn1U8U4nBDgBuaOAjQ@mail.gmail.com>
 <202109211630.2D00627@keescook> <af3c775a1515f97c8dbe6a6651bd6e4b6986e8cd.camel@perches.com>
 <202109211757.F38DF644@keescook> <YUraGKetS+Tgc7y9@localhost.localdomain>
In-Reply-To: <YUraGKetS+Tgc7y9@localhost.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 22 Sep 2021 14:15:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjS-Jg7sGMwUPpDsjv392nDOOs0CtUtVkp=S6Q7JzFJRw@mail.gmail.com>
Message-ID: <CAHk-=wjS-Jg7sGMwUPpDsjv392nDOOs0CtUtVkp=S6Q7JzFJRw@mail.gmail.com>
Subject: Re: function prototype element ordering
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>, apw@canonical.com,
        Christoph Lameter <cl@linux.com>,
        Daniel Micay <danielmicay@gmail.com>,
        Dennis Zhou <dennis@kernel.org>, dwaipayanray1@gmail.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Linux-MM <linux-mm@kvack.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        mm-commits@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Tejun Heo <tj@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 12:24 AM Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> Attributes should be on their own line, they can be quite lengthy.

No, no no. They really shouldn't.

First off, no normal code should use that "__attribute__(())" syntax
anyway. It's ugly and big, and many of the attributes are
compiler-specific anyway.

So the "quite lengthy" argument is bogus, because the actual names you
should use are things like "__packed" or "__pure" or "__user" etc.

But the "on their own line" is complete garbage to begin with. That
will NEVER be a kernel rule. We should never have a rule that assumes
things are so long that they need to be on multiple lines.

We don't put function return types on their own lines either, even if
some other projects have that rule (just to get function names at the
beginning of lines or some other odd reason).

So no, attributes do not go on their own lines, and they also
generally don't go before the thing they describe.  Your examples are
wrong, and explicitly against kernel rules.

           Linus
