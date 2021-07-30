Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9883DB6D8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 12:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238445AbhG3KHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 06:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238395AbhG3KHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 06:07:00 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0DEC061765
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 03:06:54 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id p5so10591424wro.7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 03:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lXeo4aYimJxnDYbg1LxiGfrP/ZMdpRBQtu3fCof7FPk=;
        b=mOjmNOYoHokGGePIZRcmD3gOaE94LdsYLCHIj4lM+x6RYFUApXN6nfoqBo/simcvys
         l4RxXIzFK5fqrBT00aI2XhEcWGkoFqDH//ioOuUVmJGZPRyhIUhGu8ClHKo7yLC8g7eZ
         THklx+EvGI0j1nAE59MHy3pAxePq7Bn4/w6X26ATFZoLSpS+rKtdABt/pYcAuWACDhJR
         YVDq/UR8cM4hdV9KU20Hq9pgd8XAyFPLxckbMQwVGIJRBMLjYxUbKBtAJQsGmojHwWUZ
         cj6z6FyS2LTmJeZ9qIrGqE/cl7HSwuhjBPAaOFjcjZwbYzGQ7mt0Far/OUHQJhKL9qq8
         UPdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lXeo4aYimJxnDYbg1LxiGfrP/ZMdpRBQtu3fCof7FPk=;
        b=i8v1HM3sGT5nT9vU6W53JMt7WR4SHn1WzebQb3BVF5P1FrYzbOz9I/1Pl/+vuareXm
         BKw7Kzeaj3gmVuHQVR/hNnt40qfHDY45uFSMP0ag21FSzXblnFBJ1yiXgYjBwTx0yH2g
         y81z8WvEucI7RksYNIt2FvcNtITFp3M5V8OeP2HGkURULyxclc33c+2vY1xQoJ1/vslz
         ghvY0yOwTLYxnsv5kOOdU4yRhcXyzuK05l2K1Z+wuU10a7VhdQKBpIVoPaY1t2hb/g+c
         70fUEY6B6R/oIWrOFeamsveKJCg/KbqSlE/Z9jQdRT9UR4RaIU8oYsW5aSvvITVn/jut
         1C1Q==
X-Gm-Message-State: AOAM531myJxU1A62OvFdEvN+NUISAwcdJm5W7PiquJmnvF+mHA2TOP1h
        qmk8Fr5/SEytnoMC0RlqpHYKug==
X-Google-Smtp-Source: ABdhPJxFAazihg9MdTDdS5uuWJN6e8/9LMeef8q0AuiVhN8vBu+SBt8FIrQUlK0YUML22N51OKwj8g==
X-Received: by 2002:a5d:4585:: with SMTP id p5mr2136596wrq.265.1627639613172;
        Fri, 30 Jul 2021 03:06:53 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id v12sm1161711wrq.59.2021.07.30.03.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 03:06:52 -0700 (PDT)
Date:   Fri, 30 Jul 2021 11:06:51 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net, jason.wessel@windriver.com,
        dianders@chromium.org, rostedt@goodmis.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/4] kdb code refactoring
Message-ID: <20210730100651.of7dd7jzjmzpzfcx@maple.lan>
References: <20210712134620.276667-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210712134620.276667-1-sumit.garg@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2021 at 07:16:16PM +0530, Sumit Garg wrote:
> Some more kdb code refactoring related to:
> - Removal of redundant kdb_register_flags().
> - Simplification of kdb defcmd macro logic.
> 
> Tested with kgdbtest on arm64, doesn't show any regressions.
> 
> Changes in v5:
> - Incorporated minor comments from Doug.
> - Added Doug's review tag.
> 
> Changes in v4:
> - Split rename of "defcmd_set" to "kdb_macro" as a separate patch.
> - Incorporated misc. comments from Doug.
> - Added a patch that removes redundant prefix "cmd_" from name of
>   members of struct kdbtab_t.
> 
> Changes in v3:
> - Split patch into 2 for ease of review.
> - Get rid of kdb_register_flags() completely via switching all user to
>   register pre-allocated kdb commands.
> 
> Changes in v2:
> - Define new structs: kdb_macro_t and kdb_macro_cmd_t instead of
>   modifying existing kdb command struct and struct kdb_subcmd.
> - Reword commit message.
> 
> Sumit Garg (4):
>   kdb: Rename struct defcmd_set to struct kdb_macro
>   kdb: Get rid of redundant kdb_register_flags()
>   kdb: Simplify kdb_defcmd macro logic
>   kdb: Rename members of struct kdbtab_t

Series applied, thanks!


> 
>  include/linux/kdb.h            |  27 +-
>  kernel/debug/kdb/kdb_bp.c      |  72 ++--
>  kernel/debug/kdb/kdb_main.c    | 626 +++++++++++++++------------------
>  kernel/debug/kdb/kdb_private.h |  13 -
>  kernel/trace/trace_kdb.c       |  12 +-
>  samples/kdb/kdb_hello.c        |  20 +-
>  6 files changed, 357 insertions(+), 413 deletions(-)
> 
> -- 
> 2.25.1
