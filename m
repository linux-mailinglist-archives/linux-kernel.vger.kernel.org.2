Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2333886F7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 07:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345054AbhESFvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 01:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349022AbhESFrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 01:47:01 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37D3C061760
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 22:45:41 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id n8so1156796plf.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 22:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YX6bVogG7OVOPNM1yvwbjKO/m+OQLr7iv04qm+yLWgk=;
        b=qlBlhCYZ4jdvxAcFL4MFjLwB9Mr54MsVnnFEjADnPiNBOwQUrSJtPPRJInz72qIUD8
         09Xk+BS39Pw/LEB3HpuOPCD6uCaYNWIXPcOYeFGaRrPltssi0Bg2E5j1yTzRTyZpXDLV
         zDa6yg98Ych9jTAkdj33Mb1wdw4A1KagrOzIPGQJdcPn9pLf6Y77p/QV8CAlMnXwHVUe
         KqmaWsLgjnhuIE3/LHs2P0XAdtnj8MxdhEPSQDC7c1cGXJkxj46bWb8UFkch1wAU0+3s
         0nDL31uoeob59ZTqPqr7GIKWjPtX2voUMjBMcvyWwORcISYjO9rRSGbfh/lTOaMyJOXl
         f6Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YX6bVogG7OVOPNM1yvwbjKO/m+OQLr7iv04qm+yLWgk=;
        b=goZGIFWju7TufzJyeGRktNle/fJ4OpFMyLYKygNRGh3tNIBDDQ9e49dVFJjpO0Q3jp
         y23tasfCy3SVz/92PBp9c31WLKjJQt2GF1rTC0/6/bX+6+ZWvf3ksnC4hqP6feYnDpAE
         K8Nr22qrwwuRm2GRj0lIV+ujmZ5/2aKFDSNrgju0dCH7iCrqpYBF4BnhnX45ojQyrxT/
         PHlbSxuZVMKBAY2E6W1zo+VoWOlcaUhDQR55tBbVC0CJSiRQX88G6CBCyeaFpEgUQiLn
         08Qn1i5GBFMUThFozY8JkzCbGtOs3oFOdtZc44bYc+qrFURn5fEMjJgzRwNYpEWfOMV7
         O5LA==
X-Gm-Message-State: AOAM533B0Feed2+Tx+pPdENMI3S69XV8ZI9Pt68WzmKaWzMxOFere/vy
        SVM+W81RPVZTx2WWQFMUzbXwM5ncvjWsFwdBqdNh7Q==
X-Google-Smtp-Source: ABdhPJzFjlL3ldo/YTrnNY5oN/5DBrDGqVKohxRHJO2DbVshHNB6qfBiCQwKAgVDsFk8W1xhnfmVeBIw+jSWb7IZCkA=
X-Received: by 2002:a17:902:f20c:b029:f0:af3d:c5d8 with SMTP id
 m12-20020a170902f20cb02900f0af3dc5d8mr8801350plc.23.1621403141274; Tue, 18
 May 2021 22:45:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210424004645.3950558-1-seanjc@google.com> <20210424004645.3950558-20-seanjc@google.com>
In-Reply-To: <20210424004645.3950558-20-seanjc@google.com>
From:   Reiji Watanabe <reijiw@google.com>
Date:   Tue, 18 May 2021 22:45:25 -0700
Message-ID: <CAAeT=FzuLL5JMW2orGWDfdZ1oLN0Bm+-scnYwEysVd_WCkibYA@mail.gmail.com>
Subject: Re: [PATCH 19/43] KVM: x86: Move EDX initialization at vCPU RESET to
 common code
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 5:51 PM Sean Christopherson <seanjc@google.com> wrote:
>
> Move the EDX initialization at vCPU RESET, which is now identical between
> VMX and SVM, into common code.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Reiji Watanabe <reijiw@google.com>

All of those refactorings look great to me.

Thanks,
Reiji
