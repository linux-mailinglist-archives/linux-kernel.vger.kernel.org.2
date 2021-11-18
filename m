Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C37545523B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 02:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240829AbhKRBfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 20:35:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236932AbhKRBfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 20:35:21 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED332C061764
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 17:32:21 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id np3so3787029pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 17:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SUDgqfw79hNY26jZLVy2BdIxOeMeyBTKUtGKG0JHeTw=;
        b=QYl8ZU55MVbn3YPwuz5xDclB08EJ+6GPPyntZKH9cfg2QabRftq+ARsPg369M8Sxqh
         yLd1Q6n81LUZii+3Vluc61d0pMKUvIiV1BaIJ+TdbXqc+uRohINknm3Kf8rmUdataLhR
         j5CW+tjM8I/7R4yU0LQd/pqJDGTsQJBIW0yvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SUDgqfw79hNY26jZLVy2BdIxOeMeyBTKUtGKG0JHeTw=;
        b=QzQXhYkAmOyPTTcqMEr9KyaPhKht8KwVa68FQM7lBguUftY4PNkMmE8DwWdPq+tSqZ
         qZHjhVg5M83iNR5mo9qu95QrtReUYIyWsW8+BCeWgqaanwmMYSC9won70BLvdrA2LiWT
         V4WhFYyEq/4M3ZRJ0l1YWVhMMRX11c6xNUS1wwkaONCI9x1OqFROpXvhf6A7x033P4yF
         pghYOOoGrIZEGg8Uvk/2ss72I7GmWLWlmCV48hj06jhNbTy+e45S8oOh6l8t15lSoEt2
         HkpF6b8TsYmSiULGbGUMAEYeFTcB7po+tk0yFmu2cjIBqqYmH7431HUVdxO/v6HYBwTV
         lcyw==
X-Gm-Message-State: AOAM532GU2DvVNyAM58hiUsLwMcYCOyBi2CL+KveomLWb+zr83I819V1
        NX8kT3mO9YDPU/PZOGdzzGLsmA==
X-Google-Smtp-Source: ABdhPJw9NtNZOMzIIpkK69AK3HEXLRQJphzbtDxsSk/X76HyTEGYyivUAENDyGjliOWUtPegjsJMUA==
X-Received: by 2002:a17:90b:4c44:: with SMTP id np4mr5467213pjb.195.1637199141467;
        Wed, 17 Nov 2021 17:32:21 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ip6sm6855084pjb.42.2021.11.17.17.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 17:32:21 -0800 (PST)
Date:   Wed, 17 Nov 2021 17:32:20 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Kyle Huey <me@kylehuey.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrea Righi <andrea.righi@canonical.com>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        Robert O'Callahan <rocallahan@gmail.com>
Subject: Re: [REGRESSION] 5.16rc1: SA_IMMUTABLE breaks debuggers
Message-ID: <202111171728.D85A4E2571@keescook>
References: <CAP045AoMY4xf8aC_4QU_-j7obuEPYgTcnQQP3Yxk=2X90jtpjw@mail.gmail.com>
 <202111171049.3F9C5F1@keescook>
 <CAP045Apg9AUZN_WwDd6AwxovGjCA++mSfzrWq-mZ7kXYS+GCfA@mail.gmail.com>
 <CAP045AqjHRL=bcZeQ-O+-Yh4nS93VEW7Mu-eE2GROjhKOa-VxA@mail.gmail.com>
 <87k0h6334w.fsf@email.froward.int.ebiederm.org>
 <202111171341.41053845C3@keescook>
 <CAHk-=wgkOGmkTu18hJQaJ4mk8hGZc16=gzGMgGGOd=uwpXsdyw@mail.gmail.com>
 <CAP045ApYXxhiAfmn=fQM7_hD58T-yx724ctWFHO4UAWCD+QapQ@mail.gmail.com>
 <CAHk-=wiCRbSvUi_TnQkokLeM==_+Tow0GsQXnV3UYwhsxirPwg@mail.gmail.com>
 <CAP045AoqssLTKOqse1t1DG1HgK9h+goG8C3sqgOyOV3Wwq+LDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP045AoqssLTKOqse1t1DG1HgK9h+goG8C3sqgOyOV3Wwq+LDA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 05:20:33PM -0800, Kyle Huey wrote:
> Yeah that's one way to solve the problem. I think you're right that
> fundamentally the problem here is that what SECCOMP_RET_KILL wants is
> not really a signal. To the extent that it wants a signal, what it
> really wants is SIGKILL, and the problem here is the code trying to
> act like SIGKILL but call it SIGSYS. I assume the ship for fixing that
> sailed years ago though.

Yeah, this was IIRC, a specific design choice (to distinguish a seccomp
KILL from a SIGKILL), as desired by the sandboxing folks, and instead
of using two different signals (one for KILL and one for TRAP), both
used SIGSYS, with the KILL variant being uncatchable.

-- 
Kees Cook
