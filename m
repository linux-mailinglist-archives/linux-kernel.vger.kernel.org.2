Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5872E39FC49
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 18:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbhFHQYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 12:24:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26179 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232134AbhFHQYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 12:24:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623169340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ok+shLqzyv78HhrCPatk5ZH7xd0vr4GnUta6jGlDoJI=;
        b=ZTBElWHdKFDeNvMqB/fFsjks5zChFYGuoEz1Ld18kr2UQVIzdG8N3MtswtYRd8Ex0tayb1
        jRTCB7i5Loat0bn4T2z6y0X1qEKz++NhZUSwqJUIenLjlQZs+aJglYt0eoMugU4iqfeypS
        sHE/tNG0fudLqD8NlHSje9HHsjICJNo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-k3phGCl5P665SWebBaR3_A-1; Tue, 08 Jun 2021 12:22:18 -0400
X-MC-Unique: k3phGCl5P665SWebBaR3_A-1
Received: by mail-wm1-f70.google.com with SMTP id o14-20020a1c4d0e0000b029019a2085ba40so617140wmh.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 09:22:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ok+shLqzyv78HhrCPatk5ZH7xd0vr4GnUta6jGlDoJI=;
        b=ugwXKiK/PGWbavwiIk01IxdsnjP6zQvEdjkogBzbHDIaBOq/6HaXGE+dVVnEMj3Tc2
         aajH9xWlSCJDWSz5f0OpQY3M/4731REtGZJL2uQkZ5p8z9ndTt3pp5TsaIqu0xAtPQyk
         sreyYsTaZ8FUQ3mG9uHcxiK86EOt9ZV6Yie7WdnRebaBflG++9zGJwQLCo3VUqseorOL
         xnzZlJo/y+WuzOdrwLWVIYeSb4LTM+M1AKjelMYjwF4GyjGHqoCH1ZpcVe664nwOZhRT
         81KwLO+tt0bnU6Q7PGucg35/tlFVVZptW1vXxrWppbySepSPoqFF4ctyhP0fL5s8nIwq
         xv4g==
X-Gm-Message-State: AOAM533U6aST7x4YShXak+4RGOJ8aZYWqcvwzSFmtKLyIm8oDfjw1BQ9
        wSJ41Oc9G9tYATUtVY6kYtIIXft3QfPVjDJ2FCI4X9VPnWBcY4z7VN4d9w2XtpwK6gGbAQhxba1
        i+8FWMqiaF1MW9zE3at/3fbem
X-Received: by 2002:a7b:c24e:: with SMTP id b14mr23234187wmj.6.1623169337671;
        Tue, 08 Jun 2021 09:22:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyC+n56dPzuybrrNseY5pZzjjxr0lZ8vs61haw6SjQYimAX5KUEeUYyWF6ViTudX4GdbHx1ag==
X-Received: by 2002:a7b:c24e:: with SMTP id b14mr23234160wmj.6.1623169337454;
        Tue, 08 Jun 2021 09:22:17 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id y8sm2812916wmi.45.2021.06.08.09.22.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 09:22:16 -0700 (PDT)
Subject: Re: [PATCH] KVM: SVM: Fix SEV SEND_START session length &
 SEND_UPDATE_DATA query length after commit 238eca821cee
To:     Ashish Kalra <Ashish.Kalra@amd.com>
Cc:     seanjc@google.com, tglx@linutronix.de, bp@alien8.de,
        mingo@redhat.com, hpa@zytor.com, joro@8bytes.org,
        Thomas.Lendacky@amd.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, srutherford@google.com,
        brijesh.singh@amd.com
References: <20210607061532.27459-1-Ashish.Kalra@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c579735c-31c3-eed5-576f-b07177231790@redhat.com>
Date:   Tue, 8 Jun 2021 18:22:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210607061532.27459-1-Ashish.Kalra@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/21 08:15, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> Commit 238eca821cee ("KVM: SVM: Allocate SEV command structures on local stack")
> uses the local stack to allocate the structures used to communicate with the PSP,
> which were earlier being kzalloced. This breaks SEV live migration for
> computing the SEND_START session length and SEND_UPDATE_DATA query length as
> session_len and trans_len and hdr_len fields are not zeroed respectively for
> the above commands before issuing the SEV Firmware API call, hence the
> firmware returns incorrect session length and update data header or trans length.
> 
> Also the SEV Firmware API returns SEV_RET_INVALID_LEN firmware error
> for these length query API calls, and the return value and the
> firmware error needs to be passed to the userspace as it is, so
> need to remove the return check in the KVM code.
> 
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> ---
>   arch/x86/kvm/svm/sev.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 5bc887e9a986..e0ce5da97fc2 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -1103,10 +1103,9 @@ __sev_send_start_query_session_length(struct kvm *kvm, struct kvm_sev_cmd *argp,
>   	struct sev_data_send_start data;
>   	int ret;
>   
> +	memset(&data, 0, sizeof(data));
>   	data.handle = sev->handle;
>   	ret = sev_issue_cmd(kvm, SEV_CMD_SEND_START, &data, &argp->error);
> -	if (ret < 0)
> -		return ret;
>   
>   	params->session_len = data.session_len;
>   	if (copy_to_user((void __user *)(uintptr_t)argp->data, params,
> @@ -1215,10 +1214,9 @@ __sev_send_update_data_query_lengths(struct kvm *kvm, struct kvm_sev_cmd *argp,
>   	struct sev_data_send_update_data data;
>   	int ret;
>   
> +	memset(&data, 0, sizeof(data));
>   	data.handle = sev->handle;
>   	ret = sev_issue_cmd(kvm, SEV_CMD_SEND_UPDATE_DATA, &data, &argp->error);
> -	if (ret < 0)
> -		return ret;
>   
>   	params->hdr_len = data.hdr_len;
>   	params->trans_len = data.trans_len;
> 

Queued, thanks.

Paolo

