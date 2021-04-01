Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC03351B24
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238075AbhDASFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:05:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47544 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236667AbhDARqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:46:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617299170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GbN00XAl17jTfdcL36pqLI9NxKBduDGkH9PWAr5DUrU=;
        b=NA7tfk8lK4hC7pLvMwSJptvbr0OJxuI3NXf4Qtwxwb2H1XittoW+PsS0NM5ak6/P4QF7if
        9GAIQnb8yN3hbGSiq57CqTblGWI28FGJWnFHYEz9DYnmT6MU7HIscpOyGHwcRlmys0L9Ur
        jU0VpqvhIyFyOEpHixEtqKhd0CG8qHM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-502-fvDz2qThNhalWtb0ImK30Q-1; Thu, 01 Apr 2021 10:45:31 -0400
X-MC-Unique: fvDz2qThNhalWtb0ImK30Q-1
Received: by mail-ed1-f69.google.com with SMTP id h5so2946504edf.17
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 07:45:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GbN00XAl17jTfdcL36pqLI9NxKBduDGkH9PWAr5DUrU=;
        b=rWZ31t9bRTPJ8rgR8JTaPit0EKaTX05IfSj7cx0D3D6CszrdOPPFr9bhElAIsOOkcC
         cXAgSrYgXKW0CnT+3hqunJow3Rt1V8iTU2kVe9yXTa/AU3TM+itJ7RxFnMeLkw4sj75w
         kzX0iURHXQ00QyPSdIX1aAdLi1DVrhZgi0aH3hfkcqlruTyV6MWvvxFmxstfs9yGn2p0
         U2SKzhQcIR9fs6ABREIFZptZsqwRtiNLFBnI5BCWFuTlHJ8Y3z/KfkzGlUNN6wyHWRS9
         2W02rvnoh+hOmqNa4e8QrbgvByiL7xDxOxtbpLmShuLZ9mYtwI0+OKmYt16FG15LWPjV
         djMA==
X-Gm-Message-State: AOAM5310s54cfWWkDppsPtXq3B8h0sGzGK2sR8ctsKE5Rua3+t4osre1
        +yPxi9X9lCJ66rorLyAFTjPFqg15Q8PaEurLkIkr/DyuLR7+7Mpb/e6ETwrYAuSygOYxYbkw6qB
        E5nmEioMFVs3M49dgHKR5cjRZ
X-Received: by 2002:a05:6402:1a3c:: with SMTP id be28mr10314053edb.125.1617288330508;
        Thu, 01 Apr 2021 07:45:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx0BiWLs8rgC3v72usoRnhjcbcl9AJPbTfNdkmdteh68PTju1z4CTFTvtjEovIrggDeSZOqqA==
X-Received: by 2002:a05:6402:1a3c:: with SMTP id be28mr10314041edb.125.1617288330328;
        Thu, 01 Apr 2021 07:45:30 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id ho19sm2798579ejc.57.2021.04.01.07.45.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Apr 2021 07:45:29 -0700 (PDT)
Subject: Re: [PATCH -next] KVM: selftests: remove redundant semi-colon
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kvm@vger.kernel.org
References: <20210401142514.1688199-1-yangyingliang@huawei.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c1f44dca-a703-e68f-ec29-0d14671c2e6e@redhat.com>
Date:   Thu, 1 Apr 2021 16:45:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210401142514.1688199-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/21 16:25, Yang Yingliang wrote:
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>   tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c b/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c
> index 804ff5ff022d..1f4a0599683c 100644
> --- a/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c
> @@ -186,7 +186,7 @@ int main(int argc, char *argv[])
>   		vcpu_ioctl(vm, VCPU_ID, KVM_XEN_VCPU_SET_ATTR, &st);
>   	}
>   
> -	struct vcpu_runstate_info *rs = addr_gpa2hva(vm, RUNSTATE_ADDR);;
> +	struct vcpu_runstate_info *rs = addr_gpa2hva(vm, RUNSTATE_ADDR);
>   	rs->state = 0x5a;
>   
>   	for (;;) {
> 

Queued, thanks.

Paolo

