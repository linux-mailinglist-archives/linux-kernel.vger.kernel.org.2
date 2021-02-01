Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B20D530AC2A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 17:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbhBAP7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 10:59:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbhBAP7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 10:59:09 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B58C061756
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 07:58:28 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id i6so10953168ybq.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 07:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JoSWAB8tYFyJpcsNX+CN9GuhUPZE1Ihwm8K0UfiFLtI=;
        b=fUmgSJtL5aOyDU5a3GIqmq+j8rdIjyIbpQEuzBuU9cZ/4c7Uw446OmDo1DOKSO3SvG
         rCTf/QQ5PADmSAt5Zoyr/kDXmNO3B1NOhSjJ4XYm5PQwFAqtOPmPvbBB242ehSB3iHNX
         7XNyrK94ahQLx+3T9R1v7R5uGrgcxouB1RCsYLm9VNxQAzMF398jChR7O0ILu8yZuRF0
         K8a4RAqBjxjbi6M+NOsN0slmeUE4q9Je6A3NQRAJ222AaVRxtNVjo/AbiW/vuHbNrxEb
         xCuG6nPELdi7+kRLG6hBKL8SyqU2vh+Wx6+mD5o97EAMkuexJmuLvTcx53DpYD0MVJ+I
         R+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JoSWAB8tYFyJpcsNX+CN9GuhUPZE1Ihwm8K0UfiFLtI=;
        b=QEtkQsKAa0owpEeEP/qs5LlMLURxwV60+tURwM0Xb6klE8c/1Vb5HG//KOoHiHfZGC
         jF22nxKI1b++MKWklMoCvP7uJYev1fxOs7zRJ95h1OThtvYpE6UBOPk6Nodgz3ocmrH4
         0rC0Bvl9opWUOuQqIF09BzNF8WH3J1yyqBGKZWI5V40dIIfVCIBJyxk3/p2VpQ/gwlqf
         y6GgcEyRr4KtMdykJAEW4UqyD2gcPAV8+Qi2Y1MQ2v27Mv6wSWvsPTkSew/X0KVHFaw1
         IbrQ3V0e+sw88bbDEHmAMza9+NB4iML8DPvDD9LgfQgr+kJdQ1AlxC3qAw4HLx+V1nuN
         9yMA==
X-Gm-Message-State: AOAM5320/ib82AOwZgoew/QzYzyjXhVfeurMQ9Q6A4zJuOv32+0znyJY
        cGgY+ax4esW2EGKgoP0JVki4TBjNHWerIhJQ8Zc=
X-Google-Smtp-Source: ABdhPJw1Pyfipegady8vF9jKKiG2pXANIgSFEEKwmuGUsnmRV98TACN/1lnBBvHmygmz7JEceWtsMeqhvlqYrBwa1b4=
X-Received: by 2002:a25:1b88:: with SMTP id b130mr21666925ybb.26.1612195105952;
 Mon, 01 Feb 2021 07:58:25 -0800 (PST)
MIME-Version: 1.0
References: <20210201041532.4025025-1-masahiroy@kernel.org>
In-Reply-To: <20210201041532.4025025-1-masahiroy@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 1 Feb 2021 16:58:15 +0100
Message-ID: <CANiq72kdUhVgDXSAWt3E=27NtMtC9Bwr3hFN9SKyAFP1VL6O3Q@mail.gmail.com>
Subject: Re: [PATCH] init: clean up early_param_on_off() macro
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>, Johan Hovold <johan@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@gooogle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 1, 2021 at 5:15 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Use early_param() to define early_param_on_off().

Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
