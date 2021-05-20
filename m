Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1BCD38A4CA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 12:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235956AbhETKKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 06:10:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:39796 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234871AbhETKDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 06:03:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8D4D0AE81;
        Thu, 20 May 2021 10:02:09 +0000 (UTC)
Subject: Re: [PATCH 3/3] slub: Actually use 'message' in restore_bytes()
To:     Stephen Boyd <swboyd@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org
References: <20210520013539.3733631-1-swboyd@chromium.org>
 <20210520013539.3733631-4-swboyd@chromium.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <198cf778-53b8-ecfe-1a76-3f3dbde4c0d7@suse.cz>
Date:   Thu, 20 May 2021 12:02:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210520013539.3733631-4-swboyd@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/21 3:35 AM, Stephen Boyd wrote:
> The message argument isn't used here. Let's pass the string to the
> printk message so that the developer can figure out what's happening,
> instead of guessing that a redzone is being restored, etc.
> 
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/slub.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 87eeeed1f369..16e8e8f8dc0c 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -777,7 +777,7 @@ static void init_object(struct kmem_cache *s, void *object, u8 val)
>  static void restore_bytes(struct kmem_cache *s, char *message, u8 data,
>  						void *from, void *to)
>  {
> -	slab_fix(s, "Restoring 0x%px-0x%px=0x%x\n", from, to - 1, data);
> +	slab_fix(s, "Restoring %s 0x%px-0x%px=0x%x\n", message, from, to - 1, data);
>  	memset(from, data, to - from);
>  }
>  
> 

