Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 438C63B0A73
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 18:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbhFVQkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 12:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbhFVQkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 12:40:46 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E7EC06175F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 09:38:30 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id u2so2001915plf.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 09:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3STMsch4X3DHLr8z4bBHjozjW70mR8Uwk306HzfJxdE=;
        b=ikxL95WseTOiuX3iub6AAiU7LJIWsjvNoJS0/F1fh762+zi5idvDJQtwZYHJ9byHSm
         xAD+/LN2Ii5x3v1I+lLaL11iymQjc3gHF5VGP/M671+7NlB+pALQdK/7U9AxM7+thYUg
         KLFDLVj1OUHClfDicKHPIA7lTaHWC+lIUsyefMN5/tVAI7FuMyPRKgo0uYFU3Sa6aCSL
         J6kmCV/H4ru0McPjc/TmZ2ijtTxBLMjSQyM5mBUQnqpCi5LxxmM1c43ACvmhJ0LhHHHY
         o8xMutgDa1qGr28d2De1NcfaWYgFBfnGo2sPQCCNRnpaKFrlf9iuNKY3pgoV9oZqt2Qd
         VJiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3STMsch4X3DHLr8z4bBHjozjW70mR8Uwk306HzfJxdE=;
        b=GdypiyC0MB5y9w0r+gOhppufgUv+shLmVmmpndHd9KuUOqs6dF03+XOhqBQzZIZWFy
         q4SY1pybZIiMF8RJEdVUgookbPLVUK2G5E7WCoVTxk8jce19ZAWDmD3WTOLgXaLCl5Lx
         lMSytkiTHw1JIWMkxtuYER8DOv1vS33WM31hkdaQYY/zHG/D3wol5KjAFziHSn0nHLT/
         Co32OyWgIz90zS+zpoFEZUW70uPpjYNwg4DBbBL/pU0iLgov8ptmrmwpxBIIsPFVsz2w
         eDdHDKUGd7ToIkrawo60kerAgTETG2ypbnabCG6gGTZdBi88Mh1+wUFiEfSll8G/Fujo
         WE7A==
X-Gm-Message-State: AOAM530cYBH0oyCHz/8vy0HVvhG+cUe8hBvb6nhgtHyqlhj/F6DM5kSo
        1+qowjzq1ImKY1pxCRar9LEKYA==
X-Google-Smtp-Source: ABdhPJwlMUw/8cV9tZjTDpOthfL+7WdZDlGmmpNtw1OUgeadX54a6ryH0XB3nok/CW6wdYLS3pFBwQ==
X-Received: by 2002:a17:902:b288:b029:f8:fb4f:f8d3 with SMTP id u8-20020a170902b288b02900f8fb4ff8d3mr23313243plr.25.1624379909756;
        Tue, 22 Jun 2021 09:38:29 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id h8sm19052242pfn.0.2021.06.22.09.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 09:38:29 -0700 (PDT)
Date:   Tue, 22 Jun 2021 16:38:25 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Ben Gardon <bgardon@google.com>, kvm@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] KVM: x86/mmu: Fix uninitialized boolean variable
 flush
Message-ID: <YNISAXXPWnhJlurO@google.com>
References: <20210622150912.23429-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622150912.23429-1-colin.king@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2021, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> In the case where kvm_memslots_have_rmaps(kvm) is false the boolean
> variable flush is not set and is uninitialized.  If is_tdp_mmu_enabled(kvm)
> is true then the call to kvm_tdp_mmu_zap_collapsible_sptes passes the
> uninitialized value of flush into the call. Fix this by initializing
> flush to false.
> 
> Addresses-Coverity: ("Uninitialized scalar variable")
> Fixes: e2209710ccc5 ("KVM: x86/mmu: Skip rmap operations if rmaps not allocated")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
