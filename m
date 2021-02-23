Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDAC63230E9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 19:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbhBWSnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 13:43:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbhBWSnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 13:43:06 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F701C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 10:42:26 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id j19so12692027lfr.12
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 10:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nW1+AMD4PYuhUkEM4FM2B5KEsUAeGbVHXYzkjyeSfIk=;
        b=d1TNtHWo0c2fjpEv6kjIPQYRTGZgT5yURrXaWeBuWVHjBD9iQ5AVQKpN6dJIpx/Ai8
         KGKxfLQK+QkHGApZMf/VwslQizlNzZMo91q8DtOSyuhNgLnjmVprfsK0C/fQzFcSPf4T
         uPUTOPEy5TICl8vs2pej3ewerJc4regAyZv+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nW1+AMD4PYuhUkEM4FM2B5KEsUAeGbVHXYzkjyeSfIk=;
        b=jD7SAL73DiElbibMWPF3zDfvjQl12z0VOOMSS3LMKDXrtakb7Y4mnKFR+Yx3L2g3YK
         5g2h2Wp/QEglq80PVxgWR1fPo1gSslkjb0K6L87vvZYrBPTzUb3aQA2ISdXZ8BMXG9O9
         HorwhnODsn0nE4H3+Pu9IhL1DQ9k63p440SU7K0sXASIAK8TTkT1z7JIZHIh17VoFw4o
         PstmS2GVNjFhDScGb5coVSZdc6PQKApLsugFpaHhLkBKmm86oBp5BQsQB6D+/zPb6uj/
         lNVD8krPbR1ZxZIQofN8b6O5PdFTT+B+W93FdfgexiPxd7+Is2bLdNpwyf2COp5v7ToP
         dlYA==
X-Gm-Message-State: AOAM532eJvW/0+rVXS6++IJbN+oMqBqOlSQ2HU/fNZYtv6ldwx+iYXqo
        b5Dj3opQvsK3jvVp0udiPUtotxVS/TE1rA==
X-Google-Smtp-Source: ABdhPJz9PY+KRhOuhLaYevOTmqKz5MlVwjAge4zf6SqdBR8FGIDlrr6kgNsbiQzrrx+xrgw+YqEJsw==
X-Received: by 2002:a19:910e:: with SMTP id t14mr18330029lfd.282.1614105744433;
        Tue, 23 Feb 2021 10:42:24 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id k22sm785109ljj.31.2021.02.23.10.42.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Feb 2021 10:42:23 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id o16so59653693ljj.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 10:42:23 -0800 (PST)
X-Received: by 2002:a05:651c:110e:: with SMTP id d14mr18515605ljo.220.1614105743465;
 Tue, 23 Feb 2021 10:42:23 -0800 (PST)
MIME-Version: 1.0
References: <YDUibKAt5tpA1Hxs@gunter> <CAHk-=wipCbbXswcFvnrGae01H54dY1+XoaL+9YaiU71zGzko3Q@mail.gmail.com>
In-Reply-To: <CAHk-=wipCbbXswcFvnrGae01H54dY1+XoaL+9YaiU71zGzko3Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 23 Feb 2021 10:42:07 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh8vHL43v7GWK9MWrWitSmOmrEw1B0AJD9CrhBc4FvpxA@mail.gmail.com>
Message-ID: <CAHk-=wh8vHL43v7GWK9MWrWitSmOmrEw1B0AJD9CrhBc4FvpxA@mail.gmail.com>
Subject: Re: [GIT PULL] Modules updates for v5.12
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 23, 2021 at 10:26 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Feb 23, 2021 at 7:42 AM Jessica Yu <jeyu@kernel.org> wrote:
> >
> > Please pull below to receive modules updates for the v5.12 merge window.
>
> Pulled.

Actually, I take that back.

I think there is something horribly wrong in my tree, and my build
process is now about 30% slower. It went from 5+ minutes to 8+
minutes. The main suspect would be some lack of parallelism.

I can't see anything in the module pull that could possibly cause
this, but it seems to have coincided with that pull.

I'm investigating, but the output stopped for a long time at

  CHK     include/generated/autoksyms.h

Ring a bell? Did something change in here?

                Linus
