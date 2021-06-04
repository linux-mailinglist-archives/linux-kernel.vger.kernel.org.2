Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF7C39C276
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 23:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbhFDVde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 17:33:34 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:35721 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbhFDVdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 17:33:32 -0400
Received: by mail-ot1-f48.google.com with SMTP id 69-20020a9d0a4b0000b02902ed42f141e1so10472330otg.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 14:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vbZgSAN+iPQara7nvEit4oB9ifITGuuSWNRzPMg2j/k=;
        b=Gn1VmhwpMuiy8ERQ5bEET4OO9FUpsRyio6QBNHFwno6ZrDu4T3ZLBcnhOw8KVGu9i3
         Gy2t8fSl792Qrx4+8uB0DEvEyIQ7yLP9zenzGl5cGEalFoZZQa8toLCLzwhIWOi0xibX
         0bRgWeWFApcFGQfisS5ao6vFCPh5OFU0FZaKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vbZgSAN+iPQara7nvEit4oB9ifITGuuSWNRzPMg2j/k=;
        b=sDwNk/j6qjVQXWuEz1+8IaKruW3NSiyiEnz0ju74ck59MON3q/srUITOftc3L2izry
         U3d9LXCWvtcpGv2fm68SuEdbbZH97EiV034VpHGN49zAQ5F7SxtfXeuCxJLwl99PyoqF
         2S9qBV90i/2g+XitDVxZgZRfFWopD8wS2qCEXy2Te9Lwo4Mm84k8SFlE85KEAZ6grK7F
         qLcWUd+XcdJ4e6xcCyx8KbORsLkm0UjTUXLWT50YG9k0ncP23G9P84N3ROn9CW2i/ZXX
         bjkItxuXTcojJ7b4D1x/Kze3TPtqil9hdvVgy/RKGAraofwfGmAko39vLff80ehITsFL
         udDQ==
X-Gm-Message-State: AOAM53279FNMhzV7xZYh3WRrVeRfNCGppkVWzAXqwsjpMXy1d9GDQ1PL
        yP9wlYCmtC6ujGIx6JbthRtfKw==
X-Google-Smtp-Source: ABdhPJxrU9jcGqepUNIzkGr6FohSOZgv5x2HsJMLz0ZRmBGzAetpiAKJO8RmHepnCeW0WcH/PJ/Kfw==
X-Received: by 2002:a05:6830:3115:: with SMTP id b21mr5182451ots.291.1622842230022;
        Fri, 04 Jun 2021 14:30:30 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id x7sm705549ooc.23.2021.06.04.14.30.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 14:30:29 -0700 (PDT)
Subject: Re: [PATCH] selftests: lib.mk: Also install "config" and "settings"
To:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210527031753.3729663-1-keescook@chromium.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <edfcc51d-af42-5034-0ba2-f6a419c58a7f@linuxfoundation.org>
Date:   Fri, 4 Jun 2021 15:30:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210527031753.3729663-1-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/21 9:17 PM, Kees Cook wrote:
> Installed seccomp tests would time out because the "settings" file was
> missing. Install both "settings" (needed for proper test execution) and
> "config" (needed for informational purposes) with the other test
> targets.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>   tools/testing/selftests/lib.mk | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
> index 0af84ad48aa7..fa2ac0e56b43 100644
> --- a/tools/testing/selftests/lib.mk
> +++ b/tools/testing/selftests/lib.mk
> @@ -100,6 +100,7 @@ define INSTALL_RULE
>   	$(eval INSTALL_LIST = $(TEST_CUSTOM_PROGS)) $(INSTALL_SINGLE_RULE)
>   	$(eval INSTALL_LIST = $(TEST_GEN_PROGS_EXTENDED)) $(INSTALL_SINGLE_RULE)
>   	$(eval INSTALL_LIST = $(TEST_GEN_FILES)) $(INSTALL_SINGLE_RULE)
> +	$(eval INSTALL_LIST = $(wildcard config settings)) $(INSTALL_SINGLE_RULE)
>   endef
>   
>   install: all
> 

I will pick this up for 5.14

thanks,
-- Shuah
