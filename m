Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1309931EB27
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 15:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbhBROyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 09:54:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27447 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231944AbhBRMxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 07:53:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613652656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G1+c/zNnGBxuuXf4uV5rPzBui+5+v2sjTvTk5kBuJec=;
        b=XAnUhkxmUmL5/GnTEe3zh6KcivEePKGVNKTG8seFRpSS0lQKVpjr+yKJCOXfHM5xnOUXu0
        jaUZUP4SfsvhCVseCipjbg5Z4Jd3M8qaaHxto2vTI5IRvPwxg94KmlYof1GAMy82GHnGjw
        YAznB8GEtRxlmeTnilNEVWTh/hDwsic=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-gwcc0c5BNti8mbez-OVjTw-1; Thu, 18 Feb 2021 07:50:54 -0500
X-MC-Unique: gwcc0c5BNti8mbez-OVjTw-1
Received: by mail-wm1-f69.google.com with SMTP id f123so145498wma.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 04:50:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G1+c/zNnGBxuuXf4uV5rPzBui+5+v2sjTvTk5kBuJec=;
        b=tycWu11OPghLn7y0jvWo/YSgdSigstHyQ+ZhetHiDuRLqfV6IV8QwbRlmhVG2QHae3
         huEnhwcJDp1e+DihE5Wv1fSTafz2Xqiu/jOy8fATtrYtV9e0OkHMUpvyNlr7ulcGgy7e
         LG57vyra6Z0uZjykNbmG/woxZnZt9iYt7kAIy8MZDdZ7aO1Tq5rCOls2NNrmkUd7hiWF
         +s/HWP9g2V61npB6tNrTOAfhBv5cMEWEDdMt+cSONe+YT2pkwYtYPPHqUH3iD2fTEhKw
         LNaaTyFa02JG+wkVcr/9ton7rWBtFaGXLI3P0e4uUTYugHuB7k0s9NOnbQb8Y6H6rair
         HZgQ==
X-Gm-Message-State: AOAM533aIqV1VaSXAIbCU7SiwzulW72pM8FfhgXhoUhdA86/mXzTg8Tf
        uShQiV5byKDUzYzO9rnJzw9rNIKLLgzFlEwRQzALPn0PcbTFYJWZzHu+4UWNld/IERRcAivELMG
        OjCD2lFEi+xmRkpTSFmjP40Wm
X-Received: by 2002:a7b:c747:: with SMTP id w7mr3462353wmk.140.1613652653594;
        Thu, 18 Feb 2021 04:50:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy3iHYYfg2haqJPUXVivJv5QYxnqIZdBWANeT/jritdfSj3F3J8C8Vz6tA/beauDMbaoXaXRg==
X-Received: by 2002:a7b:c747:: with SMTP id w7mr3462341wmk.140.1613652653400;
        Thu, 18 Feb 2021 04:50:53 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id a9sm8528035wrn.60.2021.02.18.04.50.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Feb 2021 04:50:52 -0800 (PST)
Subject: Re: [PATCH 10/14] KVM: x86: Further clarify the logic and comments
 for toggling log dirty
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        Makarand Sonare <makarandsonare@google.com>
References: <20210213005015.1651772-1-seanjc@google.com>
 <20210213005015.1651772-11-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2d455c2e-1db4-5aff-45eb-529e68127fe7@redhat.com>
Date:   Thu, 18 Feb 2021 13:50:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210213005015.1651772-11-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/02/21 01:50, Sean Christopherson wrote:
> 
> -	 * Nothing to do for RO slots or CREATE/MOVE/DELETE of a slot.
> -	 * See comments below.
> +	 * Nothing to do for RO slots (which can't be dirtied and can't be made
> +	 * writable) or CREATE/MOVE/DELETE of a slot.  See comments below.
>  	 */
>  	if ((change != KVM_MR_FLAGS_ONLY) || (new->flags & KVM_MEM_READONLY))
>  		return;
>  
> +	/*
> +	 * READONLY and non-flags changes were filtered out above, and the only
> +	 * other flag is LOG_DIRTY_PAGES, i.e. something is wrong if dirty
> +	 * logging isn't being toggled on or off.
> +	 */
> +	if (WARN_ON_ONCE(!((old->flags ^ new->flags) & KVM_MEM_LOG_DIRTY_PAGES)))
> +		return;
> +

What about readonly -> readwrite changes?

Paolo

