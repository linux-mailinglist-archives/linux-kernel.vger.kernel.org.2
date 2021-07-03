Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB8183BA754
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jul 2021 07:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbhGCFRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jul 2021 01:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbhGCFRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jul 2021 01:17:20 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24ABC061762
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 22:14:47 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id h9so14014744oih.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 22:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=eQxbF2ka00EcYVsDRXeRxiGJcZxPSvtP/SHd1/OGxlc=;
        b=UVqx69n8/IJdOIjvtMMarIGzJAscY5qTxd3ntwDrmXn2Xr7jbjqkNqw9q2LeMikJKJ
         RyGWGPD8WCrkKnN/OoPXMMkZxiD6veCtjavG6XS9V35jnouiOmBOjPKsWbtmDAs2u3Ex
         9cJXntU76d3/BedLHbh+GrW05owgHBaEquMlp3Pu29gj+rAxLBCg/NRr6JtEM7fsFGwS
         leJHQpX48kNoQ5972uCxQGx67Qoc5j4U0MAaQTGOKEYz1j5KO1xUfsq2rb3W1jlQIRjk
         IQv/CYJUiKJjROSGLt1QnLUEv6vwFQKHmy3rw7iE86qowe7G+hyqbKNitdNKiWMB/aXJ
         mP8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=eQxbF2ka00EcYVsDRXeRxiGJcZxPSvtP/SHd1/OGxlc=;
        b=Ry3ozKS6QJ3dclOTSUlfZr2EDJ9HBnT+PqJWgAjupSIKQT2BUzXy1lSz9LmKDtUYFh
         mgaoafjkN3aV79nF3h/CtgeM2GnNXfXrCaEGUMlGBKbVSRRIeyGeSF+KrjS1ytCLJ5nj
         6XNF7Cu21nn4y+uWGJxbzaGcimCueM03/DbhvQ8YTq2vQSnO1DoAQa6+9gunB5bpuyU0
         ULnvU5LEWen+ZP8spW4yNur4rP7IYO7AoHQt2GRLjzoT1o5goqGkKn3CDlDClU/KFp09
         bUa3gWx8f8F6howC5af6Pltd0qGYI01dGkPLvDPlpVfr90KJBTL1cvPOMybzLrejCybH
         LGnw==
X-Gm-Message-State: AOAM531HFqaWGvEu1Wg4f0Yomfv+y3Gfs0OkmLe6QoUvPtfbwOU9ddsQ
        RhIO18o6FdSEbQaIcynvVIA=
X-Google-Smtp-Source: ABdhPJymc0nt+FrkZ7BS5ru98/uEkMhYCThRyD1sDhdB3c33wR1tBGhLKU1CaV4tkbNsA6b6yeOolw==
X-Received: by 2002:aca:4e8d:: with SMTP id c135mr2567086oib.21.1625289287153;
        Fri, 02 Jul 2021 22:14:47 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r25sm1058290otp.21.2021.07.02.22.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 22:14:46 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 2 Jul 2021 22:14:44 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] percpu: flush tlb after pcpu_depopulate_chunk()
Message-ID: <20210703051444.GA3786429@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 03, 2021 at 04:04:49AM +0000, Dennis Zhou wrote:
> Prior to "percpu: implement partial chunk depopulation",
> pcpu_depopulate_chunk() was called only on the destruction path. This
> meant the virtual address range was on its way back to vmalloc which
> will handle flushing the tlbs for us.
> 
> However, now that we call pcpu_depopulate_chunk() during the active
> lifecycle of a chunk, we need to flush the tlb as well otherwise we can
> end up accessing the wrong page through an invalid tlb mapping.
> 
> This was reported in [1].
> 
> [1] https://lore.kernel.org/lkml/20210702191140.GA3166599@roeck-us.net/
> 
> Fixes: f183324133ea ("percpu: implement partial chunk depopulation")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Dennis Zhou <dennis@kernel.org>

Tested-by: Guenter Roeck <linux@roeck-us.net>

Thanks!
Guenter

> ---
>  mm/percpu-km.c |  3 ++-
>  mm/percpu-vm.c | 11 +++++++++--
>  mm/percpu.c    |  7 ++++---
>  3 files changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/percpu-km.c b/mm/percpu-km.c
> index c9d529dc7651..6875fc3b2ed7 100644
> --- a/mm/percpu-km.c
> +++ b/mm/percpu-km.c
> @@ -39,7 +39,8 @@ static int pcpu_populate_chunk(struct pcpu_chunk *chunk,
>  }
>  
>  static void pcpu_depopulate_chunk(struct pcpu_chunk *chunk,
> -				  int page_start, int page_end)
> +				  int page_start, int page_end,
> +				  bool flush_tlb)
>  {
>  	/* nada */
>  }
> diff --git a/mm/percpu-vm.c b/mm/percpu-vm.c
> index ee5d89fcd66f..6353cda1718e 100644
> --- a/mm/percpu-vm.c
> +++ b/mm/percpu-vm.c
> @@ -299,6 +299,7 @@ static int pcpu_populate_chunk(struct pcpu_chunk *chunk,
>   * @chunk: chunk to depopulate
>   * @page_start: the start page
>   * @page_end: the end page
> + * @flush_tlb: if should we flush the tlb
>   *
>   * For each cpu, depopulate and unmap pages [@page_start,@page_end)
>   * from @chunk.
> @@ -307,7 +308,8 @@ static int pcpu_populate_chunk(struct pcpu_chunk *chunk,
>   * pcpu_alloc_mutex.
>   */
>  static void pcpu_depopulate_chunk(struct pcpu_chunk *chunk,
> -				  int page_start, int page_end)
> +				  int page_start, int page_end,
> +				  bool flush_tlb)
>  {
>  	struct page **pages;
>  
> @@ -324,7 +326,12 @@ static void pcpu_depopulate_chunk(struct pcpu_chunk *chunk,
>  
>  	pcpu_unmap_pages(chunk, pages, page_start, page_end);
>  
> -	/* no need to flush tlb, vmalloc will handle it lazily */
> +	/*
> +	 * We need to flush the tlb unless the caller will pass it to vmalloc,
> +	 * which will handle flushing for us.
> +	 */
> +	if (flush_tlb)
> +		pcpu_post_unmap_tlb_flush(chunk, page_start, page_end);
>  
>  	pcpu_free_pages(chunk, pages, page_start, page_end);
>  }
> diff --git a/mm/percpu.c b/mm/percpu.c
> index b4cebeca4c0c..e23ba0d22220 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -1580,7 +1580,8 @@ static void pcpu_chunk_depopulated(struct pcpu_chunk *chunk,
>  static int pcpu_populate_chunk(struct pcpu_chunk *chunk,
>  			       int page_start, int page_end, gfp_t gfp);
>  static void pcpu_depopulate_chunk(struct pcpu_chunk *chunk,
> -				  int page_start, int page_end);
> +				  int page_start, int page_end,
> +				  bool flush_tlb);
>  static struct pcpu_chunk *pcpu_create_chunk(gfp_t gfp);
>  static void pcpu_destroy_chunk(struct pcpu_chunk *chunk);
>  static struct page *pcpu_addr_to_page(void *addr);
> @@ -2016,7 +2017,7 @@ static void pcpu_balance_free(bool empty_only)
>  
>  		bitmap_for_each_set_region(chunk->populated, rs, re, 0,
>  					   chunk->nr_pages) {
> -			pcpu_depopulate_chunk(chunk, rs, re);
> +			pcpu_depopulate_chunk(chunk, rs, re, false);
>  			spin_lock_irq(&pcpu_lock);
>  			pcpu_chunk_depopulated(chunk, rs, re);
>  			spin_unlock_irq(&pcpu_lock);
> @@ -2189,7 +2190,7 @@ static void pcpu_reclaim_populated(void)
>  				continue;
>  
>  			spin_unlock_irq(&pcpu_lock);
> -			pcpu_depopulate_chunk(chunk, i + 1, end + 1);
> +			pcpu_depopulate_chunk(chunk, i + 1, end + 1, true);
>  			cond_resched();
>  			spin_lock_irq(&pcpu_lock);
>  
> -- 
> 2.32.0.93.g670b81a890-goog
> 
