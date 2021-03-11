Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E87293372C3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 13:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbhCKMf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 07:35:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233190AbhCKMfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 07:35:05 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462A0C061574;
        Thu, 11 Mar 2021 04:35:05 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id g9so18770157ilc.3;
        Thu, 11 Mar 2021 04:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kD+l4kkxKKdUXJQ23AQkR8FXXJ0y04WGuJHxzgDJRv8=;
        b=MP98FclJzXBmegZ2Hfg3NslxwABrao5gudQXwGIRkIt0/b4bN97IOmPAzrA8NPZ4V1
         63Bkgl1x3VgSkyV4E5c633NfHfefkJ8aCnc0BHLJuDDRVS23pUVoRzO348MqUMV0y/Ro
         GkCO6rMuMm5jEZzXh49AMdDXjSnAe7oJZHqDHI/2/NpUtFnoLAZPxMbzmCl6scxu/TW8
         Nux+nl0RSz09QtfaKddJZoWe4KNIvo3ErRoGMXDoCW5DQJe/9YqZRWjspfSPlxSbFSV1
         w//suhuA5GOw3GfBHKF780pCI0ZVx9URuGjJYqd3HcpC7vVGniH7eIHA4/Z4Zntf0mse
         uEVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kD+l4kkxKKdUXJQ23AQkR8FXXJ0y04WGuJHxzgDJRv8=;
        b=kiVOIlTzS8ScSr531CDlsmMsIQ8P2c5ZLfhBHZYDiN3RuEPPgzAomsggh55e6x1VzL
         v4In39RZ40RnPVqzkv2WsBAq/cVCEBjmljM3dT2m+ccbGHVUfeECxpz/c9riLKAam6Lm
         jcuECE+Rx+r1ygeGxaUnM1VuvoWr5hz/gTXStZBCNCzs7O29TtsT0ArcE0Yo6da5hIvZ
         XE7kDMjPhPBsIvRc7H3LQ6KYGnOIA83Q1lBIsvF0Ao92s/U1WcbHJidgh+DgAwiZqMyf
         e0F/hvxaIL93Gu4LLUEEDQWs9khJnNnh8jB7lsuZRqx3Jog82VY/D6S2uuOdgEqfalfc
         h6RQ==
X-Gm-Message-State: AOAM530VryVeTRGS2Fqsrpsmv+GB5Ydk9AG5tUy8Yic44wkOUnh0dzgx
        WP5ojLQc1U2QRRqmmUp1QWBXa8YkaTkjz3vKWsw=
X-Google-Smtp-Source: ABdhPJzVtEakATdWW4VtfwUZKd0SXkdKNnUM5sILMsU4t79IaXrM/CeslMV4JekVnYf9MqTbg/ZxExNZ8xXnbCrWWFs=
X-Received: by 2002:a05:6e02:156e:: with SMTP id k14mr4381915ilu.200.1615466104755;
 Thu, 11 Mar 2021 04:35:04 -0800 (PST)
MIME-Version: 1.0
References: <1614758717-18223-1-git-send-email-dillon.minfei@gmail.com>
 <1614758717-18223-9-git-send-email-dillon.minfei@gmail.com> <a5b4a06c-60c4-ba56-5f5b-dd7a8c5a0d6d@foss.st.com>
In-Reply-To: <a5b4a06c-60c4-ba56-5f5b-dd7a8c5a0d6d@foss.st.com>
From:   dillon min <dillon.minfei@gmail.com>
Date:   Thu, 11 Mar 2021 20:34:28 +0800
Message-ID: <CAL9mu0K9f2rDsFeiVKT0izutxQzAU_=YBo6x7w1m=8gDhK9uOw@mail.gmail.com>
Subject: Re: [PATCH 8/8] ARM: stm32: add initial support for stm32h750
To:     Alexandre TORGUE <alexandre.torgue@foss.st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux@armlinux.org.uk, Vladimir Murzin <vladimir.murzin@arm.com>,
        afzal.mohd.ma@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre

On Thu, Mar 11, 2021 at 6:43 PM Alexandre TORGUE
<alexandre.torgue@foss.st.com> wrote:
>
> Hi Dillon
>
> On 3/3/21 9:05 AM, dillon.minfei@gmail.com wrote:
> > From: dillon min <dillon.minfei@gmail.com>
> >
>
> No empty commit message please
Okay, thanks for remind.
>
> > Signed-off-by: dillon min <dillon.minfei@gmail.com>
> > ---
> >   arch/arm/mach-stm32/board-dt.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm/mach-stm32/board-dt.c b/arch/arm/mach-stm32/board-dt.c
> > index 011d57b488c2..a766310d8dca 100644
> > --- a/arch/arm/mach-stm32/board-dt.c
> > +++ b/arch/arm/mach-stm32/board-dt.c
> > @@ -17,6 +17,7 @@ static const char *const stm32_compat[] __initconst = {
> >       "st,stm32f746",
> >       "st,stm32f769",
> >       "st,stm32h743",
> > +     "st,stm32h750",
> >       "st,stm32mp157",
> >       NULL
> >   };
> >
