Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8449F3398E1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 22:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235152AbhCLVKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 16:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235142AbhCLVKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 16:10:20 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF36C061762
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 13:10:19 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id t29so2691064pfg.11
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 13:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pAFjvyG2BbuTR3wtn+p9SqjjHJsHfZYBaKEIukNmkVY=;
        b=vc6FxzbYVVZjdJEOtsXsduPQatLfiaVPUx7lsOMuWZRohiMgayTvLyeV0MwzdexptK
         Bm7Vc9Au744meaK5aoM+NFWSf8U+JGpmsaD445FNT5K1mQiBDhIeJgdCw5AL+rShRVPy
         752uzcppiFQZa6/ExdAzCZp8TnMbPQAH6uXQyeZlZKEVfzTp7Lg0iqLaqSzDJy0v5KzE
         OkPackqgyz9EWoFSsQFavX3gYpLEv4l/p0vqPrC4Si/JVzFXxtE3HBhtHu8wUUxlKVlU
         PZX92mQZuR9qYIdAFlwntQDcqmYC4GAiPD+zK/xpmWPeCm62eZg2gx0iZ2pFPtOeqP7Q
         rgWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pAFjvyG2BbuTR3wtn+p9SqjjHJsHfZYBaKEIukNmkVY=;
        b=QJy1HafUxhR7MvBsW7C3MIiQoKrJAYPJqNBWZ9IEdJV0X7RtHb85jF8y6oA4Skzm74
         PsoSLEtLgIzsg2Z1InFEru8cZiGvy32Wl0fulCDauhbPr9UjaxL0nQszkzO6pU27E5bT
         lL5924enAO3AuEfyGV0oc8tTpnoW40gqT+lN3ES2sRBSDXSZu5uUufl3Bm7RJrPAAsH1
         tLIdLiwBplMvsh7oMmTqTWFW5P86PWwBwdxGaCsFpmb9SpmT43iBHkj57MyHtn7tH6q8
         rAjsYb///gJ3CusuhK8mquoXIQ+gMgYcvrHYlt/vEoqd20u5GmhaR7lxZ/PpN6L8Ywg5
         EeUg==
X-Gm-Message-State: AOAM530q8z4EbaWuTBN2itLwq5wtCpJ1LIWirDgFRnbjroKA/X5PcLTK
        J80u2KZFqBTob8bYV4D6b2OXBw==
X-Google-Smtp-Source: ABdhPJzZqo8fypR7EoA+WAQj0FiBpOz4ZTPpaT51JQKOswutZAbZB0I1mU0vdImvhQDzgMdCafHRuA==
X-Received: by 2002:a63:cd08:: with SMTP id i8mr13355788pgg.49.1615583418687;
        Fri, 12 Mar 2021 13:10:18 -0800 (PST)
Received: from google.com ([2620:15c:f:10:e1a6:2eeb:4e45:756])
        by smtp.gmail.com with ESMTPSA id q95sm2911339pjq.20.2021.03.12.13.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 13:10:18 -0800 (PST)
Date:   Fri, 12 Mar 2021 13:10:11 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Kai Huang <kai.huang@intel.com>
Cc:     kvm@vger.kernel.org, x86@kernel.org, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org, jarkko@kernel.org, luto@kernel.org,
        dave.hansen@intel.com, rick.p.edgecombe@intel.com,
        haitao.huang@intel.com, pbonzini@redhat.com, bp@alien8.de,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com
Subject: Re: [PATCH v2 02/25] x86/cpufeatures: Add SGX1 and SGX2 sub-features
Message-ID: <YEvYsx+jUfALD8Py@google.com>
References: <cover.1615250634.git.kai.huang@intel.com>
 <164745a2de1b9c5bede8c08a3a57566b75a61ae1.1615250634.git.kai.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164745a2de1b9c5bede8c08a3a57566b75a61ae1.1615250634.git.kai.huang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2021, Kai Huang wrote:
> @@ -290,6 +290,8 @@
>  #define X86_FEATURE_FENCE_SWAPGS_KERNEL	(11*32+ 5) /* "" LFENCE in kernel entry SWAPGS path */
>  #define X86_FEATURE_SPLIT_LOCK_DETECT	(11*32+ 6) /* #AC for split lock */
>  #define X86_FEATURE_PER_THREAD_MBA	(11*32+ 7) /* "" Per-thread Memory Bandwidth Allocation */
> +#define X86_FEATURE_SGX1		(11*32+ 8) /* "" Basic SGX */
> +#define X86_FEATURE_SGX2        	(11*32+ 9) /* "" SGX Enclave Dynamic Memory Management (EDMM) */

There are spaces immediately after _SGX2 that can be replace by a tab.
