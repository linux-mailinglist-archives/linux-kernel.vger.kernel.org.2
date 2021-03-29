Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5D134DC5E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 01:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbhC2XXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 19:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbhC2XXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 19:23:39 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C05BC061762
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 16:23:39 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id t20so5170394plr.13
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 16:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=i93hLvYxsFCybeNtor23w12Rt5ORCOAw25cIRX3LxjY=;
        b=SsZlzw0tt3fxyETtQ7MeX09GLDiKldGwNRv5YawW8LhCpywPJuUmDMh7mY6au6NJUN
         HiCNPx8oqf9Ubz9X3Sx6kRfs8Q9hh7dzxv9mfgZ4x8EiyljWaS8C1XbaHPkYNIdI4S+r
         8fmrrPOVZXXQM13Rr4R+ZgwglyLPGmr8awW3zRxnVQ1gFtyxtVsr6B7PzK7ulZiLHQ2Z
         HFk0RngJuz2ILmC7mC3UM1Gp755U5fdQ6LUCTKEA8ZwLlfNEU8ydHDEwDn3FpPSAcmk1
         FmHKgAf5AgmenR3QNjEX7G8PKVBHSVZf1znV6Nko7MEYCOfBmvSFskTznlaGgwT6tzwT
         GgwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=i93hLvYxsFCybeNtor23w12Rt5ORCOAw25cIRX3LxjY=;
        b=pAGiNxxfimzUs84QSb3eIv1IgSGFuvFs7RM0kIkCcGq2Hb+e+CCPGGCE1r5yHoOKfc
         lmzCmMAwcMJKBxx68alS+rhRlr1pTgMRx28bYfPRQi4nVocW6UOTRcXhsQgTspkrh6SI
         yCJxZIjGeZro/yTaedCAhr8jj23Ujvc2Fa+jTzINzmiBwmuenN7wMAQfkyqnVLeECnu9
         3jBdqBtiNabaXkugLY+UwrJIPeHwOmYt5NYwKpRHTsEFBqXpC8aEEu/6+KyDUcWZiWOf
         ALf02E0Cr1Ifsgp1dvaiOcQ/rk3Im/EVe1UP+3Rf+bhjfO0JASMiT5jPIfwWEE58xYC1
         xbiQ==
X-Gm-Message-State: AOAM532ZcC8/YnZgr3EaNIhQoEaTqz2SG0wGhEpl4baaiQ48tNPNDZs/
        GDth9NWX/ckTxR2f9VaPadsZSQ==
X-Google-Smtp-Source: ABdhPJyD4+Zilkfav+lGi1g4pHyAbNAESoqN19318NrUIl925B9DC6Flh/Y033lZKl36Hlk6FO5i1Q==
X-Received: by 2002:a17:90a:fb83:: with SMTP id cp3mr1425479pjb.33.1617060218853;
        Mon, 29 Mar 2021 16:23:38 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:e17c:78f7:dc94:55dd? ([2601:646:c200:1ef2:e17c:78f7:dc94:55dd])
        by smtp.gmail.com with ESMTPSA id g26sm18130550pge.67.2021.03.29.16.23.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 16:23:38 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3 1/1] x86/tdx: Handle MWAIT, MONITOR and WBINVD
Date:   Mon, 29 Mar 2021 16:23:37 -0700
Message-Id: <377A7B0B-9959-4AFC-A575-7AC20FEE6077@amacapital.net>
References: <837afe840f5826bf7fcba07a5e483d7e2283db34.1617059703.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <837afe840f5826bf7fcba07a5e483d7e2283db34.1617059703.git.sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: iPhone Mail (18D61)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Mar 29, 2021, at 4:17 PM, Kuppuswamy Sathyanarayanan <sathyanarayanan.k=
uppuswamy@linux.intel.com> wrote:
>=20
> =EF=BB=BFIn non-root TDX guest mode, MWAIT, MONITOR and WBINVD instruction=
s
> are not supported. So handle #VE due to these instructions
> appropriately.

Is there something I missed elsewhere in the code that checks CPL?
