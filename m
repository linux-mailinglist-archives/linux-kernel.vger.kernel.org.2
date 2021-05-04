Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D62937323D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 00:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbhEDWMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 18:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232424AbhEDWMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 18:12:44 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084B0C061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 15:11:48 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id p12so213451pgj.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 15:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X24lUXlMEhpG08QpqR1PXTQYsmjAZVq0k2CHWE7HhVY=;
        b=X61PxexQtJUyrYRZSK0xCUjkBWVWmqhbPHTL7U8gdl1OQpo3CTBNZnV/wez9UyhXDJ
         1g4Lu29fx9+u7UNRTBfbuGMl8k+ogE1ofqlzgh0y+/qzYdLYOpSrDSUZ3N29aQAJct0x
         eOoQAahlK7FUSxosC99+uipbZwlR1oIrZWKGontQ83L+1dHR6SBurmfpyUwNDgrDDlYg
         nwr0jjoo3JSJ1lQRvLO8AfHplkHL+Gy2vz2gnkbA2ZbZUxFuggwdrKw8LHAW3ZvQUTkg
         suhIP1eg15yp+4j25ZuBVsAjiZs2g7OURRvAO755z9kAfU3P1WlFGQY8IhFui61lyzUL
         Nt4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X24lUXlMEhpG08QpqR1PXTQYsmjAZVq0k2CHWE7HhVY=;
        b=JbI7c1tD0G8JvwYUeGFiAMHchq34PMbZaueOTPhwLb+zDlB7YiTI+7fS/1rdT/06QA
         XH/SU2145z5k/mSo0TbXd2BO7rJNteJev0y6NhVgNpde3puVOTJh4dsHnGeVf3/dTbE+
         UNAP9CIcIOjand3lT3iOFDdNeyOiWC3ys13wh0x6VZxyVgEthN9hyyHqr53uDIZq8g0z
         XGS4CF8OcAUoG4u1kYXTyYUn3a/ASZlDHmiJ11Y7Zrg4nCVVXsubKM6rf/KGoOHk3QxD
         UF/tgZZvXTF0yl/JaJYG7yqnP0bunwC22RXSHwmUHnJdMNGbSgOwzas/yRAnJkUVY/qY
         1iaA==
X-Gm-Message-State: AOAM531QHMYhT7lQadT336wtl+24FcHasr++nQyfpf6tu6D7CKnHrHk3
        RehTskT4fTR2vCHWexBvwYGDrWAUxOT8FklG42SK0Q==
X-Google-Smtp-Source: ABdhPJxBDaBz2DRw8kqPKeDKfQ4d46qBSNpg+xnZ9QTKG26vZ10umSbISFR3+PaN/BYlWh1v6oWwRWAfY8yFbDKC4qg=
X-Received: by 2002:a65:63c5:: with SMTP id n5mr7588258pgv.271.1620166307446;
 Tue, 04 May 2021 15:11:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210430131733.192414-1-rsaripal@amd.com> <20210430131733.192414-2-rsaripal@amd.com>
 <CAAeT=Fw-nt5h3DhRCQr8Ma71NiP7dHB+WD2hie_55SpCHR=mDQ@mail.gmail.com>
 <e53887f8-c09d-28db-5041-bf8822370c46@amd.com> <CAAeT=FyAmSxKy5cpGLBH_kqDohXeQOdi4r02KjQO_vycq=4y=Q@mail.gmail.com>
 <d64b9e19-7124-640f-0ca1-7abc7816d642@amd.com>
In-Reply-To: <d64b9e19-7124-640f-0ca1-7abc7816d642@amd.com>
From:   Reiji Watanabe <reijiw@google.com>
Date:   Tue, 4 May 2021 15:11:31 -0700
Message-ID: <CAAeT=FwYNJfHUzQjSpJD8oexNfR9CLa2oPx4Umh6=97xpkA7fA@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] x86/cpufeatures: Implement Predictive Store
 Forwarding control.
To:     "Saripalli, RK" <rsaripal@amd.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, Borislav Petkov <bp@alien8.de>, hpa@zytor.com,
        Jonathan Corbet <corbet@lwn.net>, bsd@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Boris / Reiji, I am wondering if I have answered all the questions on these latest patches.
> Just checking to see if there are any more changes needed.

All the questions from me were answered and I don't have any
other comment/question for the latest patch (assuming that
the patch will be updated based on the comment from Tom).

FYI.
I was going to ask you a question about x86_spec_ctrl_mask.
But, since it is used only for KVM (although x86_spec_ctrl_mask
is defined/used only in arch/x86/kernel/cpu/bugs.c),
I plan to ask you about it once your KVM patch gets updated
rather than this patch.

Thanks,
Reiji
