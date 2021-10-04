Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E95C5421472
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 18:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237550AbhJDQzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 12:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237524AbhJDQzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 12:55:11 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D21FC061746
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 09:53:22 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id x8so309788plv.8
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 09:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZUf5cLarGbiZnEVQ0Jzbit4iKZIxXZvjgSxdN+0foqc=;
        b=Vx5dqKS/inyiI6BZVCDIbx4UiQ0h+MwxKSDQSPjEPPX2/1cd8EQ8qr9Bd+t2Iv9Vtn
         o4D0NdAD3wLu3IcOFiismcNxu+wyOjUhHv2Nq7pEOHKPMny+oFgaMtZ9OIpmcL0Lve85
         d3dnIiNMkk15Bv/lvsO50uuKyZj1h/4lSm6V4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZUf5cLarGbiZnEVQ0Jzbit4iKZIxXZvjgSxdN+0foqc=;
        b=v1HV8hf4AcQst0CR4b9jOh5kgPNr530TbZhcV3ls4lnaDtpJXIekCUdrkTaL6RTzUV
         /YDgMdgmCGECqy767AXnHDkey337k3co0rtV4q7vD/gzDWC45xnfxnZCGYIAAHEHnu09
         cjvd4Av934C6OndoH02ocaYlvr9pGpx5l9SvLQf5SLU6GhJLuanWV4t2zBVA8DiT+kKw
         nYhL3aTxIai6+PChyazOBPtiJlEysCpmw0hC4T3R/w+DNUt7EKMj4i8IRfEdRlipx6AY
         HY2s7QOWdXquQZrd05J2iQ9p0URhF4xshkGhVNngA7TOJciyA07WyneuSLgR25q2OXiB
         sGGA==
X-Gm-Message-State: AOAM533TijJFp2F625zj/xDJQCucYhKni0MkKu21n6BNFo7aMBr4PO7k
        ZddNUp3rqz+ChzqB1FCKAIp9fg==
X-Google-Smtp-Source: ABdhPJw6z9JMaEksrrfUCdhF1zMg6OajCMv5wDqRrCT1ktQzZlZPw+WHtJxMGyDW7ekLIIMMypGhFQ==
X-Received: by 2002:a17:90a:6c97:: with SMTP id y23mr31633347pjj.117.1633366401867;
        Mon, 04 Oct 2021 09:53:21 -0700 (PDT)
Received: from ebps (cpe-75-80-179-40.san.res.rr.com. [75.80.179.40])
        by smtp.gmail.com with ESMTPSA id z2sm3550319pfe.210.2021.10.04.09.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 09:53:21 -0700 (PDT)
Date:   Mon, 4 Oct 2021 09:53:18 -0700
From:   Eric Badger <ebadger@purestorage.com>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        "open list:EDAC-CORE" <linux-edac@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] EDAC/mc_sysfs: Print MC-scope sysfs counters unsigned
Message-ID: <20211004165318.GA700900@ebps>
References: <20211003181653.GA685515@ebadger-ThinkPad-T590>
 <045ce9cf33904a52a365a04c055c5cbf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <045ce9cf33904a52a365a04c055c5cbf@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 03:21:13PM +0000, Luck, Tony wrote:
> > This is cosmetically nicer for counts > INT32_MAX, and aligns the
> > MC-scope format with that of the lower layer sysfs counter files.
> 
> While this is technically the right thing to do, I pity the system administrator that
> is looking at a system with more than 2147483647 corrected or uncorrected errors!
> 
> So:
> 
> Acked-by: Tony Luck <tony.luck@intel.com>
> 
> but maybe this is just churn and not really useful in practice?

Pity accepted :). I only noticed the sign mismatch after seeing a
negative value on a server in the wild. But it's cosmetic really; if
you've reached INT32_MAX you'll probably reach UINT32_MAX and can't rely
on the counter.

Cheers,
Eric
