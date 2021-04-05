Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F18BC353A3F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 02:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbhDEAa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 20:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbhDEAaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 20:30:23 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3C5C0613E6
        for <linux-kernel@vger.kernel.org>; Sun,  4 Apr 2021 17:30:17 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id s17so11111942ljc.5
        for <linux-kernel@vger.kernel.org>; Sun, 04 Apr 2021 17:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4djxblumYsM0MYjaTI3gAeclQoo4tMzFZGJUydviNoY=;
        b=k9XPOH16pkp6wIhN6fUXTfgtf00C1nX1vfWzkAoJCwZhTPryGhPETEbWtKNuql8dcT
         J66HvvN+nGIGX/hWkB2rtYjC7ogWFD4Rd4IZkQ0bS/rYf5HmIGTyE/ZylI39cDqXlZLQ
         DrwfgJgtrdAYa4RnReHlFBjkf09I61p5QCpFtdcJBiTqN5do0FBlf/GNBAM4Sa4K9fTt
         O0Sc6EJP96oqfCYeJaor+ktU4xDDekqEt6oEKns8rGYAeQWl4AQoPK1E7sIISi8w1r2q
         CU1BS4YW9udqw0T/oEayc0e8nZsTv0pujP4QcRjuay7oCDxyx5293bIck4CW+rAYTTaJ
         a32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4djxblumYsM0MYjaTI3gAeclQoo4tMzFZGJUydviNoY=;
        b=exPc5qe7n+2rVBYbaWb4o/hVT82WRiWhC+l2pGj9dT8xuEu/ke8CytO6S40jQhcktU
         2bihPHsmcjrzWekwiKJxerafo4CAiuxdfwdqSUIbyhNVp6jFsO33163WCE9cx7DtVjcl
         03L3izO+RusPdB9bW+1Ta9skStEpTZ8qtFDiYeZjlziM7QbEKAYP2wVDvx4jmNgpP9Zg
         ZiAtgzAE/5cggWMh1wMzyDVsP/5+5J6hKy1wfautpWNdBQ0vzEV6GXYIU+TY+52VGt3R
         tmAQkKvXp+GgXJTjlRzOpT7n2vrSv/oXL7rc48XEhFdQl2SD/JYx5SFba3xWwzizQjR6
         4bdA==
X-Gm-Message-State: AOAM533R8f5U5BSjo4n2QZ7Q4c1Y7i84FBMyo5NhXWieFmLp1WbD9k3D
        FqdquoMVfb6Jqpq0ZWrP39cGGRmRBLjRnUc+X2rr0g==
X-Google-Smtp-Source: ABdhPJya1pQ3m+PBzENKSEcDzB6ja6iy+5Hr6CE5/UQqlDXSenL4ol3iYtZBtv3DVLGum6BVeQ8oNUuY6m+mGf4u65w=
X-Received: by 2002:a2e:87d8:: with SMTP id v24mr14196684ljj.387.1617582615756;
 Sun, 04 Apr 2021 17:30:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210330044206.2864329-1-vipinsh@google.com> <YGn42SKCPg2HWtQc@mtj.duckdns.org>
In-Reply-To: <YGn42SKCPg2HWtQc@mtj.duckdns.org>
From:   Vipin Sharma <vipinsh@google.com>
Date:   Sun, 4 Apr 2021 17:29:59 -0700
Message-ID: <CAHVum0fhWSOFRS-t7cF=zCRf_SUoMN5UOYBChWSpmhJVcuMbsg@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] cgroup: New misc cgroup controller
To:     Tejun Heo <tj@kernel.org>
Cc:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh <brijesh.singh@amd.com>, Jon <jon.grimm@amd.com>,
        Eric <eric.vantassell@amd.com>, pbonzini@redhat.com,
        hannes@cmpxchg.org, Janosch Frank <frankja@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>, corbet@lwn.net,
        Sean Christopherson <seanjc@google.com>, vkuznets@redhat.com,
        wanpengli@tencent.com, Jim Mattson <jmattson@google.com>,
        joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, Matt Gingell <gingell@google.com>,
        David Rientjes <rientjes@google.com>, kvm@vger.kernel.org,
        x86@kernel.org, cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 4, 2021 at 10:35 AM Tejun Heo <tj@kernel.org> wrote:
>
> Applied to cgroup/for-5.13. If there are further issues, let's address them
> incrementally.
>
> Thanks.
>
> --
> tejun

Thanks Tejun for accepting and guiding through each version of this
patch series.
