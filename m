Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9745D39C98D
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 17:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbhFEPpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 11:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhFEPpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 11:45:23 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F8BC061767
        for <linux-kernel@vger.kernel.org>; Sat,  5 Jun 2021 08:43:34 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id t16-20020a05600c1990b02901a0d45ff03aso6112936wmq.2
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jun 2021 08:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=clvSa+JvU6uBZ+o4YWIoUVY1T/E/2QPROQXufQI5L34=;
        b=T0g+7NMfdg+/GWUIM/XuSqgrwASyZbRCGDGVNvTo3QwR7HHSOvoJeV5wwnhAYyEu8p
         lNCqV8yQ7QZXDNGNVrsstpm1xDzeS/IWZMneJbjVR+IHlGfredBoI6hFBgUpSnP1+rcw
         lPRPTiKnOkt32MhcYup1zoHo6FabIXls9uVdcH8vAJ++OGYRgSsDqb5sCZYbbDgOHYI6
         h1BMPdgCtpaVHpGaoFHrUaKGqsD5sauVVUh/AxjDkxobKYd+46Q+iYA+e4fO2kSeqB1k
         trU0dGYNFBnEOSl22Uu/TgW1U4k+IVbgIlUDqqcX5K/6JMdMM/BI2Kmydu2ehZunaF0u
         ESWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=clvSa+JvU6uBZ+o4YWIoUVY1T/E/2QPROQXufQI5L34=;
        b=ToRunVcnDlBgCeWcn9U/xBI6OaqI3VdyWRB9WnX9TYCIhoEO7k76bJJuSuc/ovgXiz
         WDwuh3YkKfFaSF1TWnEStgaV7I6VHzPU4pjVI9LmYGMPjXMVMJ69EnyaTy4DlDIVLrIv
         DDgxpC58JIJfhzLpxr4FD0XKAqeoo5olaW358U9yZu2upBCFAcEU7/cFqmNs+NGO1mPV
         Yz2GRMRn3ErnvmrCK1RzrWIHafU4QPb3+ypkYCzuj1F/qNC29aj/SSLj2d8P/Loba0ga
         2RKoQ1gJjTbsQV8JdoH7Vdtk0r/xaN1L8L/inRoryAiVKwiyBbbBeItDsndixPPXedLU
         +T/w==
X-Gm-Message-State: AOAM531BoZ6BYjjFLlIEN5i7eL2fWeL/0vJW7+nt4BfgVYUXJyj2EDsH
        Bdbhls3L/OanYE73SF/v+5ROVzE8biOl8DwY6+lAcQ==
X-Google-Smtp-Source: ABdhPJw4Dw/ErnZ+CAGXFG16Mr96Iq3PCkOCpBV8t6JOv8RyD39fk8GHFGJiW0cDt6C2hHns9FgdWJ5t4GAeTvXvhxo=
X-Received: by 2002:a1c:1dd3:: with SMTP id d202mr8688712wmd.78.1622907813308;
 Sat, 05 Jun 2021 08:43:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1622898327.git.mchehab+huawei@kernel.org> <08ac283ac5bdc2664255a7ad34514e50d3ed85d8.1622898327.git.mchehab+huawei@kernel.org>
In-Reply-To: <08ac283ac5bdc2664255a7ad34514e50d3ed85d8.1622898327.git.mchehab+huawei@kernel.org>
From:   David Gow <davidgow@google.com>
Date:   Sat, 5 Jun 2021 23:43:22 +0800
Message-ID: <CABVgOSmheB_f5gNc_zyuDHrwdRs_x_osutorJbLUMGpRRU4nzA@mail.gmail.com>
Subject: Re: [PATCH 02/34] docs: dev-tools: kunit: don't use a table for docs name
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 5, 2021 at 9:18 PM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> We'll be replacing :doc:`foo` references to
> Documentation/foo.rst. Yet, here it happens inside a table.
> Doing a search-and-replace would break it.
>
> Yet, as there's no good reason to use a table there,
> let's just convert it into a list.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---

While I personally quite like the look of the table when rendered by
Sphinx, I think the list is much more readable as plain-text, so this
is okay by me.

That being said, a definition list[1] seems like it should be better
still, though I can't get it to work with the kernel's Sphinx
configuration, so let's stick with this for now. (Given we've only got
one page of documentation here, the whole thing doesn't matter much
anyway.)

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

[1] https://rest-sphinx-memo.readthedocs.io/en/latest/ReST.html#definition-list


>  Documentation/dev-tools/kunit/api/index.rst | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/dev-tools/kunit/api/index.rst b/Documentation/dev-tools/kunit/api/index.rst
> index 9b9bffe5d41a..b33ad72bcf0b 100644
> --- a/Documentation/dev-tools/kunit/api/index.rst
> +++ b/Documentation/dev-tools/kunit/api/index.rst
> @@ -10,7 +10,7 @@ API Reference
>  This section documents the KUnit kernel testing API. It is divided into the
>  following sections:
>
> -================================= ==============================================
> -:doc:`test`                       documents all of the standard testing API
> -                                  excluding mocking or mocking related features.
> -================================= ==============================================
> +Documentation/dev-tools/kunit/api/test.rst
> +
> + - documents all of the standard testing API excluding mocking
> +   or mocking related features.
> --
> 2.31.1
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/08ac283ac5bdc2664255a7ad34514e50d3ed85d8.1622898327.git.mchehab%2Bhuawei%40kernel.org.
