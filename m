Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66FB83429A6
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 02:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhCTBcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 21:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhCTBbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 21:31:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0B2C061760
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 18:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eeczjN9wefOmJj/5y5zYFmY+3fxkK7PM3F6myS4kr+I=; b=zqPpD+fuNMBeUv+5ezl4j4CJ0o
        brRwxM93ENrTZqcd/DaDgZTpsgsXj4TapMrdDnbPwOkR69yXgIg8gX8XgOQsi+sMvOdT/7xb6nsSs
        hahamXRLEPCQI7llbYrzrJAIUOW4uVDXEC0w0IPKm6gQ8NPd5SpxTAy+WmheHES0GMUtXIa4buzRV
        E57XYVv9cyhI36VSoPYq8+P3Zz0XOliSYzoJw0khNyEGKzh+FFqI7FnxYTAhGGvARZMXOPk5lRisD
        78Vtrih5McljF3m9wdLy4pjOgXvhLQTt1g2cWU/I5yd3MtNaKApn0UyaTL1fkiT1WlspG3ynQDUf0
        nOf80ujg==;
Received: from rdunlap (helo=localhost)
        by bombadil.infradead.org with local-esmtp (Exim 4.94 #2 (Red Hat Linux))
        id 1lNQSy-001e2T-Q9; Sat, 20 Mar 2021 01:31:49 +0000
Date:   Fri, 19 Mar 2021 18:31:48 -0700 (PDT)
From:   Randy Dunlap <rdunlap@bombadil.infradead.org>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
cc:     catalin.marinas@arm.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: kmemleak: Fix a typo
In-Reply-To: <20210319214140.23304-1-unixbhaskar@gmail.com>
Message-ID: <1c7eca5b-c47-8954-b34d-9552d13123ef@bombadil.infradead.org>
References: <20210319214140.23304-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: Randy Dunlap <rdunlap@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210319_183148_865981_925125B1 
X-CRM114-Status: GOOD (  11.93  )
X-Spam-Score: -0.0 (/)
X-Spam-Report: Spam detection software, running on the system "bombadil.infradead.org",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  On Sat, 20 Mar 2021, Bhaskar Chowdhury wrote: > > s/interruptable/interruptible/
    > > Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com> Acked-by: Randy
    Dunlap <rdunlap@infradead.org> 
 Content analysis details:   (-0.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -0.0 NO_RELAYS              Informational: message was not relayed via SMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 20 Mar 2021, Bhaskar Chowdhury wrote:

>
> s/interruptable/interruptible/
>
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>


> ---
> mm/kmemleak.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> index c0014d3b91c1..f09f1a9402a9 100644
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -1202,7 +1202,7 @@ static void update_refs(struct kmemleak_object *object)
> }
>
> /*
> - * Memory scanning is a long process and it needs to be interruptable. This
> + * Memory scanning is a long process and it needs to be interruptible. This
>  * function checks whether such interrupt condition occurred.
>  */
> static int scan_should_stop(void)
> --
> 2.26.2
>
>
