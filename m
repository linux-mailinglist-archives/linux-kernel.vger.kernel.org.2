Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFA2E454D30
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 19:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240146AbhKQSa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 13:30:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:34174 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240203AbhKQSaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 13:30:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637173637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=muja5Zqc4exP8/ZNpkPsxqcHPiMkorOYQ6WQyXUYa38=;
        b=GQh/CzlBIPLkgjUT8Olkh2fiK+uSgcPo0G8EdFaeRRIMQBs0QOlW2LXxL0JU9DwAByDFXQ
        H3bV6KJiOn9uMBk2glTmWfK665sxdrKW1y61YrSNosf6E7PMcgh9QcPK+q1Jt/B39R3AG3
        EiAWmp6nrN5035GDwrACc9wm0Zw3n9Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-suO45-XKOS2CFKtvC8PVrQ-1; Wed, 17 Nov 2021 13:27:13 -0500
X-MC-Unique: suO45-XKOS2CFKtvC8PVrQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9D7B08799E0;
        Wed, 17 Nov 2021 18:27:12 +0000 (UTC)
Received: from [10.39.192.245] (unknown [10.39.192.245])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8E81B5F4ED;
        Wed, 17 Nov 2021 18:27:11 +0000 (UTC)
Message-ID: <cbcce032-abfb-7fdc-74bb-0f4a29010c30@redhat.com>
Date:   Wed, 17 Nov 2021 19:27:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 4/4] KVM: SEV: Do COPY_ENC_CONTEXT_FROM with both VMs
 locked
Content-Language: en-US
To:     Peter Gonda <pgonda@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        seanjc@google.com
References: <20211117163809.1441845-1-pbonzini@redhat.com>
 <20211117163809.1441845-5-pbonzini@redhat.com>
 <CAMkAt6odbAGZ-LgK7yefnNRgoAAs3ekvR2_sZpjTiv_6mfwRKg@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <CAMkAt6odbAGZ-LgK7yefnNRgoAAs3ekvR2_sZpjTiv_6mfwRKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/17/21 18:46, Peter Gonda wrote:
>> +       if (dst_kvm == src_kvm)
>> +               return -EINVAL;
>> +
> Worth adding a migrate/mirror from self fails tests in
> test_sev_(migrate|mirror)_parameters()? I guess it's already covered
> by "the source cannot be SEV enabled" test cases.
> 

It was covered by the locking test (which does not check i != j). 
There's no equivalent for the operation of creating a mirror VM, I can 
add it in v2.

Paolo

