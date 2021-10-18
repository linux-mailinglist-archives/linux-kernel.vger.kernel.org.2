Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C52B243267E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 20:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbhJRSg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 14:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232873AbhJRSg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 14:36:58 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF31C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 11:34:46 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id g36so1757988lfv.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 11:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3yIhmbyQ2Bjkk7ltMaflrF9iqPQ0fQAIQa9ANGo7kQY=;
        b=mDxHYkIrPyFlZcLd5Lmf1h58osaKBBKImi0vwaR9AA+Z6wjTxmrsnvuHuvVSnRqO5O
         tcs5Wjp2GKH1xK6CecmcUeqjV0xPYjjQPc/2K35jolYlUmWxJxpq6MBFkoC2E/Amf6FN
         YVJERs/vNIyNQ4HZAyDsgejKJWne6YVrLoISBqmJ3HjwHmGU0h6mgx7WDmU+yFmLPIj6
         w0QCSEKlDkaSFaMpyV8+KXG/bcRYC/oLFFZxRrMXl2UAIVUeLBbgFXVxoziea9wdTfKN
         Ok659w6Q+wE/o34cHM90CHcGMjN/VA2l+VOBT73rCrXANUNGs8fOrqxrzdK0tLNRjeoU
         lcPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3yIhmbyQ2Bjkk7ltMaflrF9iqPQ0fQAIQa9ANGo7kQY=;
        b=U5NgOZR/0wE9abN+s5gNRwDc1dCzoWKr2oHtNKzWR2s66djKY9xcJBXKi5ogVgTwmi
         7g9xJl6lZoLTTAd1nEu3s/HOzkXUCQ/GZW55w+CJXrpC8cFNrZgzBpK2ss/vtLJazri0
         YcbdTZG0VFy23DfQVHoQzmBODb5jwItjm8GGu8byywNPq/JYhn9cW+XCeCkbX7IO3W78
         3eRpZcC50/JTz+tMg7QYUYfzY6QfkigoaGrXRKeKqYAM5YegPPmbLSQtE8dF3jELzaQN
         phaHp5Ll/1neiaLqsIJVxWJMXSSwcRwss5EEXgISUH05vWOm/RWCvfq20pJaXeSaSoa6
         9cQA==
X-Gm-Message-State: AOAM530KjJ6UYxmbGtJZXlB8nr5V9zwGj2op+SHPEelfdnXbE3ig0/ct
        vevqXH/waTVXDR+gehykmAof3hKiNbHrUiwSz2HJmA==
X-Google-Smtp-Source: ABdhPJxhiujb58an/syD4wS+0Veklak5dKdvkCcFTUL6Moc+I4DMxvUUPWzB27PibGVVK8AIsW60KddeGG8GuSGi05s=
X-Received: by 2002:a05:6512:b0a:: with SMTP id w10mr1323928lfu.240.1634582084713;
 Mon, 18 Oct 2021 11:34:44 -0700 (PDT)
MIME-Version: 1.0
References: <20211018182537.2316800-1-nathan@kernel.org>
In-Reply-To: <20211018182537.2316800-1-nathan@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 18 Oct 2021 11:34:33 -0700
Message-ID: <CAKwvOdn4_DrgaZoAo-v7CbYurNUpfAK5tnzT023=WCDzkmYQVg@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: Fix bitwise vs. logical warning
To:     Nathan Chancellor <nathan@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tor Vic <torvic9@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 11:26 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> A new warning in clang points out a use of bitwise OR with boolean
> expressions in this driver:
>
> drivers/platform/x86/thinkpad_acpi.c:9061:11: error: use of bitwise '|' with boolean operands [-Werror,-Wbitwise-instead-of-logical]
>         else if ((strlencmp(cmd, "level disengaged") == 0) |
>                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>                                                            ||
> drivers/platform/x86/thinkpad_acpi.c:9061:11: note: cast one or both operands to int to silence this warning
> 1 error generated.
>
> This should clearly be a logical OR so change it to fix the warning.
>
> Fixes: fe98a52ce754 ("ACPI: thinkpad-acpi: add sysfs support to fan subdriver")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1476
> Reported-by: Tor Vic <torvic9@mailbox.org>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

LGTM, thanks for the patch! I guess this would be the first
"interesting" case this warning has found in kernel sources?
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  drivers/platform/x86/thinkpad_acpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index 07b9710d500e..7442c3bb446a 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -9058,7 +9058,7 @@ static int fan_write_cmd_level(const char *cmd, int *rc)
>
>         if (strlencmp(cmd, "level auto") == 0)
>                 level = TP_EC_FAN_AUTO;
> -       else if ((strlencmp(cmd, "level disengaged") == 0) |
> +       else if ((strlencmp(cmd, "level disengaged") == 0) ||
>                         (strlencmp(cmd, "level full-speed") == 0))
>                 level = TP_EC_FAN_FULLSPEED;
>         else if (sscanf(cmd, "level %d", &level) != 1)
>
> base-commit: 85303db36b6e170917a7bc6aae4898c31a5272a0
> --
> 2.33.1.637.gf443b226ca
>


-- 
Thanks,
~Nick Desaulniers
