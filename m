Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9BB34FC95
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 11:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234568AbhCaJWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 05:22:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35414 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234577AbhCaJWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 05:22:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617182524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zVTROcBb9bzk8v36Iv2BqaLwng0q/XnAhHIMpKNn/Ys=;
        b=J7OQhVGOOFbTrGOOalIS61arlTXGZTMGd+Pp2qw+5dNfaKNe0yJ95hBbc4cGQa+xZcnfhL
        PEY0DJQa6i/rxbmZX6xgITlBrjaPfi5je2wAKQh8btuTABKK/iWOkOzdxypdR3GKdV95OM
        N4jboCb3HOuPojYhKJgAZIuSmgXIqBs=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-hUcwV68kOuOfYPJGhU8rKw-1; Wed, 31 Mar 2021 05:22:02 -0400
X-MC-Unique: hUcwV68kOuOfYPJGhU8rKw-1
Received: by mail-ed1-f70.google.com with SMTP id y10so770907edr.20
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:22:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zVTROcBb9bzk8v36Iv2BqaLwng0q/XnAhHIMpKNn/Ys=;
        b=dJxw0LaJOyoVLwZ9dQHzishrnCAa+y1ausvEdBW8TZdNhqpXZ8pvgbJJuj2jY6pxnk
         vbX0kGFamNUED5QKY0v8XKZ18f6e7Qh/pjMKdGAucCv3kYMvkmcYmwD/Sall0RMntQX0
         uapANU12pFsVmJzU/TvrTLAk2YNRya39/EL3MzF9RptQaWCVSxlkuJB3H3Sx2NZSXsWG
         TF9Sm8wphN3L0y1X6ea4xG7BHJf941QDJJK4soEf9EszmaoEYEqKiG3Pw+8KqG35TFjZ
         2DiMDpuPlGawEw4u5K7OX4rgw4S/ftTVjIzQfQkl/7kdN4Eyo0gFYJw47+a2Kuvu3rnu
         SImg==
X-Gm-Message-State: AOAM532wVbZkJsOdkYw9iYeELNzfmLmV8J2C4N23Z+IT2YnTx6Kf6QF9
        eU8+MhXkluFpEqyj8OQbbNop7OmKryjFi692nl/DqK7sTs1iQ/v9UqI/XSmJ1OHSd/RSvExPbZc
        LIoCQUU9lal9sv17B6naU67FqLlmkLs86vxErAnWuNgAJg5qKO45bVI+DsgISLOr/BZeD5SyxjA
        VI
X-Received: by 2002:a17:906:26c9:: with SMTP id u9mr2490747ejc.520.1617182521439;
        Wed, 31 Mar 2021 02:22:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKa9uTF2uTziE05IHjX/X7hZq3YmL9WZwLFu1Pz7aA1dpsCjRo6rR9QXD1luH8TZAUg/dkxw==
X-Received: by 2002:a17:906:26c9:: with SMTP id u9mr2490728ejc.520.1617182521264;
        Wed, 31 Mar 2021 02:22:01 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id q19sm786118ejy.50.2021.03.31.02.21.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Mar 2021 02:22:00 -0700 (PDT)
Subject: Re: [PATCH v16 00/17] KVM RISC-V Support
To:     Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Graf <graf@amazon.com>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        KVM General <kvm@vger.kernel.org>,
        kvm-riscv@lists.infradead.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
References: <20210115121846.114528-1-anup.patel@wdc.com>
 <mhng-a4e92a0a-085d-4be0-863e-6af99dc27c18@palmerdabbelt-glaptop>
 <CAAhSdy0F7gisk=FZXN7jmqFLVB3456WunwVXhkrnvNuWtrhWWA@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a49a7142-104e-fdaa-4a6a-619505695229@redhat.com>
Date:   Wed, 31 Mar 2021 11:21:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAAhSdy0F7gisk=FZXN7jmqFLVB3456WunwVXhkrnvNuWtrhWWA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/03/21 07:48, Anup Patel wrote:
> 
> It seems Andrew does not want to freeze H-extension until we have virtualization
> aware interrupt controller (such as RISC-V AIA specification) and IOMMU. Lot
> of us feel that these things can be done independently because RISC-V
> H-extension already has provisions for external interrupt controller with
> virtualization support.

Yes, frankly that's pretty ridiculous as it's perfectly possible to 
emulate the interrupt controller in software (and an IOMMU is not needed 
at all if you are okay with emulated or paravirtualized devices---which 
is almost always the case except for partitioning hypervisors).

Palmer, are you okay with merging RISC-V KVM?  Or should we place it in 
drivers/staging/riscv/kvm?

Either way, the best way to do it would be like this:

1) you apply patch 1 in a topic branch

2) you merge the topic branch in the risc-v tree

3) Anup merges the topic branch too and sends me a pull request.

Paolo

