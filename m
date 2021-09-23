Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1E8A416331
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 18:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbhIWQ1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 12:27:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53104 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242141AbhIWQ1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 12:27:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632414352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b8Ah2Qh7p6T0mn87VL57RtyibfllbNYrDwoM7m+3Joo=;
        b=KFrRnH5HWwCMv+MSKwMzhV3x78WEgbsKM6aQl29737vFHrNcTHPUb6e3/qcMRFOcf6kZq8
        SPt4p79KTeEQzl0tdKsQUoREHDr+G4TDOC4uxIpEjHdB4HI2vuTcbSLkCBi+1p7s8pGv1b
        pX4wDRC7t0at1cJSiwNdP+VgwnlwAaw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-xfiW3XhgM3iBbsMPcAG03g-1; Thu, 23 Sep 2021 12:25:51 -0400
X-MC-Unique: xfiW3XhgM3iBbsMPcAG03g-1
Received: by mail-ej1-f70.google.com with SMTP id f21-20020a17090631d500b005f737f369d7so87864ejf.18
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 09:25:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b8Ah2Qh7p6T0mn87VL57RtyibfllbNYrDwoM7m+3Joo=;
        b=FmcylVXdp1Q09tbTavtxhpiHTE8mIor+9HneczsoDEEutIlDw668CaMPyoZrD4T8sC
         xRaIwzGxVYo4LMBc6bmD2Re0QiIDjiLC/elYn9Q/4f80IPlbd81auicQhjkGR5P6vqEz
         aMlAVvSzsuxcvLH5301d9SzujJ0zYBJaiOhpetJBdnP8E94h8TJxZ0lg1R411euyOmdP
         fZdpVAUutWks/LdfPJ+wjZf4G4N+bPie+eN1QN6xBo2hHaII3NuTJA7TWMAWeVvfOtFu
         vr8/I+Lxo89SIvCb4AYo/uNUbTdpswLWsHPTJX9vtLsAeDUtEQ6NhjLX2EwYYtxw5Jxr
         qLHw==
X-Gm-Message-State: AOAM531BwjREPr/mDsP/a/PSmYm5qQK+A36b0kH69Sf8TQNkTSyeFZZR
        4AiuGtW1Zdnb/Lj2nbxMR5V5OmYfat/l+4rw9+pFNs7VcFo9yg2XLTSt9xsW9DurnHw2nzzVQpR
        Ml+RwUtv2SR9uBVDok3n4BfsPRSNJ+L30ZkpKx5WnfcreArqMEzqpKrkRi0+fJxmju2gcLtNs9W
        ON
X-Received: by 2002:aa7:da93:: with SMTP id q19mr6706460eds.206.1632414349590;
        Thu, 23 Sep 2021 09:25:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx9XnSwLPcjGBamhpDTdT3EiRg8QNymAoajRgXO8jyqO9O2UVhfynrBSpJ2DkEt/MKXS42ECQ==
X-Received: by 2002:aa7:da93:: with SMTP id q19mr6706421eds.206.1632414349350;
        Thu, 23 Sep 2021 09:25:49 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id gl2sm3237224ejb.110.2021.09.23.09.25.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 09:25:48 -0700 (PDT)
Subject: Re: [PATCH] kvm: selftests: Fix spelling mistake "missmatch" ->
 "mismatch"
To:     Colin King <colin.king@canonical.com>,
        Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210826120752.12633-1-colin.king@canonical.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <02094ffc-11c4-8b72-f889-a0654f95d2bb@redhat.com>
Date:   Thu, 23 Sep 2021 18:25:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210826120752.12633-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/08/21 14:07, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in an error message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   tools/testing/selftests/kvm/lib/sparsebit.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/lib/sparsebit.c b/tools/testing/selftests/kvm/lib/sparsebit.c
> index a0d0c83d83de..50e0cf41a7dd 100644
> --- a/tools/testing/selftests/kvm/lib/sparsebit.c
> +++ b/tools/testing/selftests/kvm/lib/sparsebit.c
> @@ -1866,7 +1866,7 @@ void sparsebit_validate_internal(struct sparsebit *s)
>   		 * of total bits set.
>   		 */
>   		if (s->num_set != total_bits_set) {
> -			fprintf(stderr, "Number of bits set missmatch,\n"
> +			fprintf(stderr, "Number of bits set mismatch,\n"
>   				"  s->num_set: 0x%lx total_bits_set: 0x%lx",
>   				s->num_set, total_bits_set);
>   
> 


Queued, thanks.

Paolo

