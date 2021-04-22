Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A94FC367B63
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 09:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235211AbhDVHro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 03:47:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32217 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235058AbhDVHrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 03:47:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619077629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=feEZwhZhckEp2NWHe0knkLxWYyq3yllm3KyAPbxZatA=;
        b=LTgOe92HTnRjXA2fXQ9Kzn1Nh16PKSSrgdIlUOCfbP+pRNYFddBUFrrETX5r1MzdI17yh1
        8aH42b5D4ohQHKd+rpSoAYeFXEDWJv4DH1+diz4d/5aY+qy5f7rteGO5qFxDz3FRbaZ/Rv
        Qfkhmc538MyoqP5CBO/jTy0PaJpolFI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-T7dtLB0iPAWSzTUwX8AWYg-1; Thu, 22 Apr 2021 03:47:07 -0400
X-MC-Unique: T7dtLB0iPAWSzTUwX8AWYg-1
Received: by mail-ed1-f71.google.com with SMTP id f1-20020a0564021941b02903850806bb32so10336193edz.9
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 00:47:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=feEZwhZhckEp2NWHe0knkLxWYyq3yllm3KyAPbxZatA=;
        b=RBYjKDsqmOXaCf652ca0/YJWCBhAA+ichDzfFxsrfQQMGN8CDBFnuUx1V0p/OEDHSq
         ID+exlc3m/dVpGBs4zcxSz4I321RxCB2Lm5u0LYbJ+2sWD0JJzoAQr9Q0tMN1m+8pWx/
         +LAyOP9f0yJR+pET3hqICY8O+bMiMMl7lio/m5K6oiE3juNASJMnr+Zo7y8dTXsjpX69
         efGD0jjFnbAJu7/67jv8Fi0VVKT3kKR/2W8j4ewfGDBMeU4a/K8a7EMtsiPLyBaZJ9od
         FIleE49zBe6TdIMmK1SV8rb6wGFnaIN2FMN9wDLVKueUqiNYWIGa0S0EOLsTbWJlcc1n
         cQwg==
X-Gm-Message-State: AOAM532uYxoI2ORIIoGdvCL0JvfrpT9hMUKqyyVSVSRc8SrhfMX/gUNZ
        c/eDYZ60D2HVFQZ8wf19Q0W9CKP8/tlvQ7mAwAOTFaefhjTYHej0j+n0jUME2cKytXFud8HrS7B
        XwgvcZ9EgOatZuBHYqn7G+9eM
X-Received: by 2002:a05:6402:781:: with SMTP id d1mr2225852edy.32.1619077626363;
        Thu, 22 Apr 2021 00:47:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyclzt2baCaNcGBj1gjbLknc8ok1XMcMD/HR6PAfyuesi+oGnecNQynLgSuDuyo1tmi16/4EQ==
X-Received: by 2002:a05:6402:781:: with SMTP id d1mr2225841edy.32.1619077626172;
        Thu, 22 Apr 2021 00:47:06 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id y25sm1371324ejb.34.2021.04.22.00.47.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Apr 2021 00:47:05 -0700 (PDT)
Subject: Re: linux-next: manual merge of the cgroup tree with the kvm tree
To:     Vipin Sharma <vipinsh@google.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>, Tejun Heo <tj@kernel.org>,
        KVM <kvm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        David Rientjes <rientjes@google.com>
References: <20210422155355.471c7751@canb.auug.org.au>
 <124cf94f-e7f5-d6f3-7e7a-2685e1e7517f@redhat.com>
 <CAHVum0eQX8+HCJ3F-G9nzSVMy4V8Cg58LtY=jGPRJ77E-MN1fQ@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e6256bd5-ca11-13c1-c950-c4761edbcf4d@redhat.com>
Date:   Thu, 22 Apr 2021 09:47:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAHVum0eQX8+HCJ3F-G9nzSVMy4V8Cg58LtY=jGPRJ77E-MN1fQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/21 09:33, Vipin Sharma wrote:
> First of all, I am sorry that my patch series has caused this trouble to
> all of you. I am not aware of the correct way to submit a patch series
> which changes files in more than one maintainer's territory. Any
> guidance for the future will be helpful.

Vipin, don't worry as you don't have to do anything (and didn't do 
anything wrong, for that matter).  It's all in the maintainers' hands; 
Stephen takes care of warning maintainers of what will happen in the 
next merge window, but as far as you're concerned you're all set.

You can check the current state of the merge in the queue branch of the 
KVM tree.  This is what I plan to merge if Tejun agrees.  That would be 
helpful indeed!

Paolo

