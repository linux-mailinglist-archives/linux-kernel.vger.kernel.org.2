Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF0A4141D5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 08:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbhIVGab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 02:30:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:56581 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232670AbhIVGaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 02:30:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632292140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pJ7mY3KGJnt0GGObf9665ZCn7DQvGIxKlz9Hgzfe7VE=;
        b=Ah6F7aW5/exccYXC1OVMx5XAUJSgBfMU9UjQW3vy82NGWuB7IHHWUbst15q9aKgbi61m1R
        6xtU221qIfogFbksD81bH4UyMgm0TgzITsoPmxn35yTy+dSFgwUZI+QluwQbcauAFBXG8n
        5gL0qX9f/vf+qoNQX5SPW2JkhnRz5lI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-LHZYwT6oOZCqoq-Xv1gLvg-1; Wed, 22 Sep 2021 02:28:58 -0400
X-MC-Unique: LHZYwT6oOZCqoq-Xv1gLvg-1
Received: by mail-wr1-f70.google.com with SMTP id c15-20020a5d4ccf000000b0015dff622f39so1106934wrt.21
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 23:28:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pJ7mY3KGJnt0GGObf9665ZCn7DQvGIxKlz9Hgzfe7VE=;
        b=d9N9W+2EZlPXJXOfOLQueVYfiNFgCF4nht9Qrwacj79QDSu0SO2wUesockoiOd06L/
         DbHyjSslS0+xII4pVP/I/kREjKZFNMegMV8Aq1l584mlTsRuUF3JjUEIKoVZurBcsLgw
         Sx7odn2lLFhVFUuRnIzayWvPGhmaPY5nIac4aycw49nAFeD713c8XpBv3syTrGjlTXei
         gkX9KRgi1ixUIoqeX3bkop5p720XpxOkaR0jymb5q7YjwUuu3otEqvZey4Gi1uwQdDuW
         RdZQ0TtuF9/qWIVMriy04hb8NzU4T0mwAW6hFUauBdqaNX9HAVK08+sDQtB6uLsdrc1x
         F2VQ==
X-Gm-Message-State: AOAM530dSOX6mQ8zTcdEQWRkgUWA/S29+UMMGCzjBiHlvxvPbV5DJJoJ
        zoj8gaLYFN3/9WvvLnHxL1CyrdNuqKs2gGTUf/Zh6E1DW+qSEzth1hRyYDUw8de1mW4jDOkwmYW
        WEmKdT876zNLG4jAHN/LYhzuH
X-Received: by 2002:a05:600c:3ba4:: with SMTP id n36mr8722436wms.35.1632292137445;
        Tue, 21 Sep 2021 23:28:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzGUh0clwu4unN1cIXXPNEQKf8qlYc4JIONnRibnq73sMmW8cPrqysrS+MXk+0qjWI0DZnAvw==
X-Received: by 2002:a05:600c:3ba4:: with SMTP id n36mr8722395wms.35.1632292137204;
        Tue, 21 Sep 2021 23:28:57 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id i18sm1136021wrn.64.2021.09.21.23.28.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 23:28:56 -0700 (PDT)
Subject: Re: [PATCH v3 06/16] perf/core: Rework guest callbacks to prepare for
 static_call support
To:     Sean Christopherson <seanjc@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, Guo Ren <guoren@kernel.org>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, linux-csky@vger.kernel.org,
        linux-riscv@lists.infradead.org, kvm@vger.kernel.org,
        xen-devel@lists.xenproject.org,
        Artem Kashkanov <artem.kashkanov@intel.com>,
        Like Xu <like.xu.linux@gmail.com>,
        Zhu Lingshan <lingshan.zhu@intel.com>
References: <20210922000533.713300-1-seanjc@google.com>
 <20210922000533.713300-7-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6636ab49-e21c-601f-9d2c-34e681c14faa@redhat.com>
Date:   Wed, 22 Sep 2021 08:28:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210922000533.713300-7-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/09/21 02:05, Sean Christopherson wrote:
> To prepare for using static_calls to optimize perf's guest callbacks,
> replace ->is_in_guest and ->is_user_mode with a new multiplexed hook
> ->state, tweak ->handle_intel_pt_intr to play nice with being called when
> there is no active guest, and drop "guest" from ->is_in_guest.

... from ->get_guest_ip.  Code-wise,

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

