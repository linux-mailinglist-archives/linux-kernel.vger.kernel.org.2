Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B10063E32F0
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 05:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbhHGDSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 23:18:18 -0400
Received: from mail-pl1-f173.google.com ([209.85.214.173]:41667 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbhHGDSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 23:18:17 -0400
Received: by mail-pl1-f173.google.com with SMTP id z3so9665849plg.8
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 20:17:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cpusoSOd4NknFaIppIZ9J2xjSzLfMAllzc1fhTnTH88=;
        b=aesFGbXZtlrN3Bcn0cGSEq6WmlkDhxHwUWQvKyay2ulITcYm3JiRqUbEkaTieTg9l7
         W1+ktz4sPrHPlSYOC6/16oOe2KsKnzuVka/y2fYEZHKHwOT8m1RCBWVbb/wRsbtaneqx
         Bc39cW9gmgfULfkhI6G2UBr+nHfCUQW+35ypAFgyr4qGu+oQd+rds7XyU+k8NA03jKkK
         T/BEw4Udkys3CPkKav63cwf2KpUFnPJdQBAZqhinyZ89nCaOotdqa9Rp8BXc/xL5+ltk
         207xsKC8E9i7X1cMuiGPbduUrIwJN0Vwshqy6lWWc60pnslcFIIcqN/bkD1z5r7pSaxN
         nUMw==
X-Gm-Message-State: AOAM5328Ni7SdhUVWqq7Z5cDYRmkkfVWku7uxzmmr92sAvf2f/0h63UD
        V+M+eHJlOatW7cscmDVGooeMxQepnEs=
X-Google-Smtp-Source: ABdhPJwMsZxfX38sOMvnpOBG7SHArX3Jk6MChL1njYAf0axsREL1V2JqQdni+2L5zKIbzwYdqKUh1A==
X-Received: by 2002:a05:6a00:1305:b029:347:676:d38f with SMTP id j5-20020a056a001305b02903470676d38fmr7912268pfu.39.1628306278737;
        Fri, 06 Aug 2021 20:17:58 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:8305:dc99:b3ea:1aa2? ([2601:647:4000:d7:8305:dc99:b3ea:1aa2])
        by smtp.gmail.com with ESMTPSA id v1sm14124799pgj.40.2021.08.06.20.17.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Aug 2021 20:17:58 -0700 (PDT)
Subject: Re: [PATCH] lkdtm: move SCSI_DISPATCH_CMD to scsi_queue_rq
To:     Kevin Mitchell <kevmitch@arista.com>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hannes Reinecke <hare@suse.de>, linux-kernel@vger.kernel.org
References: <20210806225905.417649-1-kevmitch@arista.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <b3c621ee-1729-e631-3dd5-3b4792dd1927@acm.org>
Date:   Fri, 6 Aug 2021 20:17:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210806225905.417649-1-kevmitch@arista.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/6/21 3:59 PM, Kevin Mitchell wrote:
> When scsi_dispatch_cmd was moved to scsi_lib.c and made static, some
> compilers (i.e., at least gcc 8.4.0) decided to compile this
> inline. This is a problem for lkdtm.ko, which needs to insert a kprobe
> on this function for the SCSI_DISPATCH_CMD crashpoint.
> 
> Move this crashpoint one function up the call chain to
> scsi_queue_rq. Though this is also a static function, it should never be
> inlined because it is assigned as a structure entry. Therefore,
> kprobe_register should always be able to find it. Since there is already
> precedent for crashpoint names not exactly matching their probed
> functions, keep the name of the crashpoint the same for backwards
> compatibility.
> 
> Fixes: 82042a2cdb55 ("scsi: move scsi_dispatch_cmd to scsi_lib.c")
> Signed-off-by: Kevin Mitchell <kevmitch@arista.com>
> ---
>  drivers/misc/lkdtm/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
> index 97803f213..2612f214d 100644
> --- a/drivers/misc/lkdtm/core.c
> +++ b/drivers/misc/lkdtm/core.c
> @@ -81,7 +81,7 @@ static struct crashpoint crashpoints[] = {
>  	CRASHPOINT("FS_DEVRW",		 "ll_rw_block"),
>  	CRASHPOINT("MEM_SWAPOUT",	 "shrink_inactive_list"),
>  	CRASHPOINT("TIMERADD",		 "hrtimer_start"),
> -	CRASHPOINT("SCSI_DISPATCH_CMD",	 "scsi_dispatch_cmd"),
> +	CRASHPOINT("SCSI_DISPATCH_CMD",	 "scsi_queue_rq"),
>  	CRASHPOINT("IDE_CORE_CP",	 "generic_ide_ioctl"),
>  #endif
>  };

Please send SCSI patches to the linux-scsi mailing list. See also the
MAINTAINERS file.

Thanks,

Bart.


