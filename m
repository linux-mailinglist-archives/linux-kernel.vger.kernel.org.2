Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49C2F367FDA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 13:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236043AbhDVL5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 07:57:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26820 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235957AbhDVL5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 07:57:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619092586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r/EfgkIAyveAD+413kdmsLTagFR2+ozoz9ZwbDock6Y=;
        b=WNBUCXWitlicQ+JZur8/QFWY/+YqewEfAPrZo32aP3kCbowhO9YrSV6U1Ot0Qvw2eRjUpA
        51EdtVasxIlBdzWLKbsrnUk62cI4WHXHx6XAIvunDeZqHtFgPO8gvDxZpkE+yPN/+xURrm
        12tXpJrADoQb7qb5rCUItCP4W48QKOA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-nnKV-7_sPlKvtm5prfgw7A-1; Thu, 22 Apr 2021 07:56:24 -0400
X-MC-Unique: nnKV-7_sPlKvtm5prfgw7A-1
Received: by mail-ej1-f72.google.com with SMTP id d11-20020a170906370bb029037c87968c04so7109751ejc.17
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 04:56:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r/EfgkIAyveAD+413kdmsLTagFR2+ozoz9ZwbDock6Y=;
        b=KaOxFfbwSWzAxPT8toMoP3fnzfO04nBS0SCmPT00GorMe8iiEVRDrRf2UOouQYT45g
         37qiyx4cnaTjYgIrxkJobDLwHxnvdjgyeuv6nfWk92TtHFmQ5dN4HvJvLAz3gurDZmTv
         Et1mjUuvfb2SS5fEn/2h8OOiNrIHgQPGRrfkap4jxNd8p2BljRte5zaU9mjpu0hzQKAA
         Zi4y9uMk0v0m5YXUcMOFW6WcHxHnL7iZIDLZ/q2veyjTZgiWiIxaBmFJX1AhK2mBMygN
         utcSGJsJYGIiB/KC6OVz/nnBxgXVPpnLtgh9WYzAHvsPYhz0fQ4ha1AHlGEoZPBbOAHU
         dAtg==
X-Gm-Message-State: AOAM5313fvkDSXDyFmoSSPDu+Hfv3flOTKpayMScXmdnYfJjBfrLE+4u
        EWxFWsy8K0bRZ0b7iZptV0dsXpnzd8onvLFTEGGu/5DNH/bQhxkWaJJjwy4PkLHurvFhUF5Xha4
        4/sQRs6WI7LI3OV2E7WGquWYh
X-Received: by 2002:a17:906:4746:: with SMTP id j6mr3036121ejs.39.1619092583640;
        Thu, 22 Apr 2021 04:56:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwCeeqN0ifqMSMQ2inHAeNFtxH8+83gzY3wP7UhM9Zgkyaq44qYqtN6tKTnJVbhKUD424wd2A==
X-Received: by 2002:a17:906:4746:: with SMTP id j6mr3036108ejs.39.1619092583465;
        Thu, 22 Apr 2021 04:56:23 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id b18sm1771934eju.22.2021.04.22.04.56.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Apr 2021 04:56:22 -0700 (PDT)
Subject: Re: linux-next: manual merge of the cgroup tree with the kvm tree
To:     Tejun Heo <tj@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>, KVM <kvm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Vipin Sharma <vipinsh@google.com>
References: <20210422155355.471c7751@canb.auug.org.au>
 <124cf94f-e7f5-d6f3-7e7a-2685e1e7517f@redhat.com>
 <YIFiiYtgL7/uvzng@slm.duckdns.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <58697cc7-cb94-19f0-0b60-759ec8fdbae8@redhat.com>
Date:   Thu, 22 Apr 2021 13:56:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YIFiiYtgL7/uvzng@slm.duckdns.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/21 13:48, Tejun Heo wrote:
> Hello, Paolo.
> 
> On Thu, Apr 22, 2021 at 08:34:15AM +0200, Paolo Bonzini wrote:
>> Tejun, please don't commit patches to other tree without an Acked-by from
>> the maintainer (which I wouldn't have provided, as the right way to go would
>> have been a topic branch).
> 
> My apologies, for some reason, I was incorrectly assuming it was all dandy
> on the kvm side.

It was, just full of conflicts. :)  It's only a process thing and not a 
problem with the code.

>> Fortunately these patches are at the bottom of your tree.  If it's okay,
>> I'll just pull from there "as if" you had provided a topic branch all the
>> time.
> 
> I'd be happy with however you wanna resolve it. Please let me know if
> there's anything I can do to help.

Great, I've pulled from your tree then.  Stephen, that will also fix the 
conflicts with Linus's tree, since Tejun's merge base was newer than mine.

Paolo

