Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9E03685B0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 19:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238495AbhDVRTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 13:19:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52764 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236660AbhDVRTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 13:19:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619111938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ADOjI+NtzKDREhR9XOqO3+4p2xANO5KAda5fRT3OdLc=;
        b=KDaZrGE+VgmYAgPul/Uq6muCvEAdNGhd4O55m55v9Yl1Q9/RLoqIhgAcDf4opXc3hHGgwy
        OXcCyYkdNosZ+2cz0DWq3wLi5cNvkXa87qKX8Bt9/7f+npSTkmDIr45Z7kYzvby6z3V91T
        pS8p/IF9fShne+xHsvAVPJy9E/l1SS4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-3Fi3hZLFPImCTXRgmhln7A-1; Thu, 22 Apr 2021 13:18:56 -0400
X-MC-Unique: 3Fi3hZLFPImCTXRgmhln7A-1
Received: by mail-ej1-f70.google.com with SMTP id k5-20020a1709061c05b029037cb8a99e03so7434129ejg.16
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 10:18:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ADOjI+NtzKDREhR9XOqO3+4p2xANO5KAda5fRT3OdLc=;
        b=ddQY9fXNXjkPOqUQZBrXOq3o1dkCoLkzatNHon/OoIzuw1ZvIheXVv1qxpDbpULwX5
         nhmPW8PRGJyJJBBXqZQUxAdlyVeceq1cMLvtedCEiwVA3sv8MCda9qaYHtyv/ADkFXE4
         il32vr0mXm3hOBx0n/cEfUNfmtjvLZdP8vCdLdwlCK3RUv67i2q9I7OTDZBuqrzayVZF
         PyB7AD4RoWx5qNvpUCc671eFQfIyk7cPXTS0UkQrcg0NXj8kB4FskztX8Ah/cL3n1wr0
         f5Azd2uMtbpFAQLLfXAixkqh/NzGUahRkddEp4S9JU/YZwBfqKzm1yFxI66LR6f156SM
         Sm9A==
X-Gm-Message-State: AOAM533jSKG8/9HNKUA9xOW9THlbZVkd8VscnPStY/bd/MTEXfeFFUeu
        18gy33dL3MV5xEsN4MOKnO/5aXQW/aRdo9ltoRJkNWnHwRFUv/huM8hwauLs1kIdDndbF3+GhlM
        dAAW9guJUhx2k+gGD/htE8IUj
X-Received: by 2002:a05:6402:2d1:: with SMTP id b17mr5102574edx.144.1619111935692;
        Thu, 22 Apr 2021 10:18:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyQSo2/UymAR9WwM02biqe3scYUkK5iwwA1J3Ltc5U9Mqbf8AqNusfTqBC3ujEmYEUpbdN3Bg==
X-Received: by 2002:a05:6402:2d1:: with SMTP id b17mr5102555edx.144.1619111935487;
        Thu, 22 Apr 2021 10:18:55 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id j9sm2563374eds.71.2021.04.22.10.18.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Apr 2021 10:18:54 -0700 (PDT)
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
 <e6256bd5-ca11-13c1-c950-c4761edbcf4d@redhat.com>
 <CAHVum0cVMd-SxmjKAJyJXO7SR68GKXQ7WTqyqWVfq1MMVd+oLQ@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <13e21724-bbe5-0fb0-82b6-35f87fe4c639@redhat.com>
Date:   Thu, 22 Apr 2021 19:18:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAHVum0cVMd-SxmjKAJyJXO7SR68GKXQ7WTqyqWVfq1MMVd+oLQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/21 19:09, Vipin Sharma wrote:
> On Thu, Apr 22, 2021 at 12:47 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>> You can check the current state of the merge in the queue branch of the
>> KVM tree.  This is what I plan to merge if Tejun agrees.  That would be
>> helpful indeed!
> 
> Merge looks fine from my patch perspective. However, one thing is missing:
> 
> In sev_guest_init() after sev_asid_free() call we should also write
> set sev->es_false = false.
> 
> Without this the main intent of Sean's patch will be missing in the merge.

So this:

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 3539201278bd..2632852be856 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -224,7 +224,7 @@ static int sev_guest_init(struct kvm *kvm, struct 
kvm_sev_cmd *argp)
  	sev->es_active = es_active;
  	asid = sev_asid_new(sev);
  	if (asid < 0)
-		return ret;
+		goto e_no_asid;
  	sev->asid = asid;

  	ret = sev_platform_init(&argp->error);
@@ -240,6 +240,8 @@ static int sev_guest_init(struct kvm *kvm, struct 
kvm_sev_cmd *argp)
  e_free:
  	sev_asid_free(sev);
  	sev->asid = 0;
+e_no_asid:
+	sev->es_active = false;
  	return ret;
  }


Sounds good, I'll squash it and push to kvm.git.

Paolo

