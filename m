Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA048406002
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 01:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349188AbhIIXXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 19:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349239AbhIIXXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 19:23:01 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075B4C061575
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 16:21:51 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id f18so140986lfk.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 16:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Ip6KeFGcMX6jk9gP4cDHs2yNmjHzz+Km9aVu9mX3ZE=;
        b=PDH0k14suDx2erif+Etm2SZyyScxLmkUEtTlX1eWR0TBNG0r8lWhLn6ZvxqwKoY3ci
         i7s1ryMlCEII7y6dkPcEQ0oJMtO64o88WtQ7jZ/3SDF7nuKYvJLfXlpqAaE8hG4vx3aL
         TRMu3W7UGfv9Jt2Ic4dz98+v1tX0C2JahfpvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Ip6KeFGcMX6jk9gP4cDHs2yNmjHzz+Km9aVu9mX3ZE=;
        b=Jl63QkZXX7y+OyUNtSHyvwEyRpPFNOa2ssfe1S/+F3MvkQfR8iZyWmL+fXjKtwQ54Q
         J38j4Og37A4jD2dnNqIndQoRHJWwtQl1W6dt7zYRnlsAwcdYD3hSTr1OWvp0zKlRBMP5
         g1YGU72QlBRR4/FLHlLEU5uzc5Cj/VDL9/xzhg+nsqTNPU0iowIvpdzYmyqwKWDZG5b9
         uXJGJYenTqUqoyinFcnT87oQJBNgvsXC4uFdB6LIYycnZTqUE2qqvowUz0fkAWMJE5up
         QoRiLxD2IhUmj7kmz7dcxPRvo7AblHcLZuYaGLwOq0+WqrUApz0UTx5cGKELlA1jqlBe
         f8xA==
X-Gm-Message-State: AOAM531GmOsjjKSGWQbu8tsguCBW/4Ktd4PspecAEPeNIhQcxMd9AD2I
        IQaOhOrRConHITu4eepCjCJm9sa77N9ZoDCAThE=
X-Google-Smtp-Source: ABdhPJwOJNcVOYSs81dR1nZralsE18F5isGGYpQCDCP+q1z6h/VqPSesSPDaRoWCtvQakNDRawgCig==
X-Received: by 2002:a05:6512:3f03:: with SMTP id y3mr1661926lfa.5.1631229708767;
        Thu, 09 Sep 2021 16:21:48 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id i5sm341439lfb.124.2021.09.09.16.21.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 16:21:48 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id a4so168793lfg.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 16:21:47 -0700 (PDT)
X-Received: by 2002:a05:6512:3da5:: with SMTP id k37mr1641237lfv.655.1631229707726;
 Thu, 09 Sep 2021 16:21:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2r5mvadF7FkC1NhVyYNBG_XzwH4daryt42YLJrHnn5ws1Y=A@mail.gmail.com>
In-Reply-To: <CAH2r5mvadF7FkC1NhVyYNBG_XzwH4daryt42YLJrHnn5ws1Y=A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Sep 2021 16:21:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiE8+=FvKk8nEdh62S_khLgoaasOo4kkwERaMK0u3GZqg@mail.gmail.com>
Message-ID: <CAHk-=wiE8+=FvKk8nEdh62S_khLgoaasOo4kkwERaMK0u3GZqg@mail.gmail.com>
Subject: Re: [GIT PULL] ksmbd fixes
To:     Steve French <smfrench@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 9, 2021 at 2:59 PM Steve French <smfrench@gmail.com> wrote:
>
> 18 ksmbd fixes including:

Sigh.. The text in the tag says 19.

But 18 was indeed correct.

For next time, if you're not quite certain, git can help you with these things:

   git rev-list --count --no-merges linus..

or similar.

But the important part is just the overview of what's actually going
on, not the number of patches. I tend to mostly edit that out anyway.

                Linus
