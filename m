Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9D5544E131
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 05:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbhKLE4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 23:56:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbhKLE4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 23:56:00 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F988C061767
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 20:53:09 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id d72-20020a1c1d4b000000b00331140f3dc8so5916679wmd.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 20:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+ZiK5wyX3w4aM56kpjKnvax97Zf+ILLyAN73jdIclOk=;
        b=nwNt1Sff2RO1rmMjwEnVbRH/WctJXwTqpx/5jay3NVnqB7pLY0wUCZqRVmnsniPiKi
         K8KkYQIOVsxu8uxJ7h0Emeq7dqnjxplLMTZiHxx1P6Y85Si2BheuH618ZgIKYqUfOhf2
         9KmFds6DMdTgeyf7Taib4UDCrmiI8bCOr45Oq0sPdTxZxi+uZ2TyvZO5uPuaA1p1u78D
         416j7egryMw/onpBrCVZYJAAjmx3nEUBzxjKrN0ubOVOY5KKiZVMVz5RAKezU+X6EEwU
         YhdDBsN3hlbhI4af0kGSO7VlFkU0RzPFb7kzMPg7akknUOXjJZo8HfoQNKXWqJryCMr0
         hljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+ZiK5wyX3w4aM56kpjKnvax97Zf+ILLyAN73jdIclOk=;
        b=kBdadqEYyqhdW3VsVv/TKxOPHUrkD1Cv/L+wW+3r+SqxXyQHTlPOCofw6YqjoVuiIL
         rl8rep+0EgA7+ksyqPZUCIfr4TnpCWWiRqs6x2iisiW4JcTWbJzsUPEP03xm2jhvY7cC
         rVX9Mj+mn2sUulowkJGl2ulxBd6gp0CNB59VVtQfFJeb98cE3jBpGcw+JkesPsf2dGmi
         8UU4wH1OoboosbZNIE6V50XBHzB7DPJlcL7VWzWOuV9im+Bock8av9IrqYOPHWNY1a15
         VhIvmHf32qFgKHRv2RrfYCgqZtPwMzPSgxwuW04xrVExbdUtHoptxW855G/peHHsr+g7
         KyBA==
X-Gm-Message-State: AOAM532vymhZ3JPrmiLKQBLixRlwAW8BJlnuEaCcS2SWVt/i8LJcZG/q
        A51VsVCDL2uwzCxL5myEATS5aAiIOBz24CSMbdDGtg==
X-Google-Smtp-Source: ABdhPJx1NoY+HM4gMq8uAeYZD6EaGY7DKZ9zkiLAg0dxrfsir9P7I6VW4CEl9H3wzxJFfVELpp9dR3VXw4oDPX9JoPU=
X-Received: by 2002:a05:600c:35c8:: with SMTP id r8mr14369696wmq.8.1636692787987;
 Thu, 11 Nov 2021 20:53:07 -0800 (PST)
MIME-Version: 1.0
References: <20211111183356.4073001-1-dlatypov@google.com>
In-Reply-To: <20211111183356.4073001-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 12 Nov 2021 12:52:56 +0800
Message-ID: <CABVgOSmOd4L+9HPT6ajq8zZ6RLBkHiXXa04F1JZcE83+31+HyQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: revamp message for invalid kunitconfig
To:     Daniel Latypov <dlatypov@google.com>
Cc:     brendanhiggins@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2021 at 2:34 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> The current error message is precise, but not very clear if you don't
> already know what it's talking about, e.g.
>
> > $ make ARCH=um olddefconfig O=.kunit
> > ERROR:root:Provided Kconfig is not contained in validated .config. Following fields found in kunitconfig, but not in .config: CONFIG_DRM=y
>
> Try to reword the error message so that it's
> * your missing options usually have unsatisified dependencies
> * if you're on UML, that might be the cause (it is, in this example)
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

Thanks -- I think this is a good improvement: the previous message was
pretty opaque.

Reviewed-by: David Gow <davidgow@google.com>

>
> Note: this is based on https://lore.kernel.org/linux-kselftest/20211106013058.2621799-1-dlatypov@google.com/
> There's a fairly trivial merge conflict between these two patches (that
> patch changes the line above where this diff starts).
>
> ---
>  tools/testing/kunit/kunit_kernel.py | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
> index 7d459d6d6ff2..350883672be0 100644
> --- a/tools/testing/kunit/kunit_kernel.py
> +++ b/tools/testing/kunit/kunit_kernel.py
> @@ -266,15 +266,17 @@ class LinuxSourceTree(object):
>         def validate_config(self, build_dir) -> bool:
>                 kconfig_path = get_kconfig_path(build_dir)
>                 validated_kconfig = kunit_config.parse_file(kconfig_path)
> -               if not self._kconfig.is_subset_of(validated_kconfig):
> -                       invalid = self._kconfig.entries() - validated_kconfig.entries()
> -                       message = 'Provided Kconfig is not contained in validated .config. Following fields found in kunitconfig, ' \
> -                                         'but not in .config: %s' % (
> -                                       ', '.join([str(e) for e in invalid])
> -                       )
> -                       logging.error(message)
> -                       return False
> -               return True
> +               if self._kconfig.is_subset_of(validated_kconfig):
> +                       return True
> +               invalid = self._kconfig.entries() - validated_kconfig.entries()
> +               message = 'Not all Kconfig options selected in kunitconfig were in the generated .config.\n' \
> +                         'This is probably due to unsatisfied dependencies.\n' \
> +                         'Missing: ' + ', '.join([str(e) for e in invalid])
> +               if self._arch == 'um':
> +                       message += '\nNote: many Kconfig options aren\'t available on UML. You can try running ' \
> +                                  'on a different architecture with something like "--arch=x86_64".'
> +               logging.error(message)
> +               return False
>
>         def build_config(self, build_dir, make_options) -> bool:
>                 kconfig_path = get_kconfig_path(build_dir)
>
> base-commit: c949316af0a7c2103521aaa39be85392e2f02bab
> --
> 2.34.0.rc1.387.gb447b232ab-goog
>
