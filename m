Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5770D35DFA1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 15:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345926AbhDMM7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 08:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345922AbhDMM7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 08:59:46 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6E5C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 05:59:25 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id k128so106780vke.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 05:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K6gp3sUpFpXKT8ewnG/DtO59TU7kZa7T83ujn+9U3LY=;
        b=k/keZUcro40h04uT1/VfEHmkHDGBDKO2cnowLghFt0R1PeqRpkI4rt/hFE+iqBgHUI
         Ogxoz2hyWL6OV7DkVxZA83PkMwrkh4obMpAwjOHmJLP+Rc+Oqjk0by3lSrhC4Gsac//n
         e2uLp5gJHoSPY51YZjKCxlImTOj+FPPBMt6oU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K6gp3sUpFpXKT8ewnG/DtO59TU7kZa7T83ujn+9U3LY=;
        b=SNHzg4JOVNub/9MDGN9CMDkAMjjtDFQ2OMIKuJMysYYCQ5JeprJoaBOzcEyKH6MIHm
         z/o5hXdrTOz/zAY2wMXHNRLuhIpu+SMoi0TkfD1LSU62Fm41ynbDwdfwg9K7iPjBiruy
         vIFQ5KXcPewvivFMZUS7M5S6tDdYf1oiECwAOntMyigYYKsKpCRfBAyGaLkZ+dbA0fnL
         YrhTcAzR9n5R2WNoKH41c1pZINpE/Y/OEH2yJAEmTfiIEGBYeMDyDdXbQd7fwaSCJkDl
         IJ13te0ZRMi4wnupjnkBXqGqjSniRR2s7HBKInPB7JtfsSajzaf+LZzLyk2Sz120nNDe
         qt7g==
X-Gm-Message-State: AOAM530yXACljo9LZZz9EV/dSjRBK/mm/2L7NT6G6dJCmvglKVxtyMWg
        xq5OtiBRVuuG1CppRuoOqP6lzGvOnwNg/vgvbBOU/g==
X-Google-Smtp-Source: ABdhPJxs6+Ltcl9KHtwI860jVS+ZVqSy1Ow96RAOLyEy068wP1TKV+u/hvVaYVi95fFNGiw4JKo3k26V5KV613Kdsvw=
X-Received: by 2002:a1f:4ec3:: with SMTP id c186mr23220165vkb.11.1618318764741;
 Tue, 13 Apr 2021 05:59:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210124232007.21639-1-richard@nod.at> <CAJfpegvN2KdMj_7T-OF1PAs8xZiU3f4233AvigaXwwRAsgQEjw@mail.gmail.com>
 <563952295.378372.1612881357746.JavaMail.zimbra@nod.at> <1923896038.379134.1612901174023.JavaMail.zimbra@nod.at>
 <CAJfpegufojx4q_CfR6L-fzSyQw9QXJZKy5xKVZZWaepADkL=Kw@mail.gmail.com>
 <CAJfpegv-UDcgzkFiZXdoif2qjws5_xXh2bQSNbNdviQHhxzZHA@mail.gmail.com> <CAJfpegsbVWPGKe-bLvM=00EHe-PC_QgJ9umxCf1gFtUQge6_cg@mail.gmail.com>
In-Reply-To: <CAJfpegsbVWPGKe-bLvM=00EHe-PC_QgJ9umxCf1gFtUQge6_cg@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 13 Apr 2021 14:59:13 +0200
Message-ID: <CAJfpegv9kvJ_KKyRo89Yp30RocZut=PBNJGbVobgO2f2Z36jcQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] MUSE: Userspace backed MTD v3
To:     Richard Weinberger <richard@nod.at>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Ron Minnich <rminnich@google.com>, sven <sven@narfation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        fuse-devel <fuse-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 7:09 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> Pushed to
>
> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git#fs_fuse_split
>
> There's still room for improvement, but I guess this can wait after
> MUSE integration.

Hi Richard,

Have you had a chance of looking at this?

Thanks,
Miklos
