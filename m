Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 072FC34EE0E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 18:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbhC3QiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 12:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbhC3Qhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 12:37:33 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CA7C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 09:37:33 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id v23so6451083ple.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 09:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=QqMvnDkY+P2M1ndUgFwujTYEkrHMP1XLAkCwI/GJn4E=;
        b=okF4h/MTVVI6fn5eNJjFFtMC+5ifL9D5Q2H8BUmShzn9coWylF5LZIDeUNBlZlrb9t
         H7cWmud6LEabZmG6ZjFMkK+SpCNnYGvbT0j3CGIg4+qi6zY0dsTdWhNodVrBlQ2mC1Xd
         alwD2tXlqmCQeeL52Dl/uRiHYczDisE3D2zVKKriOXZKvREMWe3AYWyMF4WMquaIsBCz
         glNYiVrGLGn5Nau9ltQP4/+2at67KygcU1b56Wa5ZwnjHj9jMgx/fpZOBDNk5f45Tmdl
         zv8nVomaXdn3h0YnevU+WbWbEicnSCABRLB2SYjZ5I8sZtyruo6ByV3XbUTYCfx//Fi4
         StEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=QqMvnDkY+P2M1ndUgFwujTYEkrHMP1XLAkCwI/GJn4E=;
        b=paVvkNo+S6FolfXd7sDobILj4+FBiYUSBsPxFKtFKOo6SX/DccWnMdDDd2hwfLWmt0
         jUF1kF8CEOuy6W6vziwzB3BzgVh04Y5u4tXAWoBK2Cmi7tDmUxIuY4hKExVdWbsVWd/j
         8PjgQ/GKC2vUwbmAe8V4eFO0Zux74OfcYRrtuQhta2KWGoLsF+RIotjtWkkx/zw1IN17
         GDFWczqVcirlXSc7uoGbdNrgeCqibGYUUceme9YtswSPUDRE0eiRqZZe8jBflEBHDNiJ
         0dBUddFoEIrWdPq9GXa6PNOPJUX4mEnhbvhKQIE3FWYxpu8w3gaA+RfiUI3ZHajknzfy
         IeEg==
X-Gm-Message-State: AOAM530a8o4JazGvskNmoLc3b9+ZUKfbImnqDXas2ZTW4lC7RR7eCpS9
        5gCDeWaUbww5haaXlG/JJMZ41Q==
X-Google-Smtp-Source: ABdhPJyDbgxbQqhcVXTEcjTXmm17ukCPIxTEQ/NM8N5+gHILNFZlx/PTpdGIhjPYRlIhfadCcYgmgg==
X-Received: by 2002:a17:90b:20c:: with SMTP id fy12mr5047192pjb.41.1617122252707;
        Tue, 30 Mar 2021 09:37:32 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:49d9:5468:c384:1417? ([2601:646:c200:1ef2:49d9:5468:c384:1417])
        by smtp.gmail.com with ESMTPSA id k15sm21508881pfi.0.2021.03.30.09.37.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Mar 2021 09:37:31 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3 1/1] x86/tdx: Handle MWAIT, MONITOR and WBINVD
Date:   Tue, 30 Mar 2021 09:37:30 -0700
Message-Id: <4DD05B91-13B3-4842-A215-C8DC6F34F219@amacapital.net>
References: <YGNAQrWMl3AZQ3HG@google.com>
Cc:     Andi Kleen <ak@linux.intel.com>, Andy Lutomirski <luto@kernel.org>,
        "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <YGNAQrWMl3AZQ3HG@google.com>
To:     Sean Christopherson <seanjc@google.com>
X-Mailer: iPhone Mail (18D70)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Mar 30, 2021, at 8:14 AM, Sean Christopherson <seanjc@google.com> wrote=
:
>=20
> =EF=BB=BFOn Mon, Mar 29, 2021, Andy Lutomirski wrote:
>>=20
>>>> On Mar 29, 2021, at 7:04 PM, Andi Kleen <ak@linux.intel.com> wrote:
>>>=20
>>> =EF=BB=BF
>>>>=20
>>>>> No, if these instructions take a #VE then they were executed at CPL=3D=
0.  MONITOR
>>>>> and MWAIT will #UD without VM-Exit->#VE.  Same for WBINVD, s/#UD/#GP.
>>>>=20
>>>> Dare I ask about XSETBV?
>>>=20
>>> XGETBV does not cause a #VE, it just works normally. The guest has full
>>> AVX capabilities.
>>>=20
>>=20
>> X *SET* BV
>=20
> Heh, XSETBV also works normally, relative to the features enumerated in CP=
UID.
> XSAVES/XRSTORS support is fixed to '1' in the virtual CPU model.  A subset=
 of
> the features managed by XSAVE can be hidden by the VMM, but attempting to e=
nable
> unsupported features will #GP (either from hardware or injected by TDX Mod=
ule),
> not #VE.

Normally in non-root mode means that every XSETBV results in a VM exit and, I=
IUC, there=E2=80=99s a buglet in that this happens even if CPL=3D=3D3.  Does=
 something special happen in TDX or does the exit get reflected back to the g=
uest as a #VE?=
