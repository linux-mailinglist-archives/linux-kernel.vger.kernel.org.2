Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61DEB3C7834
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 22:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235450AbhGMUyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 16:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234394AbhGMUyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 16:54:39 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF44EC0613E9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 13:51:47 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id v7so22645093pgl.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 13:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=obIPDjCBKxSf9eNIBaYimuhTq9MwYLKG2Lkrml2WVkc=;
        b=l1OFOVbx799HYclC5UOFfxx756UAUM/yU24he0IN8K1LaHcvE2nZeQTDoO6FcrgbHa
         b8YRJLTifIDRJhe4o9C7g2tSW/ZKGTEuiTNXQWwGrXzaG9uicD2z0jNGchDb/HV4QzXa
         HcyHiUPxlHFUi/mDI0F6bj8SNACsRrfqCVXddPYA2d83fVmFsVHNaw7kL9n9m3GiJtci
         1FnbPhKmdx9Vp6Tj+XCqm2Lm+v9e0ATizOmsJJK0fH0WGJ9S9ivNlaHJypYpNvkrsi3i
         e98y2DWTz0nZsPjOAelEYHVGpI/PILCLKDtQQ7f9vUcM/eewEhWFpQbRUcSvtdAOxKGU
         d+8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=obIPDjCBKxSf9eNIBaYimuhTq9MwYLKG2Lkrml2WVkc=;
        b=bNb/DvFy+q9c/UHtbzAgKrfqlRB2ghMJF3M/wJ6XlN71ty//+WTN4bzn413F4HCKTV
         tjLYlFUeWifpnYKbA+yRW1dBGKzn5io13AfuZZPbrFjvKOCGBERTdCLKeEdvsw+oVx5k
         MzjKAhO+5zd2nt+NUVJ08ydWuclbBwNPdvG809SPVttggcAFTq6/YTomEakOj5kdcY4I
         7Lu6oCUT2oUmn2VCBa3GThsL2Jtz0M6GLyDroaw3+6B+HmEYsEobjVtpFesWgFd35+qG
         zSt1J3oFnX97KPL243/7zS+U8zP7hZqf/XRhdJ5uWVV12MiQwe3ntcDF57QiE9sh4Vmg
         8QJw==
X-Gm-Message-State: AOAM5328Cb588jOGPpUnDqDMErhUhqa0NZv1IdvQtJ0JI3SlAMoEO1eR
        3xZ1k9jVEAwFvCwVBMmmevaZng==
X-Google-Smtp-Source: ABdhPJxctmb2j3ozJzCx4wGg8EArySI8Ls9La6ABeaZiakTKEoU0dIpxA+s5VUkbK1/K2sd8nCLGOQ==
X-Received: by 2002:a63:ae01:: with SMTP id q1mr5782132pgf.216.1626209507187;
        Tue, 13 Jul 2021 13:51:47 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id gd20sm50816pjb.33.2021.07.13.13.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 13:51:46 -0700 (PDT)
Date:   Tue, 13 Jul 2021 20:51:43 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     isaku.yamahata@intel.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, erdemaktas@google.com,
        Connor Kuehl <ckuehl@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        isaku.yamahata@gmail.com,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [RFC PATCH v2 38/69] KVM: x86: Add option to force LAPIC
 expiration wait
Message-ID: <YO3832IMZH/ZLZ4Z@google.com>
References: <cover.1625186503.git.isaku.yamahata@intel.com>
 <357378fcb6e3e2becb6d4f00a5c3d2b00b2c566b.1625186503.git.isaku.yamahata@intel.com>
 <a349d5bf-b85c-34c3-bb88-523df23a2985@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a349d5bf-b85c-34c3-bb88-523df23a2985@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06, 2021, Paolo Bonzini wrote:
> On 03/07/21 00:04, isaku.yamahata@intel.com wrote:
> > From: Sean Christopherson <sean.j.christopherson@intel.com>
> > 
> > Add an option to skip the IRR check in kvm_wait_lapic_expire().  This
> > will be used by TDX to wait if there is an outstanding notification for
> > a TD, i.e. a virtual interrupt is being triggered via posted interrupt
> > processing.  KVM TDX doesn't emulate PI processing, i.e. there will
> > never be a bit set in IRR/ISR, so the default behavior for APICv of
> > querying the IRR doesn't work as intended.
> > 
> > Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> > Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> 
> Is there a better (existing after the previous patches) flag to test, or
> possibly can it use vm_type following the suggestion I gave for patch 28?

Not sure if there's a "better" flag, but there's most definitely a flag somewhere
that will suffice :-)
