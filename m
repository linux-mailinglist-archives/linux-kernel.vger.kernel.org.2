Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F73B31FCCE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 17:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbhBSQHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 11:07:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57662 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230017AbhBSQCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 11:02:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613750481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oak/a1c41DR+oakbhcUs5bY+XJCINNwaJG3qvr9jT4E=;
        b=X8uUfu/VfXcVJICyec7ZCqe20XP4Fp9ynG9t59QQTF7Oih9YnzMVKyJpmaiJg3HMdCFs/7
        MLBc7WPWejZlOb6uruDhSVYZLL/PvtLLgVM3TjRensmz+o3LzD07j/2tBVf3JGcKWxvFzS
        DWfEIOawn4voQXRiiuxuJjyRynw6vDo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-129-P_dNdB2YM7Sqk7xok-Yd0Q-1; Fri, 19 Feb 2021 11:01:18 -0500
X-MC-Unique: P_dNdB2YM7Sqk7xok-Yd0Q-1
Received: by mail-wm1-f72.google.com with SMTP id q24so2682904wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 08:01:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oak/a1c41DR+oakbhcUs5bY+XJCINNwaJG3qvr9jT4E=;
        b=WRCrDze+4zdt0UH9ZV8qPIycVInUiPXUYFMlyNNFe4QN3Grmr8GmJPkj0W3mdh96jd
         MbGnNlfGKnXP59j33BxluNEC7LUDAiHpXSD7gH3/ruiZO4UaEb4Wv19XM7osjsZbRJOR
         epqU0H1/qafeBYry6b8DURrTm++BJKn6ybKxQF5o64OJw9JKciv3oyDbzdUv0zeQs5WG
         v3Fgps4iYZDvxHIYe9Tx86nBmTUDST9zxHV1nrO71Jv7p80ptZ6H+Bu0OxpsCvEB3lLf
         Hdb2iusgRlSS1a7CcIXRtVQRNz8DuT4PY2SnyN09vSuefs2Zy5FD1bv+H9xXz0vxxsnG
         pgyA==
X-Gm-Message-State: AOAM5301+lLlZ9NL9m/tBoENs/kVL7DkJKxC1S7cylRTq0STm3+O8zwM
        g09HC75vhl2ha4qTyBDzkpK3JdzKroNdmFFhhV4tqncoExv6D7Osq44I5i+3fDDayr3AM1WhR2Z
        iYMA6pcC7+H9g8PMa1v5Q8Zzd
X-Received: by 2002:a5d:610a:: with SMTP id v10mr10024134wrt.334.1613750475888;
        Fri, 19 Feb 2021 08:01:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxo9i8WHF/v88BAJZiEAW272dnC6jy0hvBDleHoKpO1K8Q2ujs+q+NaivQy6//F143ZPK0qKQ==
X-Received: by 2002:a5d:610a:: with SMTP id v10mr10024016wrt.334.1613750474806;
        Fri, 19 Feb 2021 08:01:14 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id w16sm14258476wrk.38.2021.02.19.08.01.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Feb 2021 08:01:14 -0800 (PST)
Subject: Re: linux-next: build warnings after merge of the origin tree
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20210219080235.52c8c7f4@canb.auug.org.au>
 <87pn0w3wde.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f93b780b-7027-0f05-7288-04f313cfe86c@redhat.com>
Date:   Fri, 19 Feb 2021 17:01:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <87pn0w3wde.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/02/21 16:33, Vitaly Kuznetsov wrote:
> Stephen Rothwell <sfr@canb.auug.org.au> writes:
> 
>> Hi all,
>>
>> Building Linus' tree, today's linux-next build (htmldocs) produced
>> these warnings:
>>
>> Documentation/virt/kvm/api.rst:4537: WARNING: Unexpected indentation.
>> Documentation/virt/kvm/api.rst:4539: WARNING: Block quote ends without a blank line; unexpected unindent.
>>
>> Introduced by commit
>>
>>    c21d54f0307f ("KVM: x86: hyper-v: allow KVM_GET_SUPPORTED_HV_CPUID as a system ioctl")
>>
>> These have been around for some time.
> 
> I remember seeing a patch fixing these:
> https://lore.kernel.org/kvm/20210104095938.24838-1-lukas.bulwahn@gmail.com/
> 
> Paolo, could you please queue it up? Thanks!

I was expecting Jon to pick it up, but yes I can do that too.

Paolo

