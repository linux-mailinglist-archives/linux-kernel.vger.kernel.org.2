Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C340D362FFF
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 15:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236370AbhDQMqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 08:46:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28624 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236226AbhDQMqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 08:46:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618663552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UoC+7ilmBcEmJCJwQI3vwr6Z/+vKUfNZ6vKqvqIxm3s=;
        b=Za7CcH9bdoAWTdLm6gzjEKwH897YKQy9rtkGoUp5KSmV8LS9G62/dVv+P81DEscQ5VmhZO
        8PAzX6F+HQLiT0vZM6NE5lsClx/E68sboBkV4f3OJWNriIalVGHTd3iLX6c21oo1XgK+v0
        ThQpSIa98oU1/Y/Z6+pX8G4SEXGmATg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-go840eWiNiyfajdC7WAL3A-1; Sat, 17 Apr 2021 08:45:50 -0400
X-MC-Unique: go840eWiNiyfajdC7WAL3A-1
Received: by mail-ed1-f72.google.com with SMTP id ay2-20020a0564022022b02903824b52f2d8so8616092edb.22
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 05:45:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UoC+7ilmBcEmJCJwQI3vwr6Z/+vKUfNZ6vKqvqIxm3s=;
        b=msNsV7KE/2GdqJwaySVhNdC0xyfHNxHPfnzvDIMJ1aGotE9aFzoVCFBtDwNSES55qH
         pgkRGwcIqBQWaLpxNlpvOakBEUmzAsjdnYBq0JJMWI2ST0FfLqacNbeO0Q+NXWyERIsv
         HGZMJm49DblquJxJDRC44GfIaSYL6KAsKH8goGNBWaLpJ4j5yIOPaRJIqDHaaJ7NyTCA
         3XMm/qdqfUcCAx+rYy6B9DJAuyT2yjTuApGXZfPoZYnF3VaPqWm5NyIT4wbQVbOBkvO4
         e+XTsy15a5dEoM8RcNHQN2yiOyFXAv7FQEnBor3LcDmDWBXjy8K+vTb2xCGptY6R5CGH
         STLg==
X-Gm-Message-State: AOAM531qndsjLBLflq94j21PAC9CfOnB2IYaRNbth3WZRR2ak7yER92z
        BXmHYOhsGX97zsjQoMABMuYIG9R29YbvJ5Ehu+unEmANLk39Ocgpg4PnP3LBi1Lb6rJQlLpixcJ
        2p34RkKGRbaKlLdjF4JkazcI/lFTv7WPPPV2cilQmEUmvUT9HLQts3Dwo6tGsqdoQlX4XmYGjG3
        qy
X-Received: by 2002:aa7:d541:: with SMTP id u1mr15332144edr.95.1618663549302;
        Sat, 17 Apr 2021 05:45:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxu3V/xkz7i5j8tGWXxBT3bekNVADAjTz8NvcTBB8JDHTTw3q/brCheVYPsMy6PHSOwStAGew==
X-Received: by 2002:aa7:d541:: with SMTP id u1mr15332118edr.95.1618663549034;
        Sat, 17 Apr 2021 05:45:49 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id t15sm7530395edr.55.2021.04.17.05.45.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Apr 2021 05:45:48 -0700 (PDT)
Subject: Re: [PATCH v2 8/8] KVM: SVM: Allocate SEV command structures on local
 stack
To:     Borislav Petkov <bp@suse.de>,
        Sean Christopherson <seanjc@google.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210406224952.4177376-1-seanjc@google.com>
 <20210406224952.4177376-9-seanjc@google.com>
 <9df3b755-d71a-bfdf-8bee-f2cd2883ea2f@csgroup.eu>
 <20210407102440.GA25732@zn.tnic> <YG3mQ+U6ZnoWIZ9a@google.com>
 <20210407173407.GB25732@zn.tnic>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <32b9a108-c7f8-885b-9cee-783d63aea794@redhat.com>
Date:   Sat, 17 Apr 2021 14:45:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210407173407.GB25732@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/21 19:34, Borislav Petkov wrote:
> On Wed, Apr 07, 2021 at 05:05:07PM +0000, Sean Christopherson wrote:
>> I used memset() to defer initialization until after the various sanity
>> checks,
> 
> I'd actually vote for that too - I don't like doing stuff which is not
> going to be used. I.e., don't change what you have.

It's three votes for that then. :)

Sean, I squashed in this change

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index ec4c01807272..a4d0ca8c4710 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -1039,21 +1039,14 @@ static int sev_get_attestation_report(struct kvm *kvm, struct kvm_sev_cmd *argp)
  static int sev_send_cancel(struct kvm *kvm, struct kvm_sev_cmd *argp)
  {
  	struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
-	struct sev_data_send_cancel *data;
+	struct sev_data_send_cancel data;
  	int ret;
  
  	if (!sev_guest(kvm))
  		return -ENOTTY;
  
-	data = kzalloc(sizeof(*data), GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
-
-	data->handle = sev->handle;
-	ret = sev_issue_cmd(kvm, SEV_CMD_SEND_CANCEL, data, &argp->error);
-
-	kfree(data);
-	return ret;
+	data.handle = sev->handle;
+	return sev_issue_cmd(kvm, SEV_CMD_SEND_CANCEL, &data, &argp->error);
  }
  
  int svm_mem_enc_op(struct kvm *kvm, void __user *argp)

to handle SV_CMD_SEND_CANCEL which I merged before this series.

Paolo

