Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47CEE41EDC4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 14:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352680AbhJAMtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 08:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbhJAMta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 08:49:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA3FC061775
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 05:47:46 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633092464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+zX6xGPW4mN3Q3tFL/FI5GEAMCMZRY7LeLocGO6ysPA=;
        b=bih0NorCA2IylQNBiPAA3Wk8N2KbwmrYUhCEiGby65TSTwuL2fZgZQsG9Oepqdngf89Tot
        VRM4Ork3oQUCZLjOdyYEu66QLwHq33PIUqhaAXYRiRQ83nEkLi9rO1fRF1CUsFZa597+ak
        YQoJh7mNh0WcmFax+uw/Hq5cY83BXS7RKVp2zKNkAbYKiXlpwCsRKEj2K+DJ6FWHfDu32u
        3acGwhlq3+rrOZ6nhcQa6GG7simBMbXq6LYu/V7QToltVQnVaO9g6VTZ0bSoOcCnVTJIer
        64TEBb2cuz2Y+fuTrhk3ftE20EiG29wB8gRdJg+enQzRPMmeRHsyHhwuXEfQTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633092464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+zX6xGPW4mN3Q3tFL/FI5GEAMCMZRY7LeLocGO6ysPA=;
        b=CnhBJ/BK5mtos67sfYdQpA3pLcjglTCZzGwVkd89iP3Sq+DuHqnC2e/AEPtCsovI6DGSUd
        OFQeYluxtH54BjAg==
To:     "Chang S. Bae" <chang.seok.bae@intel.com>, bp@suse.de,
        luto@kernel.org, mingo@kernel.org, x86@kernel.org
Cc:     len.brown@intel.com, lenb@kernel.org, dave.hansen@intel.com,
        thiago.macieira@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: Re: [PATCH v10 03/28] x86/fpu/xstate: Modify state copy helpers to
 handle both static and dynamic buffers
In-Reply-To: <20210825155413.19673-4-chang.seok.bae@intel.com>
References: <20210825155413.19673-1-chang.seok.bae@intel.com>
 <20210825155413.19673-4-chang.seok.bae@intel.com>
Date:   Fri, 01 Oct 2021 14:47:43 +0200
Message-ID: <87h7e06he8.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chang,

On Wed, Aug 25 2021 at 08:53, Chang S. Bae wrote:
> Have all the functions copying XSTATE take a struct fpu * pointer in
> preparation for dynamic state buffer support.

Which is something different than the subject line claims to do and
still does not explain why this code needs access to struct fpu later
on.

Thanks

        tglx
