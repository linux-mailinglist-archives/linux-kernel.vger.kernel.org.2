Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFCA3364A90
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 21:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241698AbhDST1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 15:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238544AbhDST1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 15:27:32 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CA8C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 12:27:01 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id 8so3250840qkv.8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 12:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KS1Cjb+5IzYaeizmFEnxlkXXC1aDE7oEixJIHEs6ylA=;
        b=QZyi5Dji5AdE+5SQ4n5JeA0XoUR5PxmbDUHrQlM5UM35yIi+V9Axd/qupj8VClmRG/
         H/ATUNdBmPGCBvSW3iPG5RqNJDyB9Enl5iGmjbti97I9NhmfqPe2Mk3lC6Icu1ljq+3x
         1Dh3GcwFbeQh3R09pc2S70kyLZLPl3lj9+nzCRQavmynOE2Zjk1VRxxRHu2SN8cjTZpF
         uNloS75jdZd4e2G6RRGflr2Cs6Mq/BXpnfTOUt3GslrfBB0hxvQIpZqsqvHa1zjFwRGy
         vDRQEBWgrLh0oqvDeznsMOKa/QtPnANTR3cQ2dzkAC177TRnTuldyhCiK/F5wKfZEwgX
         cbcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KS1Cjb+5IzYaeizmFEnxlkXXC1aDE7oEixJIHEs6ylA=;
        b=M6awh5Ph8bybW4ChuxhgmpX020kDXnd4vEs2Ovv5citQzQSrLL2lzNM8e4efuDtmAd
         PAzZS+HELxYubOiuA9qQltZTbw3awRC1DbGRWEsHGp7B+jXzBEmkfrnnEOArXNq0xap0
         y0k2vwBmaOvtouqvyqLVXeir3ByjkzLTMTQ9WvmGT0MRgSfOTcmNUHfRfzdyTX+hPsGB
         KclNmd+sXHpOn/BZz2alqVLy6zai3k5JssSk1UqDWhxPvB09fgHQBQMNh8EkXHS8s5lz
         w8s8vsZdZeLl72cZ+JEFNDFkitOYipmZhdKw0pjnLh4bpa+rH/A8aR4czJjRGmHyrHEl
         EnCg==
X-Gm-Message-State: AOAM531ittZM9OZz3lWOyLeZT/f3DEoLZBOcFuCFgeDC9z4FtLd4zy4o
        RIh4CUfgMVrjZmbGW5eN8zEK2wgs4eGJdgYWF1k2Mg==
X-Google-Smtp-Source: ABdhPJz6J9DwdEtBiJaAUR5+atIHfVrTiOYv1hJdpb++RbLiw+J3imF4ECYNCO1gx/CONDh314Cdpaw8wb2C/OcNGHU=
X-Received: by 2002:a37:a788:: with SMTP id q130mr12712225qke.276.1618860420267;
 Mon, 19 Apr 2021 12:27:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210412101421.609526370@infradead.org> <20210412102001.287610138@infradead.org>
 <YHhp0THHD2ofUdZD@hirez.programming.kicks-ass.net>
In-Reply-To: <YHhp0THHD2ofUdZD@hirez.programming.kicks-ass.net>
From:   Josh Don <joshdon@google.com>
Date:   Mon, 19 Apr 2021 12:26:49 -0700
Message-ID: <CABk29NtFEcKxicJ-zG338Z-gUd5-6rwiB=58K4+ZqkJ+S3v2Og@mail.gmail.com>
Subject: Re: [PATCH] sched/debug: Rename the sched_debug parameter to sched_debug_verbose
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, greg@kroah.com,
        linux@rasmusvillemoes.dk,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Looks reasonable to me.

> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4756,7 +4756,8 @@
>
>         sbni=           [NET] Granch SBNI12 leased line adapter
>
> -       sched_debug     [KNL] Enables verbose scheduler debug messages.
> +       sched_debug_verbose
> +                       [KNL] Enables verbose scheduler debug messages.

boot param is not renamed from sched_debug below.

> @@ -22,7 +22,7 @@ early_param("sched_debug", sched_debug_s
>
>  static inline bool sched_debug(void)

nit: consider renaming. Or, we can even get rid of this function
entirely, since in the !CONFIG_SCHED_DEBUG case we have
sched_debug_verbose defined to 0.
