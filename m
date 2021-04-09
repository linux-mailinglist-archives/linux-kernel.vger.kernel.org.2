Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A09FA359408
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 06:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbhDIEiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 00:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhDIEiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 00:38:00 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54879C061760;
        Thu,  8 Apr 2021 21:37:48 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id v70so4665888qkb.8;
        Thu, 08 Apr 2021 21:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HGWn++Wqm+IbcEB8+bOET7BZgu8FprdT5nb/lQPUSxE=;
        b=YjyyoqLaTXyj1y6oqpotLYvBmx2AxeJYhiskbd0RBUgzZwuFLGVvmYZim48ovbIoFy
         JTJDSrrIcBfdcXnC5sjo4s8HmwxNvkwtdmiWgnPmsnvTGDqeMRBsv5faVl7GMM1PeyYA
         lcKFlvxaiBiCphrnZwlxsPFH0pahFa0MkKjzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HGWn++Wqm+IbcEB8+bOET7BZgu8FprdT5nb/lQPUSxE=;
        b=XkJqq4OWeJwByAyRD33hlTZyYhroPc9aMkWguaFFCrVP3haR4QjTZJgAGttpFr2VuL
         Z0jU0j0wpS4iVkjgyV+UZQSosbbnQIqy0PW5gDMXL+l1h4q51sHXxOYpeaKGkIIkFdzk
         7Ba0FdH3DTxLlncA84yMTq8u+H6dvIF30DbvIs1nN9MhZHequm1n4GmScdmrHJ6dZGvW
         NoUe3IPYUnBXuFnP9f1j4RVAxXcjpzVw76NWt2IoAunu1l8QmWQtqEOJ3Rv3SJook0+/
         xN9pklFPdCUQKBb9IG7ROppFQaDE0+iWzMSGvU8uEBoIcpWDGpfz4eF6/PmiyUdmmXsr
         Dk3Q==
X-Gm-Message-State: AOAM5337IWzWlN3kKApXXJTCZQTQ32HahVdiJwA3VtjNGCAhLqulAhUz
        HDZ0k5M+oZrwF3EuOtsCPKoEnbbRErp73dqJyAM=
X-Google-Smtp-Source: ABdhPJwH0HNJo1gVVxx5R8dLODfUf7/t7vsJbCGCK7+GhFbFudJi/yprSO2/SZQI2lgV5ITrwiHORHI3seB00X76ZBw=
X-Received: by 2002:a05:620a:c11:: with SMTP id l17mr12159214qki.487.1617943067553;
 Thu, 08 Apr 2021 21:37:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210406120921.2484986-1-j.neuschaefer@gmx.net>
 <CAK8P3a0VfnUucvZNkA9PdxrWiYUOkisV00v-375PmgQYp4aXoQ@mail.gmail.com> <YGzZofPvT80b5gS5@latitude>
In-Reply-To: <YGzZofPvT80b5gS5@latitude>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 9 Apr 2021 04:37:34 +0000
Message-ID: <CACPK8XdbwbsbJuZmvsFqJ+x5viu652vpfR1kwB4Gu+khRHNt_g@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] Initial support for Nuvoton WPCM450 BMC SoC
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Tomer Maimon <tmaimon77@gmail.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Apr 2021 at 21:59, Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.ne=
t> wrote:
>
> On Tue, Apr 06, 2021 at 05:15:01PM +0200, Arnd Bergmann wrote:
> > On Tue, Apr 6, 2021 at 2:09 PM Jonathan Neusch=C3=A4fer
> > <j.neuschaefer@gmx.net> wrote:
> > >
> > > This series adds basic support for the Nuvoton WPCM450 BMC SoC. It's =
an older
> > > SoC but still commonly found on eBay, mostly in Supermicro X9 server =
boards.
> > >
> > > Third-party documentation is available at: https://github.com/neuscha=
efer/wpcm450/wiki
> > >
> > > Patches 1-4 add devicetree bindings for the WPCM450 SoC and its vario=
us parts.
> > > Patches 5-7 add arch and driver support. Patches 8 and 9 add a device=
tree for
> > > the SoC and a board based on it. Patch 10 finally updates the MAINTAI=
NERS file.
> > >
> > > Patch 2 requires "dt-bindings: arm: Convert nuvoton,npcm750 binding t=
o YAML"
> > > (https://lore.kernel.org/lkml/20210320164023.614059-1-j.neuschaefer@g=
mx.net/)
> >
> > Hi Jonathan,
> >
> > It appears these patches are doing roughly the right thing, and we may =
still
> > be able to get them into v5.13, but I'm not sure what your plan for mai=
ntaining
> > them is. The two options are that you either send your patches to be pi=
cked up
> > by Joel, or you send everything directly to soc@kernel.org once it's fu=
lly
> > reviewed.
>
> The route via Joel sounds alright with me. I've Cc'd him on this version
> of the series.

I've had a look at the series and it looks good to me:

Reviewed-by: Joel Stanley <joel@jms.id.au>

Nice work Jonathan.

I'll put this in it's own branch along with the bindings change it
depends on and send a pull request to Arnd for v5.13.

Cheers,

Joel
