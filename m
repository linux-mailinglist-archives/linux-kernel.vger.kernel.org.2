Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF97455F6D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 16:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbhKRP25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 10:28:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38016 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232139AbhKRP2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 10:28:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637249155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ERRITdzVcT17gm6mQeebp56svvkvy1m5O4EplSE47f4=;
        b=GPXM4rKr2nZ5ykM1sr2GFR1xrNYW35ugbEk9h/HCuqGz16yfzsENhBWFpZ0tUpziIeQVyP
        BwDwkgX8J9QQQgJYdSpBODDUGbMs26mPq/6lMeXi08gg22Lf8D1we2SUyfBlIwQ0rxtZIn
        QYdHrcMQPMiWeXtfLgIuO0obsIP73qg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-551-MXMbAmXsNMWNYlsH7x48Sw-1; Thu, 18 Nov 2021 10:25:50 -0500
X-MC-Unique: MXMbAmXsNMWNYlsH7x48Sw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E374280A5C3;
        Thu, 18 Nov 2021 15:25:47 +0000 (UTC)
Received: from [10.39.192.245] (unknown [10.39.192.245])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B8AA05C3E0;
        Thu, 18 Nov 2021 15:25:44 +0000 (UTC)
Message-ID: <b6711c49-edab-acfa-2005-42e4732d0e4f@redhat.com>
Date:   Thu, 18 Nov 2021 16:25:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 12/15] KVM: VMX: Reset the bits that are meaningful to be
 reset in vmx_register_cache_reset()
Content-Language: en-US
To:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
References: <20211108124407.12187-1-jiangshanlai@gmail.com>
 <20211108124407.12187-13-jiangshanlai@gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211108124407.12187-13-jiangshanlai@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/21 13:44, Lai Jiangshan wrote:
> +/*
> + * VMX_REGS_AVAIL_SET - The set of registers that will be updated in cache on
> + *			demand.  Other registers not listed here are synced to
> + *			the cache immediately after VM-Exit.
> + *
> + * VMX_REGS_DIRTY_SET - The set of registers that might be outdated in
> + *			architecture. Other registers not listed here are synced
> + *			to the architecture immediately when modifying.

Slightly more expressive:

/*
  * VMX_REGS_LAZY_LOAD_SET - The set of registers that will be updated in the
  * cache on demand.  Other registers not listed here are synced to
  * the cache immediately after VM-Exit.
  */
...

/*
  * VMX_REGS_LAZY_UPDATE_SET - The set of registers that might be outdated in
  * VMCS. Other registers not listed here are synced to the VMCS
  * immediately when modified.
  */
...

	BUILD_BUG_ON(VMX_REGS_LAZY_UPDATE_SET & ~VMX_REGS_LAZY_LOAD_SET);
         vcpu->arch.regs_avail &= ~VMX_REGS_LAZY_LOAD_SET;
         vcpu->arch.regs_dirty &= ~VMX_REGS_LAZY_UPDATE_SET;

That is lazily loaded registers become unavailable, and lazily updated registers
become unavailable and dirty.

Paolo

