Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4CF34DEEC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 04:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbhC3C6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 22:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbhC3C6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 22:58:17 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA95C061762
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 19:58:15 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id g15so11187136pfq.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 19:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=bYJtg6/aY9IB9WPNhczeftcGb9GFpdNakq3l+2zkNCY=;
        b=2Mrdl9EjSV+y/ZlsTdFHADMkTyt9vclFKFAw8Vltf6rzuvEmm5ktkDTq7d+3Iis1Ow
         P4K2eFqI3Zh/TSar69cqQZQxIjJJIrTy/N0lxD0yskxs5GervQIRHekYUKVjAFPoGJlH
         pR7yDa0qiVRu72llRrO4tjcxfzh2HitFFDTCOzSmow+hvel3gF7K6bRfw2ubaJNPOTNl
         mm0l0sercL64fefJWdEocPl5n3om6ECXXBXykMmBEthXHmgK3FqyKsffYDLaczeoItL1
         nrN3xAeW3IkhLYRIGcWPnYrQVPx11TA08SKpQvGuQF/PXBUWMs6oSd0NKgRiM1SinvMI
         GVCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=bYJtg6/aY9IB9WPNhczeftcGb9GFpdNakq3l+2zkNCY=;
        b=V9sU+mLu0VJWHTJdIhq4imQG6WCChffu5AE01mG/zeH66pS7jGeAlfA6OsCROOtLk7
         u9WN4toi2ysKRz9Rxr8auKRmqh7czNaMAMeC6859aAVaEA+w7UrY68jx/RFpAhTtv/4j
         tYCG3gD9fkT59D1PraLrfFvnlJvTeQzeObyLTKp0lp//f0sFO9sEQ2KjJ4EH3dTR3/aL
         FEgLV9Mr0fZoG7NFHXUCES+NHo3dx0eZlvrOpyhybH09hEh9wMtwc+YMAVKf217pbZgl
         dj8JgVS0AI2dVX3xZDAdZhUjat9f9Se8TzX3iyM8xbvAN7mBw1g8/f8wZUoQ+oi8MsXn
         vMXw==
X-Gm-Message-State: AOAM531y74SqzbgcsHL4xh+xD0/3IkCswoDsSRVpA84Vg1omguhWlaor
        CX0MciQ9XCrWggjkP7g9Wk5vzA==
X-Google-Smtp-Source: ABdhPJyNea+qxvS0Q0JdAqlZWNovVE3NqMfm7ePhO9aMUwZsrLevBZSo8exGl//tVV5sSieB57Yb8g==
X-Received: by 2002:aa7:9ae7:0:b029:20a:d94d:dd61 with SMTP id y7-20020aa79ae70000b029020ad94ddd61mr28919446pfp.0.1617073095027;
        Mon, 29 Mar 2021 19:58:15 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:ec9d:4055:2e64:33f9? ([2601:646:c200:1ef2:ec9d:4055:2e64:33f9])
        by smtp.gmail.com with ESMTPSA id u12sm18435997pfn.123.2021.03.29.19.58.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 19:58:14 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3 1/1] x86/tdx: Handle MWAIT, MONITOR and WBINVD
Date:   Mon, 29 Mar 2021 19:58:13 -0700
Message-Id: <2FE32855-EA5D-44E4-AACC-25E9B1476547@amacapital.net>
References: <20210330020403.GA1285835@tassilo.jf.intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20210330020403.GA1285835@tassilo.jf.intel.com>
To:     Andi Kleen <ak@linux.intel.com>
X-Mailer: iPhone Mail (18D61)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Mar 29, 2021, at 7:04 PM, Andi Kleen <ak@linux.intel.com> wrote:
>=20
> =EF=BB=BF
>>=20
>>> No, if these instructions take a #VE then they were executed at CPL=3D0.=
  MONITOR
>>> and MWAIT will #UD without VM-Exit->#VE.  Same for WBINVD, s/#UD/#GP.
>>=20
>> Dare I ask about XSETBV?
>=20
> XGETBV does not cause a #VE, it just works normally. The guest has full
> AVX capabilities.
>=20

X *SET* BV=
