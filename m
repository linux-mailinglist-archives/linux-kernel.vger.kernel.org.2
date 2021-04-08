Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F448358DF0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 21:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbhDHT6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 15:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbhDHT6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 15:58:38 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6984C061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 12:58:26 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id g35so2150217pgg.9
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 12:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=4N1kjjTn55rRbrrq/+KkyyeUWallp6st2fMntbajpqU=;
        b=BCvpnIT9aDF246OVUAgc5nq8a6442rj3yQakx88oV2SsypMLWEG7w9vVgsHnCDFkJR
         9cmz2xx8A9nSY/b4gwVsKPc+ZUFVKj8Y/KDwkwlec/2WMpwDX/rpqdPzjxpYAkjY5K3l
         rZ3Tj9oMJft8ZtX+7QYPTcu6Hgt6sZKodgflw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=4N1kjjTn55rRbrrq/+KkyyeUWallp6st2fMntbajpqU=;
        b=ln0h4xh6xy9Tz3iw8J5MaXoEoYZeh0x3DuyYVPLCb35QKX1lwBlR1YDissI1j8hzx3
         IGWXS7OzmFwqApSNDteaOhdfGK8k/mKPWAfdGqxvgO9nZ5zAo6SQgA9oG0u5m6CWIvtM
         iFiIk/QQAACWMnfEZLwSYwbJ3l3GJ7nlDPis/Ts93lbcWild4mHu8y7A1k/r0tnPKYa3
         0n8SUnDXXP31h+ASDoU+13gA29YDMnId/2u3/Sm6ZDfJcDFBwSMqWZWwQivWrx+dkHn3
         CeDwLjpFIxEtoMCUzdXvDsmryj/p517VY795FOyaFXJEx7gqke0Q27JtfkKT/80KP2Hu
         DjCQ==
X-Gm-Message-State: AOAM530pU8qv/DkbsUAFMM/iXFsAzt8gn9CJPFNNrEJ5Ol58G0thOrbh
        i0b3IUhCGns4xqnXC+zEyUz2AA==
X-Google-Smtp-Source: ABdhPJwqiFpgOMZvV25vaiurpiKlJiF7EbI5S8Ah7GbKPuDSnbspWHIUElJlAEgYwYHaOiDyJci5HA==
X-Received: by 2002:a63:78cc:: with SMTP id t195mr9367700pgc.196.1617911906233;
        Thu, 08 Apr 2021 12:58:26 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:201:44c3:3248:e7f5:1bbd])
        by smtp.gmail.com with ESMTPSA id f187sm252780pfa.104.2021.04.08.12.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 12:58:25 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210408101743.GB22237@MiWiFi-R3L-srv>
References: <20210331030520.3816265-1-swboyd@chromium.org> <20210331030520.3816265-13-swboyd@chromium.org> <20210407170328.x7hgch37o7ezttb6@pathway.suse.cz> <20210408101743.GB22237@MiWiFi-R3L-srv>
Subject: Re: [PATCH v3 12/12] kdump: Use vmlinux_build_id to simplify
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org
To:     Baoquan He <bhe@redhat.com>, Petr Mladek <pmladek@suse.com>
Date:   Thu, 08 Apr 2021 12:58:24 -0700
Message-ID: <161791190437.3790633.11239676305383366588@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Baoquan He (2021-04-08 03:17:43)
> On 04/07/21 at 07:03pm, Petr Mladek wrote:
> > On Tue 2021-03-30 20:05:20, Stephen Boyd wrote:
> > > We can use the vmlinux_build_id array here now instead of open coding
> > > it. This mostly consolidates code.
> > >=20
> > > Cc: Jiri Olsa <jolsa@kernel.org>
> > > Cc: Alexei Starovoitov <ast@kernel.org>
> > > Cc: Jessica Yu <jeyu@kernel.org>
> > > Cc: Evan Green <evgreen@chromium.org>
> > > Cc: Hsin-Yi Wang <hsinyi@chromium.org>
> > > Cc: Dave Young <dyoung@redhat.com>
> > > Cc: Baoquan He <bhe@redhat.com>
> > > Cc: Vivek Goyal <vgoyal@redhat.com>
> > > Cc: <kexec@lists.infradead.org>
> > > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > > ---
> > >  include/linux/crash_core.h |  6 +-----
> > >  kernel/crash_core.c        | 41 ++----------------------------------=
--
> > >  2 files changed, 3 insertions(+), 44 deletions(-)
> > >=20
> > > diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> > > index 206bde8308b2..fb8ab99bb2ee 100644
> > > --- a/include/linux/crash_core.h
> > > +++ b/include/linux/crash_core.h
> > > @@ -39,7 +39,7 @@ phys_addr_t paddr_vmcoreinfo_note(void);
> > >  #define VMCOREINFO_OSRELEASE(value) \
> > >     vmcoreinfo_append_str("OSRELEASE=3D%s\n", value)
> > >  #define VMCOREINFO_BUILD_ID(value) \
> > > -   vmcoreinfo_append_str("BUILD-ID=3D%s\n", value)
> > > +   vmcoreinfo_append_str("BUILD-ID=3D%20phN\n", value)
>=20
> I may miss something, wondering why we need add '20' here.

The build ID is an array of 20 bytes and this format is to print 20
bytes in hex.
