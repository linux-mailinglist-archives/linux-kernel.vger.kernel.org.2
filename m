Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D17B343018
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 23:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhCTWks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 18:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbhCTWkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 18:40:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711E0C061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 15:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Rm++ZBko8PgNveQjUBSGv2T36CmW0HBM9zUDPgiM88k=; b=OvtQDmFO075pBMaaJc1gH0d1nG
        bi3OGn+vOfJ2fqNpQ/0UjXL2O8pU/euvCWnF7KuPG1o+49ACsj93zIYFaY6pIMhRXg6ThwI1GoSUD
        KVzNWBGyp7L2X+P3AbxkmhmlaJfN30sNEqpZjc8+9XFUvxvWXsXBWFB0gmyQMaE0gJ6OP1tW8lWmk
        Icxp/IkF+kPagH6HnbJCMauQfZbhf7UZ2+LSQ7bbNG0v7o4apDBWHOEAM5Z5sidUma8+k6/skBtAb
        PMjx08zkV7JesAJZyVUI59b7aIjf+hWwmFrPapcnNSyIT0Kr9EFSZC2a01anMG3XRCTu9DeNz08CT
        d1sLH78A==;
Received: from rdunlap (helo=localhost)
        by bombadil.infradead.org with local-esmtp (Exim 4.94 #2 (Red Hat Linux))
        id 1lNkGO-0024fS-Qa; Sat, 20 Mar 2021 22:40:09 +0000
Date:   Sat, 20 Mar 2021 15:40:08 -0700 (PDT)
From:   Randy Dunlap <rdunlap@bombadil.infradead.org>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
cc:     linux-graphics-maintainer@vmware.com, sroland@vmware.com,
        zackr@vmware.com, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/vmwgfx: Fix a typo
In-Reply-To: <20210320211617.30746-1-unixbhaskar@gmail.com>
Message-ID: <17a49e9b-6ba6-9cca-d835-9199d92e4870@bombadil.infradead.org>
References: <20210320211617.30746-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: Randy Dunlap <rdunlap@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210320_154008_883671_BAC758F3 
X-CRM114-Status: GOOD (  14.90  )
X-Spam-Score: -0.0 (/)
X-Spam-Report: Spam detection software, running on the system "bombadil.infradead.org",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  On Sun, 21 Mar 2021, Bhaskar Chowdhury wrote: > > s/particuar/particular/
    > > Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com> Acked-by: Randy
    Dunlap <rdunlap@infradead.org> 
 Content analysis details:   (-0.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -0.0 NO_RELAYS              Informational: message was not relayed via SMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 21 Mar 2021, Bhaskar Chowdhury wrote:

>
> s/particuar/particular/
>
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>


> ---
> drivers/gpu/drm/vmwgfx/vmwgfx_so.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_so.c b/drivers/gpu/drm/vmwgfx/vmwgfx_so.c
> index 7369dd86d3a9..6cd38e407145 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_so.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_so.c
> @@ -33,7 +33,7 @@
>  * The currently only reason we need to keep track of views is that if we
>  * destroy a hardware surface, all views pointing to it must also be destroyed,
>  * otherwise the device will error.
> - * So in particuar if a surface is evicted, we must destroy all views pointing
> + * So in particular if a surface is evicted, we must destroy all views pointing
>  * to it, and all context bindings of that view. Similarly we must restore
>  * the view bindings, views and surfaces pointed to by the views when a
>  * context is referenced in the command stream.
> --
> 2.26.2
>
>
