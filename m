Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A58BB34E193
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 08:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbhC3GyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 02:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbhC3GyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 02:54:02 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EE0C061762
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 23:54:02 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id o16so15142363wrn.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 23:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/5eEEdExB/WrcymVKXu9WY7O+JW+rGDAlHjMnzkWSN0=;
        b=usJ/DzjF7T3vYoDSsVKlv8V4nwI9Obf1PPZm3sH78ecUqNEOM7cT5sqxrx7DsCfkFJ
         Bv4azBoeYlPKKHMs5q3jwX0u3DpovuZA5IU2cyOsO6vhrD5R6dR3UN3HM9JOLY/n5z1v
         LbqZfYzhmZ5dlGSHb/PFEoBtDJSOWsxt/5EQfdvSAUqqJyQ5s0oZTTxxxZj7n3mcrYoW
         wzMBzFmrU5BCOCX0pB9ekUVAABhYVuTHFhyT6iWTqP2WDzgjlfS/x0NKchJiY3mSXs11
         kk9BSqTD14b0kZMRl0IWJJZk/R4aPzOaoy3z5wUtrLO2MYxLzeci2AcTtWrc1qHX3shA
         XaRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/5eEEdExB/WrcymVKXu9WY7O+JW+rGDAlHjMnzkWSN0=;
        b=cjB9HdUK3+KVIppzXUCQyS1CxC2wC1LNBluMSFZQ0KS8HbpYVDdCebvPdA0Om162qQ
         t1UJgclBuRonc0QBGuUCyU+5hi1LJl9IadbExoGtFD7/anyayJhfxMJh6FAgssZ0j9Wf
         U1IOP1a6v7PRLGHck1mKBBg7Md6M4YkBVlrumh/M7Fiy1jeGuWuvBX/qEDdCNpyUB/XC
         c57CgkW1g5uT47JuBa+AUt8Y5FXQyy9cqOi4Hz63skHUE/RY4Flog6W74KTGoONSLqpH
         J8/yXffk3PnD0wto+Yxl4gVgKRcAhxzABrD5e9+jTBvuaLA59sQYox23j0R6eAW/3Gqy
         ETSw==
X-Gm-Message-State: AOAM532r24kiTNuA8OQq9HAAO8+QEvQjszcb0WWospl26fpwkO+eSfVt
        egNejaToN+YObx9dw3jMMpw=
X-Google-Smtp-Source: ABdhPJxZ9hubhygriBWKASELSanfG5z122prep0Y/PX+NLg5L8FMObK0M7djFJL42aVkU1p18iCXZw==
X-Received: by 2002:adf:d20b:: with SMTP id j11mr31799984wrh.397.1617087241210;
        Mon, 29 Mar 2021 23:54:01 -0700 (PDT)
Received: from hthiery.fritz.box (ip1f1322f8.dynamic.kabel-deutschland.de. [31.19.34.248])
        by smtp.gmail.com with ESMTPSA id a6sm2872514wmm.0.2021.03.29.23.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 23:54:00 -0700 (PDT)
From:   Heiko Thiery <heiko.thiery@gmail.com>
To:     jisheng.zhang@synaptics.com
Cc:     jens.wiklander@linaro.org, linux-kernel@vger.kernel.org,
        linux@roeck-us.net, op-tee@lists.trustedfirmware.org,
        rostedt@goodmis.org, Heiko Thiery <heiko.thiery@gmail.com>
Subject: Re: [PATCH] tee: optee: fix build error caused by recent optee tracepoints feature
Date:   Tue, 30 Mar 2021 08:53:42 +0200
Message-Id: <20210330065341.18074-1-heiko.thiery@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210325120601.71584253@xhacker.debian>
References: <20210325120601.71584253@xhacker.debian>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> If build kernel without "O=dir", below error will be seen:
> 
> In file included from drivers/tee/optee/optee_trace.h:67,
>                  from drivers/tee/optee/call.c:18:
> ./include/trace/define_trace.h:95:42: fatal error: ./optee_trace.h: No such file or directory
>    95 | #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
>       |                                          ^
> compilation terminated.
> 
> Fix it by adding below line to Makefile:
> CFLAGS_call.o := -I$(src)
> 
> Tested with and without "O=dir", both can build successfully.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

Fixes: 0101947dbcc3 ("tee: optee: add invoke_fn tracepoints")
Tested-by: Heiko Thiery <heiko.thiery@gmail.com>

> ---
>  drivers/tee/optee/Makefile | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/tee/optee/Makefile b/drivers/tee/optee/Makefile
> index 56263ae3b1d7..3aa33ea9e6a6 100644
> --- a/drivers/tee/optee/Makefile
> +++ b/drivers/tee/optee/Makefile
> @@ -6,3 +6,6 @@ optee-objs += rpc.o
>  optee-objs += supp.o
>  optee-objs += shm_pool.o
>  optee-objs += device.o
> +
> +# for tracing framework to find optee_trace.h
> +CFLAGS_call.o := -I$(src)
> -- 
> 2.31.0
> 

Thank you.

-- 
Heiko
