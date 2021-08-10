Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 615F73E84F6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 23:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233788AbhHJVJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 17:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbhHJVJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 17:09:22 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA789C0613C1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 14:08:51 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id t35so1098283oiw.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 14:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=rBnuCjF4OrAtuZ/I6bis+5AbEoYqDoFUpxjnGFAFTWc=;
        b=V3VuFDuP8N54+ffqX3fMhnzQtEGCVpjz5Z6o5m/ZCzdX7pw6maVxapH8gKIpA1PFvl
         N7ODFJxahvN5s1IgMO0lwnAQsQiurvHTxMPOpF+T7Z/1kB8GQ1MEbpEP6BY4VGmu3qWh
         AOUoiYUf41YInPtRCN758oQenC0caBV1BvHQmTS++UHmHfaANxVQKqIQo7Cd4MDDl4yq
         zuX+LUfW8IKY5I2xDwb1rtQLYpVhIwrMQcF5tJ+HIVFCf8TgGRlN7vUc2oOR+C36egEV
         WNm/5EznEMshnMgKZsTPGXmdR4vd7mq00uvtae0rydqYSwN+q66njXE+PEGLosvctRrS
         qvsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=rBnuCjF4OrAtuZ/I6bis+5AbEoYqDoFUpxjnGFAFTWc=;
        b=IEzi/zL3+P8mf7hProJ59cogMmrSmD2NfunKtHK8pk4PcYbp2uuek5ohUyZ900Nmi2
         mlGv+1N0DsAHo5RDoerBFEtb5R85yKl9sPZc61Yvbz/IRtb0aWXfG7CkkDMpbZnMpUei
         OpbRTUtHyVHx++Ghc5D6shh+aoEtOSFylL00Wo3/vLH7snZKKsdEPcdyPH/mW5Ybzu5c
         AjEYhUdQDjQo+PLHMWY1LBJAIZAgDOuczX63Oef1yLbm9aq4YSIWqA/Y+zG45+/dX9M9
         w0luH3BfM/a65MQ089VgIWRxHrtbd8R46GYQDBjILRI7/GIJD27fOdvSgPC8hZECWS6V
         gebQ==
X-Gm-Message-State: AOAM530BQ4bFf6u3tVbqNodPjRBWsJRo+fI6erGFSda32zN7bVez0PpR
        OKRcDFFbEif95DzhsH6isVwZvQ==
X-Google-Smtp-Source: ABdhPJzNLDtfFYwyZE8sXaFXrcq3Gdv4urYj+yP5wcE3AoJiSU6zeV++3TGdD1jwnwlnogniOTTFiQ==
X-Received: by 2002:aca:1e05:: with SMTP id m5mr4970545oic.29.1628629730876;
        Tue, 10 Aug 2021 14:08:50 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id y138sm3399706oie.22.2021.08.10.14.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 14:08:50 -0700 (PDT)
Date:   Tue, 10 Aug 2021 14:08:38 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Yang Shi <shy828301@gmail.com>
cc:     hughd@google.com, ying.huang@intel.com, linmiaohe@huawei.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] Revert "mm: swap: check if swap backing device is
 congested or not"
In-Reply-To: <20210810202936.2672-3-shy828301@gmail.com>
Message-ID: <3983c910-a02b-e67b-8c2b-7a379c3d22e1@google.com>
References: <20210810202936.2672-1-shy828301@gmail.com> <20210810202936.2672-3-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Aug 2021, Yang Shi wrote:

> Due to the change about how block layer detects congestion the
> justification of commit 8fd2e0b505d1 ("mm: swap: check if swap backing device
> is congested or not") doesn't stand anymore, so the commit could be just
> reverted in order to solve the race reported by commit 2efa33fc7f6e ("mm/shmem:
> fix shmem_swapin() race with swapoff"). The fix was reverted by the
> previous patch.
> 
> Suggested-by: Hugh Dickins <hughd@google.com>
> Cc: "Huang, Ying" <ying.huang@intel.com>
> Cc: Miaohe Lin <linmiaohe@huawei.com>
> Signed-off-by: Yang Shi <shy828301@gmail.com>

Thanks for doing these,
Acked-by: Hugh Dickins <hughd@google.com>
to all three.

I guess 1/3 will vanish now, since what it's reverting has not yet gone
forward to Linus: it would have been nice for 2/3 to have mentioned that
what it's reverting is kindof buggy: but then you'd have to explain the
"kindof", and that takes more words than it's worth - maybe a lore Link
to the discussion?

But you've done the work that I've not yet got around to:
so thank you, and ignore my gripes.

Hugh

> ---
>  mm/swap_state.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 1a29b4f98208..8d4104242100 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -628,13 +628,6 @@ struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
>  	if (!mask)
>  		goto skip;
>  
> -	/* Test swap type to make sure the dereference is safe */
> -	if (likely(si->flags & (SWP_BLKDEV | SWP_FS_OPS))) {
> -		struct inode *inode = si->swap_file->f_mapping->host;
> -		if (inode_read_congested(inode))
> -			goto skip;
> -	}
> -
>  	do_poll = false;
>  	/* Read a page_cluster sized and aligned cluster around offset. */
>  	start_offset = offset & ~mask;
> -- 
> 2.26.2
