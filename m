Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D64BF3675F4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 01:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343798AbhDUX4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 19:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343795AbhDUX4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 19:56:51 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F6FC06138A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 16:56:16 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 12so69122086lfq.13
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 16:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jScCnNgYw+6uXS8RCkV8cOc6vpYKM4nhpFzQC4X8xFk=;
        b=yKDcISw4Xf9Y6DAbYtERNo2KXM8uXDgE5zo/M7c4Sl0Iv59UyI29FxTe2p5hOMIbb3
         up/5xEp8950jm15ieI4xIuG2kU1aaIxapyBeAVSUcLicX2/G80dsENZf7X8uasnniopa
         Z/PpSlL4QVmkaK4sbPIzHdO0BNkynbeY0uUB62C7/e/qPGoU7qKQEtd+pQid0ezxl23G
         77vTvPGogIild+X0Xlp9wxQ8HeIFIaahVsANiZjoqLRPw3TnHiMozXUL72krnvEcOamy
         oZcSCTRqG3hWEqszfRo4Z0ZaDsWSm0vAarrTANYFAxtCesFH+FvP2i7fR8z18sQHbaps
         ykBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jScCnNgYw+6uXS8RCkV8cOc6vpYKM4nhpFzQC4X8xFk=;
        b=Y1RKQ+nhT5PfHQxSA742if+N52CIqBye4npoXX7MHG/t8La30CTxY4uHs4ExWCwL+S
         ODgPeZevSbyUCAJQXXZNITe8FNnKbsWa9wkKmBoFIpaiNCzFqgbuoqFWHpjtXjyt2Rsn
         JvtsBVpdR3HWP4NcB5yJG9g6gIC6UyZwb0O+1PLOQb0REeNqKq66Z8X+M5ZhlD5oWF5h
         pwfxwMIyx1DedGdnQziH9pbIOoSSq2/7Z4Ff/FM+hLANqwFy0BqLwNJKWLXJd0yq3ipK
         HkCxPIF7057RMEIp5lOgQoemeat+dXrjPMxoObj5N1IMUtdnH8dOToxs5Whff0hYJqCq
         FO5Q==
X-Gm-Message-State: AOAM530lM471Z+vKk3NUoISOSvsLkZLnTNkPCyf+qvB2m7wLfRFk66xa
        EtbA5ltHHtVJXq45NlkWJ7M/F+m5PIgkXRNuCSoHWA==
X-Google-Smtp-Source: ABdhPJybEltUhG63+NS74YGYPxZwjzpS4nqORopVa+7OGxpP9OaH5uXEFitYtWUmoQv4AnEQ/yq7qrRaqescIGAUUzk=
X-Received: by 2002:a05:6512:3a85:: with SMTP id q5mr473572lfu.465.1619049375213;
 Wed, 21 Apr 2021 16:56:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210415123521.86894-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210415123521.86894-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 22 Apr 2021 01:56:04 +0200
Message-ID: <CACRpkdZvLqWp3tozHLpALKojuC6U_fE_4b_eHF9MM3K+0RCzGg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] pinctrl: core: Fix kernel doc string for pin_get_name()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Drew Fustini <drew@beagleboard.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dong Aisheng <dong.aisheng@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 2:35 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> The kernel doc string mistakenly advertises the pin_get_name_from_id().
> Fix it, otherwise kernel doc validator is not happy:
>
> .../core.c:168: warning: expecting prototype for pin_get_name_from_id(). Prototype was for pin_get_name() instead
>
> Fixes: dcb5dbc305b9 ("pinctrl: show pin name for pingroups in sysfs")
> Cc: Dong Aisheng <dong.aisheng@linaro.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Patch applied, thanks!

Yours,
Linus Walleij
