Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87F973A2E6F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 16:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbhFJOoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 10:44:07 -0400
Received: from mail-lj1-f175.google.com ([209.85.208.175]:47009 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbhFJOoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 10:44:05 -0400
Received: by mail-lj1-f175.google.com with SMTP id e11so5191334ljn.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 07:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w7cTvg5Z5DJncBADLZGV4GDgWHVz8pNe7eJCnwA2Y4w=;
        b=Sbl2yvQUGTLCRqNr7A7e3HSsB4T7oT+UNZaOMFGYW9IeV5Q1mrrr5PdYhLn0DOBG1j
         K6cmTkS2nHIKAkwZJpBZY3NxpHMu55gi2tKnJo171jEhARmkO+KetdOR4siznZQM4BO7
         O+RyuIb9vkHPboAuhp2E9f6WWjAZUHssAk8wtbdEBndRDNTMvLohmI3C9i07cgRTvKlG
         SPmgTMHQjDLjQjfBCzuKFlmhZNwE3CC1a73mGgoc3+QgFjq0ossmZa94pPLJz5EkFaUn
         F5mZ0VfUsg4YJF3Q4OF1KS7F6VjEAah2OrBnOIxO0sWZQYjOQkZY+l0FaTD+sfkVsLBP
         EvbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w7cTvg5Z5DJncBADLZGV4GDgWHVz8pNe7eJCnwA2Y4w=;
        b=SEQtXTaTJjXIjuzhRmn66nVy1pzv4Co+SgGZV4saEZtYwEUJPbVqAK5GL+VhvKxU/R
         2tvKxGymu7isAa3gPIJ/0LRGSxMb6ou+PFREfLq2Al/Vq2RanHI0IjJNqx0ZZjbzCIh0
         /nCeWc6VkPliTJxV1Bi7RLR88bRjjSSDtMyeNCLwUEE/lOT+xtjxz9zUKIZ8X7qa9Qgm
         GoUmOWPt/IKTFTkXhcH9mHZuPqN9JBFwYKVMDa0fHGeXirWTFGRgMiiHlTwHb9DppsOD
         XT858PeNp+yVnn919r/9IhzjwwUeNMszRV77ZqL1cL+kGxEMEtG8cxwrTpooihH8WU8f
         HxwQ==
X-Gm-Message-State: AOAM532bqpdYIyOZn8IJ/nqtJq/7Y7ClJ+6ppXcUn9Iy0Oz42tBRgGYn
        lKck1c7wzBcri1TMc7rpixeslQ==
X-Google-Smtp-Source: ABdhPJwkvqkG+K7UUvzBQgdj1nJptVRu+DidcKEuTCIirE4w+o41jZxDFpamrNMzF2tID9M4yQNL3A==
X-Received: by 2002:a2e:9a4c:: with SMTP id k12mr2533207ljj.172.1623336056416;
        Thu, 10 Jun 2021 07:40:56 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id i17sm317035lfe.31.2021.06.10.07.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 07:40:55 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id EE9211027EE; Thu, 10 Jun 2021 17:41:11 +0300 (+03)
Date:   Thu, 10 Jun 2021 17:41:11 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v1 03/11] x86/cpufeatures: Add TDX Guest CPU feature
Message-ID: <20210610144111.lfqs43xweiaogdic@box.shutemov.name>
References: <20210602022136.2186759-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210602022136.2186759-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YMIFVh9WpDiUuRsa@zn.tnic>
 <20210610142943.uohw6nzpip5yi4no@box.shutemov.name>
 <YMIjRC7dD4als88Z@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMIjRC7dD4als88Z@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 04:35:48PM +0200, Borislav Petkov wrote:
> On Thu, Jun 10, 2021 at 05:29:43PM +0300, Kirill A. Shutemov wrote:
> > No, "tdx" is host feature. It is part TDX host enabling. This feature
> > indicates that kernel runs within TDX guest and named accordingly.
> 
> So there will be X86_FEATURE_TDX_GUEST and X86_FEATURE_TDX, latter to
> mean TDX host functionality?
> 
> Are those patches somewhere public for me to see?

Yes. You are on CC:

http://lore.kernel.org/r/9a74fb153bc21dc5cac46e84913b88182f216d1b.1605232743.git.isaku.yamahata@intel.com

-- 
 Kirill A. Shutemov
