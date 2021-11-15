Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9270452835
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 04:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344086AbhKPDHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 22:07:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244921AbhKPDHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 22:07:30 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB34C06120F
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 15:35:57 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id u11so15830174plf.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 15:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=t+zeUthCjwxIPtiqPuvHkjVJXWI02lrp3HVe/TTmMOM=;
        b=npoTfvZsyHR62144HIHzj1jI/1WdWaAajjPuelBpZnaPwbvplPx+mC8Kx0FExblInN
         Ii5mhcVJVekLichUGe6qpce5rTwI0F5OSzoKLCsq3TjE9YNuKMNOE1uiIyCozLwSmL2F
         kthi8i0r2Uz+QWF36+z8q128aAgKe9wN0ar9gxHqz8fr2AUBzpzoeK9yAAYwP4kG1lmI
         TgbY39G9n3Z2P2tsLqFwJDmQfMHGvU3PfgzbuzFh864dsJ6tIdDMrgekKqKc5XmPELTw
         OAzo2RHAblFZNnVxx/PdIiMQcBRRMOw/I0o9EXZjYpmSEQyRDetgJejE3mDHSXmOGMlK
         kSrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t+zeUthCjwxIPtiqPuvHkjVJXWI02lrp3HVe/TTmMOM=;
        b=3phA92/AO4FW6LXxQF7XOofNPbaE7lUXc4SS3lvmgEnOHlj0TsxywoOMTmePCHc1PX
         28h7tpN8bGagAypUQe5IMMlddLhNQxP29xgjzCaPOmiEZR7iKksxotnBk7zpkSnmt5l9
         e/c2WdveIfZKvMVuGFB17Ltt4nNXZv9tkocmOwNes/liwyOItahff6kzgeDXz1EsSg5o
         qMtCNcVhuSAlTIR4oACgUZJ7VZhR8mXahKIy9UrvpWp3fpOrbliS1loi72x8A+68/B5N
         Pbt22OQyQFO63iUQoqDzjHW7fvmrg3UpUilFgPHbCJNFJ5vku0XaX+p6MaLncj8wiwHk
         0zpA==
X-Gm-Message-State: AOAM532Yt2ZyHOzg7HOcsfYXZ4N1K76VJBPLhiqZkwrLQgNQOMOVxGfV
        sotXJsbXhrE5YsT3Olll9Ljteg==
X-Google-Smtp-Source: ABdhPJxP8k37Yn+RVzY4mitYLWlpK3o6ksKluoDvGBw+s7bgUCaPyOflgd189QuPhvlSQHcJNw43Vg==
X-Received: by 2002:a17:902:d491:b0:142:892d:a89 with SMTP id c17-20020a170902d49100b00142892d0a89mr39125545plg.20.1637019356587;
        Mon, 15 Nov 2021 15:35:56 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id g7sm12000240pfv.159.2021.11.15.15.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 15:35:56 -0800 (PST)
Date:   Mon, 15 Nov 2021 23:35:52 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Peter Gonda <pgonda@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Marc Orr <marcorr@google.com>,
        Nathan Tempelman <natet@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <Thomas.Lendacky@amd.com>
Subject: Re: [PATCH 1/6] KVM: SEV: Disallow COPY_ENC_CONTEXT_FROM if target
 has created vCPUs
Message-ID: <YZLu2FcX4XdbiVBt@google.com>
References: <20211109215101.2211373-1-seanjc@google.com>
 <20211109215101.2211373-2-seanjc@google.com>
 <CAMkAt6qLVLsP6_0X_u+zdRT99rutphZ11y-1-hEUQ8KZOUU8tA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMkAt6qLVLsP6_0X_u+zdRT99rutphZ11y-1-hEUQ8KZOUU8tA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021, Peter Gonda wrote:
> On Tue, Nov 9, 2021 at 2:53 PM Sean Christopherson <seanjc@google.com> wrote:
> > +       /*
> > +        * Disallow out-of-band SEV/SEV-ES init if the target is already an
> > +        * SEV guest, or if vCPUs have been created.  KVM relies on vCPUs being
> > +        * created after SEV/SEV-ES initialization, e.g. to init intercepts.
> > +        */
> > +       if (sev_guest(kvm) || kvm->created_vcpus) {
> >                 ret = -EINVAL;
> >                 goto e_mirror_unlock;
> >         }
> 
> Now that we have some framework for running SEV related selftests, do
> you mind adding a regression test for this change?

Can do, will likely be a few days though.
