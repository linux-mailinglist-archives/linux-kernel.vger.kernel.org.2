Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 965843423CE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 18:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbhCSRza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 13:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbhCSRzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 13:55:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE3EC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 10:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rUwGdU8Yedk4kRCKzbyc5m3bgGUr+REyzJApW/WqH2k=; b=tPPzkGgGH0ENXaQU2hnZoDDaEG
        kZX09R4jXMCO1CV9teSr1VJpC/Qd0OrxiA0cjdUgyJo7TVF6+XulHM9yYtTUvgs1QD9xfMvOH9o4w
        g4OzNPDnxcOQzC+E+0GbYdsrRbFRnkeWdDwMBy4v+G22UC0bt3EiWECuM9c+ZZ063lgKmxNtxGWzG
        VGa+RPHLUS+HEepy8C8hHeLXBIUX7ClyYaYaCW9Sp/P7cgrvqpJCJ08thSXz1LbkHU9dI9Wh7xep3
        8KNfPdn4XD5Y4EMqoCLjjkMysNdMR0PpfLUAh6X+eACgih80n6m27g7ANKhGVl79TPjNqHeWIdEoS
        h1NRNhBQ==;
Received: from rdunlap (helo=localhost)
        by bombadil.infradead.org with local-esmtp (Exim 4.94 #2 (Red Hat Linux))
        id 1lNJLH-001R9U-SO; Fri, 19 Mar 2021 17:55:24 +0000
Date:   Fri, 19 Mar 2021 10:55:23 -0700 (PDT)
From:   Randy Dunlap <rdunlap@bombadil.infradead.org>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] average: Mundane typo fix
In-Reply-To: <20210319010126.9537-1-unixbhaskar@gmail.com>
Message-ID: <88ccf363-c6c4-3aab-9f1-8da3ef23650@bombadil.infradead.org>
References: <20210319010126.9537-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: Randy Dunlap <rdunlap@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210319_105523_937787_31BF17FF 
X-CRM114-Status: GOOD (  13.19  )
X-Spam-Score: -0.0 (/)
X-Spam-Report: Spam detection software, running on the system "bombadil.infradead.org",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  On Fri, 19 Mar 2021, Bhaskar Chowdhury wrote: > s/funtions/functions/
    > > Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com> Acked-by: Randy
    Dunlap <rdunlap@infradead.org> 
 Content analysis details:   (-0.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -0.0 NO_RELAYS              Informational: message was not relayed via SMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 19 Mar 2021, Bhaskar Chowdhury wrote:

> s/funtions/functions/
>
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>


> ---
> include/linux/average.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/average.h b/include/linux/average.h
> index a1a8f09631ce..0cb77b3e483c 100644
> --- a/include/linux/average.h
> +++ b/include/linux/average.h
> @@ -11,7 +11,7 @@
>  *
>  * This implements a fixed-precision EWMA algorithm, with both the
>  * precision and fall-off coefficient determined at compile-time
> - * and built into the generated helper funtions.
> + * and built into the generated helper functions.
>  *
>  * The first argument to the macro is the name that will be used
>  * for the struct and helper functions.
> --
> 2.26.2
>
>
