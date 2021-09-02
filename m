Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23A543FF365
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 20:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347120AbhIBSrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 14:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347119AbhIBSrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 14:47:05 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF69CC061757
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 11:46:06 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id gp20-20020a17090adf1400b00196b761920aso2165103pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 11:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RJjkaPdtlOJqSnXq7mSfygXQwnXxIuqzSEg1pz6exPQ=;
        b=ZpI1yhXR+45fjWE0xmOeixih8mfZWvoCQJ950wnl9c6F5HOyWnGWRXEY13r5MD1Cev
         /PQbgo3Dpy8odQrqlAelZ5FL2JM4oCbOK6dpoa/BNTR+0G87Ria0fTzTwoYPcivJxFjj
         5Fkn2zNT/ut5L4xg92jy49CufilFKpHPv8bOOFKlxAmjPYKGgQVALuaYCqz9JAQWtFB0
         UV236/fTllWub8Hk/eAcc7P6EpBcTGHG3Y1Vih7x7C0x644fGAyx18Z0A1xdDaje5zO9
         i4e5ncIMgqwt8cGqj/6pX4Nt6rmoXAmXoNAEkicAXJTF2eWXtJ0ZNCz9m7wAK/xhrTln
         TxEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RJjkaPdtlOJqSnXq7mSfygXQwnXxIuqzSEg1pz6exPQ=;
        b=AGz6Db3TgKk145DAN4alrROlWMz/Wx7LPq0R7MOOnOU2L8eXtKjiPDkAzptAcFAkqS
         HvwqPnSJO8R1FszeBO4kxgQS41SVp9MBUtz1V+GMBmLx/A3wSHzwG/5Z5WsHY1o+TTpf
         Ujlb+UYW9UED4bar+TfjexAVHaDiIRZLoS7K1EDCsKAR7E7XJldXPgJ26JpEJNvczepL
         YEwmy9Ld9IB1jdkKW/EBfcLyL0msR4Q1eH16ANhf6u33lXFlanIx18peDREnEbDXSDPH
         50+Lc5eToAPODjA5Db+DCuRZzKYTkO/bW5lC/ywA8MboEBtmgMVdoFGijg+RHuEvi1/Z
         D8rA==
X-Gm-Message-State: AOAM533EBplv3bX6Hpd5C3lWGOs7EKm8EptDujc1KNpSRZnEwxxdNg30
        Wx/CLht6pV0f0DjlAfAzP+7wLZyaRG+0fA==
X-Google-Smtp-Source: ABdhPJysE0pwFVDH+n/51jkpkpP0kO/tfMSYjNw0tg1hfaQRf2QKFlJKY5DHFmD1B//lKRPNavK9nA==
X-Received: by 2002:a17:90a:c293:: with SMTP id f19mr5526581pjt.106.1630608366158;
        Thu, 02 Sep 2021 11:46:06 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id v190sm3100825pfv.166.2021.09.02.11.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 11:46:05 -0700 (PDT)
Date:   Thu, 2 Sep 2021 18:46:01 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     David Edmondson <david.edmondson@oracle.com>
Cc:     linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wanpeng Li <wanpengli@tencent.com>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <joro@8bytes.org>,
        David Matlack <dmatlack@google.com>, x86@kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH v4 4/4] KVM: x86: SGX must obey the
 KVM_INTERNAL_ERROR_EMULATION protocol
Message-ID: <YTEb6f7rvrbNU2j7@google.com>
References: <20210813071211.1635310-1-david.edmondson@oracle.com>
 <20210813071211.1635310-5-david.edmondson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210813071211.1635310-5-david.edmondson@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2021, David Edmondson wrote:
> When passing the failing address and size out to user space, SGX must
> ensure not to trample on the earlier fields of the emulation_failure
> sub-union of struct kvm_run.
> 
> Signed-off-by: David Edmondson <david.edmondson@oracle.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
