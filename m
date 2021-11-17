Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00D484546E9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 14:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237498AbhKQNKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 08:10:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:46258 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237440AbhKQNKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 08:10:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637154428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0LTZQNPdeqRQ2yT5OTn224BgKxkqswLX71q3wqkNfeM=;
        b=NXeddxlYd+9MY7j9RWEm8DEYoolbeA8oFr2zmWIIdkt5H/Ny3T/3aI+MOqcHh8hYj7bFBJ
        GurZjSMlwhTe3txtJ+PQNTVA48pkTHDjTUdiuadNHg+1FYqFTFCiahGNYpl8V/wCan/64U
        wrBJbejmioP5YnIho1+Y3hbiAMvgL88=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-87-EP4QXOF9Nx-sCzxb3JKZfg-1; Wed, 17 Nov 2021 08:07:05 -0500
X-MC-Unique: EP4QXOF9Nx-sCzxb3JKZfg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7EB58799E0;
        Wed, 17 Nov 2021 13:07:03 +0000 (UTC)
Received: from [10.39.192.245] (unknown [10.39.192.245])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EB88160657;
        Wed, 17 Nov 2021 13:07:00 +0000 (UTC)
Message-ID: <5148de60-4a9d-67ef-ca64-5c6461034c0c@redhat.com>
Date:   Wed, 17 Nov 2021 14:06:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 2/2] KVM: SVM: Extend host physical APIC ID field to
 support more than 8-bit
Content-Language: en-US
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, x86@kernel.org
Cc:     joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, peterz@infradead.org, hpa@zytor.com,
        thomas.lendacky@amd.com, jon.grimm@amd.com
References: <20211110101805.16343-1-suravee.suthikulpanit@amd.com>
 <20211110101805.16343-3-suravee.suthikulpanit@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211110101805.16343-3-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/21 11:18, Suravee Suthikulpanit wrote:
> +	if (level_type != 2 || !x2apic_mode) {
> +		avic_host_physical_id_mask = 0xffULL;
> +		goto out;
> +	}
> +
> +	core_mask_width = eax & 0xF;
> +
> +	max_phys_mask_width = get_count_order(apic_get_max_phys_apicid());
> +
> +	/*
> +	 * Sanity check to ensure core_mask_width for a processor does not
> +	 * exceed the calculated mask.
> +	 */
> +	if (WARN_ON(core_mask_width > max_phys_mask_width))
> +		return -EINVAL;

Can it just use apic_get_max_phys_apicid() in x2apic mode, and 0xff in 
!x2apic mode?  I'm not sure why you need to check CPUID[0xb,0x1].

Paolo

