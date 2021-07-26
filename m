Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 697B13D5A73
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 15:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233738AbhGZM5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 08:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233502AbhGZM5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 08:57:23 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68250C061757
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 06:37:52 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id z7so11070292wrn.11
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 06:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ChBDWJjgJliQvBWPa96cZKBrj8qouHAqBK1Xkip7XyQ=;
        b=Kpph3QTxJGtxEgvnKlHAaQ/WsUeHxHPdjzAF4MZN4FUTuW/wN3TzsWNtgfv9r36uAs
         p/XdjuDkHkVAhxVEO8NvW1gV6FPHZglG3b1bLvJm6kOWsptNRGswfm/l9xyJBChP1Ivc
         QNXSF5C3ygUKmQU7+srxJWak4TlFEOT6JJ08pX2kU2IFdzDgKGSHaemQMndcPQMAYne4
         eDDZme+g9qxB9UGXk59oRxGlFeqpT6DyLa0nKAexTm60olLq3WQnE9syXC9EdmU5oyX+
         pQiStIXSWD40M+NTPHXqP+iCs1EMfZrML8oZb0C8B1jDUJc2ryP4jW9qeHZE7A0ubrSz
         OMcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ChBDWJjgJliQvBWPa96cZKBrj8qouHAqBK1Xkip7XyQ=;
        b=tbcIOG6slY2IVQ76utN1odmyp8dJY6Iy9eoATrlg2PBxIACXRrJ5I5+DpJOwlt3RVi
         AgBfmfuVv60IptC+oxnuq4F5Zq0rhetmr00AQfo07bxPiUkI+LXq6OvzuRbPxdy4m7oE
         s/iF0srXxtn7vy1okZjL4kQBi2ilno9eeWacW2qvcusoAC2F4koACmAdxV10b+77iEZg
         SA2jfHPz8yLW4llJSYWxjC8Y0Qx1fN3lxNYN5832r8bQs6gxR1LEQeLbqnW1OUfRTR4V
         Ns17BUjlPF9uZUtjWv99PAOghba0l0Xcus+CTBUI9YSMxvQ2FniEIvrcWZNPFQ3cksGe
         XKsg==
X-Gm-Message-State: AOAM532ctHXEfgRw1isRiA3L0KXr5xmFlWcDPbfNJXBs5hqY55qeKaaZ
        5Sfij+GeSPtr5d/hqWfdcr0T2A==
X-Google-Smtp-Source: ABdhPJx/S+M5qDheZPdw44GN/Qi+qjgIvoYVvbvT6GyIaSazSaRaxer+sSo819fP+1LI+6sHddQEpg==
X-Received: by 2002:a5d:5102:: with SMTP id s2mr19332590wrt.214.1627306670979;
        Mon, 26 Jul 2021 06:37:50 -0700 (PDT)
Received: from ?IPv6:2a02:8084:e84:2480:228:f8ff:fe6f:83a8? ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id y3sm42654841wrh.16.2021.07.26.06.37.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 06:37:50 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] printk: Add printk.console_verbose boot parameter
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
References: <20210713011511.215808-1-dima@arista.com>
 <20210713011511.215808-3-dima@arista.com>
 <20210721144621.ddvxouzxpp6sn4ec@pathway.suse.cz>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <031380c9-2b18-d984-c058-d0733c5d3328@arista.com>
Date:   Mon, 26 Jul 2021 14:37:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210721144621.ddvxouzxpp6sn4ec@pathway.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/21/21 3:46 PM, Petr Mladek wrote:
[..]
>> +	printk.console_verbose=
>> +			Raise console loglevel to highest on oops, panic or
>> +			lockdep-detected issues (only if lock debug is on).
>> +			With an exception to setups with low baudrate on
>> +			serial console, keeping this enabled is a good choice
>> +			in order to provide more debug information.
>> +			Format: <bool>  (1/Y/y=enable, 0/N/n=disable)
>> +			default: enabled
> 
> Hmm, the name suggests that the console should always be verbose.
> It looks like a counterpart to the "quiet" option.
> 
> It actually is a counter part to the existing "quiet" option
> except that it triggers in some situations only.
> 
> Hence, I would call it "no_auto_verbose":
> 
>    + "verbose" follows the simple naming scheme of the existing
>      "quiet" option (no "printk" and no "console" in the name)
> 
>    + "no_auto" suggests that it disables some auto-verbose behavior
>      which is exactly what it does.
> 
> Any better idea?

Yeah, ok. I've tried to avoid negative as a parameter as it sometimes
may be confusing. But I see you have this naming in mind and no hard
feelings from my side - I'll call it "no_auto_verbose" in v3.

[..]
>> @@ -2404,6 +2404,12 @@ module_param_named(console_suspend, console_suspend_enabled,
>>  MODULE_PARM_DESC(console_suspend, "suspend console during suspend"
>>  	" and hibernate operations");
>>  
>> +bool printk_console_verbose = true;
> 
> I would call it "console_auto_verbose".
> 
>> +EXPORT_SYMBOL(printk_console_verbose);
> 
> I would prefer to move console_verbose() into printk.c
> and export the function instead of this variable.

Makes sense, will do in v3.

Thanks,
          Dmitry
