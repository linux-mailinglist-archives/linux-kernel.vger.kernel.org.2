Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC9F3EAF1D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 06:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233727AbhHMEOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 00:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbhHMEOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 00:14:02 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52563C061756;
        Thu, 12 Aug 2021 21:13:36 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id 22so22659qkg.2;
        Thu, 12 Aug 2021 21:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JATj7FlSMDAm89anL9O14/wxabM+bn6u6NhVI8X8ONE=;
        b=lE2ubq/U0m3V2snJ8bMvBWCXNeU5Fw0Wv9eyUHk8DAwHTQanm5wFxiTPjKtAaxALCh
         /IVN/OSLvUl2tOs4mrRp5Rc8s+zZ9grirEMWhuj/m0+9FtTCe1nzFnhWoLeElj7/SrXq
         rCcNYIYx/BALAuUVm46dOIlYQ7dGqN/gBk43U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JATj7FlSMDAm89anL9O14/wxabM+bn6u6NhVI8X8ONE=;
        b=Wz3Cz+Dh42Uif9Ii4PLtylFGJTiy2BynSu1lk1gMkFTBRflJLdTnSdkSQg17QxxQrA
         Mgks5Gn6y/WYCC4VdVPEGoM/h6gQMGydZ6erxZb1Z/FQQnP43QlWxe75eFu7u8xBBNpL
         1ld+3BVJxxl8ieuh40exlqHICT3AJGvVRyFeH2x95FyyaKaFrsY60h1KwdjZxFatFcla
         WyrjgaaRiflhCQ2YFh2Vyh+CMiURaSCTub/Ml+iM+GO/s+zhGQv/f9AvWbKwhPneseD2
         hI1ukWzCEXLgVoy8O8bJ4OKjXANZEa8PUHO1ujjSMn690QINcZqxh/Yb5JSh7x67maN0
         P2wQ==
X-Gm-Message-State: AOAM532ZaQTSJjtZacRizmI7bcZ+5FzJnn0w9tvjsXgHcs3ytaiinus3
        U7/ymN9+1AvM6+uEsowHg8UTae1fBxKtbIY8+bA=
X-Google-Smtp-Source: ABdhPJwZqoAo49DMKYzjDkSgFAuPBY+tIL4xnl8wvv+rWSUBDeXDtc0ndYWLTCbIfTwEdimJshNoOAUSSoZGjVZlzR0=
X-Received: by 2002:a05:620a:19a8:: with SMTP id bm40mr293306qkb.66.1628828015291;
 Thu, 12 Aug 2021 21:13:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210805222818.8391-1-rentao.bupt@gmail.com> <20210805222818.8391-5-rentao.bupt@gmail.com>
 <CACPK8XcV5On2D4D+SXnfw1M0owwfCL4Su19jOEA7yWpq+T3jLw@mail.gmail.com> <20210813034016.GA21895@taoren-ubuntu-R90MNF91>
In-Reply-To: <20210813034016.GA21895@taoren-ubuntu-R90MNF91>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 13 Aug 2021 04:13:23 +0000
Message-ID: <CACPK8XeoV8DqDNYFgK97r-Q0DebNjrmgUTydKSYmGt+3x=-vOQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] ARM: dts: aspeed: Add Facebook Cloudripper
 (AST2600) BMC
To:     Tao Ren <rentao.bupt@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Andrew Jeffery <andrew@aj.id.au>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Tao Ren <taoren@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Aug 2021 at 03:40, Tao Ren <rentao.bupt@gmail.com> wrote:
>
> On Fri, Aug 13, 2021 at 01:29:17AM +0000, Joel Stanley wrote:
> > On Thu, 5 Aug 2021 at 22:28, <rentao.bupt@gmail.com> wrote:
> > > +&mdio1 {
> > > +       status = "okay";
> >
> > You're enabling this but it looks like it's unused?
>
> Thanks Joel for the careful review. The MDIO controller is not paired
> with BMC MAC; instead, it's connected to the MDC/MDIO interface of the
> on-board switch (whose ports are connected to BMC, Host and front panel
> management port).

I see!

>
> In other word, the MDIO controller is used, but we do need some user
> space scripts to control the controller. What's your suggestion? For
> example, should I add some comments to explain the purpose?

Yes, that would make sense.

I've applied your patch, so if you want to add comments please send a
diff against this tree:

https://git.kernel.org/pub/scm/linux/kernel/git/joel/bmc.git/log/?h=dt-for-v5.15
