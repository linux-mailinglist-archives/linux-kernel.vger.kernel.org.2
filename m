Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 354E033FAEF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 23:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbhCQWU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 18:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbhCQWUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 18:20:37 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718B0C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 15:20:37 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id cl21-20020a17090af695b02900c61ac0f0e9so5898801pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 15:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/ZNitVW6tu44OGxgiCKPMYxsVQ0NeOsQR8ABJdE9An0=;
        b=muVpvF9oran20WGEXoJgKowr5DwcVVt49x2tWsFy+Y4BvjHgGhRJ8iHx83C9462qd5
         +ZbGhSLeFzwaNXBdbKRz31axFN3qUdJ/JDVnKujmivwkEeNk2uR/nTIOUTR4ByF3lXc+
         U03KuSy9CxBDvG9z+74/wPu8spoByPYhWsbT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/ZNitVW6tu44OGxgiCKPMYxsVQ0NeOsQR8ABJdE9An0=;
        b=nIBLKB5T6FLiWVNEoj7v8XDdx4d6VNGqddByALNQy0hgRpUQAzdmpVjh8ZZkvp3ULz
         6BGaOT3er1Jb1XtsgakgG0RXfqLcDIPlFP4hf5zM2mIuJu8ZBRaryZD+uG1ZaaTeapsq
         5fJO5e9R6L1HY6/J9xSm+McsZyhGnByEk4O70haKKYCvYmGFvkzcntApxLUMR2T74+Yo
         XNXgG4MdaPz3h32XLxcchBPI+vSfyau4ExoDQNQqXeAgRtubpPNJAC9QD/5oH30B9sGn
         xv1v4uOTpiUrMzwXyt4hxf9xR/DkrQ8IFCHgDWKdyu0U2VGZPBSXCtzPIMSSwXZJGjyS
         a6ig==
X-Gm-Message-State: AOAM532YTQWltGXRzX6ujjIFE5DvIoJOHbLcvG6F9i6TcKRUVxP/3oJB
        9GBYLcAWkXKZiy4boAplWSgFEQ==
X-Google-Smtp-Source: ABdhPJzIgLlYIFtoRCbfRhppJ0Dr7dd0iLR7G9R1WbIAciXJoCIhk3QWekMkk3f6oel/qRIUWKdJ3A==
X-Received: by 2002:a17:90b:4395:: with SMTP id in21mr955487pjb.201.1616019637024;
        Wed, 17 Mar 2021 15:20:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l4sm89449pgi.19.2021.03.17.15.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 15:20:36 -0700 (PDT)
Date:   Wed, 17 Mar 2021 15:20:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mukesh Ojha <mojha@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com, Huang Yiwei <hyiwei@codeaurora.org>
Subject: Re: [RESEND PATCH v2 2/2] pstore: Add buffer start check during init
Message-ID: <202103171434.A04E5FAF@keescook>
References: <1614268817-7596-1-git-send-email-mojha@codeaurora.org>
 <1614268817-7596-2-git-send-email-mojha@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614268817-7596-2-git-send-email-mojha@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 09:30:17PM +0530, Mukesh Ojha wrote:
> From: Huang Yiwei <hyiwei@codeaurora.org>
> 
> In a scenario of panic, when we use DRAM to store log instead
> of persistant storage and during warm reset when we copy these
> data outside of ram. Missing check on prz->start(write position)
> can cause crash because it can be any value and can point outside
> the mapped region. So add the start check to avoid.
> 
> Signed-off-by: Huang Yiwei <hyiwei@codeaurora.org>
> Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
> ---
> change in v2:
>  - this is on top of first patchset.
> 
>  fs/pstore/ram_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
> index 0da012f..a15748a 100644
> --- a/fs/pstore/ram_core.c
> +++ b/fs/pstore/ram_core.c
> @@ -514,7 +514,7 @@ static int persistent_ram_post_init(struct persistent_ram_zone *prz, u32 sig,
>  	sig ^= PERSISTENT_RAM_SIG;
>  
>  	if (prz->buffer->sig == sig) {
> -		if (buffer_size(prz) == 0) {
> +		if (buffer_size(prz) == 0 && buffer_start(prz) == 0) {
>  			pr_debug("found existing empty buffer\n");
>  			return 0;

Were you seeing cases where the sig was correct, size was zero and start
was non-zero but still smaller than buffer_size(prz)?

That should only happen if a prz changed in size (but not location)
across boots, and I guess, yes, should be detected and zapped. But that
means you need a case for size=0 buffer_start!=0 for zapping.

But you talk about a crash without this test? "any value" isn't true,
the next tests make sure it's within buffer_size:

                if (buffer_size(prz) > prz->buffer_size ||
                    buffer_start(prz) > buffer_size(prz)) {
                        pr_info("found existing invalid buffer, size %zu, start %zu\n",
                                buffer_size(prz), buffer_start(prz));
                        zap = true;

can you tell me more about what you're seeing?

-Kees

-- 
Kees Cook
