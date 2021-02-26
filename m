Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 483C03263F0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 15:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbhBZORS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 09:17:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23373 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229566AbhBZORB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 09:17:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614348932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4kRH4vZslkX9Yf42k0RaWB9YdK7vW9HptLZSW8LNHNg=;
        b=Mz2soumOTeLznrShsmsnfLKDvNke9e4deDPKiiL5UpeqBW6jTT5FymkqRW3U1W6uPs4PMm
        P92l93fD4QECmHDLXM0HJIDWTLLc/fNMmDLIdHpbarCfO6lH9UtQQqK8m/3Mj7OmbTbMOQ
        Lzxf8ZAWhRKnU1zB+bw7qeOpvZ86cLk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-WQUfBUJSPTWPe02wC08i9Q-1; Fri, 26 Feb 2021 09:15:30 -0500
X-MC-Unique: WQUfBUJSPTWPe02wC08i9Q-1
Received: by mail-ed1-f70.google.com with SMTP id i19so2111501edy.18
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 06:15:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4kRH4vZslkX9Yf42k0RaWB9YdK7vW9HptLZSW8LNHNg=;
        b=jpTzS1SUBP5y52Gr05DcYyMDBABfHIcjaYK2u2rvZd1GGyaC8JYdSugejUgFlz3/QV
         amEc/QYZKp+sbGZx2e7RWn8+/8oZhQk1KBABJLBUBs2zUTD2NXRw3O76xQpT2xF4cByU
         Zu3rmyXVLgPMeXoOSRQEGDBQfFwWYWLy6FFB1/iW6yvCCfSKhD1ykN5c1s+muk9FPIDO
         qLRePeFIWIj4q/tHR+t50Vv7ScqpzATqyLfg3FVjM0/oormDPeYMUABspaIdBmjZrTYt
         DJ4TxNEPHb7VEmtrjjJqkfhCtzu7Lf5LbI8ip+RRDSIgLahPAlqFGN/WqZM9bhfWMzaa
         nFPQ==
X-Gm-Message-State: AOAM530wuBEW01GcvvC5BvnXKXVXBagYGPQ9tqqNGOXiVOS3QSCb60TH
        /7UYDSdmyy48wu6cL7ez4ZhD3R2C/o+5S1I2GdOdXs4OkDX7nZUV2Alp9b3NkLc9G5ZKFjxeGnx
        anEfi/rhOGrN8aBR/6mYqNTiQ
X-Received: by 2002:a17:906:9455:: with SMTP id z21mr3593225ejx.174.1614348929099;
        Fri, 26 Feb 2021 06:15:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzA/A1HwjyNJo2CiRQRHDk6PYRktz0aj+HEKsx75YP4xTsAoCrBb3vAmZGu+ERlBnprwQsS2A==
X-Received: by 2002:a17:906:9455:: with SMTP id z21mr3593207ejx.174.1614348928925;
        Fri, 26 Feb 2021 06:15:28 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id i13sm5974548edk.38.2021.02.26.06.15.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Feb 2021 06:15:28 -0800 (PST)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Lamprecht <t.lamprecht@proxmox.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Jim Mattson <jmattson@redhat.com>,
        Sasha Levin <sashal@kernel.org>
References: <20210104155705.740576914@linuxfoundation.org>
 <20210104155706.339275609@linuxfoundation.org>
 <85e3f488-4ec5-2ad3-26a6-097d532824e1@proxmox.com>
 <4fa31425-3c13-0a4f-167b-6566c6302334@redhat.com>
 <YDjwxF2RyKnsQqF/@kroah.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 5.4 12/47] KVM: x86: avoid incorrect writes to host
 MSR_IA32_SPEC_CTRL
Message-ID: <34df16e4-06a1-3343-2fd9-5004ec5f5fa1@redhat.com>
Date:   Fri, 26 Feb 2021 15:15:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YDjwxF2RyKnsQqF/@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/02/21 13:59, Greg Kroah-Hartman wrote:
>>> So can you please add this patch to the stable trees that backported the
>>> problematic upstream commit 6441fa6178f5456d1d4b512c08798888f99db185 ?
>>>
>>> If I should submit this in any other way just ask, was not sure about
>>> what works best with a patch which cannot be cherry-picked cleanly.
>>
>> Ok, I'll submit it.
>>
>> Thanks for the testing.
> 
> Does that mean I should not take the patch here in this email and that
> you will submit it after some timeperiod, or that I should take this
> patch as-is?

The patch that Thomas requested (commit 841c2be09fe) does not apply 
cleanly, so I'll take care of sending the backport.

Paolo

