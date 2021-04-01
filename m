Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF16D3519FD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234574AbhDAR50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 13:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235080AbhDARmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:42:12 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F9BC0045DB
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 07:27:13 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id ap14so3240057ejc.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 07:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gnafp+WfprUSUoacKsjOwRBf+VXemWu2ScVTthleKlo=;
        b=LR9XnNbOVyRPM9uKaP6OkP5ztLHdsLIUBWS4FM+sG9YdiylPaqUwHU2zcckCIWYAuC
         pVQELYHpOXc3KbZv6GWHjkCEMK5JUnMCn6c2nyfkEEsEPD4uF26vTxlBcymQ+LwNhwSG
         q9LPyUi6XNTevS25W7v8FHeNEflOdOKU2WNxKflu8yFGGsqfBvuTS+jgvVYP/Vzjxe4u
         jNkzw7/KW9GUd/dbUc1vE+v0hN7VS3qIH7wv5H/fh6ISSHjvm4X1oBrzpSmgL5KYEsTj
         bdY594j9g3m+Gu30WhwxJMnF82UW2g1c0sudNTMYGUqUmsN+pd9jox3SBQm7I//jKSlp
         Q6Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gnafp+WfprUSUoacKsjOwRBf+VXemWu2ScVTthleKlo=;
        b=UmN/N6yYyOHbspDxUWWi2Kz8tuUTchjzNnxZtD/wfFi5oyscG0XuwrDFxmJCEZ1Hm5
         QL1hYZr/J0B3aTvanD0FeC4d9ZdH2ulgXh21W0Wtszg9dPpNcCmt5vqBhRvpyykCreBf
         YTHmzAmOqPKBXSZH3ks+I0ICd7BL8NET8D97q0jOokkjLEo35RsaPx6Y6HGz4tciysk3
         WYmVh6DTfst8GzKCawpXvOcNSKoF/xdqBMr11ih4OV5DsrXHXwKLok22D7LVarZwZ7kZ
         vDJerp/BLe3grBxIOAdtZ0Kco3EOLJTFi5MpO/LBOMr53nU7y11/ZaSlD1nUJEn5qoIt
         lPww==
X-Gm-Message-State: AOAM531jP7nMOXN5ZrBfXmcNjYTCj1IyECtwoLzU3ZEBVX9Dde/R114G
        SqHZhgQVSyluzmWS3RPAmtNbTEEUkbfA6wRvF3Wf0A==
X-Google-Smtp-Source: ABdhPJxskqrkU+/Bun8iluS9RzTTCb312PP/YzPq0j1Ynfozeu/uQ5PJ0jJtaZQhzko8nZjTMM9sCROJMFZvlGqDETY=
X-Received: by 2002:a17:906:4ada:: with SMTP id u26mr9365566ejt.129.1617287232520;
 Thu, 01 Apr 2021 07:27:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210331163816.11517-1-rppt@kernel.org>
In-Reply-To: <20210331163816.11517-1-rppt@kernel.org>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 1 Apr 2021 10:26:36 -0400
Message-ID: <CA+CK2bB7FuPV5z+j+8HS+wHOmNXAANYPLwo64ebV71AWNCjPSw@mail.gmail.com>
Subject: Re: [PATCH] mm/hugeltb: fix renaming of PF_MEMALLOC_NOCMA to PF_MEMALLOC_PIN
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021 at 12:38 PM Mike Rapoport <rppt@kernel.org> wrote:
>
> From: Mike Rapoport <rppt@linux.ibm.com>
>
> The renaming of PF_MEMALLOC_NOCMA to PF_MEMALLOC_PIN missed one occurrenc=
e
> in mm/hugetlb.c which causes build error:
>
>   CC      mm/hugetlb.o
> mm/hugetlb.c: In function =E2=80=98dequeue_huge_page_node_exact=E2=80=99:
> mm/hugetlb.c:1081:33: error: =E2=80=98PF_MEMALLOC_NOCMA=E2=80=99 undeclar=
ed (first use in this function); did you mean =E2=80=98PF_MEMALLOC_NOFS=E2=
=80=99?
>   bool pin =3D !!(current->flags & PF_MEMALLOC_NOCMA);
>                                  ^~~~~~~~~~~~~~~~~
>                                  PF_MEMALLOC_NOFS
> mm/hugetlb.c:1081:33: note: each undeclared identifier is reported only o=
nce for each function it appears in
> scripts/Makefile.build:273: recipe for target 'mm/hugetlb.o' failed
> make[2]: *** [mm/hugetlb.o] Error 1
>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  mm/hugetlb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index a5236c2f7bb2..c22111f3da20 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1078,7 +1078,7 @@ static void enqueue_huge_page(struct hstate *h, str=
uct page *page)
>  static struct page *dequeue_huge_page_node_exact(struct hstate *h, int n=
id)
>  {
>         struct page *page;
> -       bool pin =3D !!(current->flags & PF_MEMALLOC_NOCMA);
> +       bool pin =3D !!(current->flags & PF_MEMALLOC_PIN);

Thank you Mike!

Andrew, since "mm cma: rename PF_MEMALLOC_NOCMA to PF_MEMALLOC_PIN" is
not yet in the mainline, should I send a new version of this patch so
we won't have bisecting problems in the future?

Thank you,
Pasha
