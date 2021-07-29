Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFF1C3DA04D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 11:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235661AbhG2Jdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 05:33:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24583 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235546AbhG2Jdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 05:33:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627551217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=md6Oc7TeV7HG+jATakLwy9ixrHl66kXuQgl0GJ9Fitg=;
        b=ZTWYpuHgZGyHGg+za5uB4A9h7VmCU3/kE+p1mgm5UEN/6Bq0BGa3Qf+ESw5H8j/q0vc4N6
        4JZTmpkJw1IIjM2AR556L3Tmkh9FXMIsXVENMoeKViWJoTDQI+1//pqtq9EnFOWR3B8M8x
        5qCkNkFtt7VEPcgAKMhsYEBJwRCPcPQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-ODZMtwbkM9qWz6udD2LvkQ-1; Thu, 29 Jul 2021 05:33:35 -0400
X-MC-Unique: ODZMtwbkM9qWz6udD2LvkQ-1
Received: by mail-ed1-f72.google.com with SMTP id b13-20020a056402278db029039c013d5b80so2674712ede.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 02:33:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=md6Oc7TeV7HG+jATakLwy9ixrHl66kXuQgl0GJ9Fitg=;
        b=PTCha6WWPkCcL8uiTMcE+s7/HkR2tpNSpbw2sc3vQ6ZhvyUdS3IJvrmrsJRvhcN5lf
         KG4kQWI9wTeNFQWdbLk2p2x+TFV4Qibbdo+ybmcgM3dXI+P7ZEeijPGxLWNAkthN23cf
         1/+6MIYnrdvzfPaYRec3ngzrM8WLNnGBq47uEHsDF3aZLviLMjY8tbWQii7dx70nPA5p
         +ZOVJyEZ+yxxrMX6ITF0xlTzA7oELavrKQdB9Meut4l/CXIIZFRBPAzqMtXaewJI9kUf
         f62OGi1FAiFGw7T62I1KPX7iuxzaVRzIPV33r7W5xzf6RHvU8zDHkp6Odx/4yvCyNNXV
         5Kaw==
X-Gm-Message-State: AOAM530+asc0EYA5H2QNqFoHbomwpqWNCXc7qsf4u0gjNdhY0pSjfDlU
        Wb5u0gKN8WiSnowKbNgKVmgBEr378SARKuXy+EDoXQCvW+7+g5Rdk3yZRpmVr9z5eERDC6zbse7
        KjTFTtnbLc5kf8rKubXQdXCUc
X-Received: by 2002:a05:6402:221c:: with SMTP id cq28mr4957593edb.115.1627551214267;
        Thu, 29 Jul 2021 02:33:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzWtYyeEsKK8QG2q57jEd8WiiG65QrD/ajD03X4+P7WkyzcEeGdZ/zqOSInTNjlj7S2BmXcEg==
X-Received: by 2002:a05:6402:221c:: with SMTP id cq28mr4957587edb.115.1627551214144;
        Thu, 29 Jul 2021 02:33:34 -0700 (PDT)
Received: from [192.168.10.118] ([93.56.169.140])
        by smtp.gmail.com with ESMTPSA id i11sm951152eds.72.2021.07.29.02.33.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jul 2021 02:33:33 -0700 (PDT)
Subject: Re: [PATCH v2 8/9] KVM: X86: Optimize pte_list_desc with per-array
 counter
To:     Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
References: <20210625153214.43106-1-peterx@redhat.com>
 <20210625153415.43620-1-peterx@redhat.com> <YQHGXhOc5gO9aYsL@google.com>
 <YQHRV/uEZ4LqPVNI@t490s>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dc9eb6da-59ce-2dd3-c39c-8348088cadcb@redhat.com>
Date:   Thu, 29 Jul 2021 11:33:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YQHRV/uEZ4LqPVNI@t490s>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/21 23:51, Peter Xu wrote:
> Reasonable.  Not sure whether this would change the numbers a bit in the commit
> message; it can be slightly better but also possible to be non-observable.
> Paolo, let me know if you want me to repost/retest with the change (along with
> keeping the comment in the other patch).

Yes, feel free please start from the patches in kvm/queue (there were 
some conflicts, so it will save you the rebasing work) and send v3 
according to Sean's callbacks.

Paolo

