Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 294C5387AC1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 16:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349834AbhEROMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 10:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243415AbhEROLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 10:11:55 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DAD3C061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 07:10:37 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id n17-20020a7bc5d10000b0290169edfadac9so1619785wmk.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 07:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uciGMhDNE+3AdHOBR36VygtN6g1olwQ+V1Q/JfTf6uE=;
        b=up5JGa14TDHNjghPLD3cDOUMtcauCcSHlehpYRnTZ89uND/nGiCDU2u0MiXTn7HWyZ
         2E611xcSilvVolRaZpR0tvRjMLzoSmp4stY/P4twVsskipTIFvgHqygmQkOLzF76G353
         p16L5kDmdDvMEwbZ1gCJvhoC8aTMaj48iS/KI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uciGMhDNE+3AdHOBR36VygtN6g1olwQ+V1Q/JfTf6uE=;
        b=NJym4UnuECd60/VRTE3P/pSow/YA5m70P1TUPOxYIdonFX+UD/8oTJ8yIncZh4dRAc
         gVydo6UuWL/GRnzqT1t0elvBMhrjj9mUJkBvoluf1vdLC3O6If0SSbr7FWnjV0RqXasG
         WXyN7Rtw7QT2Dlw4+LDjp3CyfJ+QVsTXcHRdGHsOtyt56Wpx/esTI7FgFYre1V6bzGQ2
         Q6AvEuFecIiWA9sF7nzT6wn/MamI1pxP1I81YyZRbgK/JPpVfJLnDYp2Wmr/DLOJiSPK
         k20FHY9IFhyNapUdzbz67FHPAYqMFBQLKhegFimeNMpcX/kbywfJJlGQxNH/T9+RKPNE
         9f3Q==
X-Gm-Message-State: AOAM533lBd9tOX5AieSDeicqm+Pn+d8Nlo02abpBl6Mwi7q7gt9AH6lE
        2E6NhfLqGFD1PfTSBQMg5tNEGg==
X-Google-Smtp-Source: ABdhPJzNELWhZrTYWiEk4O7ExPc7KZlRivlxPc+bOu95Ti4f5eX0ueUZidbj/RINeRQUbHJoeql/aA==
X-Received: by 2002:a1c:ddc5:: with SMTP id u188mr5914527wmg.12.1621347035938;
        Tue, 18 May 2021 07:10:35 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:5c4a])
        by smtp.gmail.com with ESMTPSA id d3sm22160306wri.75.2021.05.18.07.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 07:10:35 -0700 (PDT)
Date:   Tue, 18 May 2021 15:10:34 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Jessica Yu <jeyu@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>, kernel-team@fb.com
Subject: Re: [PATCH v6 1/4] string_helpers: Escape double quotes in
 escape_special
Message-ID: <YKPK2gT+W8Eu04ND@chrisdown.name>
References: <cover.1621338324.git.chris@chrisdown.name>
 <56771f7dafd884d8d2ffcf104104a0c2522391d4.1621338324.git.chris@chrisdown.name>
 <YKO8xeR8q5Wdv8ZT@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YKO8xeR8q5Wdv8ZT@smile.fi.intel.com>
User-Agent: Mutt/2.0.7 (481f3800) (2021-05-04)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Shevchenko writes:
>We have only one direct user of ESCAPE_SPECIAL and there " is not used.
>
>Indirect ones are %pE, but IIRC most of them are either debug messages or some
>kind of (non-ABI) messages.
>
>It would be nice if you can confirm this and put a note into commit message.
>
>If the above is confirmed, feel free to add mine
>Reviewed-by; Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks for reviewing! :-) I will triple check that and add for v7.
