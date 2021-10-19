Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9313433A19
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 17:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233707AbhJSPXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 11:23:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25975 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231189AbhJSPXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 11:23:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634656852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZWUsS1V9g+wCEnrKEW2P2nBdry4D/ofDOreqnNn0C2s=;
        b=Vk4LN6oRY6ewYewoUZ9rrKH1StT7SYLbQFEU+oqBmbGO2HVBEk7C/jolAs2tu//TcKOGsc
        8MY61QlZ4CISn3Y94Qvu0G9rt8gkIJoypEihCN5ZqMtm9WFaJjjVFnlgRMD9ZU2RuXaZ3W
        tE6y2b8rzinsSSxeSVMQKoFFF6QUzW8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-kJrEch8RPhagwNwPSKD3lw-1; Tue, 19 Oct 2021 11:20:50 -0400
X-MC-Unique: kJrEch8RPhagwNwPSKD3lw-1
Received: by mail-ed1-f72.google.com with SMTP id a3-20020a50da43000000b003dca31dcfc2so1523296edk.14
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 08:20:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZWUsS1V9g+wCEnrKEW2P2nBdry4D/ofDOreqnNn0C2s=;
        b=QZ1FIQTVUSi0CNx+XtbymmiEq+ogH5nDhLPCwzkUpgqMFe93Xp66uRtsq0MMiH7Pej
         TjYohTu1HYcIADFGPHhtCb5RPx9gNNqNkeek26EByq+8L1kN/HUM86mgWa8HPAHa4OdK
         vx3v2m8gqYiOYcPSAdyJqfjxjc3GlaWEFCdRCJ1E3HcrQctyBJtFe8lfaMh8YEJYFV9X
         OoqqeomMasjcpCm+K0y8sQSPII0Uz0we9ClE+ujflWrTicQPU/O/g6n6nI5/drSzQrnl
         UoQ5td7cIQk/L1ZpzropX0vfjEq5v+68NN044oEpmeBEuOFkLwGv48fA1+KEYyWYjY1m
         VGEw==
X-Gm-Message-State: AOAM531Nw30/6KD5cwLxBGazD4VusW8amKpg8LWDfjMdvekKC8XFvn9k
        Ynb8V0Zjpcrhgrqf1YPifKS/v+Qnp0uYLwLoiXRbUkQJMYhscjPXXQNXic0VRP9WleZKAHMUkhB
        loRqH9TZgVdeNDFQ/py+UbK7C
X-Received: by 2002:a17:906:6149:: with SMTP id p9mr14323017ejl.362.1634656848835;
        Tue, 19 Oct 2021 08:20:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyW6yXFO906BnyicHeJfsJ3U1p1KKs/jg69z8HMFssRbuPqqO7meXlrWwPYJVckb8fdiwjteg==
X-Received: by 2002:a17:906:6149:: with SMTP id p9mr14322995ejl.362.1634656848617;
        Tue, 19 Oct 2021 08:20:48 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id s12sm3985147edj.82.2021.10.19.08.20.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Oct 2021 08:20:48 -0700 (PDT)
Message-ID: <21ebf31f-2f2a-2f5e-e731-a44ea178a6bd@redhat.com>
Date:   Tue, 19 Oct 2021 17:20:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: Fix bitwise vs. logical
 warning
Content-Language: en-US
To:     Nathan Chancellor <nathan@kernel.org>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Mark Gross <markgross@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tor Vic <torvic9@mailbox.org>
References: <20211018182537.2316800-1-nathan@kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20211018182537.2316800-1-nathan@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/18/21 20:25, Nathan Chancellor wrote:
> A new warning in clang points out a use of bitwise OR with boolean
> expressions in this driver:
> 
> drivers/platform/x86/thinkpad_acpi.c:9061:11: error: use of bitwise '|' with boolean operands [-Werror,-Wbitwise-instead-of-logical]
>         else if ((strlencmp(cmd, "level disengaged") == 0) |
>                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>                                                            ||
> drivers/platform/x86/thinkpad_acpi.c:9061:11: note: cast one or both operands to int to silence this warning
> 1 error generated.
> 
> This should clearly be a logical OR so change it to fix the warning.
> 
> Fixes: fe98a52ce754 ("ACPI: thinkpad-acpi: add sysfs support to fan subdriver")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1476
> Reported-by: Tor Vic <torvic9@mailbox.org>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans


> ---
>  drivers/platform/x86/thinkpad_acpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index 07b9710d500e..7442c3bb446a 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -9058,7 +9058,7 @@ static int fan_write_cmd_level(const char *cmd, int *rc)
>  
>  	if (strlencmp(cmd, "level auto") == 0)
>  		level = TP_EC_FAN_AUTO;
> -	else if ((strlencmp(cmd, "level disengaged") == 0) |
> +	else if ((strlencmp(cmd, "level disengaged") == 0) ||
>  			(strlencmp(cmd, "level full-speed") == 0))
>  		level = TP_EC_FAN_FULLSPEED;
>  	else if (sscanf(cmd, "level %d", &level) != 1)
> 
> base-commit: 85303db36b6e170917a7bc6aae4898c31a5272a0
> 

