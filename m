Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2773311B01
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 05:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbhBFEke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 23:40:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:43870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232515AbhBFDVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 22:21:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 40A746500C
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 23:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612568613;
        bh=Tnsb8oUi4JpqC3KzBK6WXmknOTu/p8IPEkQ9Fl+xtp8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rD5mKDXXv0Ajh7AKKXPd1yUZoCFm/DZEXAqWbHmig9TdmO4iTISmgGl/m31w1hmSV
         uIlbCkfXYsmi65whOiQDbMqOSRZZv5wEmHV5WXFgw45G8OIip83BqVSCZtiueqKNK9
         MUxMOk5ilrpH37mGnHyctXh7JscLCN4s+Ucvyo1D7FWmD7gRVDJls6VwJOA5AqEhkl
         ABCk/HdZyTfdTvnUu2ZuAyCdVD750DfxSUpkQEQu8APjpwDIKTXrBzhJ0ZqveVr6JS
         oCRrjVw96W/JSjkKOsMKN7A3d1J5LX+pYz+7WpWurZV6YldfpnRv20fBF8lEGvXtP9
         MHisXSbRAeDyQ==
Received: by mail-ej1-f50.google.com with SMTP id hs11so14904126ejc.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 15:43:33 -0800 (PST)
X-Gm-Message-State: AOAM533Hb5Ms8PKe/BiZq6vkAwMhvQwcebDwSNh7V1HS+PVJCeFro7Ew
        qRJy2mv1MLzrBcXLOYt9FUHy8IpRX9E9pvLCgJt+hA==
X-Google-Smtp-Source: ABdhPJy8y9rEcNBczScD4q1/N2ChdfNHoPOvrgy/LyVB9ioESE/JtAe85iIAISVE83yvySiZ1N4uHol3imKKhLkWR6w=
X-Received: by 2002:a17:906:b09a:: with SMTP id x26mr6392166ejy.199.1612568611706;
 Fri, 05 Feb 2021 15:43:31 -0800 (PST)
MIME-Version: 1.0
References: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com> <f443f4a2d80ea3717bd1865ae61cec2a100805c3.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <f443f4a2d80ea3717bd1865ae61cec2a100805c3.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 5 Feb 2021 15:43:20 -0800
X-Gmail-Original-Message-ID: <CALCETrWQm+4ocEjDM2e1z=ewmjf4r--6UeqnTwKEtKRa_o-mNg@mail.gmail.com>
Message-ID: <CALCETrWQm+4ocEjDM2e1z=ewmjf4r--6UeqnTwKEtKRa_o-mNg@mail.gmail.com>
Subject: Re: [RFC v1 13/26] x86/tdx: Handle MWAIT, MONITOR and WBINVD
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 5, 2021 at 3:39 PM Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> In non-root TDX guest mode, MWAIT, MONITOR and WBINVD instructions
> are not supported. So handle #VE due to these instructions as no ops.
>

MWAIT turning into NOP is no good.  How about suppressing
X86_FEATURE_MWAIT instead?

--Andy
