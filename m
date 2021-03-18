Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A536340D80
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 19:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbhCRSqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 14:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbhCRSqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 14:46:17 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9126CC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 11:46:17 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id g15so4119247pfq.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 11:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Bf0Dt0STxVme8E7nNHr9X3FypHJvzfOBAA6p3/VdKOs=;
        b=f4U7f0b0xTtH72mR0AURUneWkNYBzDnPg87aC2lPFJRIjbEVwaeJx1JvRtNRtvS2ib
         nTERXzmVPsbFXSraCX/EG1Cis+s1l4Nn+BiMAIOPcrLjS0HMgr+Rro4OLNbf6eyhiNN6
         1MbcvGkNuV0hUxMD4m/A3DLlfi5YEmRaBLujIL82wZjdgAqrcJNPc9KD+NEW/TXEhOmo
         HK0kXFcpzDREZoawv2//shVPXvrZLKF2nqlgY3gGEJh0IRmF+cZP7lg9BlNSICE2wDlI
         mrQ8VLTnwPAm/PdEUI2TK06Uc1NFVm3i4zxvD0UPtMohF+anAcDwsG0kWakBz/aRQ/Sg
         NRWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Bf0Dt0STxVme8E7nNHr9X3FypHJvzfOBAA6p3/VdKOs=;
        b=mvAogNmtZ0qPXj3h1mPMrw7wH+WKkfy8s/Uxe3Nx5Lt+00IUHsqfh2I43kA2TDyKp5
         LWJMpfs8pr+ZRZKMZRcTQHXAoXEeGm6vgCqXw9ltmSTJjPTcaT9eWKMFdmLQY7VDNCKN
         ox7bTD4xNYCwgYJuylRTdtmUvj+GsLZh3szzBZuzhn7gQShwK2DhE1yodKHKdSh7VY5K
         inzSUObAudKBUydPfq1lDWy5pRm5PEufAv/YLPK0AiTOwcfZV6vRhAC9C9g0IfBVO+Cj
         8VSSMeWTVyiYNGvyvjvH0ZBgHmoYW0bojTlDaQLPjfPg6H1bX7OateOnCHofM3exset2
         rpHQ==
X-Gm-Message-State: AOAM532kiJN917VxECNJ/NlDM0ZS0VhNH6YWwA15AujH2IfhTv1vYCB5
        SAitFbLmRiG9D3RE1NSAnWkz3A==
X-Google-Smtp-Source: ABdhPJwFxywHp7L5YJi90JSdTwq+RSG30E/0m9h/OlAzFFlrxlPlHWRYwoUGnnXZsl5VQFWZec+LCw==
X-Received: by 2002:a65:5543:: with SMTP id t3mr8130155pgr.275.1616093177008;
        Thu, 18 Mar 2021 11:46:17 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id c72sm3075133pfb.165.2021.03.18.11.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 11:46:16 -0700 (PDT)
Date:   Thu, 18 Mar 2021 18:46:12 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Andrew Jones <drjones@redhat.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/kvm: add get_msr_index_features
Message-ID: <YFOf9Jc3eFw6+dZX@google.com>
References: <20210318145629.486450-1-eesposit@redhat.com>
 <20210318170316.6vah7x2ws4bimmdf@kamzik.brq.redhat.com>
 <c08773f1-4b84-bb19-cda8-c8ac6ffffdaf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c08773f1-4b84-bb19-cda8-c8ac6ffffdaf@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021, Paolo Bonzini wrote:
> On 18/03/21 18:03, Andrew Jones wrote:
> > > 
> > >  TEST_GEN_PROGS_x86_64 = x86_64/cr4_cpuid_sync_test
> > > +TEST_GEN_PROGS_x86_64 += x86_64/get_msr_index_features
> > 
> > Maybe we should give up trying to keep an alphabetic order.
> 
> FWIW I had fixed that but yeah maybe we should just give up.

Never!  What if we make offenders wear a dunce cap at the next KVM Forum?
