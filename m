Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A161E30FB5D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 19:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239079AbhBDSZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 13:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239044AbhBDSZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 13:25:09 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F466C0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 10:24:29 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id l12so4739477wry.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 10:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bqhKJeoVgC8X9omnqAQFhGwn7i6vcm5biCu8hCuSmsc=;
        b=mS1F26WRUDL/2eC6m6CaQ7EFMSsdGeTCCOhzSMDCjGT93wLceWJ9el78YcVG2XqT5i
         UqVytoukFRxRQT8DHQOcZSdezf6aZfm4cMHxWtUBL914wTBeCU3B+7bROExs5LUwFrCJ
         WXe2PCmgsr4VArHc42+FuL7ILIXzXBFQv0oVLONVawbLaWqcC6hgjXQBMZBD6TX8J8dJ
         3TrqtrEJZ117lGENT5OWBVyBNmhfhsO2lc4Ev0t3lQ+xJX2ZNI9xwHK76j1T8+bfINfz
         SSnuRec1a0u+Fgv5p1JNHOiDUnNYpC3ZZM4JebJW5CZizUNezhin4g67sF9QjV0HpO74
         meWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bqhKJeoVgC8X9omnqAQFhGwn7i6vcm5biCu8hCuSmsc=;
        b=S+NAT0CmT25GnmzKm2nVXGOE0EZ5bock4GJXoAqlNC+nww7K+je55SBmGeuabKVfZx
         rhj+ONoJSuTY7Zq3m9HPVX1W9qwvh/B94mzHnmhDsPshGRLmkzDWa+aAwlqNnCm+ex1h
         Xe5opVJeyGiYEGrxBYQfKkyjNTc/Td95gnc1KIExhBnI7oqZJBK9ci02oeUEl8v1aflu
         0zzo/1Uht0xQ168elGfCu3GlFA97O5uBQv5w/m7jzXZUOkeu9w5Z69Uw54zhR59l+myx
         9HXfOHq7U8orA8s023xoGDIetjpG5X78uTYmA4aoyU0sHF5HSDDjARVxu7n7ZjuuhnLR
         59aQ==
X-Gm-Message-State: AOAM5316ept1G4eVfnH+c/ctF6g1ortGrBljCyppYAj1u2p1XsNxHnP4
        9Ykxvp1nYL+64SlCd+L6CoGdfw==
X-Google-Smtp-Source: ABdhPJyY9kiYlOPf8laxHOlhG16GwuGMkScM8L4Dj0rm/ARmDfAXf85n5/++3N6RBc9bsoayAr8Ncg==
X-Received: by 2002:adf:e642:: with SMTP id b2mr668852wrn.221.1612463067694;
        Thu, 04 Feb 2021 10:24:27 -0800 (PST)
Received: from google.com (230.69.233.35.bc.googleusercontent.com. [35.233.69.230])
        by smtp.gmail.com with ESMTPSA id g14sm9650047wru.45.2021.02.04.10.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 10:24:27 -0800 (PST)
Date:   Thu, 4 Feb 2021 18:24:24 +0000
From:   Quentin Perret <qperret@google.com>
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, android-kvm@google.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        Fuad Tabba <tabba@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>
Subject: Re: [RFC PATCH v2 12/26] KVM: arm64: Introduce a Hyp buddy page
 allocator
Message-ID: <YBw72KeLQ5dzSoJi@google.com>
References: <20210108121524.656872-1-qperret@google.com>
 <20210108121524.656872-13-qperret@google.com>
 <20210202181307.GA17311@willie-the-truck>
 <YBrsep4xK1F4YRWb@google.com>
 <20210204143106.GA20792@willie-the-truck>
 <YBwKRM3uHDMC9S0U@google.com>
 <20210204174849.GA21303@willie-the-truck>
 <YBw2aIr/Ktx1dsOT@google.com>
 <20210204181317.GE21303@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204181317.GE21303@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 Feb 2021 at 18:13:18 (+0000), Will Deacon wrote:
> I was going from memory, but the loop in __hyp_alloc_pages() searches up to
> HYP_MAX_ORDER, whereas this is _never_ going to succeed beyond some per-pool
> order determined by the size of the pool. But I doubt it matters -- I
> thought we did more than just check a list.

Ah, I see -- I was looking at the __hyp_attach_page() loop.

I think it's a good point, I should be able to figure out a max order
based on the size and alignment of the pool, and cache that in struct
hyp_pool to optimize cases where this is < HYP_MAX_ORDER.
Should be easy enough, I'll see what I can do in v3.

Thanks!
Quentin
