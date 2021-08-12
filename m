Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA3EE3EA805
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 17:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238421AbhHLPxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 11:53:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26124 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238195AbhHLPxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 11:53:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628783602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dHPw1bhKl19tpaWZWxIqL1UIJ8eN+9Q1TmLAPmpMLXc=;
        b=diI3w0Fg1ancmdWWLeAMr4G92L/XajtbciMHRdwvI3Hq0jIaI/NKmW5qGsDHT0TZ81VNSP
        HlVmdvlGWza0+cVDtd8kL0OZedodaPr1EYUPHkd83kEO0t5RCV7Ot5KllLWKcA3vVKLCYv
        bZltZr2CXyja8tfkbmYBTk3dlg1GpYE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-xgxI_37jN_SNh0IBJU3yJA-1; Thu, 12 Aug 2021 11:53:21 -0400
X-MC-Unique: xgxI_37jN_SNh0IBJU3yJA-1
Received: by mail-ej1-f71.google.com with SMTP id ja25-20020a1709079899b02905b2a2bf1a62so1996868ejc.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 08:53:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dHPw1bhKl19tpaWZWxIqL1UIJ8eN+9Q1TmLAPmpMLXc=;
        b=KA7zCYUGypeZ4qnqJO6p4rbzSJ5Q+NgXjDT5sjmIKSWU8q+RuPOPljNV+odtfXuZNH
         UkCbz/6aGOhLOW161A9FvWAflQmORks6r9o7oLeLEXOVF3mxvptYq+J5yUXaztEB+ej3
         w9C8fSXpNNasTbwexRRAC97MJ191qdGUf8V7pzvz6jDg+88nAPwHV9H1BIEfm0sDn+MR
         CTRmjH9jVkUo2GpiKIu77R6DaYwdGMBpHHzR2ecv8LKJ6ieAZKM4fU6ChtSkChGV+4qR
         K30PQhr9wxznvurKWs0MhQoOMeefg+ljtv5vmsUdep+2pEVdV5bxsQgbnsNFEArYEkf9
         7CUQ==
X-Gm-Message-State: AOAM530YIE61v/uQVhXqUh89EPp4+SuKmU34kvGNkZavBFnpqIKxrDd2
        XRA0qzKE3SN4v26gTbzENXO99qBFy/e19wWT/8mx/GmJiLKN1M4b8syTAnaCQntlU2/pGFeW10D
        Iam5yemarRQ4KETCWY3q7FCdH
X-Received: by 2002:aa7:c345:: with SMTP id j5mr2694260edr.331.1628783599819;
        Thu, 12 Aug 2021 08:53:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyA2o0pTKirLj0DNfQbHbvFJAFWpUMp09yyngCH8w5NoiU/HesRnlmz+BQfPLisSylJ4MIxPw==
X-Received: by 2002:aa7:c345:: with SMTP id j5mr2694241edr.331.1628783599604;
        Thu, 12 Aug 2021 08:53:19 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id m25sm1293859edv.81.2021.08.12.08.53.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 08:53:18 -0700 (PDT)
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        vkuznets@redhat.com
References: <20210811102356.3406687-1-pbonzini@redhat.com>
 <20210811102356.3406687-2-pbonzini@redhat.com>
 <20210811180322.GA178399@fuller.cnet>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/2] KVM: KVM-on-hyperv: shorten no-entry section on
 reenlightenment
Message-ID: <5e3ddaea-c0f4-f207-de54-5702c970079b@redhat.com>
Date:   Thu, 12 Aug 2021 17:53:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210811180322.GA178399@fuller.cnet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/08/21 20:03, Marcelo Tosatti wrote:
>          hyperv_stop_tsc_emulation();
> 
>          /* TSC frequency always matches when on Hyper-V */
>          for_each_present_cpu(cpu)
>                  per_cpu(cpu_tsc_khz, cpu) = tsc_khz;
>          kvm_max_guest_tsc_khz = tsc_khz;

Yeah, it's more complicated than this.  The right sequence is:

- update the master clock

- update the TSC page parameters

- stop TSC emulation

There is no need to invalidate the TSC page.

Related to this, after kvm_hv_invalidate_tsc_page the sequence value in 
the Hyper-V TSC page will always be 1, which is wrong.  I'll take a look 
at that too.

Paolo

