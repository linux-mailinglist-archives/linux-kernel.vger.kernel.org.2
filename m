Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6223B344F4E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 19:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbhCVSzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 14:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbhCVSyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 14:54:46 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6581BC061756
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 11:54:46 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id h3so11637966pfr.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 11:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C6WJKx3BOi9nQkez3SccHyBDAf1k0LVTRQZfDBrkHyI=;
        b=lROe8A3BfIgu0wSAyymzCG+OaZGPSPRf5WXAPgf1RNZNuQsv1wIBTvrqjTNJ6QyEit
         1/eYhLK8nbGq6zxinywzSNB3h8wFI2C3jZ7B5EiXgEJFO73NIkC4GGEx1dqJAOkESryI
         +SRQJXSay1vDinJGHbEAUUAJsLZaj883q4Brd8XZUDiXZy32QWHo01+AZg4iVEGmpc4B
         24ABF0G6KnhskHx9KcXUiVMV1gidde0sEpcHr+O561YGKG5BPu4P3VV0HKS+kdZmlSoa
         +LEpvlocNgqW7VLmLaJ1KJEa/Juv8Ply6k8SRx9p9WL3+98g1fPb60V+TYi+sIAPdA0G
         QOew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C6WJKx3BOi9nQkez3SccHyBDAf1k0LVTRQZfDBrkHyI=;
        b=dTuNHAUZG1E7aq3S7cCQkVTHUwc78NX3muZlK7ikazTn/mwcXOP7AyWJbs+K7hbfel
         7m0wJhNXvPgjvV7kmy8WsAi6MrX0j8/MEyU6VnoIGaIRxpGVP0es/VUKF97Fb1Rf22fd
         ++zzTuSLPhpRR7r7pK0EopQds92cdHi9QqN/wg284JXXxrtxjQ+4/XWFfEbyl/6RwazC
         iZ5TeDktDjKrkIQsHYdqXczxuX+mJafqDz9Ks0Nz/TpNDZpi7+LCnn9n7jF65h/uOU3E
         vSw7PShwYBBy4nazAiPwRhGk2a1EGbVcsqYMMHqDq3Z3rDvlAfRsat6t2Dl2t4Ucf0fh
         I+4A==
X-Gm-Message-State: AOAM532EoYHGG3jzQi68OYx7Q+mRnIurO1wjPENqGWQE+WW+y6Yc1i22
        NGGQvs+qmCTTvTJy8x2sE71v9A==
X-Google-Smtp-Source: ABdhPJz0l22YWeP9jVU3HKFhLJi528uNyZjIEnZx2eg3VbJIDvpGhW0i0D919T5LrCeG92+9X3LWNw==
X-Received: by 2002:a63:c04b:: with SMTP id z11mr880319pgi.60.1616439285665;
        Mon, 22 Mar 2021 11:54:45 -0700 (PDT)
Received: from google.com ([2620:0:1008:10:1193:4d01:a2a0:b6db])
        by smtp.gmail.com with ESMTPSA id d6sm13657285pfn.197.2021.03.22.11.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 11:54:44 -0700 (PDT)
Date:   Mon, 22 Mar 2021 11:54:39 -0700
From:   Vipin Sharma <vipinsh@google.com>
To:     Jacob Pan <jacob.jun.pan@intel.com>
Cc:     tj@kernel.org, mkoutny@suse.com, rdunlap@infradead.org,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, jon.grimm@amd.com,
        eric.vantassell@amd.com, pbonzini@redhat.com, hannes@cmpxchg.org,
        frankja@linux.ibm.com, borntraeger@de.ibm.com, corbet@lwn.net,
        seanjc@google.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, gingell@google.com,
        rientjes@google.com, dionnaglaze@google.com, kvm@vger.kernel.org,
        x86@kernel.org, cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [Patch v3 1/2] cgroup: sev: Add misc cgroup controller
Message-ID: <YFjn7wv/iMO4Isgz@google.com>
References: <20210304231946.2766648-1-vipinsh@google.com>
 <20210304231946.2766648-2-vipinsh@google.com>
 <20210319142801.7dcce403@jacob-builder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319142801.7dcce403@jacob-builder>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 02:28:01PM -0700, Jacob Pan wrote:
> On Thu,  4 Mar 2021 15:19:45 -0800, Vipin Sharma <vipinsh@google.com> wrote:
> > +#ifndef _MISC_CGROUP_H_
> > +#define _MISC_CGROUP_H_
> > +
> nit: should you do #include <linux/cgroup.h>?
> Otherwise, css may be undefined.

User of this controller will use get_curernt_misc_cg() API which returns
a pointer. Ideally the user should use this pointer and they shouldn't have
any need to access "css" in their code. They also don't need to create a
object of 'struct misc_cg{}', because that won't be correct misc cgroup
object. They should just declare a pointer like we are doing here in
'struct kvm_sev_info {}'.

If they do need to use "css" then they can include cgroup header in their
code.

Let me know if I am overlooking something here.

Thanks
Vipin Sharma
