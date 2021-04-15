Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29205361136
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 19:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234446AbhDORiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 13:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234130AbhDORip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 13:38:45 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21855C061756
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 10:38:22 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id a85so16095943pfa.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 10:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=qTYGqzgil/KG8BYTYBPwGN3gXrSpHDUW63tZ+WnYNXY=;
        b=HPyj+pxGtVO6Jy9bJKdJSCHeq3JApvva+y0eFjTL8uy0X/ff20SwRqwCj88QA6Mrgs
         ohwnqCya6FchdXbqe9DlL21B5sh6BzdW80BXaTMX9F/k8dOzbkNGA8idwzoCTQCQmMEO
         cXT9Sqcpb60l34KpZLXaM/TY+y6LlGQe20YCglxj7JhKlRTTCB9ZgU97aaINLOH19ATt
         0NXEt4AWjW0fxne5Qv08kVg5j6oE1r7sQISKCfpK9kdSvu/QN8ffMAVepzrENKLv4I6I
         q9/bmgIW+3XTdV5540qnfARCkHJAVD1+sAziOIm2RT1xGVjpcdrhwZ9GkHuuHw4jK9RN
         9mmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=qTYGqzgil/KG8BYTYBPwGN3gXrSpHDUW63tZ+WnYNXY=;
        b=K2hZruGDH77hQLdStognOMActwnCwMb9Qh5J7mTP4PebSbBLAhjo8UAcQIxPfowBW6
         FRnrdiuu/mKRlq731dMH2eVQdeYsBrEivkuGFFy2wEXP9FCkztlYiyiR6vDimKTdFtg1
         1lwCZMURM5S10YDC1ZdKSnujFaVO1Oo0XFZJGiZrAIV7kL2Z6Xtfq+fsHNWtRm0uPQaT
         M4Z6Dswwo+NO4IKWpNSnrCw6fy319IyLdb1Dvo2ACU6sn7r/42t/WqgQNNMGVg/6U/Kh
         nwCdWdlPAGGnuuCl+XkWZThpwt9jltjgRy+Qsj/GbwUNLVvwlLExQMtS++IMuRUmAOiG
         Cplg==
X-Gm-Message-State: AOAM5303Z7FkEOH/oaajYm/qspfTbjO/isl9HbCLFKVZ5HeFvsktC82S
        8NiJMps/1/owVKRmWlt4aw74jQ==
X-Google-Smtp-Source: ABdhPJwzqYSPMuzNspKDnA/H+hYbFx7mgJCG7akECQHGfWWxiAaw2u9SKTEFKzVic7/hubhyBtLmvQ==
X-Received: by 2002:a63:d009:: with SMTP id z9mr4465139pgf.16.1618508301576;
        Thu, 15 Apr 2021 10:38:21 -0700 (PDT)
Received: from ?IPv6:2600:1010:b016:5472:f478:f987:b4dd:abc9? ([2600:1010:b016:5472:f478:f987:b4dd:abc9])
        by smtp.gmail.com with ESMTPSA id e4sm2894211pgu.89.2021.04.15.10.38.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Apr 2021 10:38:20 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related features
Date:   Thu, 15 Apr 2021 10:38:19 -0700
Message-Id: <C5EFC9AE-3A62-480D-86FD-79B0ADA7E472@amacapital.net>
References: <25f1cca7-fba7-63c1-f11d-17a3069a9ceb@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Len Brown <lenb@kernel.org>,
        Willy Tarreau <w@1wt.eu>, Florian Weimer <fweimer@redhat.com>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-abi@vger.kernel.org, libc-alpha@sourceware.org,
        Rich Felker <dalias@libc.org>, Kyle Huey <me@kylehuey.com>,
        Keno Fischer <keno@juliacomputing.com>
In-Reply-To: <25f1cca7-fba7-63c1-f11d-17a3069a9ceb@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
X-Mailer: iPhone Mail (18D70)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Apr 15, 2021, at 10:00 AM, Dave Hansen <dave.hansen@intel.com> wrote:
>=20
> =EF=BB=BFOn 4/15/21 9:24 AM, Andy Lutomirski wrote:
>> In the patches, *as submitted*, if you trip the XFD #NM *once* and you
>> are the only thread on the system to do so, you will eat the cost of a
>> WRMSR on every subsequent context switch.
>=20
> I think you're saying: If a thread trips XFD #NM *once*, every switch to
> and from *that* thread will incur the WRMSR cost.

Indeed.  My sentence was missing a few words at the end.

>=20
> The first time I read this, I thought you were saying that all threads
> would incur a WRMSR cost on every context switch.  If that's the case, I
> grossly misread the patches. :)
