Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E847934DC8C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 01:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbhC2XjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 19:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbhC2XjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 19:39:16 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D194C061762
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 16:39:16 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id v3so10445798pgq.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 16:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=hN4WWhVcXw6nl268dQhfj4OLxqRRKkO70cVGJuR0GJ4=;
        b=gaboA5c7IrFAj7LuI1vjBWj5jwE1J1LIh0VGAt6543i4QZYPqdKXNCfVfg6JsZco4X
         5KTCYJNnb6KCxXFQJChNNgkUuRO5LC1crBbAZ38y33jDpwPihUnujH0RoyRi+Ynp5lVZ
         Ar7xOYOtKu6tOQpkd/zppFDWY6xUa63N6D6XcdMLAClEQKDyIoh9W9BBHkyhPTszljiR
         up3weRwPvSAFqsNruEfyJ24h1SxS2n7cmgLnQgFrHDpWkcsHozCZds3snTLIq0YnU2Rt
         kmCN5AM6NfEyxv135yFb83jAzRUnLhPgY0jRnp4ThzpTE8MfwVPh6LD6XKk9n7XC1YUO
         ImMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=hN4WWhVcXw6nl268dQhfj4OLxqRRKkO70cVGJuR0GJ4=;
        b=rZIYS8ZbHoZ1kW28DO0+eajtIDxoL1R9DH/3Tc+Q3vteYLeym2pvv8bSYSlfDSel6m
         KCj40Fg0Tz+D6HvzS97sIpnTgCbIlzBJK+bpDP0ZiTpagRXmCOHaDGrUnudN4MxKDu/q
         79CohsPtN9v3QWLED5H1WRgonpesqZSxxs3EOsgtI29eg7rAsiB4Bf5j5rzKdTuuIc15
         5u9IMJ9qD9XZDBefPXYH2MwzgUrbt0vOCujvIgiFSpH+ewSGGPCLO7tqjXIG4P0u43Xw
         lEDZ/+/t/kOGr+a8ZizzvvLbQdwgvlTAbpqtk2Bdl3Sb3JEjR1afgTiNjN8y19Y+w7+I
         BDVA==
X-Gm-Message-State: AOAM532bR5QCoWt1/54DnyFH1oUhlmYvlYYsoW99LueRdLIR4h14bAgy
        3TmnZDll1cUv5acdr1QLDOV7yQ==
X-Google-Smtp-Source: ABdhPJwv8XKdbQZG2PAaW1+R5LbogOOS/V3hsriJEIhwI6g3Il7/yp4AXforO1ek2P+dl/B6i1Xdlg==
X-Received: by 2002:aa7:87c5:0:b029:202:b279:c7e5 with SMTP id i5-20020aa787c50000b0290202b279c7e5mr27981197pfo.27.1617061155588;
        Mon, 29 Mar 2021 16:39:15 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id x125sm18622993pfd.124.2021.03.29.16.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 16:39:15 -0700 (PDT)
Date:   Mon, 29 Mar 2021 23:39:11 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] x86/tdx: Handle MWAIT, MONITOR and WBINVD
Message-ID: <YGJlH76t+BGrIDVc@google.com>
References: <837afe840f5826bf7fcba07a5e483d7e2283db34.1617059703.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <377A7B0B-9959-4AFC-A575-7AC20FEE6077@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <377A7B0B-9959-4AFC-A575-7AC20FEE6077@amacapital.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021, Andy Lutomirski wrote:
> 
> > On Mar 29, 2021, at 4:17 PM, Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> > 
> > ﻿In non-root TDX guest mode, MWAIT, MONITOR and WBINVD instructions
> > are not supported. So handle #VE due to these instructions
> > appropriately.
> 
> Is there something I missed elsewhere in the code that checks CPL?

#GP due to CPL!=0 has priority over VM-Exit, i.e. userspace will get a #GP
directly; there will be no VM-Exit to the TDX Module and thus no #VE.

SDM section "25.1.1 - Relative Priority of Faults and VM Exits".
