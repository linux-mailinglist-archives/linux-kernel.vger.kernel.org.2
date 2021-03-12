Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1C6A33991E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 22:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235287AbhCLVeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 16:34:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235275AbhCLVdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 16:33:40 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB840C061762
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 13:33:39 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id 16so2749880pfn.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 13:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iVsxRcsawWsgdZYrcTYOb1n/2Sbbp73pya7fmqOzbMM=;
        b=iU0N0qMeYphwKiEy/0gaspa6VWKm+Nt69kIn87RoNKxVXvrAx5xTe9v5AzEAN28HA7
         YtKRHO05kwSsCPWGpTpqIWE+yljx5wsWZMMfePpFUKqDFK1aK35s/y3dWNP7OZ7ZCZVR
         0zMS3dzjgF/LijZi2YGejfpyGDSV74yVL59mb7BVQ8AD/EzLTxdkB1pU32QGNoNJ1t28
         HheevnlBsUSuT/xl8BNmCnFrt1FBOsBZzfa7c69ql6kTimL4Dd1eU6mw03rA42jgrqts
         Rk+GNZU77eHk7SlGMBw8oaHOlrroqEqRpGRkXTCZATJVsi3Jjcik4oEbnpRf0SWORfUA
         LoEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iVsxRcsawWsgdZYrcTYOb1n/2Sbbp73pya7fmqOzbMM=;
        b=V19RJYcA1u179gZGDV2VisC2msQr0vzy/wOSTpibctI9fRbVJagcmfk/M9zt2IkkQ8
         GReEhu99FfoUSC2ENDqnKonJLP1XWpJFQwdb/zfg97BzzdVU6kEscQYCz2XQy8vJcAYO
         KiuM5wOd/ni/WeY/+xXm6Vuja+9nodBDDGrvHEwVohGISLHqjNiMicSShwbgmb8ZHGmH
         qUdKryr+y9To7vlXPxdCU8p2BenOsXL9Lk6dc09QwFUTQVknTQgNUH+i15XEr4DxR6Ds
         xXyF6+u7kWpGDXo+SBPe9NfyTz95z9lx/+MMYNGFnrN4/XQtnr/wnf2rtw0XJ9RSqCSi
         OCjg==
X-Gm-Message-State: AOAM530V4I5GrvNF3IO95ZpE6EEwjhVd22cT5Of1QNfxnz4SvqN+y7fk
        xd4SH2OP1SzFv3SUJzcVswwRcw==
X-Google-Smtp-Source: ABdhPJyzFmLGS3OHDbNmbZP3xGaBaD+KZkN2wLIU/7KbnCgdx1a9fR5Dif0M2wDntXghS47+usszog==
X-Received: by 2002:a63:74d:: with SMTP id 74mr13471770pgh.316.1615584819001;
        Fri, 12 Mar 2021 13:33:39 -0800 (PST)
Received: from google.com ([2620:15c:f:10:e1a6:2eeb:4e45:756])
        by smtp.gmail.com with ESMTPSA id i14sm3141527pjh.17.2021.03.12.13.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 13:33:38 -0800 (PST)
Date:   Fri, 12 Mar 2021 13:33:31 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Kai Huang <kai.huang@intel.com>
Cc:     kvm@vger.kernel.org, x86@kernel.org, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org, jarkko@kernel.org, luto@kernel.org,
        dave.hansen@intel.com, rick.p.edgecombe@intel.com,
        haitao.huang@intel.com, pbonzini@redhat.com, bp@alien8.de,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        jethro@fortanix.com, b.thiel@posteo.de
Subject: Re: [PATCH v2 06/25] x86/cpu/intel: Allow SGX virtualization without
 Launch Control support
Message-ID: <YEveK42VVla8ibkl@google.com>
References: <cover.1615250634.git.kai.huang@intel.com>
 <f6d21cea6cd3b477a0e12c785feb0b6a2cfdde58.1615250634.git.kai.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6d21cea6cd3b477a0e12c785feb0b6a2cfdde58.1615250634.git.kai.huang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2021, Kai Huang wrote:
> +	if (cpu_has(c, X86_FEATURE_SGX) && IS_ENABLED(CONFIG_X86_SGX)) {
> +		/*
> +		 * Separate out SGX driver enabling from KVM.  This allows KVM
> +		 * guests to use SGX even if the kernel SGX driver refuses to
> +		 * use it.  This happens if flexible Faunch Control is not

/Faunch/Launch

Clever handling of the multitude of combinations!
