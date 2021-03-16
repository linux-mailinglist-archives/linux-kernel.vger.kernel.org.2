Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAA1E33DA39
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 18:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239051AbhCPRFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 13:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237362AbhCPREy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 13:04:54 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091C2C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 10:04:52 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id q12so6780045plr.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 10:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CzC+/B4EdyHDwI6X7IJ9Df2XewW8pzWZg0CKu8OOhaI=;
        b=slIKtPLW77a7QpWhFJSMudogMAj1TG0SbIbymQVHrTmFmuZR8J2djF/awgtNFuqs7B
         rLEicR+tlnFpSBnPWWS6U2HEOxg0RUwoJ9lYNp8a0GAtTIRjhHa5H+YGSsRIF2OQtgQ6
         EqxyCpi/lwjUp5YHqSFZrddKGFSVz6Em68mn7MkNkFZP95koMZVaqHuP0bPCCGLr2+AM
         Rih3KyMeDgZj29wH5iWo8MtdFiJ56J068PvawyCMSyJR7zD1ld6rqwMkD+PdbBp1wTNd
         XtEmlewJIgdPgi/iO+OZAHQC4O4KdoYNYceLf56mQz9+ymBp3C9KPt8rj7eUm6qRQV8o
         R2iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CzC+/B4EdyHDwI6X7IJ9Df2XewW8pzWZg0CKu8OOhaI=;
        b=bonQoU8zO4+FsBfB2GFsmgI4+A4+kB3bvl0o7i6xJaw4WhM/rc6LY5joaVPTMbwUWj
         frF+NTh0wufLkD9HE5YQjol8QAPwAqZaRkMgrhrQbCDFcC05QLeAX365y+aOpfUXEYTi
         YAkrFjgFY9MVELsl455iXMtB9fhF8/5JNnfqGCva6YwQxncl7xCVURdenkiSE0lY83ZR
         UL3SuANJcd/N19HA/xc+xqPNlKvi3dnekTbfaZw0f96YUxGdzYNcorC5TQFDSdNnGmBv
         mzy3JJT9/fXTQSaEE7dTB0IUuvJ/rtfAby6uOtpudvv6AqgPCo8+SDVcgf+/8QoiwAWp
         DqoA==
X-Gm-Message-State: AOAM530IuBg3buIOXOTvJHX87pDk5iX+eNYpcxXn42WbYMJmLliho5Oq
        sPT5f2q9VSXna2VWwY/EpqDveQ==
X-Google-Smtp-Source: ABdhPJzaDot0sXCsA9DRJmuhRYgBWvzxvZECQwqhj7HngwE8kLQUGAYZqWa4F8K5huqxKIBABQbiQw==
X-Received: by 2002:a17:903:4093:b029:e5:b933:fab7 with SMTP id z19-20020a1709034093b02900e5b933fab7mr361281plc.11.1615914291294;
        Tue, 16 Mar 2021 10:04:51 -0700 (PDT)
Received: from google.com ([2620:15c:f:10:e113:95c2:2d1:e304])
        by smtp.gmail.com with ESMTPSA id i17sm18838958pfq.135.2021.03.16.10.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 10:04:50 -0700 (PDT)
Date:   Tue, 16 Mar 2021 10:04:44 -0700
From:   Sean Christopherson <seanjc@google.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Feng Tang <feng.tang@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] tools/x86/kcpuid: Add AMD leaf 0x8000001E
Message-ID: <YFDlLHsE7AhOgkDi@google.com>
References: <20210315125901.30315-1-bp@alien8.de>
 <20210315125901.30315-2-bp@alien8.de>
 <20210316074223.GC49151@shbuild999.sh.intel.com>
 <20210316142825.GB18003@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316142825.GB18003@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021, Borislav Petkov wrote:
> On Tue, Mar 16, 2021 at 03:42:23PM +0800, Feng Tang wrote:
> > Also I'm wondering for some basic leaf and extended leaf which
> > may has different definition for different vendors, do we need
> > to seprate the csv to a general one and vendor specific ones.
> 
> Do you know of such?
> 
> Because AFAIK vendors own, more or less, each range. Like, Intel owns
> the base range and AMD the extended so there should be no conflicts
> actually...

There are no known conflicts, and all sorts of things would break horribly if
any CPU vendor (or hypervsior) were careless enough to redefine a CPUID bit.
