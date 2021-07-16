Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05D9E3CB8EF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 16:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240526AbhGPOoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 10:44:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54718 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233122AbhGPOoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 10:44:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626446468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z8XgazHaSaFYbppKUAFPtdkOLmoZld8wNP3xTo/qIeI=;
        b=AjmmJlT+UegDBVJ2DY9TjocwxuT/winp0aAIXM+GTiN4Fk/VAoeb4VNFmYEXQKCGx5IDmm
        VPn0eZBSlJW+FrNMfNwHKExw8FTD5ta/bE9kp5pTsLS530A35BTkEAdVCo0hiCe+bhYeNo
        n5DXDbGb1XsaKXyTZnfrJazXuKvdt3E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-cyuf1WrBN1yMhVtG7LUtTA-1; Fri, 16 Jul 2021 10:41:07 -0400
X-MC-Unique: cyuf1WrBN1yMhVtG7LUtTA-1
Received: by mail-wm1-f72.google.com with SMTP id m40-20020a05600c3b28b02901f42375a73fso3247283wms.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 07:41:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z8XgazHaSaFYbppKUAFPtdkOLmoZld8wNP3xTo/qIeI=;
        b=h/+foCR1Uc+Ow574ZC5Uq1YRA25ja4a4z6orxh284rrVOo7izkk/NsxH51PGuQmhNp
         aCFUE9wtbT6O95BVWuJOguLLawvMFT7b61kWxz/Z4Q0Qgz5MSDidjJV8obbQiiiLyS0g
         5lgn586MJiMOAmobTGLXP44xfVlAvn2UwTnCBGjGmyT8P6z2gaH7zrsqU0hEExpfzx9d
         mZG2NbMC4jKdqDSqRbLiTp09ppYgKfi3xdgNLc3uMS4qUsciXg9MNdCYb688w4EhG7So
         ClXJVXqypoQopOmSLJibw8/vLkNPwUzMBJeUDQlXnP+juf+DI2ClDw98Jtnn5K7yyiY1
         4Giw==
X-Gm-Message-State: AOAM533mJtZattoGUF3GDeHY0RIVBvRetMeKseX8CgVAf50+degaoFSR
        huyCFcRydYyknm7FCh3j40dipUotk/SQwxeWN+M9rfKcstd9s5Td5+G2XsBKOBYLGQui4SVzfxl
        tQiHEDBTAeVBY9UdFqjy0RsXQ
X-Received: by 2002:a05:600c:1c08:: with SMTP id j8mr11154053wms.50.1626446466444;
        Fri, 16 Jul 2021 07:41:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxWdoky2KjCr2ox5O8bhUTxWJ8ULL5wgA4y7xfyrLqCZMspJJ4SpfnI+K8oRPVEc6zZVQhJwA==
X-Received: by 2002:a05:600c:1c08:: with SMTP id j8mr11154030wms.50.1626446466168;
        Fri, 16 Jul 2021 07:41:06 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id 140sm8282837wmb.43.2021.07.16.07.41.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jul 2021 07:41:05 -0700 (PDT)
To:     stsp <stsp2@yandex.ru>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     stable@vger.kernel.org
References: <20210714213846.854837-1-pbonzini@redhat.com>
 <6f2305c0-77a8-42af-f5e9-2664119b6b2e@yandex.ru>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] KVM: x86: accept userspace interrupt only if no event is
 injected
Message-ID: <f6bd5b5b-2a4a-64e2-0a7b-a2bcdd3f541d@redhat.com>
Date:   Fri, 16 Jul 2021 16:41:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <6f2305c0-77a8-42af-f5e9-2664119b6b2e@yandex.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/07/21 09:27, stsp wrote:
>> +    if (kvm_event_needs_reinjection(vcpu))
>> +        return false;
>> +
> 
> kvm_event_needs_reinjection() seems
> to miss exception.pending check.
> Don't we need it too?

Yes, good point.

Paolo

