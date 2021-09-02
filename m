Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63CFE3FF166
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 18:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346311AbhIBQav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 12:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235316AbhIBQat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 12:30:49 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E01FC061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 09:29:51 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id w7so2504856pgk.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 09:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g7rNCRYI4FVtRdLWcxPgYOxxATANuLmHX5p0OHhQ/OQ=;
        b=e3awIW1zIGCxTic+i6+lboTIlwUoY/CE6fjKlEcBGAvlSXQ2NkpAyDAw6W2E0uHp2L
         xzWL8JbP4vpFgizBQTrlJ+CpT9kmhxkrd1clie/oJm/r2J8t3SJ4mzZvR7A7TMmvZD7/
         TNcx8f+k/skk/Af98c9JjoT65hCMkEz6K5ADL1vdk+DdF35xKaWh36kQsj60l0Oat4Av
         ntkPHMkeoUm3mBKVe9ynsvU19hXytkI5BsE4KIskCpfG8+JV3PvgP+FmdvYT+u71BUbB
         XowX3ZIgiSVQUO3yzgC+rh4Re+sDCxJjLP11qlMtwnK9RIYjJfg1Z1xYf56hwzSQG7AD
         nxOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g7rNCRYI4FVtRdLWcxPgYOxxATANuLmHX5p0OHhQ/OQ=;
        b=BgUGgn/pUQlqQKlqE8HGLLxfFEj0HmHPqwhfI5SQQy8+zu45RPN0Egi7/3l1ANPCva
         P/CCUf3y56xPw4WAqDd/uNWfQZyBBAkq8qQk10TVGgKzgxbYZzztJrOCyZOuOzBPLCwx
         FzGLPLKdaCticy5m3hysHjYUaxbeDwCGnLBu2+9028CSAXy7fJVtxq4Vd8mlyyprMaa9
         bchkAiSdspElcbUiCPTtoxK/GSUVBhROHUfn63jh2lsidhofjZOvIitZwVJGMJboOUw1
         Z0KBwomLZHRrBwhaXzKqjigrojan/6cwrsmEBCBAiBpuxVcUd3WQUgoR3vPOn+sLAlfn
         M/rQ==
X-Gm-Message-State: AOAM531flf2cguSYF4xeOfW5vrXgxjvEHbUptzyllL5lVBdKyvxMLQnw
        eeCbdCHAgPQ/q8s3Yx6a8JrDGQ==
X-Google-Smtp-Source: ABdhPJxYjlp2lHOOkXQQ6Czv2IjhTjuzKEhU3sS9GRs/1+YZ1bP5W46NJ4V9NDtdX71qvY4afwJ9kw==
X-Received: by 2002:a63:f154:: with SMTP id o20mr4113169pgk.298.1630600190841;
        Thu, 02 Sep 2021 09:29:50 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id v25sm2770900pfm.202.2021.09.02.09.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 09:29:50 -0700 (PDT)
Date:   Thu, 2 Sep 2021 16:29:46 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Chenyi Qiang <chenyi.qiang@intel.com>
Cc:     Xiaoyao Li <xiaoyao.li@intel.com>, Tao Xu <tao3.xu@intel.com>,
        pbonzini@redhat.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] KVM: VMX: Enable Notify VM exit
Message-ID: <YTD7+v2t0dSZqVHF@google.com>
References: <20210525051204.1480610-1-tao3.xu@intel.com>
 <YQRkBI9RFf6lbifZ@google.com>
 <b0c90258-3f68-57a2-664a-e20a6d251e45@intel.com>
 <YQgTPakbT+kCwMLP@google.com>
 <080602dc-f998-ec13-ddf9-42902aa477de@intel.com>
 <4079f0c9-e34c-c034-853a-b26908a58182@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4079f0c9-e34c-c034-853a-b26908a58182@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2021, Chenyi Qiang wrote:
> On 8/3/2021 8:38 AM, Xiaoyao Li wrote:
> > On 8/2/2021 11:46 PM, Sean Christopherson wrote:
> > > IIRC, SGX instructions have a hard upper bound of 25k cycles before they
> > > have to check for pending interrupts, e.g. it's why EINIT is
> > > interruptible.  The 25k cycle limit is likely a good starting point for
> > > the combined minimum.  That's why I want to know the internal minimum; if
> > > the internal minimum is _guaranteed_ to be >25k, then KVM can be more
> > > aggressive with its default value.
> > 
> > OK. I will go internally to see if we can publish the internal threshold.
> > 
> 
> Hi Sean,
> 
> After syncing internally, we know that the internal threshold is not
> architectural but a model-specific value. It will be published in some place
> in future.

Any chance it will also be discoverable, e.g. via an MSR?  That would be ideal
as we could give the module param an "auto" mode where the combined threshold is
set to a minimum KVM-defined value, e.g.

	static int __read_mostly notify_window = -1;
	module_param(notify_window, int, 444);

	...

	rdmsrl_safe(MSR_NOTIFY_WINDOW_BUFFER, &buffer);
	if (notify_window == -1) {
		if (buffer < KVM_DEFAULT_NOTIFY_WINDOW)
			notify_window = 0;
		else
			notifiy_window = KVM_DEFAULT_NOTIFY_WINDOW - buffer;
	}
		
> On Sapphire Rapids platform, the threshold is 128k. With this in mind, is it
> appropriate to set 0 as the default value of notify_window?

Maybe?  That's still not a guarantee that _future_ CPUs will have an internal
threshold >25k.

On a related topic, this needs tests.  One thought would be to stop unconditionally
intercepting #AC if NOTIFY_WINDOW is enabled, and then have the test set up the
infinite #AC vectoring scenario.
