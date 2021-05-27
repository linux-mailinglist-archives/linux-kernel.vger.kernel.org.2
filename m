Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 066873933A9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 18:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234982AbhE0Q0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 12:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbhE0Q0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 12:26:30 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF07AC061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 09:24:57 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id kr9so769933pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 09:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YE3BN5QSk4VUCTzPZRb3FD/xbSSlU+NU+OFFH90cO1o=;
        b=gsAaQ/ib2LS/Xbj2c8oXaHYsJ24DVq/8YzSpSHyt74sgHEdpECgogjDfEZkMiLWGwb
         YoaPKZNHNgHUGLDImzqN1kzliKir1GkwDxHIGUOKl5WvlPDqmAKhxUwlDuF8xIACDVIV
         bj+JP0ytBIWHhX8s6y5C5JeVrY0mr98h91ozaUOfk75K/1E3DGoY0xJDgjAhflkt2bZN
         P+gdx4wtY97tJIfWjtIcNXahb41aJofDo9GGy15ZMuxHtafDW/+SthO44WC82xp1WY2d
         xivwi6DxgvoG04yCnF8stknJ2jNnTi4PVk06aQjtVXI0WOE0R1byVNu1TRwUfYJTd8hC
         aGIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YE3BN5QSk4VUCTzPZRb3FD/xbSSlU+NU+OFFH90cO1o=;
        b=F6UhJ2ZZRXhy1/JX4qbimCDhkZlg5NM3Jd2vSZKA2cIuCT16srtayBFMrVF3DuHNYQ
         KKm4aRNpRb+m2AAoshdap0U2xmjDhUS3zS4TghCAfTMZPZVW5ZyIbHuOQVzQMki4lDMR
         tXcp9nMVe2cg4rHbyapoDmPMQo0Ym2Btt3QiirE24NTdq54Xm+HMsBjqYFUWOVcaMls/
         VBYl2SlZpin6ofYo/sSFwNm8jy/2CNYp1qiKvTz3fU+bzt1DFJVt0GB6aUhQQ52LEKZE
         8yqfuoBKf9fW/tsNwTqySQ3N3EZfD//4bC7jZKXe3wC5W2BV+6E85sL/WFJ7RJlKxied
         s3qQ==
X-Gm-Message-State: AOAM531f+qcUR/29pPZnuISwzqlHuQE+wu8JpwQnvSEAMrJcz43eDXQZ
        2/TYlLUKrgEP40p2D604E0E2OQ==
X-Google-Smtp-Source: ABdhPJwAp6Z6I/6hRXze1MLbyS5oQklxmXw19Pz8Fe69O01m0LwT2jjpUI2nIxkcwShXpgOYJmqlUg==
X-Received: by 2002:a17:90b:1d8f:: with SMTP id pf15mr10216159pjb.164.1622132697146;
        Thu, 27 May 2021 09:24:57 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id a15sm2289405pff.128.2021.05.27.09.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 09:24:56 -0700 (PDT)
Date:   Thu, 27 May 2021 16:24:52 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC v2-fix-v2 1/1] x86/traps: Add #VE support for TDX guest
Message-ID: <YK/H1CAc24UzPLDs@google.com>
References: <4031ffc2-a442-5da7-e793-ac1053533bb3@linux.intel.com>
 <20210527002931.3632581-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <636067f3ed65429ab1094b851aae5256@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <636067f3ed65429ab1094b851aae5256@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021, Luck, Tony wrote:
> +struct ve_info {
> +	u64 exit_reason;
> +	u64 exit_qual;
> +	u64 gla;
> +	u64 gpa;
> +	u32 instr_len;
> +	u32 instr_info;
> +};
> 
> I guess that "gla" = Guest Linear Address ... which is a very "Intel" way of
> describing what everyone else would call a Guest Virtual Address.
> 
> I don't feel strongly about this though. If this has already been hashed
> out already then stick with this name.

The "real" #VE information area that TDX is usurping is an architectural struct
that defines exit_reason, exit_qual, gla, and gpa, and those fields in turn come
directly from their corresponding VMCS fields with longer versions of the same
names, e.g. ve_info->gla is a reflection of vmcs.GUEST_LINEAR_ADDRESS.

So normally I would agree that the "linear" terminology is obnoxious, but in
this specific case I think it's warranted.
