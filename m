Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5773332BF69
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1835409AbhCCSDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:03:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378904AbhCCPPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 10:15:43 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD41C061765
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 07:15:02 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id n79so12661000qke.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 07:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Z7SFVE/srJLy7vxPjSXUxrCBmwOGTmTd/OLDwsoPcO8=;
        b=LgMwZyQ0cO+dRf5zC9bNib0XjzGon02Jq3aGKR2c+otD2ltKr93V01PyRtNV59FEvH
         O1umCO/uEcR2DiKONx+rFazPA9hoEFi4eFROAkakDZz4ixGowIYdviwqbRAtnUEVu2sG
         Yjvg7svG1RD4SRVybeEeIEXTVJi7g3DsEDFiXptDNrS0PVjm0Vi2aHlA7JJ6H9vj/qjD
         mc9D+Zp6zv1rXx6CQayXYY0tIJ5pEruxCqpR4GXhWKU+9TRSR/eck6xDOnOv9nixLTxv
         OxR3hWuWArABwiVJa3seHmLSBy+t/g4h0rsAdWWY6xH+BNbwtvQuJ66o/DDeSmXNz6tw
         Xceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z7SFVE/srJLy7vxPjSXUxrCBmwOGTmTd/OLDwsoPcO8=;
        b=I7CK7iVLlB6gyfynDvxfXLAuUpBhJr0nIHRtfE3ca2gsWgEgdbrzArinsi8RQXswzD
         dME0WkDMMXC2NIOwGwQYx8oz+dwaJ1BaUkSG3sXySmdfxRs7GtNxk7l9xcscjS5ulQtd
         rBNWDCqf6/56VjYES1k1vfT1V442sVRlU9Ry2cVE7IHBBhhuaE07VUbIfCpugRweouOD
         ehs4dhpBh/u3PqSEJ6bSzZOIWHxde5XPYpE3Y/HEIx2KQyeqBAbQ3eN8ITUJwLgKKN0J
         PCV8Bi1CHV+gKvb7CZXx+AyA1CpqWmimXwim9CdFLfiaw3Wnxbd4vqId9UE9cNF45M8Y
         ZoxQ==
X-Gm-Message-State: AOAM533JkI4QfKpqCs0KXiPhxmyFG6m0wkKB0Fsk77prsm4n5C7m4Nx5
        2zqJ92q80fI0ZBKvxAIDUqNNDQ==
X-Google-Smtp-Source: ABdhPJxgYj9Ivq+hFmZYQLcGJ8uQzll2GItADzptAY0NcMN2gnStfNbCJDutDNK9e9nIVoEMY9L36A==
X-Received: by 2002:a37:9003:: with SMTP id s3mr7829035qkd.361.1614784501524;
        Wed, 03 Mar 2021 07:15:01 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:5636])
        by smtp.gmail.com with ESMTPSA id r10sm11403961qtb.26.2021.03.03.07.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 07:15:01 -0800 (PST)
Date:   Wed, 3 Mar 2021 10:14:58 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     guro@fb.com, mhocko@kernel.org, akpm@linux-foundation.org,
        shakeelb@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2] mm: memcontrol: fix kernel stack account
Message-ID: <YD+n8pyJmHYNrCWW@cmpxchg.org>
References: <20210303093956.72318-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303093956.72318-1-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 05:39:56PM +0800, Muchun Song wrote:
> For simplification 991e7673859e ("mm: memcontrol: account kernel stack
> per node") has changed the per zone vmalloc backed stack pages
> accounting to per node. By doing that we have lost a certain precision
> because those pages might live in different NUMA nodes. In the end
> NR_KERNEL_STACK_KB exported to the userspace might be over estimated on
> some nodes while underestimated on others.
> 
> This doesn't impose any real problem to correctnes of the kernel
> behavior as the counter is not used for any internal processing but it
> can cause some confusion to the userspace.
> 
> Address the problem by accounting each vmalloc backing page to its own
> node.
> 
> Fixes: 991e7673859e ("mm: memcontrol: account kernel stack per node")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>

With changes proposed by Shakeel and Michal, this looks good to me.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

I guess the BUG_ON() was inspired by memcg_charge_kernel_stack() - not
really your fault for following that example. But yeah, please drop it
from your patch. Thanks!
