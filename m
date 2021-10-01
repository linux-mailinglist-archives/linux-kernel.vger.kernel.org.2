Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D81541F0EB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 17:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354934AbhJAPPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 11:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354865AbhJAPPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 11:15:03 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2AEC06177D
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 08:13:19 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id k23-20020a17090a591700b001976d2db364so7420458pji.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 08:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=epqGvL2xwASJxQVBW1Iu4NCeLliUpYCfDqhNCQQ6Qu4=;
        b=RmL9twmGl1cux62in5hgYRWjsjWQRTNuCw+2HHC11ZPLnWbcNtrkeKO6qsTnVf+AQI
         VOHQZCPXkfGqGtl5egoUHs0ILgIe2nryR/iHwonKaQCQvp4wXQ7b5dGcNp6j8Hc7F2p5
         lF2wIk+KpQaBVIFo4HvybjQ5oAjVigRE6s2a7on8nAjU5NSqQ7ZxFvqeBgiw6FqjLH7Q
         Tm2VM9gpKyNNiHlUPe7GanCql6KYPqZp3w3N+wwbu/Im+t270KnjjhVY8SUrLdKcoaaK
         dk7IGEx9L9po679KQv6O2726NPU3pcl0iQmZGhHy9TcM9+xBtxeRPDelGVQqPTkJHoQT
         D2JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=epqGvL2xwASJxQVBW1Iu4NCeLliUpYCfDqhNCQQ6Qu4=;
        b=I62UNNovaTEFIGu1gcd9fmeqa41nSi+19omTsJZTTe9b0crGjno/f0QwFV04UOV23K
         EricZrCjFgKQYzErwFpJRgNpyP6syx5452yWmvbWteMRk+cmJtRIgVwmgAATWacwHmza
         8c+GoFnGYp+83G/ggS87n0qLygfqe0SqUpc2DKwFo97JPGJRnDpGIj7vFncx+EnVtv33
         ZBVAi1aGhLPWdgW2OGw85dbpDQaokmZfPpMb5sEpwx8WakCQRNm5czRJvXUWILlicxKB
         6AnzHEAruoaoP2UUmzkesWAF8sQ4OCBmlEpokupFyTuR4LgMRyLFnon5GELR1Y9s2JAw
         jiVA==
X-Gm-Message-State: AOAM533uNv7AI3YFAd2E42H0PXOQLPtSw60qjUY4sY8ALiB+sZEcMZjp
        wcW58rkyDNfTBGDmGkPikkJAhw==
X-Google-Smtp-Source: ABdhPJwayzCtSnysz+R4jnKXc7dOdpaqRQaloWu6UZiyZVUaDl75+fhEkUoWnJ6S2FZUlI8UcciF6Q==
X-Received: by 2002:a17:902:aa91:b0:13e:292f:266a with SMTP id d17-20020a170902aa9100b0013e292f266amr10000865plr.10.1633101198760;
        Fri, 01 Oct 2021 08:13:18 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id v2sm5991593pje.15.2021.10.01.08.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 08:13:18 -0700 (PDT)
Date:   Fri, 1 Oct 2021 15:13:14 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     syzbot <syzbot+d6d011bc17bb751d4aa2@syzkaller.appspotmail.com>
Cc:     bp@alien8.de, dave.hansen@linux.intel.com, glider@google.com,
        hpa@zytor.com, jarkko@kernel.org, jmattson@google.com,
        joro@8bytes.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sgx@vger.kernel.org, mingo@redhat.com, pbonzini@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        vkuznets@redhat.com, wanpengli@tencent.com, x86@kernel.org
Subject: Re: [syzbot] KMSAN: uninit-value in kvm_cpuid
Message-ID: <YVclio5ny4ziKQer@google.com>
References: <00000000000048342f05cd44efc0@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000048342f05cd44efc0@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    cd2c05533838 DO-NOT-SUBMIT: kmsan: suppress a report in ke..
> git tree:       https://github.com/google/kmsan.git master
> console output: https://syzkaller.appspot.com/x/log.txt?x=11373b17300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=978f1b2d7a5aad3e
> dashboard link: https://syzkaller.appspot.com/bug?extid=d6d011bc17bb751d4aa2
> compiler:       clang version 14.0.0 (git@github.com:llvm/llvm-project.git 0996585c8e3b3d409494eb5f1cad714b9e1f7fb5), GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14b6c4cb300000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10fdb00f300000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+d6d011bc17bb751d4aa2@syzkaller.appspotmail.com

#syz fix: KVM: x86: Swap order of CPUID entry "index" vs. "significant flag" checks
