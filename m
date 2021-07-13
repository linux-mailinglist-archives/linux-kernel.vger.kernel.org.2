Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBAA3C7775
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 21:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235021AbhGMTuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 15:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234728AbhGMTt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 15:49:59 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851BDC0613DD;
        Tue, 13 Jul 2021 12:47:09 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id cu14so7420856pjb.0;
        Tue, 13 Jul 2021 12:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hUO4z88FjFShb0tr7ebTCI1mlDYypbUNdBXF8PiD+/Q=;
        b=S2gpv6iuoIz8KMmME9waddrFut/+xO1c/4fJ0KphbAOcyf7xLe4QKpsyQelvdnLhcD
         hxCt7L77sSih+iTVfj+VAcaCzDp2/GbnGrVFT119jUVnEDPZr0AVJJBQ/eaKK06E0Q/H
         9LPxKtXJyl+5rlCReHeEoEnvWiHdlffy9tiWNmyzsaTSFuD1TzIcMYN3DhKGYsP5qYZZ
         nRALrm9DVfdD5tqNfx8iile/54ugLaVcLzDZIrcbjyMJjGR0vMAvWyb+7lO0ve0mAiaf
         h8hpteyD0NzKDZw5lEuJovSDjBEx8d4GLticXBfNjCV2mplHAFtHPab5uXvpdM1MjmTe
         TN1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hUO4z88FjFShb0tr7ebTCI1mlDYypbUNdBXF8PiD+/Q=;
        b=VJWJZ43y97rrSu9AMJjQHgdZDfE56Chea/Abad1DsWQSG9Bhky4w/K6LRjpaOkIZZI
         u9Xy/iBXvKb1dcw7jeVItpQhhjwb2sOU2ci3zdQ94vUdLuYuoVZItdLfYAvoi0pfSJeD
         XK8X1GroiaHll35CcYtPv5B+9ipEt+BHkT+jLfYeLCFpVTCwU8N3MeXs22fJrZzmb6sn
         wR90wKXEd4XlQ4eem2t3l3KUpaxsV/EkZZeIeiCrKokFFvIniyOXnhxAR6oEpgjfoHWR
         djOlG+Nsc2Vv6VIgSkJowObxZ4OkCkwc8E7rpnzkBXrOQ3ZTWOaYvL/LMcjAmdb+WfbD
         Lv+A==
X-Gm-Message-State: AOAM530hW+eZZKs9GdA9d2g6Cx/HtryCpSfRTVYEgrgH0R7hF9weo2Hb
        hoKjEKic2ffjz7bpYiaNFZAR6tw2BvY6h2paoxk=
X-Google-Smtp-Source: ABdhPJw/cLrySdmiuHtHgNMWFAAQecmL2CP6a9Y251qzuozfAeeYM95TWi09nfpSbz0tdoHKY8xH+caVRBWV2Avivmc=
X-Received: by 2002:a17:90a:17ad:: with SMTP id q42mr900534pja.181.1626205629007;
 Tue, 13 Jul 2021 12:47:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210709170426.GC4112@sirena.org.uk> <CAHp75VeugcuwWAq5p_rx+8J2FsX7igV+UJ3QKw3XG6BiDqTtNQ@mail.gmail.com>
 <20210712124223.GB4435@sirena.org.uk> <CAHp75VeyNyYSbTMgS+5tXxOZehfxt6Wws9jScKYRKQhRRGDwsg@mail.gmail.com>
 <20210712133428.GD4435@sirena.org.uk> <CAHp75VcQUUDdLYbpvTXSMPvjBzbHtBxywVBPS_xfY5JXyo9XxA@mail.gmail.com>
 <20210712170120.GG4435@sirena.org.uk> <e17af9dc-78c0-adb8-1dfb-0698e7a4e394@gmail.com>
 <20210713152454.GC4098@sirena.org.uk> <CAHp75Ve=eY2KaPFgq3JDv1aGo_ajcNuKTV9rZQ+1f8uMJBocUw@mail.gmail.com>
 <20210713181837.GE4098@sirena.org.uk>
In-Reply-To: <20210713181837.GE4098@sirena.org.uk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 13 Jul 2021 22:46:29 +0300
Message-ID: <CAHp75Vfwz-cDrAhOnXaeUSDN-K+YJv8ahmvZ3aJwm2sKqc8HeQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] Add software node support to regulator framework
To:     Mark Brown <broonie@kernel.org>
Cc:     Daniel Scally <djrscally@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        kieran.bingham@ideasonboard.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2021 at 9:19 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Jul 13, 2021 at 06:55:59PM +0300, Andy Shevchenko wrote:
> > On Tue, Jul 13, 2021 at 6:25 PM Mark Brown <broonie@kernel.org> wrote:
>
> > > The driver code is trivial boilerplate, assuming someone doesn't go and
> > > implement a helper to register stuff separately like I suggested.  The
> > > proposed swnode stuff would involve duplicating the DT parsing code.
> > > This seems like a whole lot of effort for something that provides a
> > > worse result than either of the existing things.
>
> > I'm not sure I follow. Where did you see the duplication when I saw
> > the other way around?
>
> The current patch consists entirely of additions, it does not remove any
> existing code at all, the diffstat is:
>
>  5 files changed, 174 insertions(+)

Ah, okay, you are talking with regard to the current patch. I talked
in generic terms.

> > Converting code from OF to fwnode APIs in most cases is smooth and
> > doesn't add any overhead to the codebase,
>
> We explicitly do not want to attempt to parse regulator properties out
> of ACPI platform descriptions because using the regulator binding on
> ACPI platforms conflicts with the ACPI model for power management and
> we really don't want to encourage platforms to attempt to mix and match
> here, it's not going to lead to anything robust.  System integrators
> that need this sort of OS visible low level power management really
> should be working with the UEFI forum to get an ACPI specification for
> it, or if they don't really need it fixing up their AML to DTRT.

No-one is objecting to this. I agree that integration of regulators
and ACPI should be done in a specific way if needed at all.

> If you were to say that we could bodge around that by somehow forcing
> this binding to exist only for swnodes when running on ACPI systems then
> we'd still have the problems with creating something with worse tooling
> than what's there already.

Of course, no objections to this.

> Like I said in the other mail fwnode is a nice hack for systems that are
> using ACPI but have hardware that's doing something totally outside the
> ACPI model to allow them to reuse work that's been done for DT, it's not
> a universal solution to the lack of appropriate support for describing
> modern systems in ACPI.

In some (I suppose rear) cases it may be used by DT-enabled platforms as well.
I can imagine the case when you have a system in ROM and only what you
can do to change DTB there is either use DT overlays (which seems to
be not working, plenty of gaps there according to a Wiki I saw once)
or do something in the board files.

So, if you replace "ACPI" with the "firmware resource provider" in the
above paragraph, I will agree 100% with you.

-- 
With Best Regards,
Andy Shevchenko
