Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 805763C2AE8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 23:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbhGIVkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 17:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhGIVkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 17:40:11 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9FDC0613DD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 14:37:27 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id w2so2874001qvh.13
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 14:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+VTL8Gr8cJGnFpMbzE4kHRz33cFbsQ4k7/+zTR03H1M=;
        b=hjb/0vtyb9pSfK7D73LWl5iA20Zr54Uan5z9Z4bQEY6T7TkoJclXQnNFY34VWLaIjM
         MeVAduiH7O640f1IAxm6nMtnAn83bB/l11SFPnybDZrWICQi9vkSAUPCy7lmIlehxU5S
         Z5DAFcN8C1wsu7sh6NZ3vl2ESWHiG2zuDZKbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+VTL8Gr8cJGnFpMbzE4kHRz33cFbsQ4k7/+zTR03H1M=;
        b=lTVUrP1+BKhwX9rw5pkC5eZd2I6TocaZ3bghhoqxC5ydaLiVvArS7D+81kV34VHGlO
         Xp8CnjkJC4S38vrIajXj+WKzsv5BUeV+Ed6RqpM6FeUOsNfCTB5XxHzAv1DCFI9ZD8RH
         etGjvNBUiAcfDWsUSmYAxxhF+bCKDqUOjgaLmeSfBO2njG3Lw9HyAFGEAmausPI9tZBS
         6OGlbfx9gigrcw8c0I7bl6xafc2f5i2bzHiLQpZTa8/XLVT9+UhcM0t7EWhjmeGjBFiB
         0/z4sTP8ydwr50kPxAd/w0xnMd81CaKn/AaLJjfhDzLCgc6GvpNVn+M1fPFKWkJ022DW
         Ff0A==
X-Gm-Message-State: AOAM531GEzDxfjL/glqtSnm44vWkNILzU6v+RwJznTmRjKNqLBWBjBzv
        0+lu3OA8fn1aoga5RwexE5kSTnvE7IQOrA==
X-Google-Smtp-Source: ABdhPJzkU5e0mp1E5jbKbwLtjcKXr95HzQ3bPJmxUC6CXrMH5pU9iyaqXv5ptlNAJmE/ef1RxGlIWQ==
X-Received: by 2002:a05:6214:1087:: with SMTP id o7mr16755963qvr.27.1625866645968;
        Fri, 09 Jul 2021 14:37:25 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id p64sm3067522qka.114.2021.07.09.14.37.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jul 2021 14:37:25 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id p22so16665402yba.7
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 14:37:24 -0700 (PDT)
X-Received: by 2002:a25:d97:: with SMTP id 145mr51777675ybn.276.1625866644411;
 Fri, 09 Jul 2021 14:37:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210709104320.101568-1-sumit.garg@linaro.org> <20210709104320.101568-3-sumit.garg@linaro.org>
In-Reply-To: <20210709104320.101568-3-sumit.garg@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 9 Jul 2021 14:37:13 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WrfJEH-VYcf9ULC0pA5x0ju422c8GM1G1y33mJOmv1Fw@mail.gmail.com>
Message-ID: <CAD=FV=WrfJEH-VYcf9ULC0pA5x0ju422c8GM1G1y33mJOmv1Fw@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] kdb: Get rid of redundant kdb_register_flags()
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jul 9, 2021 at 3:43 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Commit e4f291b3f7bb ("kdb: Simplify kdb commands registration")
> allowed registration of pre-allocated kdb commands with pointer to
> struct kdbtab_t. Lets switch other users as well to register pre-
> allocated kdb commands via:
> - Changing prototype for kdb_register() to pass a pointer to struct
>   kdbtab_t instead.
> - Embed kdbtab_t structure in kdb_macro_t rather than individual params.
>
> With these changes kdb_register_flags() becomes redundant and hence
> removed. Also, since we have switched all users to register
> pre-allocated commands, "is_dynamic" flag in struct kdbtab_t becomes
> redundant and hence removed as well.
>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Looking at v3 responses [1], seems like you forgot to add again:

Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>

This also looks good to me now.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
