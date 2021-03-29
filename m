Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84BA134DC96
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 01:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhC2XnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 19:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhC2Xmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 19:42:53 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8FEC061762
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 16:42:52 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id j25so10917656pfe.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 16:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=h+wJXOEMC8At45TMqFATNY+SKf4q3vJk6Lx/7UNxXuo=;
        b=wNyi932SrWneeiQ8OAfUMKdbtCCjscxR/JGUfJfUjEALRmOIpesKAdUeOxzVq8MHvp
         wJDONIIGY2+pKhE6ShhK9dF5IeezmJ4uP9VsceE29TRhXQOPwQJzG+COWWi9TUY16hGD
         2kbk9PpBgMOwrtbtJKV51pjEAk8QNbbYZqdNmIqYWQDiFGYiaXPUclDHf2tyhIhZvn8N
         llyvS/ishWnvwCw6hJFtY2ccKJuwasGHLU+fHefIn+KB0Ir8TeUDwC+8shF59nrJOu0B
         8zJos6robUj7e/5CTTvcHE21jLEuWk8iXYkg2hRQsaYIHV9AMLo+U6PyF37qL/7O1MPC
         V+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=h+wJXOEMC8At45TMqFATNY+SKf4q3vJk6Lx/7UNxXuo=;
        b=PTVWEfgG2FGW75almWJi1bVeieprxefjud9+OC7MkBD4uuK+fXePsu3LA0E6IjgzqQ
         UneeaXjNsNi/xBaNzvBFshZ6YpQ1o+/XHNYROXayWOmV3gRfm7DwZlL/fxlSOcRUYLDb
         y/tmFrnR71cieMQz1pvd/otP5QzrpcrDAyCrTyAXBhMRGT0H6xd7Y0e8s6vZrHiUDowA
         Jzb3hj+cHCsf5nfE+zThdUzzxhHWmR6CcmZmZC5Mk1AeVJ+lKuZVmGK+dMpBf4kA+baC
         Vk75WeQd/GlEDmvMZLbC5UPSEy/b28zrfg2gM6nD8kRd2/YPG8LerJH+pE1EkxUs/cy/
         rHMg==
X-Gm-Message-State: AOAM533q7pfvnH7nFfP4iQIHOgsT6gH94L9CiaiiVrshIaoF0z3wCRtF
        LkoyEc+f0MgLsCRnTDoGXLSMSQ==
X-Google-Smtp-Source: ABdhPJxG1pFNW5rDlJfFlNIHagSNsYDT87Ru31Un4J5k6cxKhDQRFqaciwZzyeQPmyMYVrjaqbTl5Q==
X-Received: by 2002:aa7:9394:0:b029:1f4:2b30:4cdb with SMTP id t20-20020aa793940000b02901f42b304cdbmr27962750pfe.50.1617061371959;
        Mon, 29 Mar 2021 16:42:51 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id v18sm20812904pgo.0.2021.03.29.16.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 16:42:51 -0700 (PDT)
Date:   Mon, 29 Mar 2021 23:42:47 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] x86/tdx: Handle MWAIT, MONITOR and WBINVD
Message-ID: <YGJl93hlKngWLGwz@google.com>
References: <837afe840f5826bf7fcba07a5e483d7e2283db34.1617059703.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <377A7B0B-9959-4AFC-A575-7AC20FEE6077@amacapital.net>
 <10834a17-cae4-d0e3-c82b-f69da7f9141a@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <10834a17-cae4-d0e3-c82b-f69da7f9141a@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021, Kuppuswamy, Sathyanarayanan wrote:
> 
> 
> On 3/29/21 4:23 PM, Andy Lutomirski wrote:
> > 
> > > On Mar 29, 2021, at 4:17 PM, Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> > > 
> > > ﻿In non-root TDX guest mode, MWAIT, MONITOR and WBINVD instructions
> > > are not supported. So handle #VE due to these instructions
> > > appropriately.
> > 
> > Is there something I missed elsewhere in the code that checks CPL?
> We don't check for CPL explicitly. But if we are reaching here, then we
> executing these instructions with wrong CPL.

No, if these instructions take a #VE then they were executed at CPL=0.  MONITOR
and MWAIT will #UD without VM-Exit->#VE.  Same for WBINVD, s/#UD/#GP.
