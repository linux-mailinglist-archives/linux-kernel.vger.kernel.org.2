Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18B1D439ACA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 17:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbhJYPu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 11:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbhJYPuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 11:50:51 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D28C061767
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 08:48:29 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id q2-20020a17090a2e0200b001a0fd4efd49so214233pjd.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 08:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0lZC/4YVNiq6m54gciVPWUG9HJx9IWHvMOAiOdASGoo=;
        b=QyfrOXYXYzIEyrLD44pl5e5qrBHvKskln3PRReuWzpAgV2++kLJzI050rqe2oVwX2v
         /YSSz3klIowpfUugVLMls4E5ALzM885A+JjaGYEd8dI6xPFGzSKWWGCwhTUoU1wJJ2+4
         q6QXjhMZdsCR4vmwSFpvR/7/SOjlriEKOoj6W/QPj/mWp9yfleITVSt3gv9SSl80X7Ip
         BvJTrYEOJKTHV3pbSlO8IHWn3hT4T3KR9LJVANxEXG1UOo91F4D+Bcp+BL0MB5OCLaKP
         Mo/ai6V2iZC0VqjsN2MnwKzxW/qxPY5ehn5rtVsOHSmvZ7PywSIV88EiySKFBzouQ+tc
         9/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0lZC/4YVNiq6m54gciVPWUG9HJx9IWHvMOAiOdASGoo=;
        b=N0xtWbYh6annShsBoJhRmBWo7DKdYLsOE9Ndotgac1VWzKwFh+WQ3BPzNKMiz0jTNw
         YiBiHYC3fxEQ7y74Mk8redMGvqx03Ou4z/Si7GJ60kFF+36R9o/DT1iUqzq+sIGHxNkD
         HkZfY+SBInODqy+7VY7U8LamnpYwyfkIrvfDfu0YR/CzbTWs3SbVgdV49BmS5sDKua1U
         Gv8MNOuEFfA670mgnBHp2hj4xKhAAnnqSgW8A3GMw0Dc8CJA4RkSNj4maHA9fbjajpW8
         +PTlFMafO/eWyqqdj/GkaN1+UAr1fqlYt2UEWpFiDVq7PlOCEic6XkEdB72Wz8vSNWdw
         uJPQ==
X-Gm-Message-State: AOAM533dXKYFs0wgTqeEqkE1NQnYRvVDT99kfdQCUUYbpnulD/tvdd+F
        bi9aSZuKCMbzs2xO2Mvc6S5Zyg==
X-Google-Smtp-Source: ABdhPJxrKJ5kv/isPaW6TJ/VoEghKiV6FVNK9Q5PXIGPB6cKE19gMMU7U+s4ZFt4KBH5EHg4mjv+Qw==
X-Received: by 2002:a17:90a:bf0e:: with SMTP id c14mr5921807pjs.180.1635176908950;
        Mon, 25 Oct 2021 08:48:28 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id g5sm11457677pfc.65.2021.10.25.08.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 08:48:28 -0700 (PDT)
Date:   Mon, 25 Oct 2021 15:48:24 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Marc Zyngier <maz@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Anup Patel <anup.patel@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Atish Patra <atish.patra@wdc.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-mips@vger.kernel.org, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Matlack <dmatlack@google.com>,
        Oliver Upton <oupton@google.com>,
        Jing Zhang <jingzhangos@google.com>
Subject: Re: [PATCH v2 37/43] KVM: SVM: Unconditionally mark AVIC as running
 on vCPU load (with APICv)
Message-ID: <YXbRyMQgMpHVQa3G@google.com>
References: <20211009021236.4122790-1-seanjc@google.com>
 <20211009021236.4122790-38-seanjc@google.com>
 <acea3c6d-49f4-ab5e-d9fe-6c6a8a665a46@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acea3c6d-49f4-ab5e-d9fe-6c6a8a665a46@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021, Paolo Bonzini wrote:
> On 09/10/21 04:12, Sean Christopherson wrote:
> > +	/* TODO: Document why the unblocking path checks for updates. */
> 
> Is that a riddle or what? :)

Yes?  I haven't been able to figure out why the unblocking path explicitly
checks and handles an APICv update.
