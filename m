Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05EA4436B93
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 21:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbhJUT4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 15:56:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60552 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231960AbhJUT4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 15:56:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634846072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XQQxB68/bqgix0H59OBXlceD3gg5Noo7Iow2EZ2n7yg=;
        b=IPCHsUFujQzn7aTNpej8zRJrbF6mDzgwNsfjoDfb2TK+fkyyT9fGV1eleKlakTevTKD2zb
        KI4+s6w2qQ7BG0ts9wCzy+aYyOTwOuh+15jk+mVw2G0L6jYT4/Q4dhu8I6EouOHmcUL6B6
        +mk6avsUeX6oi2dvMWYeKfcGqYzuBaw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-oOTvx7XVMR6o06YxVYvvCg-1; Thu, 21 Oct 2021 15:54:31 -0400
X-MC-Unique: oOTvx7XVMR6o06YxVYvvCg-1
Received: by mail-ed1-f70.google.com with SMTP id d3-20020a056402516300b003db863a248eso1444565ede.16
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 12:54:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XQQxB68/bqgix0H59OBXlceD3gg5Noo7Iow2EZ2n7yg=;
        b=6Qxpz4/ozvF6iVviPR+WJ9HF7jQk5hDJMN4I8ei8XGRDcANqlQ//i3iUON6iiAumhS
         adbAULNapXBRHQrP68U0xhR++YEas1+Py+jtSpk2D/TEV5EgtwCNbqoNXnNeD8QY+Wan
         8hRCYcY85kksYADWdkb8Lc9gOgdul2HX4VyodRjHJHQKb6Wnh4FElYQCbndmJ5T6Como
         wjJ06dgvMqXlHuwStmAs8E6HISaTOP7b9Gt4iMmbGQruyRG1dG41+VvA58vnVArhDlcZ
         F5HYYSG1Ud2hkrqXUL/8HAHjAcEeaXknYgpKaiPDwkS4vpxc3yUCdWc3e5CuLqktYuRF
         /Gjw==
X-Gm-Message-State: AOAM5327Ro/hw0Ihc5gcSaqShRDL4afu7If5mQcgB3JBMdO4sjLjvGGD
        qttS8vudIkJTQuruiYgKjjokUWVv5unsq2P2HXnglgj+m0EUDvl8rB6ebYPTiFdsMYdXpzcbloC
        hrpp3nQqXIdRjP0q5d810H4LU
X-Received: by 2002:a05:6402:50c7:: with SMTP id h7mr10509069edb.191.1634846070222;
        Thu, 21 Oct 2021 12:54:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzmJnU7g6ZVD24HMPBsZgL0Jyl+qXHtE9LJnZE9S9oVAH4QKW2i7BfFAIN7nIyagvTLyj43JA==
X-Received: by 2002:a05:6402:50c7:: with SMTP id h7mr10509049edb.191.1634846070077;
        Thu, 21 Oct 2021 12:54:30 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id t18sm3616082edd.18.2021.10.21.12.54.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 12:54:29 -0700 (PDT)
Message-ID: <7edcd370-41a5-f7e8-1ea9-a6073c97638d@redhat.com>
Date:   Thu, 21 Oct 2021 21:54:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v2] selftests: kvm: fix mismatched fclose() after popen()
Content-Language: en-US
To:     Shuah Khan <skhan@linuxfoundation.org>, shuah@kernel.org
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211021175603.22391-1-skhan@linuxfoundation.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211021175603.22391-1-skhan@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/21 19:56, Shuah Khan wrote:
> get_warnings_count() does fclose() using File * returned from popen().
> Fix it to call pclose() as it should.
> 
> tools/testing/selftests/kvm/x86_64/mmio_warning_test
> x86_64/mmio_warning_test.c: In function ‘get_warnings_count’:
> x86_64/mmio_warning_test.c:87:9: warning: ‘fclose’ called on pointer returned from a mismatched allocation function [-Wmismatched-dealloc]
>     87 |         fclose(f);
>        |         ^~~~~~~~~
> x86_64/mmio_warning_test.c:84:13: note: returned from ‘popen’
>     84 |         f = popen("dmesg | grep \"WARNING:\" | wc -l", "r");
>        |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
>   tools/testing/selftests/kvm/x86_64/mmio_warning_test.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/x86_64/mmio_warning_test.c b/tools/testing/selftests/kvm/x86_64/mmio_warning_test.c
> index 8039e1eff938..9f55ccd169a1 100644
> --- a/tools/testing/selftests/kvm/x86_64/mmio_warning_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/mmio_warning_test.c
> @@ -84,7 +84,7 @@ int get_warnings_count(void)
>   	f = popen("dmesg | grep \"WARNING:\" | wc -l", "r");
>   	if (fscanf(f, "%d", &warnings) < 1)
>   		warnings = 0;
> -	fclose(f);
> +	pclose(f);
>   
>   	return warnings;
>   }
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Thanks,

Paolo

