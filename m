Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5768831EF88
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 20:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbhBRTRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 14:17:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234322AbhBRR5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 12:57:08 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362F7C0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 09:56:25 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d15so1663781plh.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 09:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PNc6nW1j6gyGUgECPSUhdPjrew3Be+XPvKlUbO4tTHY=;
        b=DtQ6nFpPenOo69rxexkekvnfFCZ0wbVN5UmYKXGoQGGOsohrlCN8jXbyfECdFl3o4Q
         5jJbQ1RD0LtXmjc1CmqiSgALH7AVMeO3aNwcsfe9gi8yiAvX5VDrwbvlwGizXA+p+5+P
         66mx8Qee1nontChro3pbiM+/0J2XDwJXJHKxCEmp98Iv/zuv9fI6H+R34mGJBVFBbl5O
         gon9EFLcoQx0NLH3N8lMsmvHCfs0wCtrMo0Ar5c/5uTmhVLVYzBGz2XiOzERqvJ8H/1u
         wYI8D3Zo1+yaT1LCuyMWjWYn+RZvIhpTt0MxGuc5IzECkXVt2K5qrTl6LlExHIJJyNYH
         hTwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PNc6nW1j6gyGUgECPSUhdPjrew3Be+XPvKlUbO4tTHY=;
        b=hJDV3A/1DlPlfCEd9UScDUOoeKGPM5euQTSLR7+/jIzpMFTTwxb4UfEsTegWVAx8Ox
         82s651WtDBc7FE0tZAEtm6GlbW16+htkD3qRlbqOhGv4uPqCtwFCcpIsUOvC3vMPn5FU
         mhafd5r0mpTgu3DSzJwPESZwrlmAsID8gs6/GKKDiNZSXJbwwo9HtTTIjbNJP+twZpae
         k11x1Q8FZULP5zq12YvYrWysd+t+iYSXWe+ydxDBYBL6/RjG0nN1aZjRuPkHJLzpLLw+
         nkVpF8TP3Qw7nFVf5Nqlz9/fJ8TPQjAU605lwUiiU609KJMMaxZKs8EmX6TAtNeHI9I1
         l68w==
X-Gm-Message-State: AOAM530yOs+gjo9j+cv8UXxGXabg+XhEhfk9kjc7473rRJ4cL40WaSyt
        NOi8BtuqSMrpF6k+bBoc14za/Q==
X-Google-Smtp-Source: ABdhPJz8UU5r7+x+NFb2TQVORev6WH5WcsHhj0FwlFefXKVSlSiB9TpH+SOPHiERHkzdVPYlRpZsMQ==
X-Received: by 2002:a17:902:363:b029:e3:2305:7e97 with SMTP id 90-20020a1709020363b02900e323057e97mr4968275pld.11.1613670984652;
        Thu, 18 Feb 2021 09:56:24 -0800 (PST)
Received: from google.com ([2620:15c:f:10:dc76:757f:9e9e:647c])
        by smtp.gmail.com with ESMTPSA id u15sm6672711pfm.130.2021.02.18.09.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 09:56:24 -0800 (PST)
Date:   Thu, 18 Feb 2021 09:56:17 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Ashish Kalra <Ashish.Kalra@amd.com>
Cc:     pbonzini@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, rkrcmar@redhat.com, joro@8bytes.org, bp@suse.de,
        thomas.lendacky@amd.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, srutherford@google.com,
        venu.busireddy@oracle.com, brijesh.singh@amd.com
Subject: Re: [PATCH v10 14/16] KVM: x86: Add guest support for detecting and
 enabling SEV Live Migration feature.
Message-ID: <YC6qQZpkdwueyFjs@google.com>
References: <cover.1612398155.git.ashish.kalra@amd.com>
 <6daa898789dc8de02072b1ee6e6390088dbbc5a4.1612398155.git.ashish.kalra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6daa898789dc8de02072b1ee6e6390088dbbc5a4.1612398155.git.ashish.kalra@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>

...

>  arch/x86/include/asm/mem_encrypt.h |  8 +++++
>  arch/x86/kernel/kvm.c              | 52 ++++++++++++++++++++++++++++++
>  arch/x86/mm/mem_encrypt.c          | 41 +++++++++++++++++++++++
>  3 files changed, 101 insertions(+)

Please use "x86/kvm:" in the shortlog for guest side changes so that reviewers
can easily differentiate between host and guest patches.  Past changes haven't
exactly been consistent for guest changes, but "x86/kvm:" is the most popular
at a glance, and IMO aligns best with other kernel (non-KVM) changes.
