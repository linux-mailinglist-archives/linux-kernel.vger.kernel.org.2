Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D19FA30F9DC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 18:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238643AbhBDRgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 12:36:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237552AbhBDRfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 12:35:37 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408AAC061793
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 09:34:55 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id o18so2954445qtp.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 09:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5xmJVsVdWUE9F9n1Lv8bIW1y5TAc3hCeceqbQVJQ3kA=;
        b=aDxeiSQQzZ+jvYCu9zsBzOqE41xXqisDBldzgBIrkJILMT6Umm8PovVXlab75DnLcv
         rWO3S7m21IsXtB7Cqc9cADYU6bYG0/4Sa4xROWpVZ0IBAo7bTqh/FZXBasEJXw3zk25E
         kqq4wN1WBOUkfuPH3h+PJVMViJKBbIFE2LXN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5xmJVsVdWUE9F9n1Lv8bIW1y5TAc3hCeceqbQVJQ3kA=;
        b=dPMMNpv2hRCwNOKGxstzM16Z8d2a+33IEuFcOiOcl4RSKDTWIviY9mqWSVnjk28zUv
         36SFscAze/LMbmuwXyjr0zUzDgI6WqylK5VvfHnR0UgBt5k7tbhZsdexbPmjD5tPs28W
         k7f3TM9g9utmDoGfzQntxoFnmRVv+07R1LiTJODc4Sl+Dya40oSwihxhPvKdCiq7syAj
         qxcKs4Ix3Bk2j9Su3pMXlC0zFcYeSlR5UMjLPndekio9P56xHhz7CBZ0r3Zy8NZYXfbz
         Q6me9wqDC2zDh9lJiKH4ZkJY92HuFJxQgRtS5UiiIBnEb2YRFXhqjB/n4wRvQ/ro5cQe
         +aUw==
X-Gm-Message-State: AOAM530lYILhi1vED91o3u8RZHDxbvwnzudkKMm5fEGRXG3Bf8XbcHxi
        rB1koy+1dThTZJCKrMufhJI461AU/AW2Bw==
X-Google-Smtp-Source: ABdhPJzClcvb4FaXCb1LucUcsVuJhWH4p6DCVuJCTAYT0L684+Fdb719OWOjGiC9hUmmdlVsEI5f0A==
X-Received: by 2002:ac8:59cd:: with SMTP id f13mr659555qtf.258.1612460094042;
        Thu, 04 Feb 2021 09:34:54 -0800 (PST)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id 138sm5931697qkd.80.2021.02.04.09.34.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Feb 2021 09:34:53 -0800 (PST)
Received: by mail-yb1-f173.google.com with SMTP id c3so4002039ybi.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 09:34:52 -0800 (PST)
X-Received: by 2002:a25:4fc3:: with SMTP id d186mr335253ybb.343.1612460092412;
 Thu, 04 Feb 2021 09:34:52 -0800 (PST)
MIME-Version: 1.0
References: <1612433660-32661-1-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1612433660-32661-1-git-send-email-sumit.garg@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 4 Feb 2021 09:34:40 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VWq6Z7a=-JRCiggYcdekRAN9VWQnsX+03jOVFOBRi3BA@mail.gmail.com>
Message-ID: <CAD=FV=VWq6Z7a=-JRCiggYcdekRAN9VWQnsX+03jOVFOBRi3BA@mail.gmail.com>
Subject: Re: [PATCH v2] kdb: Refactor env variables get/set code
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Feb 4, 2021 at 2:14 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Add two new kdb environment access methods as kdb_setenv() and
> kdb_printenv() in order to abstract out environment access code
> from kdb command functions.
>
> Also, replace (char *)0 with NULL as an initializer for environment
> variables array.
>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>
> Changes in v2:
> - Get rid of code motion to separate kdb_env.c file.
> - Replace (char *)0 with NULL.
> - Use kernel-doc style function comments.
> - s/kdb_prienv/kdb_printenv/
>
>  kernel/debug/kdb/kdb_main.c | 166 +++++++++++++++++++++++++-------------------
>  1 file changed, 93 insertions(+), 73 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
