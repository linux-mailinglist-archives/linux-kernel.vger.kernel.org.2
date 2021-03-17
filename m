Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2334F33EE87
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 11:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhCQKhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 06:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbhCQKgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 06:36:53 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386DDC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 03:36:42 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id mm21so1722649ejb.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 03:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DaFywpidnCeh4zxx7OmWpLHe6NVtXGuPwtwc5Xq6dkI=;
        b=St/h20aal60N0VZslFwCKJLMFrjF7wFDi3hxNyw+iIAbqz3oJNNOgH73zIOo+4oxE0
         EvGiBP0BYh+O+1qZ4ZF+gn062fhHPTtU0cKqxkDPKjAxyCpyar/77hO03QqdQOsgg/fd
         3d87b6xINHBwtaMSGl4KQzpPX3QnDzCf2V/1UhYRj/ZGtsVLHT8chU54aJZAO3JOQSds
         HlcUCxIMdUktyTvQuotR1Y4Y5xew3CbTSzELl0Rg9nyl7K90UqYmYG0hjtEGnnQaiipZ
         HtBXdWcxRqDjsPPV7ShN3udFdENa3D3kexeAtIs9v9FzrbRS2uIlx/m8l8WJTeB+s4Gs
         kbHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DaFywpidnCeh4zxx7OmWpLHe6NVtXGuPwtwc5Xq6dkI=;
        b=bRh+zEc9MBTAE7sV2/oyYBY4tcbQHpkIrWwnydbMuCoHbnGDXaP1VpOpaohxB97Ttk
         bbsYc7ea8GvUvLJHmWCXAvbVmLC5joaHxmfv96+NfL0H85OcK2gk5viTiT8GDJBm6VL/
         haJIWjgs1pK5WSw1LzsIH4f4rTnzlCVyeLvgEY4iNHxMUQ/FdxXbvod/5fdQQagVf6wt
         Z+zLZDWFhyHY2tHK9Qfs+PrVDXqnZF3hUW4u9t7xbWf+yIHtao7/2wFVJBZiwQzIpDXk
         fn6OTUXPfC+vPktczMLQ4pQXe25xUOa5hMCJ2+4smM1IfeSPpywOO8Iub2fzLHgo2JTN
         jYRw==
X-Gm-Message-State: AOAM5339n5HOF14/N46OCnfVlN5UsNk9fPHTQk0B0Arb8JmNrp/4sKdT
        0QkLiAgxdyeUQxLMUCd7nbxY3g==
X-Google-Smtp-Source: ABdhPJzNiUEFO/BpO//rhasAV4B2Hv3Idb2Z3PDPhSRZ3vHuspefsfqRaBmVQREczHqSl4XDALHJeg==
X-Received: by 2002:a17:906:12db:: with SMTP id l27mr34065389ejb.500.1615977400829;
        Wed, 17 Mar 2021 03:36:40 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id f19sm12262260edu.12.2021.03.17.03.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 03:36:40 -0700 (PDT)
Date:   Wed, 17 Mar 2021 10:36:38 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     jason.wessel@windriver.com, dianders@chromium.org,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
Subject: Re: [PATCH] kernel: debug: Ordinary typo fixes in the file gdbstub.c
Message-ID: <20210317103638.sw4wqq4p4hg7dhco@maple.lan>
References: <20210317091022.347258-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210317091022.347258-1-unixbhaskar@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 02:40:22PM +0530, Bhaskar Chowdhury wrote:
> 
> s/'O'utput/'Output/
> s/overwitten/overwritten/
> s/procesing/processing/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  kernel/debug/gdbstub.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/debug/gdbstub.c b/kernel/debug/gdbstub.c
> index e149a0ac9e9e..5c96590725f1 100644
> --- a/kernel/debug/gdbstub.c
> +++ b/kernel/debug/gdbstub.c
> @@ -204,7 +204,7 @@ void gdbstub_msg_write(const char *s, int len)
>  	if (len == 0)
>  		len = strlen(s);
> 
> -	/* 'O'utput */
> +	/* 'Output */

This is not a typo.

It is showing that the 'O' being writing into the message buffer is a
mnemonic and describing what it expands to.

Other changes look good, please can you resend with this one removed?


Daniel.


>  	gdbmsgbuf[0] = 'O';
> 
>  	/* Fill and send buffers... */
> @@ -321,7 +321,7 @@ int kgdb_hex2long(char **ptr, unsigned long *long_val)
>  /*
>   * Copy the binary array pointed to by buf into mem.  Fix $, #, and
>   * 0x7d escaped with 0x7d. Return -EFAULT on failure or 0 on success.
> - * The input buf is overwitten with the result to write to mem.
> + * The input buf is overwritten with the result to write to mem.
>   */
>  static int kgdb_ebin2mem(char *buf, char *mem, int count)
>  {
> @@ -952,7 +952,7 @@ static int gdb_cmd_exception_pass(struct kgdb_state *ks)
>  }
> 
>  /*
> - * This function performs all gdbserial command procesing
> + * This function performs all gdbserial command processing
>   */
>  int gdb_serial_stub(struct kgdb_state *ks)
>  {
> --
> 2.30.2
> 
