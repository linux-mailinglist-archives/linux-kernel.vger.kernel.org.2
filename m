Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93724324F29
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 12:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235529AbhBYL26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 06:28:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53549 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235256AbhBYL2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 06:28:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614252414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sWESMD0nckHAI0xFpXZL4oIkaF2/ZscfrAoYu7OfI+w=;
        b=LbssIS6RXN08uAPydQKG5f46Ql2Y18zrewLfWv0NgkBtqFS2GKKJzN+Yo1x0Hc9mMrHfDG
        jxLOnPvw1pDQDLeuOHs+UeX4Y8JFDAUCqzmpgmj+9q3q33B8KmO2Pjo29vL/BxpLtV4lFY
        MHmct2hw6ADJrgbjOKnI5WaaYcg++qY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-571-CHxn0uKQNQi73Q05q8DeMQ-1; Thu, 25 Feb 2021 06:26:52 -0500
X-MC-Unique: CHxn0uKQNQi73Q05q8DeMQ-1
Received: by mail-ej1-f70.google.com with SMTP id b15so2294284ejv.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 03:26:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sWESMD0nckHAI0xFpXZL4oIkaF2/ZscfrAoYu7OfI+w=;
        b=eQyaFmJnXDWpjB+k8bwotaW/HkX/ZPY4geQu+4GKJh8iZlEX1lcdMNO2jZ6wkQFmbb
         Hs8GzAeRu8Q6e8RLmZCl+RmSEdogKeyM67J1O3T+m1e+cEyvoptAR7el2cTOtsnSads/
         3+XD6SNK16stIxVKvQxsHZ5jZt3RuVR3LbU+rWxkJ/sH+vt4DwmROxuqq2/jW1JqB/Gs
         CtgUiYZg/lBUIVj0IURoTRlQcY/A1X9pJkvQ09bucAqnhI9GSPeTHIx02GbHGn6kSYZH
         OYODwKQhnJqHcosyKGj6XCzKPci8fm2/lJveAKUbSphX+1yEpeCMoCyc7NwQ4a4mQ5kU
         AcWw==
X-Gm-Message-State: AOAM533XcB1TzpwVwtqSQrhPi9lE58l630CszjDW9ARni7VtY1XzIhN0
        oDaZCqLLBKa8e1v8Ek7pmjvfp3eaTiP6YNazY2ACw7uVuCMbgdrKJQ39mf5817s8IRSiIfhBpGR
        UTJO/wZ56gN3jQtf/6TfqVnB9
X-Received: by 2002:a17:906:2b0a:: with SMTP id a10mr2214740ejg.513.1614252411243;
        Thu, 25 Feb 2021 03:26:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz+FV6cFCWq34Zp4VXzSaCx9CjsJto7qwRC97dXBeI5c95SCD9qPGVFJCozP5ss3voP39HZCA==
X-Received: by 2002:a17:906:2b0a:: with SMTP id a10mr2214723ejg.513.1614252411050;
        Thu, 25 Feb 2021 03:26:51 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id dm20sm3237866edb.59.2021.02.25.03.26.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Feb 2021 03:26:50 -0800 (PST)
Subject: Re: [RFC] KVM: x86: Support KVM VMs sharing SEV context
To:     Sean Christopherson <seanjc@google.com>
Cc:     Nathan Tempelman <natet@google.com>, thomas.lendacky@amd.com,
        x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        srutherford@google.com, rientjes@google.com, brijesh.singh@amd.com,
        Ashish.Kalra@amd.com, Nathaniel McCallum <npmccallum@redhat.com>,
        Marc Orr <marcorr@google.com>,
        "Hyunwook (Wooky) Baek" <baekhw@google.com>
References: <20210224085915.28751-1-natet@google.com>
 <04b37d71-c887-660b-5046-17dec4bb4115@redhat.com>
 <YDaFtRUAZ+P6Nrpy@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d01c686b-45e0-836a-e144-4330c46f4d42@redhat.com>
Date:   Thu, 25 Feb 2021 12:26:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YDaFtRUAZ+P6Nrpy@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/02/21 17:58, Sean Christopherson wrote:
> That being said, is there a strong need to get this into 5.12?  AIUI, this hasn't
> had any meaningful testing, selftests/kvm-unit-tests or otherwise.  Pushing out
> to 5.13 might give us a good chance of getting some real testing before merging,
> depending on the readiness of SEV testing support.

Note that I don't mean including this in the merge window.  However, I 
know that there are multiple people working on alternative SEV live 
migration support, and as long as we are sure that the API is simple and 
useful, it should be okay to merge this for rc2 or rc3.

Paolo

