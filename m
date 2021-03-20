Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7CBC3429AD
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 02:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbhCTBmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 21:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhCTBme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 21:42:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38694C061760
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 18:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YTV8iGBqHFhRXi29e5KL8hBRS8AsvFNXkRnMt99iEL8=; b=MEdAPSjCZMUIbxM9J36Yp5urm1
        wR/KjKPUIKnswCLgngL2Zg3EVNW2n0MNy821Ap6YxfcSyW3HsaX48+WY7CXolgT+95yJCLos0CdBh
        v+V2QOt4wZlgUF65OmL7Z4PU9i1rBjryNV0Tua2FnojgV7/NKpyHV6lEB4jayDHd6Q6E3jbsiVMkX
        YMlaqTOmpxfrt51fgbaUiYlC7aygboHOtMxn5cJZQC7ztFjHwab+EBAbWHGxP7QSHJZqJwizw68+7
        X4oFuATTvXB/lXIXRjm+GUf0F3Kcnox6+VT8XE/rQrGUdAvxwH0mGfuB6y7PfX2kAjTxgVl6FHxmE
        fl17XY8w==;
Received: from rdunlap (helo=localhost)
        by bombadil.infradead.org with local-esmtp (Exim 4.94 #2 (Red Hat Linux))
        id 1lNQdL-001eBb-Il; Sat, 20 Mar 2021 01:42:32 +0000
Date:   Fri, 19 Mar 2021 18:42:31 -0700 (PDT)
From:   Randy Dunlap <rdunlap@bombadil.infradead.org>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
cc:     david@fromorbit.com, linux-kernel@vger.kernel.org
Subject: Re: [unixbhaskar@gmail.com: [PATCH] lib: Fix a typo]
In-Reply-To: <YFUTASslkS14RsXf@Gentoo>
Message-ID: <c9e9369a-1a59-8915-c28e-1d1e11e6229c@bombadil.infradead.org>
References: <YFUTASslkS14RsXf@Gentoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: Randy Dunlap <rdunlap@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210319_184231_638347_401A9F7A 
X-CRM114-Status: GOOD (  18.12  )
X-Spam-Score: -0.0 (/)
X-Spam-Report: Spam detection software, running on the system "bombadil.infradead.org",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  On Sat, 20 Mar 2021, Bhaskar Chowdhury wrote: > ----- Forwarded
    message from Bhaskar Chowdhury <unixbhaskar@gmail.com> ----- > > Hi Dave,
    > > Can you please take it, as I haven't found anybody attached with this
    > file,but > found you made some e [...] 
 Content analysis details:   (-0.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -0.0 NO_RELAYS              Informational: message was not relayed via SMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 20 Mar 2021, Bhaskar Chowdhury wrote:

> ----- Forwarded message from Bhaskar Chowdhury <unixbhaskar@gmail.com> -----
>
> Hi Dave,
>
> Can you please take it, as I haven't found anybody attached with this 
> file,but
> found you made some entry(I am trying to take advantage of you!! :)  ) ..
>
> Thanks,
> Bhaskar
> Date: Sat, 20 Mar 2021 02:31:55 +0530
> From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> To: unixbhaskar@gmail.com, linux-kernel@vger.kernel.org
> Subject: [PATCH] lib: Fix a typo
> X-Mailer: git-send-email 2.26.2
>
>
> s/funtion/function/
>
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>


> ---
>  lib/list_sort.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/list_sort.c b/lib/list_sort.c
> index 52f0c258c895..282fe269f16a 100644
> --- a/lib/list_sort.c
> +++ b/lib/list_sort.c
> @@ -107,7 +107,7 @@ static void merge_final(void *priv, cmp_func cmp, struct 
> list_head *head,
>   * @head: the list to sort
>   * @cmp: the elements comparison function
>   *
> - * The comparison funtion @cmp must return > 0 if @a should sort after
> + * The comparison function @cmp must return > 0 if @a should sort after
>   * @b ("@a > @b" if you want an ascending sort), and <= 0 if @a should
>   * sort before @b *or* their original order should be preserved.  It is
>   * always called with the element that came first in the input in @a,
> --
> 2.26.2
>
>
> ----- End forwarded message -----
>
