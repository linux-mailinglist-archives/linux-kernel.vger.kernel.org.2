Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C71A345622
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 04:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbhCWDRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 23:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhCWDQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 23:16:45 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F89AC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 20:16:45 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id h3-20020a4ae8c30000b02901b68b39e2d3so4613142ooe.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 20:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KcHr5KhxTe2vIA5SGKoePAFtx0EJjffM/gwX16Axq9U=;
        b=trUflAVOrYzkJLJ7USUfjk7wQVnu8xRNa1VihcL4PE4shDAYTo6g3SEZO1aB6HhweQ
         Dwm11DtzXghFoS9wAUSe4OmSQnq5qlm6bAJcMQ4NwAg+vrxE1hTx7vv6jHbvFH7J1pNo
         WhtQAJjJFCcnNb0rcy3Yd8opHmDADxIFaDDIk6H7aTkZwZ/MoKQwtQfFegjpi34QaRZZ
         wpH1xLV1Wq/44eG8FSuxmU13RsV/tH2ZHCG4TfTyzUGuroXSboyuHQA7Iz4kOFR/GV7g
         DwfpGsRTcYrCcJlPC+uylVN0n+G7l5gpyFy+aAR9h+C9nNSxp/ZxcCuqRb10C5WCuYtv
         4BZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KcHr5KhxTe2vIA5SGKoePAFtx0EJjffM/gwX16Axq9U=;
        b=MyBwiCc4xnjNYum2a7qn5ZIZe51jtgid3ueiYmJpmBrEfDWzJ4I/VytV78ZezFEzzp
         h2bLadOi2RWn2D9+pwi/TAsexEyegFram8xD5rghHkg+Bm2pRxVL+9WZPC2b52g1nL3h
         LC0CT2jTgt0ewYHO/SR03cCCqfetKhEbOBXeNBbV50Ez51hbGphBs+QR1g1UHOp4B5YM
         IHxacFhr2koGdC+wijrs4M6SMcG73g1WpHCNH8VubQzgBOI0wPjJp9gnAiaWseBOlaX4
         bQ0RGUNuZ/4xUHCgmmUNji6WPyQoTIA/riHxr2fMFwBZ9BE1c8CwOt7/Bo83jNbFm4JY
         OvGQ==
X-Gm-Message-State: AOAM531pbgjvDf11oAdevSMpOfm+gM2Gt4mwcfLXZ4a2ZgVDx6qXge+8
        qG7qEUTNm3gr4aTG/QHDTBwDXbzyYRrkSXc9QU1uCLwLU+lBUg==
X-Google-Smtp-Source: ABdhPJze0SqjbbV2eflTYdACyTLKDcX+dUtq3fTM/RvTCrPzyPhAKgHsTYBcLaSLApUHRSVmn+O9y47iCUxJFvy/AXI=
X-Received: by 2002:a4a:ea11:: with SMTP id x17mr2015315ood.81.1616469404495;
 Mon, 22 Mar 2021 20:16:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210323023726.28343-1-lihaiwei.kernel@gmail.com>
In-Reply-To: <20210323023726.28343-1-lihaiwei.kernel@gmail.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 22 Mar 2021 20:16:33 -0700
Message-ID: <CALMp9eST+qAnXLpzPpORn6piVMNi3xY=P0KmP-cKixtCNAOH9Q@mail.gmail.com>
Subject: Re: [PATCH] KVM: VMX: Check the corresponding bits according to the
 intel sdm
To:     Haiwei Li <lihaiwei.kernel@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Haiwei Li <lihaiwei@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 7:37 PM <lihaiwei.kernel@gmail.com> wrote:
>
> From: Haiwei Li <lihaiwei@tencent.com>
>
> According to IA-32 SDM Vol.3D "A.1 BASIC VMX INFORMATION", two inspections
> are missing.
> * Bit 31 is always 0. Earlier versions of this manual specified that the
> VMCS revision identifier was a 32-bit field in bits 31:0 of this MSR. For
> all processors produced prior to this change, bit 31 of this MSR was read
> as 0.

For all *Intel* processors produced prior to this change, bit 31 of
this MSR may have been 0. However, a conforming hypervisor may have
selected a full 32-bit VMCS revision identifier with the high bit set
for nested VMX. Furthermore, there are other vendors, such as VIA,
which have implemented the VMX extensions, and they, too, may have
selected a full 32-bit VMCS revision identifier with the high bit set.
Intel should know better than to change the documentation after the
horse is out of the barn.

What, exactly, is the value you are adding with this check?
