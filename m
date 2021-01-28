Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E714307169
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 09:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbhA1IZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 03:25:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57460 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231698AbhA1IZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 03:25:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611822255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=86GGfjuYM3AI7mr7QU3sHTo8h+wDitIDwwAKJzsDkt4=;
        b=jVFZJXzar1VHdyDormgxxOK2X9zq4OA9ZzTTNhxjZHdSD6Y7DY7wTayVM1DamIBQpo7ezo
        FzqX7RjOndQSq7Oyn/KNUO0rAPulEmCLiGST5vadNU7pwvlCvIXdfjHK7ubtQA/Namm4bw
        48arkLphk68HDCr/qBHv45eELxq1h5g=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-127-aHzowZ_cPUaGxyEQvVG7dg-1; Thu, 28 Jan 2021 03:24:13 -0500
X-MC-Unique: aHzowZ_cPUaGxyEQvVG7dg-1
Received: by mail-ed1-f69.google.com with SMTP id f12so2818499edq.15
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 00:24:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=86GGfjuYM3AI7mr7QU3sHTo8h+wDitIDwwAKJzsDkt4=;
        b=GK4SQjX3eLIWKBue9CjlTRv3mWDGNsqzVdCvhQTETyPPw5RYbAK6kp8UeKZb3j9dPn
         E/D9j0jznGJ8K9ezM6KpGrcTvkUlQT/MwlZl/Vts6ySHoppsEBQNr/gpTvTgUD+h6Hg4
         D3q5IQU9iYW2MYVDkaDeRPs/1z9iZ+a5PcNm8EQQpcjBcWQtTg+5TvSFDlcV4nu9Bavo
         Qjvp7k8M6oqUhpiGAmyBbDOYjHrSrAepyNG26E1YBJ7TyhQKUIkdimbka4DW9YP3JvKt
         CJUNcSSJ6EnRbHPlMdY56midHnUarOXlPE3w6YQvpZZdhkChK8ta33dqcesQimkpqH4X
         XJYQ==
X-Gm-Message-State: AOAM532/NapNsQ7pf8J3fvbKYUCN2fbhsdEcrC9YaQhW4NBqBl9mvH+L
        bO0fb/oh/gqdCq90T/zxtb3zhN9wYP/A0nb7nR4cb+gc7ZBUI4NcLFqJFCc70OlhsmQnnyDeZe/
        K0PFyyv8cEuR/oMlSofpdA14ICW7lhYfTpJcTRdRsRwfE1sZ4ibVkVQ+rLIEyB2cEcVGns1QWOH
        Z7
X-Received: by 2002:a50:fc97:: with SMTP id f23mr13618239edq.307.1611822252371;
        Thu, 28 Jan 2021 00:24:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzKeyRQU9dTdlY4Nl3GONGetNGeiPQr74OAYJp5BcB/yhphlMwTsYUn9nYqkvL8aFBxIUZZSg==
X-Received: by 2002:a50:fc97:: with SMTP id f23mr13618213edq.307.1611822252108;
        Thu, 28 Jan 2021 00:24:12 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id t11sm2496533edd.1.2021.01.28.00.24.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jan 2021 00:24:11 -0800 (PST)
Subject: Re: [PATCH] KVM: x86/mmu: Add '__func__' in rmap_printk()
To:     Joe Perches <joe@perches.com>,
        Stephen Zhang <stephenzhangzsd@gmail.com>, seanjc@google.com,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1611713325-3591-1-git-send-email-stephenzhangzsd@gmail.com>
 <244f1c7f-d6ca-bd7c-da5e-8da3bf8b5aee@redhat.com>
 <cfb3699fc03cff1e4c4ffe3c552dba7b7727fa09.camel@perches.com>
 <854ee6dc-2299-3897-c4af-3f7058f195af@redhat.com>
 <10805faed4d19ce842cef277b74479a883514afe.camel@perches.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <409943d7-5917-9269-98eb-1a9ca704fda3@redhat.com>
Date:   Thu, 28 Jan 2021 09:24:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <10805faed4d19ce842cef277b74479a883514afe.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/01/21 19:28, Joe Perches wrote:
> It's not enabled unless DEBUG is defined (and it's not enabled by default)
> or CONFIG_DYNAMIC_DEBUG is enabled and then dynamic_debug jump points are
> used when not enabled so I think any slowdown, even when dynamic_debug is
> enabled is trivial.

Ah, I confused DEBUG with CONFIG_DEBUG_KERNEL.  I'll post a patch, thanks!

Paolo

