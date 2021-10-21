Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC304369AD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 19:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbhJURuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 13:50:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:60066 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232380AbhJURt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 13:49:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634838460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RBfAVrB74SlDq2h9NJPSX6K7Aqze9lO+g3JyEdnqq0o=;
        b=RfpAMBhUP5ZeRyOZSbzd7ezoUO6kvRrYHjc6nPYNquZkBge7Z2/0ct8ho2FuTUxznApONN
        QGekxR8m6Wh7OVNdEi5xtt7EqaOgWEpalWeAxF6me/7varl72tctx6paWl4kleD1p1B2oE
        EYv6OkU5jY+yLSi/l6igR+fRwpeNxcs=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-qtzEXKVDPL2U7KWk4pQOyg-1; Thu, 21 Oct 2021 13:47:39 -0400
X-MC-Unique: qtzEXKVDPL2U7KWk4pQOyg-1
Received: by mail-ed1-f69.google.com with SMTP id r25-20020a05640216d900b003dca3501ab4so1114754edx.15
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 10:47:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=RBfAVrB74SlDq2h9NJPSX6K7Aqze9lO+g3JyEdnqq0o=;
        b=KPq3V7IeS20uAWq1Yd8xVByKzynx3OzFynBO9kDv+vTQKzRIAj1oGY3wyntO87YZlq
         MEnHJpV8FV/+prv6Ev2rA3OqpnBaZLMM1azC4lswZi84ljS3YSWg5CqsGlsyATPUfWu1
         ZLulhyAfeVeHw+paRPEcyYQHtNfrYf7FTN0d2hBky1DdSE7HLCaYcjNF+1hHut5Y1dei
         7EggSqKwFp7H+4B8xO2s1KGpK73ux1bPF96b34M4RBqhKglVWOQfTQ/CF24wgZRj1hd0
         Ym5Rls6JdRWchP7DBsyPzYcT5Z+Od1/NAK4EffXs/PSnU3WuJlYW3IRoErGsy8Yif6lV
         stKQ==
X-Gm-Message-State: AOAM530HF2AlAwLQKxEvrtM2J4ZYnREQ1V7lbMp1pJPNmQ6FCaQ1FSoC
        /dGyGJY9Mu783LED0t3rDbbs5rv23auA7HNI7JthYZrmQjdvn6kKZLKEI0QmCurOCPa0Nm3l3BA
        q7qZ/F+wUNB1B427VqvWk1f0nXDR4pcGjrqlZr1GCj0cne76Y9X1SRs+pHuZ27o2IDoWtocH272
        y5
X-Received: by 2002:a05:6402:5209:: with SMTP id s9mr9387325edd.250.1634838458502;
        Thu, 21 Oct 2021 10:47:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyozM7RYS3i1RxKK7/0nw1ZHM3yaMyHXPKQ7O7RuXaEgIeNvfeqoaeF55tmEtZS7kqr9HaGXA==
X-Received: by 2002:a05:6402:5209:: with SMTP id s9mr9387290edd.250.1634838458241;
        Thu, 21 Oct 2021 10:47:38 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id d18sm3286859ejo.80.2021.10.21.10.47.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 10:47:37 -0700 (PDT)
Message-ID: <435767c0-958d-f90f-d11a-cff42ab1205c@redhat.com>
Date:   Thu, 21 Oct 2021 19:47:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH 0/8] KVM: SEV-ES: fixes for string I/O emulation
Content-Language: en-US
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     fwilhelm@google.com, seanjc@google.com, oupton@google.com
References: <20211013165616.19846-1-pbonzini@redhat.com>
In-Reply-To: <20211013165616.19846-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/10/21 18:56, Paolo Bonzini wrote:
> This series, namely patches 1 and 8, fix two bugs in string I/O
> emulation for SEV-ES:
> 
> - first, the length is completely off for "rep ins" and "rep outs"
>    operation of size > 1.  After setup_vmgexit_scratch, svm->ghcb_sa_len
>    is in bytes, but kvm_sev_es_string_io expects the number of PIO
>    operations.
> 
> - second, the size of the GHCB buffer can exceed the size of
>    vcpu->arch.pio_data.  If that happens, we need to go over the GHCB
>    buffer in multiple passes.
> 
> The second bug was reported by Felix Wilhelm.  The first was found by
> me by code inspection; on one hand it seems *too* egregious so I'll be
> gladly proven wrong on this, on the other hand... I know I'm bad at code
> review, but not _that_ bad.

Ping.

Paolo

