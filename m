Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADC035E5D5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 20:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343897AbhDMSDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 14:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242024AbhDMSDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 14:03:36 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0659C061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 11:03:13 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id l14so17494095ljb.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 11:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q2LuJhzVKZ4Otm2O8xgEBL/YvpN8rgKv4ejnz0lZhBQ=;
        b=PO/bW2FzQ6FzDgtNlCdHkJnMiT/9i4p/A90U8bBxxRlm7QtH1Avg7IzpZfFUhf35To
         +ZprUvd82vXwEvPh0u/Wi3KG3gk81wdPlFg/XLIPaP/wNf+1sF0XsbnBxxL1x6krTUNB
         oAhJcsICyl5wezmkkpndEaqZQAhKrbopebRWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q2LuJhzVKZ4Otm2O8xgEBL/YvpN8rgKv4ejnz0lZhBQ=;
        b=lylzW8qDZ1Fbv0OUoa2hEc9aBqYqT+Vzv1FIScXL6PFzUvS4XRB2SHkjMH8/brHSfi
         XVKEMZpjQVnVa9zXeGSLlINKgDGtgSbLrrsRMN4nugZDH8hw+7opOtm4Btf29loVTqVh
         iSXBofr+UJRbelNkVXG7f9ocWKCqVlO0uTo+XCsueVeUM6U3/HIsJeqP7m1DA3Rwx6KK
         rTk7QeI0EbIGPKaNokiV5/eemHLbTlTOhREwkuhrwKmoRFBrs0lPCf5sEZqjNXRhzmYW
         eKwhRWfwrehcbkCQOcLrk7J5Uqe6LzqJ7Y3fAvBF0LN1VdVNN6Za8bTuxy1thGRu2Fnj
         F0uQ==
X-Gm-Message-State: AOAM533pojCSItRFSFD/XN6eEKJAAJ84j4lgf5PeEIiomXEB6rsa20+D
        U4OgJVIWOTKB7LPnNPVXIXqyaos1n3eAwnhOV9J9Qg==
X-Google-Smtp-Source: ABdhPJzhrB2wAPmm6F6wdESZbAAnM20kVhcjVE6+YBb8Q9dx2+OjXTPj+pfRlhGpetqNXpEueb9hrrRKAaxhYYwq3nQ=
X-Received: by 2002:a2e:3013:: with SMTP id w19mr9815088ljw.97.1618336992322;
 Tue, 13 Apr 2021 11:03:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210413160151.3301-1-rodrigo@kinvolk.io> <20210413160151.3301-2-rodrigo@kinvolk.io>
 <20210413175355.kttgdouoyiykug5i@wittgenstein>
In-Reply-To: <20210413175355.kttgdouoyiykug5i@wittgenstein>
From:   Rodrigo Campos <rodrigo@kinvolk.io>
Date:   Tue, 13 Apr 2021 20:02:35 +0200
Message-ID: <CACaBj2ZieT2vH3_ywSkzzWXjJuSdBr1ytXdazTJ9-8mmA7xNvg@mail.gmail.com>
Subject: Re: [PATCH 1/1] seccomp: Always "goto wait" if the list is empty
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Sargun Dhillon <sargun@sargun.me>,
        =?UTF-8?Q?Mauricio_V=C3=A1squez_Bernal?= <mauricio@kinvolk.io>,
        Alban Crequy <alban@kinvolk.io>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 7:54 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
> > Fixes: 7cf97b1254550
> > Cc: stable@vger.kernel.org # 5.9+
> > Signed-off-by: Rodrigo Campos <rodrigo@kinvolk.io>
> > ---
>
> So the agent will see the return value from
> wait_for_completion_interruptible() and know that the addfd wasn't
> successful and the target will notice that no addfd request has actually
> been added and essentially try again. Seems like a decent fix and can be

Yes, exactly!

> backported cleanly. I assume seccomp testsuite passes.

Yes, seccomp selftests (tools/testing/selftests/seccomp/seccomp_bpf) passes fine

> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

Thanks!
