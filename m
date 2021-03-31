Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA6634FA31
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 09:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbhCaHav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 03:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234145AbhCaHag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 03:30:36 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9775AC061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 00:30:36 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id g15so13943832pfq.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 00:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=suhM1QfpnyObFdI0zpuVstsmyjlbl9DzdyUeQfv0xhk=;
        b=Vyeg9010q8jK0TZSKz/pqaEzuB+X76J2mf/fjLBJtPn1K2bUN4r0QwbpUE6zj6nEpL
         z/7k4TT41vQLC79PNMKqFeEbc/QIp/EdPNNrViy0bl2j26KyaUM2611CD2SGbmuoGAPc
         PJcwYDyC1utR8x0rJ9AhF+H9uad9NYxDrmvSfl0OOMtAdVCB5XflNh2F9mYzmR4PaJpw
         Mr1DbeFRTDmi1U2uawviymenx6BxgJ8ZBsW0HyxGKWOBweEeNTjzB9tXIm97H530THay
         9QEstDsbup9ifmGWFyDfyYnaiwpVUZWdhP5Mb2cXgiG7Vw5NPYmSv1/xDgpnFdorMBYO
         umQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=suhM1QfpnyObFdI0zpuVstsmyjlbl9DzdyUeQfv0xhk=;
        b=NneKnaBi4jWFAcYDF4FkBYJkTMUV7ymXQfaiP3GivoXUcpC7hok2nPfy60iCyijCe4
         caRa9RgRi4+suQydkW7SgReput3z1xdk+IgJ1bTfidzCs/EoTMvIn6NH361TBSN5WibM
         ex705krH6gCmKrBJ0Lwy9mj0b4hEa/uKp9F9wzIxtt8+IDHnqaEEoeF/jm18oLNX/9EU
         +01PMpaV9E/e0wPeJ7YUZTlglJAwpQTnNsSAGqazadw1hco0JUwjEWVcf18tcvaHjD+D
         7ZFQXicTlllJIPxf+AfZxmdwDJnpKGnpY+HskDZ3UngfILiWjYueRTaGBYj5lPCuGat4
         Agqw==
X-Gm-Message-State: AOAM53083pu2aMl/hBrSB1VT6qHApOjfh2fpnUPU+iLrlI5XZ5zlk0sX
        V66PVjR4mh/RMKqKAhQSQVWbYOmgERyg74XR+TQXtHgmr50=
X-Google-Smtp-Source: ABdhPJyynYH0zLuS3m1ItZ25UwUMuB7N/DuJWlrrwMJx3XX2CYouYLia5lpwteqMti9GcxmHraFHSmVtLO7EXFO8GmU=
X-Received: by 2002:a63:1a0d:: with SMTP id a13mr1962305pga.167.1617175836176;
 Wed, 31 Mar 2021 00:30:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210330175126.26500-1-rppt@kernel.org> <20210330181347.GQ351017@casper.infradead.org>
In-Reply-To: <20210330181347.GQ351017@casper.infradead.org>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Wed, 31 Mar 2021 15:30:00 +0800
Message-ID: <CAEbi=3ePyQwc07krUHUtXVQ=qfWFYpyMVZdx5o=T+B9yHuc=Jg@mail.gmail.com>
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

Matthew Wilcox <willy@infradead.org> =E6=96=BC 2021=E5=B9=B43=E6=9C=8831=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=882:14=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Tue, Mar 30, 2021 at 08:51:26PM +0300, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> >
> > Commit cb9f753a3731 ("mm: fix races between swapoff and flush dcache")
> > updated flush_dcache_page implementations on several architectures to u=
se
> > page_mapping_file() in order to avoid races between page_mapping() and
> > swapoff().
> >
> > This update missed arch/nds32 and there is a possibility of a race ther=
e.
> >
> > Replace page_mapping() with page_mapping_file() in nds32 implementation=
 of
> > flush_dcache_page().
> >
> > Fixes: cb9f753a3731 ("mm: fix races between swapoff and flush dcache")
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
>
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Greentiime Hu <green.hu@gmail.com>
