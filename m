Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1906240B410
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 18:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235313AbhINQDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 12:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235253AbhINQCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 12:02:48 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E92C061762
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 09:01:30 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id x27so29899865lfu.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 09:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O7o8nytLXMUXQdmXcn0J+cx6AmEuTmtKjrOwXucFFVw=;
        b=V9DkA3YxNFNKt+kZfIU6UYrbnjxqTVpU5jxLXsh+y7SsxT3fJ0JPgfzuoszBZZZtTF
         jksmWVGYCq05qzNmFTHTCJ4xcvTQvUtqU1RFlAeKMSohHNvkuV1h+llPH9kBRWDHtj/D
         YVV2qWwx2D8qnjaPYa3v/ADQKFRZwfamoKYegxKGfl6UwF4LF8Mu3e4pIREZ7ee8h3/l
         Wawh0vASCAtz0qH+oEMOx1Uabk4pngW0LUghGESdC/F0a+Yph5g9p/bsTqMU4LDEm1EG
         LJUY7DprzgF9dQ/2pg0hOjZZILp1WIOVJ36rDc5THVEPyPjKCY78FzBo7JvfKxIBnH70
         79RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O7o8nytLXMUXQdmXcn0J+cx6AmEuTmtKjrOwXucFFVw=;
        b=i2XHkTEoAwxzf28IdtRyZ+aOzqGIR/GMnJrlhTu9ZV94pVRhC7EZEY4TOzxtw4SWu5
         E8OU4RL5QioHvIOadg8IcuJQj4iDtC2Q/xGpOZBiHNeod+HiDDz0wDSctn3iGlrbIoM4
         RDi4s2ei8vLmXdOBCSVew+Bjxfy+HGyFNY2Q+Sciza70HgDYzlbZxdJgRQmIUVakNa1J
         wS7Q+ggk/RmIGwTTNNcx4ge8GvvqlbszNmMMDvZBuCe+UllI/nni5AzTA+duwxjKiVfE
         6TvY27G5Xzu+yHzOa00bEgOWxo8IwvOq9htvkgHBJO0zzgSb2SDMe4CzL3n24ob+qMqg
         hyGA==
X-Gm-Message-State: AOAM530QZOoYaRUvRir8rJuqGQBwm3vm8RQWBvjtcQ0FKkN+g0Y7gtg5
        m/wyOG/D3SRgltemiiDnmD33NRppcpNA+RpQ3Axu7w==
X-Google-Smtp-Source: ABdhPJwtPU5sKsSabfh0/4yuY25XZ69r6VnK8XAXkSz7SaLhqqmYnXbo0MQ9LZqRpoAguVUswo3zICjPngHSMuQ0+fA=
X-Received: by 2002:a05:6512:3b9e:: with SMTP id g30mr13372286lfv.651.1631635288279;
 Tue, 14 Sep 2021 09:01:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210914154441.1726853-1-andreas@rammhold.de>
In-Reply-To: <20210914154441.1726853-1-andreas@rammhold.de>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 14 Sep 2021 09:01:16 -0700
Message-ID: <CAKwvOdnW8kNHFC2sSOASm63m1D5vULF9-UOy2mJrF2tPdgh6pQ@mail.gmail.com>
Subject: Re: [PATCH] gen_compile_commands: add missing sys import
To:     andreas@rammhold.de
Cc:     Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 8:44 AM <andreas@rammhold.de> wrote:
>
> From: Andreas Rammhold <andreas@rammhold.de>
>
> The sys.exit was being used at multiple locations within the script but
> never imported. This lead to the script exiting with a error instead of
> with the nicely formatted (useful) error output.
>
> Signed-off-by: Andreas Rammhold <andreas@rammhold.de>

Hi Andreas,
Thanks for the patch. Someone beat you to the punch though:
https://lore.kernel.org/lkml/20210908032847.18683-1-kortanzh@gmail.com/.

This is good; it means folks are playing with this. :)

> ---
>  scripts/clang-tools/gen_compile_commands.py | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/scripts/clang-tools/gen_compile_commands.py b/scripts/clang-tools/gen_compile_commands.py
> index 0033eedce003e..1d1bde1fd45eb 100755
> --- a/scripts/clang-tools/gen_compile_commands.py
> +++ b/scripts/clang-tools/gen_compile_commands.py
> @@ -13,6 +13,7 @@ import logging
>  import os
>  import re
>  import subprocess
> +import sys
>
>  _DEFAULT_OUTPUT = 'compile_commands.json'
>  _DEFAULT_LOG_LEVEL = 'WARNING'
> --
> 2.32.0
>


-- 
Thanks,
~Nick Desaulniers
