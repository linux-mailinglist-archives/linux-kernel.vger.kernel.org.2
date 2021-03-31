Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69BD934FA49
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 09:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234093AbhCaHbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 03:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234168AbhCaHb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 03:31:28 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FAF6C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 00:31:28 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id x7-20020a17090a2b07b02900c0ea793940so717962pjc.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 00:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5du6vxqJjDqpP0E7Hx0rrZrKyoS/A3+yjaNzND2Szag=;
        b=OE/itPyygmho513Og+3Dr1ziqFlGB3btca2JSNBveev1czD8zYVZzGYUImDIpzCSPD
         pGJKmK3PmdshakgjlcnpmjQh9iVC23blEJV1hHtBy6G7beQctjhPR8gQBZNFDJVgSjOJ
         kl9dAPOmJ9wa6uY2HGtlODyrZpnPNLaKoT+5fqocVokPq2SAiNhr0h8dCaiDnh+3kJZJ
         8uqupx/TZrOd+XqMlRc8hGW7iUEA6IxpdlS6KqXLobx/PNRag5EGbwa9rVdci/ykvGmD
         vmozd5N1mk2sJwaIFNi3rw0KFoVE+MmZ5u2h3YSVE/JplRXn0fH+7scypyilgiysFjCo
         J/Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5du6vxqJjDqpP0E7Hx0rrZrKyoS/A3+yjaNzND2Szag=;
        b=sK64Ja2xDhtdim40xclQIZIBNCAs+qnpCZIijRDwGAqxa97ZE5LSxQ7JcU9vzRf7MN
         luMQZymVyWCAIvPbb/KH2g1/NbNvh2uQYnKildOAOUAxxIbJaqC7N4h64RH0SDqCczSt
         zrv2QF7LabxPVXfbITfdjKDz5o7XGUpwTefqc1TuhOYkguOC0X6E42+OWyq+YkgYppOc
         UTkZbYPqtMLR4O3ivmX/7fRdHW9BSf8JZ7lRsMHR5v2uSZ/T+hcGHUQ0QWqEC/e+mElW
         rViXHZx7xOgaRU0EoqnCzI5TPDFIBMZeAzYG8l1Io+odr99BvOTmuPpxkK4Rk9vcR5xK
         vi+A==
X-Gm-Message-State: AOAM530v5X2svFiIoIyvMwApz+JYWqYwxzYMzKm31gkKmuf6sQ7MJwaq
        87P0qvNjvbQLsqvTdKZsLZGmgDrbG5bmo181AbQ=
X-Google-Smtp-Source: ABdhPJx5zGJQCvb7TCdXmeCP+s6D4oyKFohI4hAtuQdzEDh1uv/ykSEQj7FNdNrmjmB0UsP0QzBwWWF9wmNp/J9NpG0=
X-Received: by 2002:a17:902:be0c:b029:e6:f007:71d with SMTP id
 r12-20020a170902be0cb02900e6f007071dmr2040896pls.15.1617175887831; Wed, 31
 Mar 2021 00:31:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210330175126.26500-1-rppt@kernel.org> <20210330181347.GQ351017@casper.infradead.org>
 <CAEbi=3ePyQwc07krUHUtXVQ=qfWFYpyMVZdx5o=T+B9yHuc=Jg@mail.gmail.com>
In-Reply-To: <CAEbi=3ePyQwc07krUHUtXVQ=qfWFYpyMVZdx5o=T+B9yHuc=Jg@mail.gmail.com>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Wed, 31 Mar 2021 15:30:51 +0800
Message-ID: <CAEbi=3fXUnpJDxaWoYtDqmEHDrziR==6-6bvrobaKboBFnLyew@mail.gmail.com>
Subject: Re: [PATCH] nds32: flush_dcache_page: use page_mapping_file to avoid
 races with swapoff
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Nick Hu <nickhu@andestech.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greentime Hu <green.hu@gmail.com> =E6=96=BC 2021=E5=B9=B43=E6=9C=8831=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=883:30=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Matthew Wilcox <willy@infradead.org> =E6=96=BC 2021=E5=B9=B43=E6=9C=8831=
=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=882:14=E5=AF=AB=E9=81=93=EF=BC=
=9A
> >
> > On Tue, Mar 30, 2021 at 08:51:26PM +0300, Mike Rapoport wrote:
> > > From: Mike Rapoport <rppt@linux.ibm.com>
> > >
> > > Commit cb9f753a3731 ("mm: fix races between swapoff and flush dcache"=
)
> > > updated flush_dcache_page implementations on several architectures to=
 use
> > > page_mapping_file() in order to avoid races between page_mapping() an=
d
> > > swapoff().
> > >
> > > This update missed arch/nds32 and there is a possibility of a race th=
ere.
> > >
> > > Replace page_mapping() with page_mapping_file() in nds32 implementati=
on of
> > > flush_dcache_page().
> > >
> > > Fixes: cb9f753a3731 ("mm: fix races between swapoff and flush dcache"=
)
> > > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> >
> > Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>
> Acked-by: Greentiime Hu <green.hu@gmail.com>
Typo.
Acked-by: Greentime Hu <green.hu@gmail.com>
