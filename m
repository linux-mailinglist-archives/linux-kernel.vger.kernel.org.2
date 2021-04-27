Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7A836BFBE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 09:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234970AbhD0HHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 03:07:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21489 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230255AbhD0HGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 03:06:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619507154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hU0X065Jts3zXqonmt3u6RVQ5smooOA0uzd+qO/RgE8=;
        b=F3HkEco0mDg5/e4f/JKkjEhqJNcTmi/jhHoA0esjXi0T6iSG4IH94s1pmyUGBLzx+wgicg
        77jLN6C9n6ob72CjlJBkZJeRAvni+khzvDMLi/jha5pqRxaSDtJPrkaZzky/NWBWwa71CB
        /2LBpsv1fCLVbvT3CxKNj3ox2A89RqI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-bWCu3qYZMJC297-0zLiG0A-1; Tue, 27 Apr 2021 03:05:52 -0400
X-MC-Unique: bWCu3qYZMJC297-0zLiG0A-1
Received: by mail-ej1-f70.google.com with SMTP id e18-20020a17090681d2b0290384d9ff1359so1968516ejx.16
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 00:05:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hU0X065Jts3zXqonmt3u6RVQ5smooOA0uzd+qO/RgE8=;
        b=JpbMmenqtwT7dk8uqAzfuWycu+0zLfS7NYnSC3L9nPgdMdqDLwIHeA6SgOOVrGMlNX
         vOFQLvq819SA4lRm4g+77bTMzGJQ3d5QjTAFCp4pAYUv8sRlyVbvQQIBZKBYe9AUNOlY
         wDjjWbISTWip3fpDSjgZ6jbGk0Ts8xJ6Ly8y8bQg0NOtl0wGXpuxdi8+NxYqjG7jYIvB
         SirX0SgbNlwuj1JcMvo0HpdGVP84Ae46ERCwUOXkAIiuqRRS2UfGcEhec2WWGsubtnnA
         eZDImjjF2BaLpsUGe+qT0ikHN0FDrTkyo4Nj9yOMtQgM9XFvIyH1BnYjZxQb6FHQFltJ
         60xw==
X-Gm-Message-State: AOAM532AfTBblpHkMOd62t41yUUpsm+HdrIYOTC3yxORbG+ZEprLW5Md
        XlM8gpAuXF2y3kHAcubelZ7Vkx1Tr717DKw3ZUpxn2jTtyHSmUdySwKOO9kIHrB9Z8D33+IMHLk
        NTwNw5iXyYnaH7/Bp/Tz9Uxl4
X-Received: by 2002:a17:907:628a:: with SMTP id nd10mr22253868ejc.326.1619507151322;
        Tue, 27 Apr 2021 00:05:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZ7hxv9V3N9QTnZlvdRwBjGOXQZdA7OUgnCOqig0VsESbZiuwiXd/zr94sDLdsUQMotZjtOA==
X-Received: by 2002:a17:907:628a:: with SMTP id nd10mr22253845ejc.326.1619507151124;
        Tue, 27 Apr 2021 00:05:51 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id 16sm12846449ejw.0.2021.04.27.00.05.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Apr 2021 00:05:50 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] KVM: VMX: Invoke NMI handler via indirect call
 instead of INTn
To:     Lai Jiangshan <jiangshanlai+lkml@gmail.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Uros Bizjak <ubizjak@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sean Christopherson <seanjc@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
References: <20200915191505.10355-1-sean.j.christopherson@intel.com>
 <20200915191505.10355-3-sean.j.christopherson@intel.com>
 <CAJhGHyBOLUeqnwx2X=WToE2oY8Zkqj_y4KZ0hoq-goe+UWcR9g@mail.gmail.com>
 <bb2c2d93-8046-017a-5711-c61c8f1a4c09@redhat.com>
 <CAJhGHyDrAwKO1iht=d0j+OKD1U7e1fzLminudxo2sPHbF53TKQ@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2fd450a9-0f59-8d88-d4bc-431245f3b565@redhat.com>
Date:   Tue, 27 Apr 2021 09:05:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAJhGHyDrAwKO1iht=d0j+OKD1U7e1fzLminudxo2sPHbF53TKQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/04/21 02:54, Lai Jiangshan wrote:
> The C NMI handler can handle the case of nested NMIs, which is useful
> here.  I think we should change it to call the C NMI handler directly
> here as Andy Lutomirski suggested:

Great, can you send a patch?

Paolo

> On Mon, Apr 26, 2021 at 11:09 PM Andy Lutomirski <luto@amacapital.net> wrote:
>> The C NMI code has its own reentrancy protection and has for years.
>> It should work fine for this use case.
> 
> I think this is the right way.
> 

