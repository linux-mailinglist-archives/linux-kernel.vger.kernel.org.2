Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EABE33526E2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 09:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234229AbhDBHPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 03:15:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35332 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231550AbhDBHPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 03:15:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617347699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XlsXpBQYO8BnA+v2nCN1VsUgWlO7pUooTMOEWnRSvJI=;
        b=gHtbHEQknJ9PBUWLepoqnQiiIMTYVbkZWlDnCyEr2fYjl6QzFOKJhFYERhMIkhbxSxR3Xo
        229DmjSKQzFK25XUeOjsEZWjJEJcjS3W+ZjKav1+qtEdykCyBvjm9ODdJy7CEmGARrXcP5
        taloKwKJ5KdVYMJ8MN5cEncA4ANtC1w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-IxpAbtYDNy-rzV8fO0IgSA-1; Fri, 02 Apr 2021 03:14:57 -0400
X-MC-Unique: IxpAbtYDNy-rzV8fO0IgSA-1
Received: by mail-wr1-f71.google.com with SMTP id p12so3967925wrn.18
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 00:14:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XlsXpBQYO8BnA+v2nCN1VsUgWlO7pUooTMOEWnRSvJI=;
        b=rMZV9IfSpkpAx8gFinKPMGgipsQGyAnB4sEyXNgwx58K0CI2xJ5LzqLnvOnzEm5Wyh
         LcjxA+cM5lypNrcuIRWT25AE8yAZ0NR3I+n0P2Xfv+t4AfjQRu4hDmzxbaIjH8DK3Knd
         7+FAzbf9DaUJTkTf2iwX7J32rIc5D+Rqx1RJldKkasDJ5+XizGvARDIk/a93IgYWlgl+
         Ur6A5lqA1sGMS2zhkfYr9kwNWF8/EKYRV30FvMYas6khi/IO72ef0paRmFSv1Qr6eg0R
         V6j3XwUlnR5SaodIbiZYsOns4TX7TJebEc6SmBUOKMdl+pPEN9xjVQoqvcRYKWRRWw8T
         GJHA==
X-Gm-Message-State: AOAM530F2nuI64jhnXPBK/bSdhuWoHW0AY0Sqb5dmjoqOZZJmKvDVg3a
        FgaHfk8iZ22FbdpdFXgt2ip0Mb/pHLdv0cD5Mrt1U3okn9OgXV3H5zm6Hg2jazjxGt9SXH2v0Ua
        15FP9HhtNGjJtOIkgxDsIbCO+
X-Received: by 2002:adf:82af:: with SMTP id 44mr13280307wrc.279.1617347696640;
        Fri, 02 Apr 2021 00:14:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz3KCpApFobW4U+KRji3BKlp3otCb2IZDr+rBpgP3L3s/iXTUtOscTxKuTStGNoCjltX5m7PA==
X-Received: by 2002:adf:82af:: with SMTP id 44mr13280285wrc.279.1617347696422;
        Fri, 02 Apr 2021 00:14:56 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id p27sm11878786wmi.12.2021.04.02.00.14.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Apr 2021 00:14:55 -0700 (PDT)
Subject: Re: [PATCH 2/4] KVM: x86: separate pending and injected exception
To:     Sean Christopherson <seanjc@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
Cc:     kvm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Wanpeng Li <wanpengli@tencent.com>,
        Borislav Petkov <bp@alien8.de>,
        Jim Mattson <jmattson@google.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>,
        Ingo Molnar <mingo@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
References: <20210401143817.1030695-1-mlevitsk@redhat.com>
 <20210401143817.1030695-3-mlevitsk@redhat.com> <YGZRrOBVvlhVTyG8@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <09c74206-ded2-900f-ef28-a2c5065a6626@redhat.com>
Date:   Fri, 2 Apr 2021 09:14:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YGZRrOBVvlhVTyG8@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/04/21 01:05, Sean Christopherson wrote:
>>
>> +struct kvm_queued_exception {
>> +	bool valid;
>> +	u8 nr;
> 
> If we're refactoring all this code anyways, maybe change "nr" to something a
> bit more descriptive?  E.g. vector.

"nr" is part of the userspace structure, so consistency is an advantage too.

>> +	struct kvm_exception_payload {
>> +		bool valid;
>> +		unsigned long value;
>>   		u8 nested_apf;
>> -	} exception;
>> +	} exception_payload;
> 
> Hmm, even if it's dead code at this time, I think the exception payload should
> be part of 'struct kvm_queued_exception'.  The payload is very much tied to a
> single exception.

Agreed, when handling injected exceptions you can WARN that there is no 
payload.

Paolo

