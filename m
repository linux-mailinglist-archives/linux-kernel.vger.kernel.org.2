Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1393398B0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 21:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235035AbhCLUvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 15:51:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235010AbhCLUvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 15:51:33 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7499EC061761
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 12:51:33 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id a8so5973945plp.13
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 12:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=vDrjln050ZWSD2n57JKYsjj24mDG3Mu6cQfXoag8kqA=;
        b=o1+mWphvFvKetD8P/Z44PWPcjEPdOlxMP5SOQC16Tskp42s9q00lujmGOIFQWhhEaV
         1ink7OOHVOKxPCCC+xqBCilm4hYNtfYqXA93rZbxOrH+fXw4mCuIhAwvWzxV35JiV+lI
         F1bLUj/xMyG+8vXBR7aexe3fAaM4Tn1okrASG7GtrXc5qspcBWXZQM7rDaB+VFV0N60v
         kqKR+njm735YkwAXVBzJHHZZE38U649WTUg1VLZeSW1oWofsuolBzXu7AdqcTUoHQVzv
         iadBzD/YkaVT31MESOfV0PH2BVjAOVGU26qG6tzmz3UOVKovVIWHocspnwgnzALbc0so
         pMqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=vDrjln050ZWSD2n57JKYsjj24mDG3Mu6cQfXoag8kqA=;
        b=m+SZ51A5Dg4ByzxK5w3x05VVBKOkImsvk5boCHwPm7nches8S4wltIXASsHwJVlRy8
         uwP9vANeBXcFiBioNlFnRaYddyCK6qZt3XpVBEfk9RMxo92CWoCQC1/heCb/5ngKqrEp
         uBg4Z15oQOKlI2sW7oYf1jTmZOUQe71//F9kiLkxJR57wYY4/NVwIOrufRqq7qDWm3sf
         nlq4VZXd7VkUiN0AiNW7ZEhc3M95YCeGh3PLaa6GtBj5ejKCIHbgNTIrr3u6Ttbeuhdu
         5c1ihBHF7pdEvA6mla77bbAk+tqfnxbJpt0+OB6oLoyHn8zqSB1KQZiCGgTWP1YWJ9l1
         IzIg==
X-Gm-Message-State: AOAM533EKEbdQ/oawMzAydeYiLyDhXLHS/WA0rEOf6Qd8oKQgnJPCAOv
        38CAlGVbVUvSwXNo57veSWGyGA==
X-Google-Smtp-Source: ABdhPJyOxdn4Hc2Qvr6pK+LxEXDtcg+Su4dKCMB6KabV21efjdTrwWXlyMlnQo+c+UfqNxWghTBHkQ==
X-Received: by 2002:a17:90a:a414:: with SMTP id y20mr122695pjp.77.1615582292700;
        Fri, 12 Mar 2021 12:51:32 -0800 (PST)
Received: from google.com ([2620:15c:f:10:e1a6:2eeb:4e45:756])
        by smtp.gmail.com with ESMTPSA id a144sm6710227pfd.200.2021.03.12.12.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 12:51:32 -0800 (PST)
Date:   Fri, 12 Mar 2021 12:51:25 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Vipin Sharma <vipinsh@google.com>
Cc:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, tj@kernel.org,
        rdunlap@infradead.org, jon.grimm@amd.com, eric.vantassell@amd.com,
        pbonzini@redhat.com, hannes@cmpxchg.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com, corbet@lwn.net, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        gingell@google.com, rientjes@google.com, dionnaglaze@google.com,
        kvm@vger.kernel.org, x86@kernel.org, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch v3 1/2] cgroup: sev: Add misc cgroup controller
Message-ID: <YEvUTatAjIoP7dPD@google.com>
References: <20210304231946.2766648-1-vipinsh@google.com>
 <20210304231946.2766648-2-vipinsh@google.com>
 <YEpod5X29YqMhW/g@blackbook>
 <YEvFldKZ8YQM+t2q@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YEvFldKZ8YQM+t2q@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021, Vipin Sharma wrote:
> On Thu, Mar 11, 2021 at 07:59:03PM +0100, Michal Koutný wrote:
> > > +#ifndef CONFIG_KVM_AMD_SEV
> > > +/*
> > > + * When this config is not defined, SEV feature is not supported and APIs in
> > > + * this file are not used but this file still gets compiled into the KVM AMD
> > > + * module.
> > > + *
> > > + * We will not have MISC_CG_RES_SEV and MISC_CG_RES_SEV_ES entries in the enum
> > > + * misc_res_type {} defined in linux/misc_cgroup.h.
> > BTW, was there any progress on conditioning sev.c build on
> > CONFIG_KVM_AMD_SEV? (So that the defines workaround isn't needeed.)
> 
> Tom, Brijesh,
> Is this something you guys thought about or have some plans to do in the
> future? Basically to not include sev.c in compilation if
> CONFIG_KVM_AMD_SEV is disabled.

It's crossed my mind, but the number of stubs needed made me back off.  I'm
certainly not opposed to the idea, it's just not a trivial change.
