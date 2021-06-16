Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 729D83AA59E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 22:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbhFPUwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 16:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233711AbhFPUwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 16:52:12 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C887C061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 13:50:06 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id p5-20020a9d45450000b029043ee61dce6bso3890959oti.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 13:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0e8lLquy/RoPIexchfl/Dy42UhNJgpKcJRp8OKOo2mw=;
        b=lREE4F/+u3tfPzBJr/PWSAFl0A5hPQXvj5qk3D3NfohfrrusmynYlYzihuvLTf1Ah6
         aAwPfXpzge+KtBAKPenQbhWZzF4JCVeiibIwoCHJYNkC+OQbPbkqGKXvzCn150+lTRX6
         OsuAMohC8wjnFK7rcH9pA6KG+8ss9IRUNaV85BDL05E7Ki0ZAU8nYHoYCdGliC6nCsZW
         PZ9BFkX68xitJHTXA0Jp7HYLLVJmsRxxrywbylFtfd1RcYfjB/LxlfaYfGuqo+1waUy6
         2LBOIu2pf/Y8Gu1DLg8FJPHALESWktoNesF4Sp5gt9X1JZnzpO6hy+WpViYcbTjEzjLy
         VmGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0e8lLquy/RoPIexchfl/Dy42UhNJgpKcJRp8OKOo2mw=;
        b=G+l39w0CKVEnvOhtYJAxtVfFFZi9U2OQUjkLSiRq43bNKDimJj8y6LAzUDQRD0Cnpf
         3Ri2wh6kmWQDI11Gv5MUw2Mfbo508AkSE6HZzVPzAcFqr8lwGWqx0ucJz2FXVTkxaVsH
         f9UTHPv4o5AOaO8ZUE9gcdXm/oYBEMM8kClumLwSHkWCWMIDWzG56kB9PSf5sqrlrGRg
         qxgxrFB/ioaapp/mm97MVsNtGCDrjb3bYjNnlCIOz0xgXJ64LA6FIkgdCpA59xOSyR6z
         RA7mBsHOVH8Z+yZMjVCwwtFkCBT7v3QeT93Vb5gyHqPH+cNdtlhqCQ7obce1CTuEYH0K
         Gjqg==
X-Gm-Message-State: AOAM530ssDOF5sGb4WKpsQ1RLIBLBsU9hNAnFIqoMzJoLLvYW64DhnYN
        xvPwSUqXy11UmZwDpcGgA+2jVm/P6ifka1UTezLjkA==
X-Google-Smtp-Source: ABdhPJxlW2IfgGoCEId2VA9mgQdRrEJsE5cGXrU6XetkrHInBTk/URpCE1qYtWk8Tfw45jq9OfaYsqrLxExbzsq1IsA=
X-Received: by 2002:a9d:1b41:: with SMTP id l59mr1541479otl.8.1623876605241;
 Wed, 16 Jun 2021 13:50:05 -0700 (PDT)
MIME-Version: 1.0
References: <YDkbCHHBUOmfI59K@Konrads-MacBook-Pro.local> <YL7XXNOnbaDgmTB9@atmark-techno.com>
 <2e899de2-4b69-c4b6-33a6-09fb8949d2fd@nxp.com> <20210611062153.GA30906@lst.de>
 <YMM8Ua0HMmErLIQg@0xbeefdead.lan>
In-Reply-To: <YMM8Ua0HMmErLIQg@0xbeefdead.lan>
From:   Jianxiong Gao <jxgao@google.com>
Date:   Wed, 16 Jun 2021 13:49:54 -0700
Message-ID: <CAMGD6P1v2JoJoxSuAYL8UjdtCaLCc4K_7xzVkumspeb0qn=LBQ@mail.gmail.com>
Subject: Re: swiotlb/caamjr regression (Was: [GIT PULL] (swiotlb) stable/for-linus-5.12)
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Dominique MARTINET <dominique.martinet@atmark-techno.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lukas Hartmann <lukas@mntmn.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Marc Orr <marcorr@google.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Peter Gonda <pgonda@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 3:35 AM Konrad Rzeszutek Wilk
<konrad.wilk@oracle.com> wrote:
>
> On Fri, Jun 11, 2021 at 08:21:53AM +0200, Christoph Hellwig wrote:
> > On Thu, Jun 10, 2021 at 05:52:07PM +0300, Horia Geant=C4=83 wrote:
> > > I've noticed the failure also in v5.10 and v5.11 stable kernels,
> > > since the patch set has been backported.
> >
> > FYI, there has been a patch on the list that should have fixed this
> > for about a month:
> >
> > https://lore.kernel.org/linux-iommu/20210510091816.GA2084@lst.de/T/#m0d=
0df6490350a08dcc24c9086c8edc165b402d6f
> >
> > but it seems like it never got picked up.
>
> Jianxiong,
> Would you be up for testing this patch on your NVMe rig please? I don't
> forsee a problem.. but just in case
>
I have tested the attached patch and it generates an error when
formatting a disk to xfs format in Rhel 8 environment:

sudo mkfs.xfs -f /dev/nvme0n2
meta-data=3D/dev/nvme0n2           isize=3D512    agcount=3D4, agsize=3D327=
68000 blks
         =3D                       sectsz=3D512   attr=3D2, projid32bit=3D1
         =3D                       crc=3D1        finobt=3D1, sparse=3D1, r=
mapbt=3D0
         =3D                       reflink=3D1
data     =3D                       bsize=3D4096   blocks=3D131072000, imaxp=
ct=3D25
         =3D                       sunit=3D0      swidth=3D0 blks
naming   =3Dversion 2              bsize=3D4096   ascii-ci=3D0, ftype=3D1
log      =3Dinternal log           bsize=3D4096   blocks=3D64000, version=
=3D2
         =3D                       sectsz=3D512   sunit=3D0 blks, lazy-coun=
t=3D1
realtime =3Dnone                   extsz=3D4096   blocks=3D0, rtextents=3D0
Discarding blocks...Done.
bad magic number
bad magic number
Metadata corruption detected at 0x56211de4c0c8, xfs_sb block 0x0/0x200
libxfs_writebufr: write verifer failed on xfs_sb bno 0x0/0x200
releasing dirty buffer (bulk) to free list!

I applied the patch on commit 06af8679449d.
