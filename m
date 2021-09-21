Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB938413DFC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 01:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbhIUXXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 19:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbhIUXXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 19:23:43 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAEBC061756
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 16:22:15 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id y4so1043164pfe.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 16:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SrgpsGNJ8rqjyV4/EJo88O9IIQbG0UxIB/O/sCFEHCQ=;
        b=Aek6S4Ex4HL+FlRX8wezQ0nSn8PZPLVSwGFM6Tuf5Vb5PRgM0t3QLU9WUHFeTsdzAU
         QtJBZLxCtSTzHjvsrBDZHuAtRs8M/UcTtn16UVPyICkA/9SmSo6/wgDRXNjilfk6+22r
         W51t+bozYpGIBCS76o+pBdu3BTXYTvAYrWg54kKw/zUklVknkRQaSR+HYh+NPP+yi8y9
         Yb/gjfeOPPT4vB//YCwqd+j/uNNgvnBzGOO9gtxuEZPi7zBRKotpsZHqTtUaIjyqVYgT
         sIUYBMdsmRG8oPPacCtBAXZP+CTj2FLeluAQ6fbuqzgy0II1EfOxhsPqM2kyF7AdcmHW
         W4uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SrgpsGNJ8rqjyV4/EJo88O9IIQbG0UxIB/O/sCFEHCQ=;
        b=OOTYTbA9PfQWM1tddoctRJvKNt69jKxj6ZGE/ZAAoLhK9XcvL0BYqc2GxlvZNpjyCV
         9oiA/XdgDq8bIKNn7NbHoDuW8B9fgdzmK6SXKAyUh5he+iBGOmTiQts2E3aBKMWm6wm8
         MIxtNu2X0SxYvAxwKzGDFCyaDdHfJowdAz/mDBizs21BhuoXEYQ1uNm0zHmPGk0IINrH
         5Q30/GW0G8rqUY1JXv3DMuPbyJRf4HT6YOQ42eSlO87bjEqtXC/dRWTAa6VeuWVO119Y
         zmeN0a22D6X1o8te0tCAnEqR/OybozvkZ4SFbnlivST526A4ZsYqzsxc3JNRzqAZlUMo
         pQ9A==
X-Gm-Message-State: AOAM532XqzWcXbWSrr7iorbLMcy3lx5O34L23zxYS97NfwrDgAxyY6K0
        /T6C3JE4PVOpGfCRW1Nq+szkJg==
X-Google-Smtp-Source: ABdhPJztKWJhnn4ll+uIjZV6ppsKBX5LhsnC09hXPT7pT0HwfgdemziHQj0i0h1tKYzjFbRFxZd+Gw==
X-Received: by 2002:a63:bf07:: with SMTP id v7mr30381034pgf.333.1632266534266;
        Tue, 21 Sep 2021 16:22:14 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id gp11sm3483849pjb.2.2021.09.21.16.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 16:22:13 -0700 (PDT)
Date:   Tue, 21 Sep 2021 23:22:09 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Zhu, Lingshan" <lingshan.zhu@intel.com>
Cc:     peterz@infradead.org, pbonzini@redhat.com, bp@alien8.de,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, kan.liang@linux.intel.com, ak@linux.intel.com,
        wei.w.wang@intel.com, eranian@google.com, liuxiangdong5@huawei.com,
        linux-kernel@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org,
        like.xu.linux@gmail.com, boris.ostrvsky@oracle.com,
        Like Xu <like.xu@linux.intel.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Guo Ren <guoren@kernel.org>, Nick Hu <nickhu@andestech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org,
        xen-devel@lists.xenproject.org
Subject: Re: [PATCH V10 01/18] perf/core: Use static_call to optimize
 perf_guest_info_callbacks
Message-ID: <YUppIQxphCUK6ZLS@google.com>
References: <20210806133802.3528-1-lingshan.zhu@intel.com>
 <20210806133802.3528-2-lingshan.zhu@intel.com>
 <YSfykbECnC6J02Yk@google.com>
 <186c330e-be42-4c49-545c-8f73573b5869@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <186c330e-be42-4c49-545c-8f73573b5869@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021, Zhu, Lingshan wrote:
> 
> 
> On 8/27/2021 3:59 AM, Sean Christopherson wrote:
> > TL;DR: Please don't merge this patch, it's broken and is also built on a shoddy
> >         foundation that I would like to fix.
> Hi Sean,Peter, Paolo
> 
> I will send out an V11 which drops this patch since it's buggy, and Sean is
> working on fix this.
> Does this sound good?

Works for me, thanks!
