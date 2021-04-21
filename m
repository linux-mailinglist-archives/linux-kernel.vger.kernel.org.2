Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7824A366D66
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243131AbhDUN7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235159AbhDUN7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:59:36 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DB4C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 06:59:03 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id m7so37018028ljp.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 06:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ib9EyqO0WAjoDZ6fdgzjZQ0H5z4tmjUfn5ViYgk5R6k=;
        b=fwhdPFJJ9tHWWJ38lpptmzBw7yy93iXiaOiuwx6es5qpjWPtijqkL4W5RcXHh4zEHk
         LttWzHBPpWKUjV92JxNCjvfathqf/stEnmcf9P2+Ot8Fz4nFILNHZpA2FRZSDN5hiDPn
         8dV8KEsr6J7e9L1JxNfPVLXEQCj2n9HnE5OzJ1VRKM3TXXDqVWqz0IO/bH2EHrQaVCRC
         dH+6qKg+wzS/59/9ho36IDSKOAJP2sgVJWMd7jUMTbvsMRymJEgWizkgi7i8ODjM6gx4
         4KhXNe/7ikzKG0EopujBaOApZkoKvr8U11c9TMGm0sou9CD5tlUbNrzibGJ+eFmHssgX
         Iriw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ib9EyqO0WAjoDZ6fdgzjZQ0H5z4tmjUfn5ViYgk5R6k=;
        b=SJHZ3zoMfDYi6VoArIXj8y+9L4IfHTreABDddKv4bbSl9cCSvL1wayVOMHnPIrovdT
         4KsBn4DClm8CAndiVBg1zhtlOdH+MX689K2GsJx3XrT3KpJaYklLGYqGxuiGEUYVIs/h
         bb39sr8z6yIwvRcUilN2bZCqyt162vC1YP8ANrDVIfmfUP1PrH09wE4EoejaqHjBcobV
         ReIup1g3m5vjJ4H90MXj8YfYDePXljUe2uChZHTJyUWX1kd0mW7Ne/vcTreq0hXyYYAK
         taccrj8ZmSjJqSiPIvPEfoUA6aWG17CIvuQNXvk/yF8U/aM28lOPOqUhs6kgdvHmrDLu
         6CGQ==
X-Gm-Message-State: AOAM530jvPlhTvCzKXNF/6GeFgLVEx8dWCsjQyTsCeMOafpKackzs1rb
        daA3xUaqtChkIvmDqQ6PbAlu+D+lbw48hJ1ojpw=
X-Google-Smtp-Source: ABdhPJzqg97MeQOjeuKmpKgeqPk5jSB2yj880kx1uDw1GzS9+dGZBRsnQW7kOxD5TZniJBkJ417W22ixCHEMaXNX8QM=
X-Received: by 2002:a2e:8987:: with SMTP id c7mr8239550lji.420.1619013541838;
 Wed, 21 Apr 2021 06:59:01 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsOifMk4+VHi4bnHCL2L_tT+Tm_Rz+KxD3ZQOowx1xms4g@mail.gmail.com>
 <293189a2-3a6b-1e50-7607-33917743b9d8@amd.com> <CABXGCsMMUa=0+GAHxfVdOOFO0Lx=tCa4+ongHN8rF4TAR9nVmg@mail.gmail.com>
 <66f5fdcb-d414-603d-bdb8-70579335b4a2@gmail.com> <CABXGCsP+qjMuPpi7o=mnuvcuRyViYxiT8qEsqS2kHwMSEs835A@mail.gmail.com>
 <fff4926a-8f20-8d31-611b-473e84d89af0@amd.com>
In-Reply-To: <fff4926a-8f20-8d31-611b-473e84d89af0@amd.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Wed, 21 Apr 2021 18:58:50 +0500
Message-ID: <CABXGCsN_ZsQpeFOpkdJyn_JtG1imp4+Yrfr2msqQGUwNDoLpmg@mail.gmail.com>
Subject: Re: [BUG] VAAPI encoder cause kernel panic if encoded video in 4K
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Apr 2021 at 11:42, Christian K=C3=B6nig <christian.koenig@amd.co=
m> wrote:
> I can try, but I'm not sure if we even have the full page fault handling
> for Navi in 5.12.
>

It would be great. For me this patch is working as expected and I
already for several days didn't see the panic "kernel BUG at
drivers/dma-buf/dma-resv.c:287!".
Anyway I will waiting for any news.

--=20
Best Regards,
Mike Gavrilov.
