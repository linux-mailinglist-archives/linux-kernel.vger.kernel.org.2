Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D57CD4141FF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 08:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbhIVGjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 02:39:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51194 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232718AbhIVGjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 02:39:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632292700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z3XTCa1nu8hCtlYTFFK2GZognBOtLDAkX/kYxcYF1XA=;
        b=DYR/cNYjYXx0ukC/9ghCQ44fMKmGf4EmHP54m3+KELovum0qTcLDOKnDi2hEmzViIjpX21
        HFCodzhVpFmWdtnp2MqpEKrqs+nsEDUdBfT0UZ1NTDzcQYTF6Z0iLqI24GuG2QTaEKtuwN
        cs3HIsVqwqgI4DMQTgjKzqTbIRJXDu4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-CFq32KV0My62Ze-qr0UW3A-1; Wed, 22 Sep 2021 02:38:18 -0400
X-MC-Unique: CFq32KV0My62Ze-qr0UW3A-1
Received: by mail-wr1-f70.google.com with SMTP id z2-20020a5d4c82000000b0015b140e0562so1175755wrs.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 23:38:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z3XTCa1nu8hCtlYTFFK2GZognBOtLDAkX/kYxcYF1XA=;
        b=xJvhw8XZ13EJTaFP+McxJ8i8Y6SH80OI6WkI7k5wriQTViOx1hVTHot1Abf6k7luRZ
         Wiw8tKwhOrTc7qPomEKvuGt+sqldXbU4YLWycQdfP2F2KQRLqx1Exq1D2sf9VGGA97aQ
         g52wg95KiZJY9aW3TEIxR8/RETNryhvYhVztx2sqRaVMq8zJdC6c8NfJLgigmyX00tHb
         Y6xwS2uO5kJzPyorzc9q+vjAfHPK2bNZcENoI+0OTNU27of/XxroFslU5wBf1T5x5rEY
         S9Y8GoKJ3hjA5x+CQ2xTpLIXuqRTDXIET+atKODNXD9fHXjbOkEmdi7qbX8ElCxr3qaA
         LWHQ==
X-Gm-Message-State: AOAM533IxPjfwjvMGwBSBfQae17ABZksdbVcIvLZ9a7zFMFAOPzlvDRN
        TCCdv5rBuQXk8jMjt/6siPjKv02VT5twh9DTxZ3sFcWJ0gueY153eqxd7XLFETMTRZ0ieM1N/Jx
        g1H2fcCs7Id5+ELQw0LzMLxOx
X-Received: by 2002:a05:600c:21c8:: with SMTP id x8mr8614019wmj.163.1632292697325;
        Tue, 21 Sep 2021 23:38:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJywCmZIrNrFYOLYwz4uLurAI8KkuEnxjxQSJf2bjooMgzy2h0qoOTiWQbU4UgbH2lcfc2iQrA==
X-Received: by 2002:a05:600c:21c8:: with SMTP id x8mr8613976wmj.163.1632292697089;
        Tue, 21 Sep 2021 23:38:17 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id j21sm1162153wrd.48.2021.09.21.23.38.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 23:38:16 -0700 (PDT)
Subject: Re: [PATCH v3 11/16] KVM: x86: More precisely identify NMI from guest
 when handling PMI
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
 <20210922000533.713300-12-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d444303f-7ee5-7ddc-8eae-64d1e6d4862a@redhat.com>
Date:   Wed, 22 Sep 2021 08:38:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210922000533.713300-12-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/09/21 02:05, Sean Christopherson wrote:
> Note, this also doesn't completely prevent false positives if perf
> somehow ends up calling into KVM, e.g. an NMI can arrive in host after
> KVM sets its flag.

s/calling into KVM/being called from KVM/ ?

Not sure about what you meant though.  The code is nice, so

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo

