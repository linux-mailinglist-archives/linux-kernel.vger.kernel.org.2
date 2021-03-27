Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94E6C34B817
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 17:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbhC0QD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 12:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbhC0QDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 12:03:42 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C453C0613B1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 09:03:38 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id v10so6590924pgs.12
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 09:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=9yM4zKl8UpHy5WriuWSH2H172IyNgj/kyCvYI8mCqB8=;
        b=2MPaGtLXoaYHCzoZX6YirTG4vpyBQiY2z8M5W+5iSoyE9nG/UTkJVdA8xOb7+r105K
         I2B3KKAzwALp8ZKgNutBfUBMsSlzaJhB4rDkbFSRFHdikL+MjVn75FBTFtHYXO5rjLBi
         RhWBvppEIEuGvMV+4mU0FxCxjyYJY4inUdkfPPeK/qFnpgPI692MGm72+dM+UV6+9H/l
         OHxj1vL+RvSUozjP3CdBNWa5aql04KwEx9SVAV6cpIpKIvofJdmv9FMxYaPJFBaBs/L/
         DO9tpLiwXvoV2N8CQq82frf7KDBXatXWGBWbUuWjDC53ag/V2PxRfpTELGFB+5WM5aqf
         54Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=9yM4zKl8UpHy5WriuWSH2H172IyNgj/kyCvYI8mCqB8=;
        b=DsSLg/V4EzNEEZDdpJwpuJ8+6MuSZzKjwaTHZSLNV43ZYSn9w2NzEbszTSg9S4YcxL
         B29XWwsoeQOoGEa8UF4WtaF1VlMbtpgCWoDaGpLdDdueneneQ02lnHixYb9EIiOhMnLg
         +R89CjJWUZZfynnPMfUmy0ZFf1hUsG49UBWS8tFD7qNGm3+/k1Bm0z21csgy6orK5EDs
         vTw6ARzWxtyQtlnGRk3r6iwzEhcdEvOj/G7GPJJZl8Dnw3ZX+69dv2tWD6mimC2QSVb0
         dNEJKQ2WnxOTWxBHvsaVzQOJxkNFe8RPCpO3vcGrS3buvve77dUf3MwTLPCgmhtZHuDm
         xHzQ==
X-Gm-Message-State: AOAM530+Ql5Te1bZeLP8+A+ZmPRwFK6THRwzqksd9GhD/XF8Z84Ljgbt
        7qJhMdhrj98XP+/5xn8SqLbUBQ==
X-Google-Smtp-Source: ABdhPJzMjm0QDNq8pesMNN98AmqrtwzMnPcZCK47+gx4UGkupHv8NEtNQQyiG9L+hgkR3rnOc6DTXA==
X-Received: by 2002:a63:6744:: with SMTP id b65mr16659049pgc.314.1616861017746;
        Sat, 27 Mar 2021 09:03:37 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:94d3:b09c:16e0:5994? ([2601:646:c200:1ef2:94d3:b09c:16e0:5994])
        by smtp.gmail.com with ESMTPSA id d20sm11346196pjv.47.2021.03.27.09.03.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Mar 2021 09:03:37 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v1 1/1] x86/tdx: Handle MWAIT, MONITOR and WBINVD
Date:   Sat, 27 Mar 2021 09:03:36 -0700
Message-Id: <91C0F6F1-B8C3-4130-B903-C63CD4B87F3F@amacapital.net>
References: <dc970f33-bb1e-7300-3298-6241dec8d445@linux.intel.com>
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
In-Reply-To: <dc970f33-bb1e-7300-3298-6241dec8d445@linux.intel.com>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: iPhone Mail (18D61)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




> On Mar 26, 2021, at 8:40 PM, Kuppuswamy, Sathyanarayanan <sathyanarayanan.=
kuppuswamy@linux.intel.com> wrote:
>=20
> =EF=BB=BF
>=20
> On 3/26/21 7:40 PM, Andy Lutomirski wrote:
>>>> On Mar 26, 2021, at 5:18 PM, Kuppuswamy Sathyanarayanan <sathyanarayana=
n.kuppuswamy@linux.intel.com> wrote:
>>>=20
>>> =EF=BB=BFIn non-root TDX guest mode, MWAIT, MONITOR and WBINVD instructi=
ons
>>> are not supported. So handle #VE due to these instructions as no ops.
>> These should at least be WARN.
> I will change it to WARN.
>> Does TDX send #UD if these instructions have the wrong CPL? =20
> No, TDX does not trigger #UD for these instructions.
> If the #VE came from user mode, we should send an appropriate signal inste=
ad.
> It will be mapped into #GP(0) fault. This should be enough notification ri=
ght?

Yes. And I did mean #GP, not #UD.

