Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5265D4045F3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 09:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352362AbhIIHJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 03:09:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58231 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350954AbhIIHJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 03:09:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631171271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O79oda6oITB+svfgMKtqjlq0+9nk7Bi2GmbowOW2Zec=;
        b=aoXZvNBQGMeoAizpgdYOoMHglwirweX/MOiQLBghU4dmXJWE6+3DiuPCuI2Cocvtjm6dst
        n5QdWn2p1BGy9FMDD/z3rAdai6MwGILIMchUx1wAG+07Tq7sbos3DzvyjDbFs7i9kU1UGW
        XrNO/Dl9efnv6nPdTg2U4ZviU0x/jKg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-u8tL0J09MtaxXEuBJ7xujw-1; Thu, 09 Sep 2021 03:07:50 -0400
X-MC-Unique: u8tL0J09MtaxXEuBJ7xujw-1
Received: by mail-ej1-f71.google.com with SMTP id ne21-20020a1709077b95b029057eb61c6fdfso310134ejc.22
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 00:07:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O79oda6oITB+svfgMKtqjlq0+9nk7Bi2GmbowOW2Zec=;
        b=QDzo8cFQmn6YKWcc3qllPL1U1jQPeeA634XWFt25nB7nQO9VINEUwYRIYsxP7I8qV2
         FmQ0TPi+1Q2/tsYL3fHPd2In6jfsPy+sd9L/HYtgwUSsatz0gfHL997/9BWGs05rUl3w
         n6wCdc9XTCu4LYeMYWZvyetOhBS/rxhgH/56M2Q+gkxmVgBJlpHgBkWHyphC576OZDUV
         nusBsypfbRF5uRsCu3hLKNUCqmR5L3BSPDnsvLfcqc9WEeo2YltSJF4V4hPC/X7+5JWw
         QWJEEH1alvlaeVWcLECmMrtluVxIWC+bkuVhjxtoSbnnZCCENyZLli/3ZtQZLhoz1rIQ
         s8mg==
X-Gm-Message-State: AOAM531rClzEgSXMl1ZtxEUYoCMaN56Q4uppqR/lLdwfYetrajgPg1MJ
        duwHCizBJ47HmnVi9AMWDnpPBaqJVfUIfTQcv9XcABZDByBDPv+Ujlyor32fgRDPy3LJlWGVxtL
        7f+4Wzp3EomHeuHa4tHe55OfD
X-Received: by 2002:a17:906:51d4:: with SMTP id v20mr1836653ejk.9.1631171269422;
        Thu, 09 Sep 2021 00:07:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzWLGtXgDgvvwtsziSdTGYQx3QchauqHAmrovAlFNC3f5RBpcB0TkK+8vK0bXB5KE9/b8E1Hg==
X-Received: by 2002:a17:906:51d4:: with SMTP id v20mr1836629ejk.9.1631171269284;
        Thu, 09 Sep 2021 00:07:49 -0700 (PDT)
Received: from gator (cst2-174-132.cust.vodafone.cz. [31.30.174.132])
        by smtp.gmail.com with ESMTPSA id s18sm425034ejh.12.2021.09.09.00.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 00:07:49 -0700 (PDT)
Date:   Thu, 9 Sep 2021 09:07:47 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Raghavendra Rao Ananta <rananta@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Peter Shier <pshier@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Oliver Upton <oupton@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v4 06/18] KVM: arm64: selftests: Add basic support for
 arch_timers
Message-ID: <20210909070747.5vgud3ssccpo7z2o@gator>
References: <20210909013818.1191270-1-rananta@google.com>
 <20210909013818.1191270-7-rananta@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210909013818.1191270-7-rananta@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2021 at 01:38:06AM +0000, Raghavendra Rao Ananta wrote:
> Add a minimalistic library support to access the virtual timers,
> that can be used for simple timing functionalities, such as
> introducing delays in the guest.
> 
> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> ---
>  .../kvm/include/aarch64/arch_timer.h          | 142 ++++++++++++++++++
>  1 file changed, 142 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/include/aarch64/arch_timer.h
>

Reviewed-by: Andrew Jones <drjones@redhat.com>

