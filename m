Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E5A36B98D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 21:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239871AbhDZTBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 15:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240804AbhDZTAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 15:00:34 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D1AC061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 11:59:50 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id a25so52086850ljm.11
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 11:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N6NhyOtw+47/wlSJQy44o+Q+9qeFKYm6+1wm+9Mor5I=;
        b=W4B5jO/WpbeTL6sGvTyuUrIymMntan1MJKukHcm0sUR5tMf0hNrTBF25OJxDmP+3MP
         tXn6F90eiPO+5LdV8R56hK+uu/6tndnNrMnnigaKK3G0y+Nq2D1KAGVCsMZtrO3YhtUH
         ijDagMJpAx2tRWSUFkTk6/IFPCOIcKLf0fpow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N6NhyOtw+47/wlSJQy44o+Q+9qeFKYm6+1wm+9Mor5I=;
        b=e8+PP0fDHXmwHR7gHU9FUyDlZ3c5SFLQhrw0B/ISoj9tg2BsCkyGKWnE3FOCpAQbRu
         2B6J5zb+kqZB+J3idI/0nhEI9Ai7URzJ9yG0CZB85LwJqrVZtSdmmEBtomvWjcnXNet+
         +ecoUC1qILmkqr+XFp1AN2bb1NefHLLCFnEC5PPRIwHs/als4zM2i/CzdrKl5AnDfDja
         7jWD/jOJBRsqWjdOdRJx1ybEtPSfYC584kW1J45u1XkoxRqNklkuuyBT/HyPZ3s8lWz3
         GG+2yk/RH1sUk5il+uwFWNmCyOmSkQIKHuqyHViTug0Hjfj9J6gqNTN20Rc6Vb7mqt7H
         1DIw==
X-Gm-Message-State: AOAM533kBcduNMxP67lBCljuugCGqe7W3GU0Diy9HWSO/bs7J4hKznj5
        py6JPmKlbowOn95/OO5AYF++ql679aSFiVuv
X-Google-Smtp-Source: ABdhPJxhdAhgtNDXGOM2nRE9heyZr098UvIveN2cffzRO+g5ZZmQxc7UqvVPOOnLCEmI3ByYHnRPTw==
X-Received: by 2002:a2e:9953:: with SMTP id r19mr14027874ljj.132.1619463588850;
        Mon, 26 Apr 2021 11:59:48 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id h5sm91105ljj.98.2021.04.26.11.59.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 11:59:48 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id a36so54542895ljq.8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 11:59:48 -0700 (PDT)
X-Received: by 2002:a2e:330f:: with SMTP id d15mr13954436ljc.251.1619463587784;
 Mon, 26 Apr 2021 11:59:47 -0700 (PDT)
MIME-Version: 1.0
References: <09464e67-f3de-ac09-28a3-e27b7914ee7d@skogtun.org>
In-Reply-To: <09464e67-f3de-ac09-28a3-e27b7914ee7d@skogtun.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 26 Apr 2021 11:59:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgA1Ma6e5qZO1EP9oMveLPJFbj=SC1R0ZewCmC-u0_r=A@mail.gmail.com>
Message-ID: <CAHk-=wgA1Ma6e5qZO1EP9oMveLPJFbj=SC1R0ZewCmC-u0_r=A@mail.gmail.com>
Subject: Re: [BISECTED] 5.12 hangs at reboot
To:     Harald Arnesen <harald@skogtun.org>
Cc:     johannes.berg@intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 11:47 AM Harald Arnesen <harald@skogtun.org> wrote:
>
> Bisected to commit 776a39b8196dbca4afb69669db0d9926ffac29ab, and
> reverting this makes the machine reboot as usual.

Hmm. That was already in rc1, so this isn't some late untested
last-minute commit that broke things for you.

Which implies that it's likely something fairly specific to  your
setup (either the config or the hardware - or possibly Void Linux
doing something other distros don't).

Mind also attaching a dmesg of an affected kernel (or with the revert
in place, I guess - it shouldn't matter until the reboot ;)

There's a lockdep assertion there, but you don't seem to have lockdep
enabled. So it be interesting to see what happens if you

 (a) enable lockdep

 (b) make sure to reboot in text mode so that any lockdep messages
would actually be visible.

Maybe Johannes will go "Doh!" and see what's wrong.

                  Linus
