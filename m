Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 884044045E0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 08:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351328AbhIIG52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 02:57:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34409 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236180AbhIIG51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 02:57:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631170577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qscILqSOiDtHr2K06miwU5XrXdXBp14iQB45BddDnqs=;
        b=Pi9IH1dd2snhxt33vMQURL0Q6o0jDjkJZMBo8k6Mz5Xcnzvj0Ym8mU3uH8FgEo4qIj6KPq
        CtKHd0WcV6nLStStidN/Trj2raBHqngalcxGE8zmxG4Z0Ij7sd3E0MqfqWGwDBbMiYni+V
        34kdSCZqf656uxr5PN0JcJBe7le+GdM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-q4F7_JQlOOaaa3T-yHgU1A-1; Thu, 09 Sep 2021 02:56:16 -0400
X-MC-Unique: q4F7_JQlOOaaa3T-yHgU1A-1
Received: by mail-ed1-f70.google.com with SMTP id o11-20020a056402038b00b003c9e6fd522bso463168edv.19
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 23:56:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qscILqSOiDtHr2K06miwU5XrXdXBp14iQB45BddDnqs=;
        b=w3E+AUeAtqsJLeccxtDX0YUw3O8A0cN1NDOVZX0MhEHIEuodybtHksfuU/34/Sc5Fa
         m2r/4RQ6d/ExkcgFwlQ3Tet6k+ccNn+moL6AlTBvF+GO7VgyOo4pYYD/J7ijJaMeXcK4
         GoJ27ikYHQ+2VGuhOb/EuQbhWC+gWtuksWmP4YkVuJYvdCWRCWi8VHCOma/BWoJSkweq
         S9bpH2VdVbkVzqPuIAXYWrRSoNOysjDfB4YMLIZcKax37g9dP0bmJ/pO8O/AdYYgB+9G
         oOiHi2zbbmfNIXo8OWsTDAGOIXyhTWCbOoPy3zzfaJsh0R4gVrnbXZjGFvJViwM5d7n2
         qWFA==
X-Gm-Message-State: AOAM533c/xhMlpYybBJOU4NuJ25Nd1HYNWeO2nb3VvLy4hdeKi4crLcW
        fUFCAZba9uzLpkFuX5Hq55H9aAua3o7dWVKs8v0MAnxyuoVpAi1ywU8ViwANXyZuYP7IQcPFk1w
        Ie0m5PG1sTLdPN10UMXrfZvL2
X-Received: by 2002:a17:906:adb:: with SMTP id z27mr1768632ejf.235.1631170575550;
        Wed, 08 Sep 2021 23:56:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzpo2+DqJ1Q+SdKK5uQrU7ZDb5hL1qYXbG3ULjiHa/exReDGCf5X1iUjVNkVgI9sq45uc1HcA==
X-Received: by 2002:a17:906:adb:: with SMTP id z27mr1768615ejf.235.1631170575371;
        Wed, 08 Sep 2021 23:56:15 -0700 (PDT)
Received: from gator (cst2-174-132.cust.vodafone.cz. [31.30.174.132])
        by smtp.gmail.com with ESMTPSA id c21sm381830ejz.69.2021.09.08.23.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 23:56:15 -0700 (PDT)
Date:   Thu, 9 Sep 2021 08:56:12 +0200
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
Subject: Re: [PATCH v4 03/18] KVM: arm64: selftests: Use read/write
 definitions from sysreg.h
Message-ID: <20210909065612.d36255fur5alf6sl@gator>
References: <20210909013818.1191270-1-rananta@google.com>
 <20210909013818.1191270-4-rananta@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210909013818.1191270-4-rananta@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2021 at 01:38:03AM +0000, Raghavendra Rao Ananta wrote:
> Make use of the register read/write definitions from
> sysreg.h, instead of the existing definitions. A syntax
> correction is needed for the files that use write_sysreg()
> to make it compliant with the new (kernel's) syntax.
> 
> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> ---
>  .../selftests/kvm/aarch64/debug-exceptions.c  | 28 +++++++++----------
>  .../selftests/kvm/include/aarch64/processor.h | 13 +--------
>  2 files changed, 15 insertions(+), 26 deletions(-)
>

Same comment as Oliver, otherwise

Reviewed-by: Andrew Jones <drjones@redhat.com>

