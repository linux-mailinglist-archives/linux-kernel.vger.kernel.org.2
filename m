Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB783AA67C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 00:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234060AbhFPWK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 18:10:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:36106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230355AbhFPWKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 18:10:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D26961076;
        Wed, 16 Jun 2021 22:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623881298;
        bh=BD273yABex25SB8fv/8nERQkMbaDvLqsi8tVPEQWNxA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lyTzVCkN214gX28y3GVPDC8fHZU1LEr6mMirfhUpCiJSl6FfOvIynWXHzc5ZHmWzd
         RJy5UPqwZcLHchkQuGHjZnNKA3fDizy7sWxMShxQG7DKGxF142tEM/oURyxNNbjnrC
         vOm6eHH+rHzcsPPQM71p1IiQUEmMw98T/Eol+uFB+NB2I8UE2YB3B3z75tNe16ujy/
         5u+Hr7PNIatSakz6jhG3WRgbAVEtGo2su06ahWklKO4nPAwMDWqoui6ibVaGytJIKn
         YsNIeTB8GVr/1NxmZcnZYVMqVGqDg7+Tsor/57eJRPpTNKMcqaQSAPsClYr8kFu/FM
         XnoEsCEQes9QA==
Received: by mail-ed1-f46.google.com with SMTP id i13so1113499edb.9;
        Wed, 16 Jun 2021 15:08:18 -0700 (PDT)
X-Gm-Message-State: AOAM533Dp4tu4yKx3kOGPgB/Y4QCExozZD0isHHkxUuFdOlnnCRjgIMm
        2VqYAf6iaeQekFYboXgWsPe+NDtiVPoiZnxwMA==
X-Google-Smtp-Source: ABdhPJxCkllYiupo8FEv1dotZCuGq3DKtEY9a1vzJuNFz3aDURB/vEMfp9Hrd4spCvHyDfPmvTzJgapyTYbFxKLDtYI=
X-Received: by 2002:a05:6402:1d0f:: with SMTP id dg15mr2292962edb.137.1623881297110;
 Wed, 16 Jun 2021 15:08:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1623824363.git.mchehab+huawei@kernel.org> <0048c23d47b582dd1a1959628fd2b895209ac826.1623824363.git.mchehab+huawei@kernel.org>
In-Reply-To: <0048c23d47b582dd1a1959628fd2b895209ac826.1623824363.git.mchehab+huawei@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 16 Jun 2021 16:08:05 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLtZhox5-d81FnWywqM6waBv5fJ26z2n9rMw8wrn4aDqg@mail.gmail.com>
Message-ID: <CAL_JsqLtZhox5-d81FnWywqM6waBv5fJ26z2n9rMw8wrn4aDqg@mail.gmail.com>
Subject: Re: [PATCH v2 11/29] docs: devicetree: bindings: submitting-patches.rst:
 avoid using ReST :doc:`foo` markup
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@protonmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 12:27 AM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> The :doc:`foo` tag is auto-generated via automarkup.py.
> So, use the filename at the sources, instead of :doc:`foo`.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  .../devicetree/bindings/submitting-patches.rst        | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/submitting-patches.rst b/Documentation/devicetree/bindings/submitting-patches.rst
> index 104fa8fb2c17..8087780f1685 100644
> --- a/Documentation/devicetree/bindings/submitting-patches.rst
> +++ b/Documentation/devicetree/bindings/submitting-patches.rst
> @@ -7,8 +7,8 @@ Submitting Devicetree (DT) binding patches
>  I. For patch submitters
>  =======================
>
> -  0) Normal patch submission rules from Documentation/process/submitting-patches.rst
> -     applies.
> +  0) Normal patch submission rules from
> +     Documentation/process/submitting-patches.rst applies.
>
>    1) The Documentation/ and include/dt-bindings/ portion of the patch should
>       be a separate patch. The preferred subject prefix for binding patches is::
> @@ -25,8 +25,8 @@ I. For patch submitters
>
>         make dt_binding_check
>
> -     See Documentation/devicetree/bindings/writing-schema.rst for more details about
> -     schema and tools setup.
> +     See Documentation/devicetree/bindings/writing-schema.rst for more details
> +     about schema and tools setup.

These don't match $subject.

>
>    3) DT binding files should be dual licensed. The preferred license tag is
>       (GPL-2.0-only OR BSD-2-Clause).
> @@ -84,7 +84,8 @@ II. For kernel maintainers
>  III. Notes
>  ==========
>
> -  0) Please see :doc:`ABI` for details regarding devicetree ABI.
> +  0) Please see Documentation/devicetree/bindings/ABI.rst for details
> +     regarding devicetree ABI.

Is this new? You did review my oneliner adding ':doc:' not too long ago.

>
>    1) This document is intended as a general familiarization with the process as
>       decided at the 2013 Kernel Summit.  When in doubt, the current word of the
> --
> 2.31.1
>
