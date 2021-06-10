Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8494B3A2F4B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 17:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbhFJPaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 11:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbhFJPaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 11:30:05 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77159C061574
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 08:28:09 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id v13so1208505ple.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 08:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+T4qTFDRvTC2LvJQo3vP3ERmcE/xIzNm1o6qGMbHAxw=;
        b=F9ypNfcxJqUDGZ7u0sw/fKZtTa7NzjZhLVcsxZr1Bw/cFytog6Agkcr7lWicM0udzF
         vsG+Pkr3EKKiweC3daELKcjS6sY+FDqKpMReoxwSctEHMYf89K/sgv9TzETASxAd7bZj
         DBLM3AQmDp6IlqHDX/BjNNfxC927fJte6Fk2lxPQjyIUvB0Frf/M5euTt46UOW2Ez3Vf
         zjTB2fVp9XiZ5ByK+FaPDbgoL0vKV/gJjoA4NnSLjxOOi4QRM9rm4KIgZ9Cdqxv8Tlz4
         gjs6mklaxV9p0/SnWUj8sYLggijju0QmZiBrwmiaq1FmvEJQllH92eUu167P7EfURAIX
         RiqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+T4qTFDRvTC2LvJQo3vP3ERmcE/xIzNm1o6qGMbHAxw=;
        b=BALTLcAEQBE4KqOlZpMOrt7gnlNeFJXLlb0F+z2+w2HDS8zuqEV297SaiUAgRJtBGC
         maLYRv8NTc3FHGITckrP+81P70E+hdynXL/OulGpiYtoXd00xuvNqpEwPIvN36ii878d
         RnmJ7DlvNviMjNA4UwbSwXmTF1gDTfYlu8NUHD9qNdBbxlOQfuagBNXEYhLar/t2Vkag
         SqZqJskf7MXCdJhIT5kg0HQrlrswF9Xua3JJvp/wN6oi0HAqAxeOP1lGb7T6Jq0x3VZL
         Yikz1EN8hXnLYYJ0fR/Br0T4KyyXuZsV6bIMda9IrqCzTb9dHqGR28TP1JLMLn9Gen44
         pZ/Q==
X-Gm-Message-State: AOAM533kwsm1VLjw8mhLuIA61kXZ76pa4fm2Hn/ibJO/6Lk7+jJofrR8
        LpT2WU1KsvsU3vH0HtGO4gD7Vw==
X-Google-Smtp-Source: ABdhPJxIoFDs3S/6HuQlHPNC7XNv1vbSG9WFj6XH/ecNZE4WneBi6ZRZxcrUOhH+IhYFJ+Ornw2/MA==
X-Received: by 2002:a17:90a:6285:: with SMTP id d5mr3990442pjj.3.1623338888870;
        Thu, 10 Jun 2021 08:28:08 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id t1sm2778175pjo.33.2021.06.10.08.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 08:28:08 -0700 (PDT)
Date:   Thu, 10 Jun 2021 15:28:04 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+fb0b6a7e8713aeb0319c@syzkaller.appspotmail.com
Subject: Re: [PATCH 2/9] KVM: x86: Emulate triple fault shutdown if RSM
 emulation fails
Message-ID: <YMIvhAzbbQuWT685@google.com>
References: <20210609185619.992058-1-seanjc@google.com>
 <20210609185619.992058-3-seanjc@google.com>
 <87eedayvkn.fsf@vitty.brq.redhat.com>
 <61e9ec9e-d4f5-bea5-942a-21c259278094@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61e9ec9e-d4f5-bea5-942a-21c259278094@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021, Paolo Bonzini wrote:
> On 10/06/21 10:26, Vitaly Kuznetsov wrote:
> > So should we actually have X86EMUL_CONTINUE when we queue
> > KVM_REQ_TRIPLE_FAULT here?
> 
> Yes...
> 
> > (Initially, my comment was supposed to be 'why don't you add
> > TRIPLE_FAULT to smm selftest?' but the above overshadows it)
> 
> ... and a tenth patch to add a selftest would be nice to have indeed.

Yes, I've been remiss in writing/modifying tests, I'll prioritize that once I've
dug myself out of the rabbit holes I wandered into via the vCPU RESET/INIT series.
