Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 481CA425717
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 17:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241969AbhJGPys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 11:54:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26555 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241930AbhJGPyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 11:54:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633621973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mki5wTjxXGr+IGNPFHM4xHf+VH4JglD76WJd/mMOISs=;
        b=ZW4NS9yiYE4RatWENqfxdIrdexBE5IuyMYLpDtyjwrKc9vRjnSADKsPFvzAA5DAQGjnXeH
        FtUYzyh0WKIuTO9Bnw8ZDq8ORN8pZc1SRkc5QSVFV538/KEo6dBG2x/FzbujCfFklzDG0r
        RpD512sTJRv9mGDWMOpr1c4lRR/OI0s=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-MI2ScWvrNpumP91FR8rxPw-1; Thu, 07 Oct 2021 11:52:52 -0400
X-MC-Unique: MI2ScWvrNpumP91FR8rxPw-1
Received: by mail-wr1-f69.google.com with SMTP id d13-20020adfa34d000000b00160aa1cc5f1so5056522wrb.14
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 08:52:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mki5wTjxXGr+IGNPFHM4xHf+VH4JglD76WJd/mMOISs=;
        b=CWC5j8i+ClY3NT+ypvfZv3N865ykZnwf4uiGSN5m72VmVL1WqtOqB0LsQmW5oZ9CQ1
         hD6uL+Xded1PgZNxkWlEnzC2/5mPm5MKEUbm736Df/eI+vPDdQhSUCD0HxvWQfZ/59mJ
         3ydQndWnuInk+IbeL8DtjSQUF5HKSYrRCRhYUnZzyAGizHDpweGtaxvKnFFxZNVkIUo/
         ZKxbN1Pzu9fUt/a0AGCTADQVYxswdDBvzY5URn3Wh1g6xQGYW6R2fkZIfA+phTDhO+Bw
         0jVyfTJgu2pRe4vbv9Yv8Onmar+bkJVRKTOT/lQgac/8ci8j1rzuEfkZmKht6tCIs8W1
         LiwA==
X-Gm-Message-State: AOAM532gyq/hr5qb0VFAmUNvb+QgG536nMiDVwu1pcmZmLtY9NVLBHDt
        cYXqwuXod+BcTrrE5VbzbTzzDbaPF2t2Tgy309L0IUBAy5PDMJRPiD3VUs0kLxkmakcGsUGZfq+
        2WZBkbupTihGkoPGVbzO3rdAB
X-Received: by 2002:adf:9b97:: with SMTP id d23mr6386625wrc.53.1633621970951;
        Thu, 07 Oct 2021 08:52:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxS9zzcdO8gEa8I10rZOiZ3zEoCv1L5U3v+lF61OvcEjd+iZrkvzPdw2F8ibmZvXvAL8shTg==
X-Received: by 2002:adf:9b97:: with SMTP id d23mr6386598wrc.53.1633621970756;
        Thu, 07 Oct 2021 08:52:50 -0700 (PDT)
Received: from gator (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id i92sm13012wri.28.2021.10.07.08.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 08:52:50 -0700 (PDT)
Date:   Thu, 7 Oct 2021 17:52:48 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org, will@kernel.org,
        qperret@google.com, dbrazdil@google.com,
        Steven Price <steven.price@arm.com>,
        Fuad Tabba <tabba@google.com>,
        Srivatsa Vaddagiri <vatsa@codeaurora.org>,
        Shanker R Donthineni <sdonthineni@nvidia.com>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        kernel-team@android.com
Subject: Re: [PATCH v2 00/16]  KVM: arm64: MMIO guard PV services
Message-ID: <20211007155248.ejwclkwnnsaunmc6@gator>
References: <20211004174849.2831548-1-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211004174849.2831548-1-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 06:48:33PM +0100, Marc Zyngier wrote:
> This is the second version of this series initially posted at [1] that
> aims at letting a guest express what it considers as MMIO, and only
> let this through to userspace. Together with the guest memory made
> (mostly) inaccessible to the host kernel and userspace, this allows an
> implementation of a hardened IO subsystem.
> 
> A lot has been fixed/revamped/improved since the initial posting,
> although I am still not pleased with the ioremap plugging on the guest
> side. I'll take any idea to get rid of it!
>

Pros/cons of the hooks

Pros:
 1) VM only needs to have a kernel that supports the feature (and a
    kernel command line that enables it)
 2) All the ioremapped MMIO ranges are permitted immediately, rather than
    deferring until some other event (which would probably be too late in
    many cases)

Cons:
 1) Having to have hooks, which is never pretty
 2) Adding the hypcalls to each ioremap, which adds some overhead
 3) Having to reference count all the mappings, which adds even more overhead
 4) Not giving the owner of the VM control over what MMIO is permitted
    (Well, maybe the VM owner just needs to blacklist drivers for anything
     that it doesn't want.)

I don't think any of the Con's are too bad and probably Pro-2 more or less
makes the hooks a necessity.

Thanks,
drew

