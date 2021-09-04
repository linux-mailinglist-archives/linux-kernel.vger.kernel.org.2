Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13CE8400C44
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 19:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237236AbhIDRYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 13:24:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33295 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237110AbhIDRYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 13:24:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630776219;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e0Wbz3oMbJb5cgHuRwL4iP+mYlNNOJ7Kny5wVEZ3hak=;
        b=FfgdQBzy1O/m5HqGNGxl5NaPTJJqCuTedzKNMlKTBpUllsyxpa0h1DMGbE8yuHentXy7u0
        X4L9hl/jzWa8KdwyAS9vzmkFLHN+ZKkPf/VK50LfBCzh7kdtZlixP8FEVbPbLZDkvigvF0
        KNSlPJpEZMiMStA1Qc9/b5xlVEO1iUI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-geTUSWzhNt6MBhynIypAxQ-1; Sat, 04 Sep 2021 13:23:38 -0400
X-MC-Unique: geTUSWzhNt6MBhynIypAxQ-1
Received: by mail-qk1-f199.google.com with SMTP id c27-20020a05620a165b00b003d3817c7c23so3696469qko.16
        for <linux-kernel@vger.kernel.org>; Sat, 04 Sep 2021 10:23:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=e0Wbz3oMbJb5cgHuRwL4iP+mYlNNOJ7Kny5wVEZ3hak=;
        b=KYf74ZL9ZAxDZQEY2CinGgO/OIZrnrHn839LXZJp9afG2GoHt+lz/wiYsml+viTU81
         mHNiUaTpgoDVJy10R7Tx4rWSxFBP5lbjelwsvdY9aR6T+g/7c6w6Dm9wbHujGo0uemFh
         FRya2ghR3IhgXxJ2MmCy18rCy8SHbkAUlUAKeZH+Xf6wl+3S341twzSPg6gUM8fXx7+7
         2hBoeVL1T8W+bst8vdmBUA2cjCp4B/lBzkZXd4QwDsOm2JmYJQOVlm0yfcToCbhNOYp6
         CD4DYQfLQaR6Z22TsHJvoAfZdPfpZU9UjBiBQKo9GeYxjBVwf3fiZmWmEtvtiAjnZ8mz
         vwMA==
X-Gm-Message-State: AOAM533NnvHd+4VjCTwSmE6yMtVFyeKDEJbgk9O7+amepWPwfe03ue7R
        nZ9aVG0cy7mb3P3zNDLJo7RwEF1MBpbFw4zKBv3DAZegZ7wxj5EcZG40XjYHSEi5XwQ8isyisB+
        4j50vpFSaQt9+CuPAc6+DQAHu
X-Received: by 2002:a05:620a:1aa5:: with SMTP id bl37mr4032270qkb.84.1630776218335;
        Sat, 04 Sep 2021 10:23:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzbsiEoEf0I4fM3MvaSmXQlxjru1r+ru6sFAFyPegl7cJi6/5JsBilMY7jxQQJoQv3I77N7aw==
X-Received: by 2002:a05:620a:1aa5:: with SMTP id bl37mr4032257qkb.84.1630776218123;
        Sat, 04 Sep 2021 10:23:38 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id z21sm1893712qts.27.2021.09.04.10.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Sep 2021 10:23:37 -0700 (PDT)
Date:   Sat, 4 Sep 2021 10:23:34 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     "Moger, Babu" <bmoger@amd.com>
Cc:     Babu Moger <babu.moger@amd.com>, bp@alien8.de, bsd@redhat.com,
        corbet@lwn.net, hpa@zytor.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, x86@kernel.org
Subject: Re: [v6 1/1] x86/bugs: Implement mitigation for Predictive Store
Message-ID: <20210904172334.lfjyqi4qfzvbxef7@treble>
References: <20210812234440.tcssf2iqs435bgdo@treble>
 <20210902181637.244879-1-babu.moger@amd.com>
 <20210903000706.fb43tzhjanyg64cx@treble>
 <dca004cf-bacc-1a1f-56d6-c06e8bec167a@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dca004cf-bacc-1a1f-56d6-c06e8bec167a@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2021 at 07:52:43PM -0500, Moger, Babu wrote:
> > BTW, is the list of PSF-affected CPUs the same as the list of
> > SSB-affected CPUs?  If there might be PSF CPUs which don't have SSB,
> > then more logic will need to be added to ensure a sensible default.
> I can't think of a scenario where it is not same on a system.

To clarify, I'm asking about CPU capabilities.  Are there any AMD CPUs
with the PSF feature, which don't have SSB?

> > On a related note, is there a realistic, non-hypothetical need to have
> > separate policies and cmdline options for both SSB and PSF?  i.e. is
> > there a real-world scenario where a user needs to disable PSF while
> > leaving SSB enabled?
> 
> https://www.amd.com/system/files/documents/security-analysis-predictive-store-forwarding.pdf <https://www.amd.com/system/files/documents/security-analysis-predictive-store-forwarding.pdf>
> There are some examples in the document. Probably it is too soon to tell if
> those are real real-world scenarios as this feature is very new.

I didn't see any actual examples.  Are you referring to this sentence?

  "PSFD may be desirable for software which is concerned with the
   speculative behavior of PSF but desires a smaller performance impact
   than setting SSBD."

> > Because trying to give them separate interfaces, when PSF disable is
> > intertwined with SSB disable in hardware, is awkward and confusing.  And
> > the idea of adding another double-negative interface (disable=off!),
> > just because a vulnerability is considered to be a CPU "feature", isn't
> > very appetizing.
> > 
> > So instead of adding a new double-negative interface, which only *half*
> > works due to the ssb_disable dependency, and which is guaranteed to
> > further confuse users, and which not even be used in the real world
> > except possibly by confused users...
> > 
> > I'm wondering if we can just start out with the simplest possible
> > approach: don't change any code and instead just document the fact that
> > "spec_store_bypass_disable=" also affects PSF.
> > 
> > Then, later on, if a real-world need is demonstrated, actual code could
> > be added to support disabling PSF independently (but of course it would
> > never be fully independent since PSF disable is forced by SSB disable).
> 
> Do you mean for now keep only 'on' and  'auto' and remove "off"?

No, since PSF can already be mitigated with SSBD today, I'm suggesting
that all code be removed from the patch and instead just update the
documentation.

-- 
Josh

