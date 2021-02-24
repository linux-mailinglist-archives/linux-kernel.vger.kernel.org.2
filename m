Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C48B7323927
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 10:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbhBXJBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 04:01:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbhBXJA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 04:00:56 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE320C061786
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 01:00:14 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id 17so789339pli.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 01:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hedH8b/OsFszXR9elwfiVwGIVLb/7vJ8FzEsHQCfO0Y=;
        b=AFltBjecIZ0gQOVHumqGRmTbWAwaS5obYpxoVXM+Q9xy7viPWMgUhtyqAHw3f+qZyo
         IpTp3dSKefgmZ4bObSpz35yc8t4W3QI3rN4ccdlctFD1wo5llgGvOKcDA+4z6iRGhGbh
         4wr7cjeQ6IXURcIiARhpsMD30ZQvaUxijHyAjAs4RPfkt5MnoAGTESfs/81oIgCYzCqg
         J/TUzDmUT4lYbx9XzoBETxbfErXr965lsLo8bNq2wIAQPpAQDztAl9t6QLreKu6g4zhm
         fJyaA88EVsvZcX39JcVuUbEePuh0a/Yw5bSlXo9rC6S0TmkiWmans/hKulEcLn8V93ir
         nA6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hedH8b/OsFszXR9elwfiVwGIVLb/7vJ8FzEsHQCfO0Y=;
        b=NpLJOtWOjerHC5xVdnPaLveWR+sXcNhvFd1LqAyd5Gzf+1bdFdkIIWGoRDlJ4EKdDp
         7gpQUejPyOa1YaiNaKEC/aoqD08mmND9fnA5HV56njS58BDLNnBfyiPJZgu6R16hEYt5
         neP2XJ3rsoYkuTBzYlWHj0XTbAwUl2FteNTYPia9r5MDraSKD2JDgPSAVtEKl7/58YLF
         24s3UNIXy67O3ROoRaC//68Q+/tPb44vI2H1snn8cMTuoGh0nkqbeoVa+uT9uKbBGxXh
         nM+qVrX1jeQKU2tmk3ETiIsveMX4+bJ1xrFbzsXVSJVB3vJJ/sltAJF+4oYTYky3JiUc
         n7Hg==
X-Gm-Message-State: AOAM532pjej/0hfgLKFq5yIkaF5kGqZw7wgK45ItQipTKXov34oU7zCZ
        nhpBfFjZL7YOLysi4O1fReKVUwlazKSRKXL4uhc=
X-Google-Smtp-Source: ABdhPJzGuI4VOfNIsHIPlEkFzmwip9VLrbYJCwWfc9xtLWc9P7FDtlCQF1+B48QnHn3pHmhDUgh89lCn2eM0bb4tEdA=
X-Received: by 2002:a17:902:a714:b029:e3:1cd:a033 with SMTP id
 w20-20020a170902a714b02900e301cda033mr30734576plq.27.1614157214421; Wed, 24
 Feb 2021 01:00:14 -0800 (PST)
MIME-Version: 1.0
References: <20200720114448.205876-1-hch@lst.de> <20200720114448.205876-2-hch@lst.de>
 <20200721110717.GA19721@atcfdc88> <20200721112800.GA27356@lst.de>
 <20210128101633.GA6249@lst.de> <20210224074742.GA509@lst.de>
In-Reply-To: <20210224074742.GA509@lst.de>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Wed, 24 Feb 2021 16:59:37 +0800
Message-ID: <CAEbi=3cQ+5ir3X6R3=cn3q1w4JqsRYVw5REqnQVLY5icyT8=xQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] nds32: use get_kernel_nofault in dump_mem
To:     Christoph Hellwig <hch@lst.de>
Cc:     Nick Hu <nickhu@andestech.com>, Vincent Chen <deanbo422@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@lst.de> =E6=96=BC 2021=E5=B9=B42=E6=9C=8824=E6=97=A5=
 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=883:47=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Thu, Jan 28, 2021 at 11:16:33AM +0100, Christoph Hellwig wrote:
> > On Tue, Jul 21, 2020 at 01:28:00PM +0200, Christoph Hellwig wrote:
> > > Can you pich the patches up in the nds32 tree for Linus?  There are
> > > not short-term dependencies on them.
> >
> > It seems like these patches are still sitting in linux-next and never
> > made it to Linus/
>
> ping?

Sorry for late.
Acked-by: Greentime Hu <green.hu@gmail.com>
