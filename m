Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8586442B8B6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 09:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238338AbhJMHRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 03:17:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41311 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238352AbhJMHRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 03:17:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634109345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=35PL8mBr5TTmUiVi2XJDDdVJheYoEo4drXok79snLSY=;
        b=cS8zFzO9RUTy7lU1tcvz8VSxspa78vjADQOLJ9+TMNi9vPJgq32duz9sTzomaVH9Ahg4Va
        okfybFWB6f7L+NXKBkOhIV2bdhB3JCGGt2UDaChQab36ODACEaap3GIWsjYRx7W8/ASFYp
        YyZepoZrkVLYPHWfJncHsb5YhCMqWwg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-VZuEoGZmPc6zNJ1OVoPYNw-1; Wed, 13 Oct 2021 03:15:43 -0400
X-MC-Unique: VZuEoGZmPc6zNJ1OVoPYNw-1
Received: by mail-ed1-f71.google.com with SMTP id cy14-20020a0564021c8e00b003db8c9a6e30so1428030edb.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 00:15:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=35PL8mBr5TTmUiVi2XJDDdVJheYoEo4drXok79snLSY=;
        b=zF+8+HZHLEhW17aPYrdnB2pbk6bOCiur/K5GEUwrbQ0Ippq2Yt+cK9vWa2bz9KPfae
         qgPSRNZ9k7D3V5FkKiv363PLHuL7+YDUBioM1c7b55/uvjHepsyhCZkSvcE8C1chbuKa
         PDD/jHIJQHEhJYCz+PZQoh2VQdZ8PaaI866c6uKyR/CeI/4SJKuBYjTox0O0SsTKAi/U
         T6fA/eH6W0c9z+Kz+YV6BZgaQ+4Ff5iuVa8SUXXb6QcWqYz0DNTbLp5+cssGNp38Wv0A
         SqhfzGp6uF4vx4sSJ+XnSJu8df+n5AiUoSPPavAHW/Iswf/NmeF1HCQM9jQkF4TLXeWc
         3RHQ==
X-Gm-Message-State: AOAM531HoS/eOzZqQPPfYpQxVEFm/feAzk4rAapmnRwbC6WEC4qE/Hsr
        JhZnyZCdVmJYxAupcvDVj4y6KoIz+1jLeaXVZtfhIpETZuyXabbR/CZAG0euroho55krdWB3ClN
        ToSVoeTyC8evR8sb74cRLCTxh
X-Received: by 2002:a17:906:4452:: with SMTP id i18mr37328485ejp.374.1634109342798;
        Wed, 13 Oct 2021 00:15:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzyWbF0GMWHEf+lA7ZzCQD8G6e2mMqmfRefQt6KvjaEIKm26V95VJZw/dpzrSxAsfIz2JWHqA==
X-Received: by 2002:a17:906:4452:: with SMTP id i18mr37328452ejp.374.1634109342533;
        Wed, 13 Oct 2021 00:15:42 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id v13sm7451288edl.69.2021.10.13.00.15.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Oct 2021 00:15:41 -0700 (PDT)
Message-ID: <a99ed8a3-249d-5cf5-1567-56c4014678f1@redhat.com>
Date:   Wed, 13 Oct 2021 09:15:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v2 0/2] x86: sgx_vepc: implement ioctl to EREMOVE all
 pages
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        dave.hansen@linux.intel.com, seanjc@google.com, x86@kernel.org,
        yang.zhong@intel.com, jarkko@kernel.org
References: <20211012105708.2070480-1-pbonzini@redhat.com>
 <YWaCu2Us+H+BSbYW@zn.tnic>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <YWaCu2Us+H+BSbYW@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/10/21 08:54, Borislav Petkov wrote:
> On Tue, Oct 12, 2021 at 06:57:06AM -0400, Paolo Bonzini wrote:
>> If possible, I would like these patches to be included in 5.15 through
>> either the x86 or the KVM tree.
> 
> You mean here 5.16, right?

No, I mean 5.15 because it literally cannot break anything that was 
working previously and the functionality provided by the ioctl 
(resetting VMs) is important.  But it wouldn't be a big issue if it was 
5.16 only.

Paolo

