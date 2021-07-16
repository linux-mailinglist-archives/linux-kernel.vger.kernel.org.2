Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B82593CBADE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 19:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhGPRET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 13:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhGPRER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 13:04:17 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED82C061760
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 10:01:22 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id x16so5611432plg.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 10:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NmQnhTlbXOfRCbLf9y86Anaxj0U0hlxHDzqR53g42lw=;
        b=m/uy5N0lDSdUUcEBsyohxPqG1FA3sC7JLvfidHa/D1BAOgIbSJpan54naFe4u/UBc5
         HaKgGoIH0AaG36C9c8AdWbAyqN2RW1LfXZLQEMWVPbpgLe4buI07O1XovW2TBeaa1r/j
         N+Y7ddaWUtRE8P+Fhr2N09VXZk/VlyFqaRkCeJnHhsEKvpsB6jFfJ/tRAUSdOlEBz264
         Sn2R1yjvbhCwdKYGKLaZJ6TqmvxdFr5MLRwKpYyEby3wc3APffdwOcqDm+241Ql0polg
         rAkvTMN5CvmDpuSpqfIFK/OLKDohaDI+an4dPU083cPjPpGyWy3aYwWuatd1PUuXDio2
         dSVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NmQnhTlbXOfRCbLf9y86Anaxj0U0hlxHDzqR53g42lw=;
        b=gAyqt+BbgIpJ1EtDJhpYiGVE541TIpn1+nu7S68B84AAvXox5MjtmezCUmUcZZPhfH
         I274gKbTYqtHixwU08lPE8PswoX1ev4PwB/sQyeR3ZRbnqGQwdEUuhdhXcK3b197z5le
         nrKE85RDlTJnsYlDaelUX7lu+QfW/5FNNtaz9GycQOV27eBRLgNEFtyo6ZfZUkgJASbf
         WXR15Mds2xMh22YUEydD4cKb6t/MGqxndOJ5WfAaLv6cW5rk1eb3uWl/Kcw/41nRmD2V
         cswECqmfvVRmaigLvo5JEdjlPYTvllOxoqNRpKiicdLRr8JSdlw0K3IMgvhdon5l4+2k
         KQ9w==
X-Gm-Message-State: AOAM531TcQew9Ozki9KfUVGO6PcRqb5OjYTq7wc7CZY5vvBwy3xlE0yn
        BgQUPevoA5Bdw/G9fvTCqye9wQ==
X-Google-Smtp-Source: ABdhPJwgnKcszg66mAGtsLOzmFzSVInsvHjsiqvW0a+0Z+ynIpjNPXpC70wcb8yyVlFKOqF0xXWQzg==
X-Received: by 2002:a17:902:b90a:b029:12b:3338:1870 with SMTP id bf10-20020a170902b90ab029012b33381870mr8530661plb.73.1626454881971;
        Fri, 16 Jul 2021 10:01:21 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id n32sm10565381pfv.59.2021.07.16.10.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 10:01:21 -0700 (PDT)
Date:   Fri, 16 Jul 2021 17:01:17 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: nSVM: Rename nested_svm_vmloadsave() to
 svm_copy_vmloadsave_state()
Message-ID: <YPG7XVwkze/3YDaI@google.com>
References: <20210716144104.465269-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210716144104.465269-1-vkuznets@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 16, 2021, Vitaly Kuznetsov wrote:
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 3bd09c50c98b..8493592b63b4 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -722,7 +722,7 @@ void svm_copy_vmrun_state(struct vmcb_save_area *from_save,
>  	to_save->cpl = 0;
>  }
>  
> -void nested_svm_vmloadsave(struct vmcb *from_vmcb, struct vmcb *to_vmcb)
> +void svm_copy_vmloadsave_state(struct vmcb *from_vmcb, struct vmcb *to_vmcb)

And swap the parameter order for both functions in a follow-up patch?  I.e. have
the destination first to match memcpy().
