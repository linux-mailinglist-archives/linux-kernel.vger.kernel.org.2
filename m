Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D49F316E41
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 19:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbhBJSPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 13:15:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233648AbhBJSEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 13:04:49 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1948C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 10:04:08 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id l27so2524407qki.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 10:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fn4OROpwcMvlPuFG0mr8IX6FA+jFG3+mu5LheKqkXo0=;
        b=iPiobhPwf6KAYITESCCZiytaCFr72WzGFqO5Krxg583eeHZJJswee2IVlHJuHVFk51
         hUWKXhD6qUJQZ9akF+hoJ0SBMSynl89auCrmXzGqpwVR8TTrOwLCakALhhncmc/31KKO
         w5cpzUSnU3cZ2kGIXac5w3JXTOg1uG5uRsLrYjb0siJVoMpiahMmcfRtKm3eynVnB77A
         qq+aY8bUIaIHuFg9y9XapEOc7TwpMRqaDXdJ3B4ZZnVPlh2aFbugjNjlrCgAvTvQbuiv
         8rQnonVEPXVhg74c+0AallmP+gLOo6xaV7ay5dZwzBUgW+9vToCfuh+GOlDUSGRfOBpQ
         oKbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fn4OROpwcMvlPuFG0mr8IX6FA+jFG3+mu5LheKqkXo0=;
        b=RCXyLA+rjSdKGn0swidkskE8mcbL6WBO5Ikyqiky+kOmFkgZR8aNBjyfAaf3MDGS3Y
         vqKLOI01UWZs5KXRQ3B0ARLsO0wiSovugXWrszOcer8HRqTExCPHusxRwXM8erf9U0wm
         JSK7mAwQZkwrsaM2zWsu1hF8jQj1UUxa55QUnZjxXMlH9Cq5i9GYDGwCXWQBpJ6QMQ//
         85H9llxy1hrvxeY0Z1hS0OBH+Ztk0poA2A8t6V7XwqwvTnYZSsxjFKGzXiOF10vG69Yk
         g2TJKpLvfzwpr97xP2rmRRF4/HZWlmsWZvCiC9vWFa7o3AjiiM4FcsYrBrsXm2985s1t
         /40A==
X-Gm-Message-State: AOAM530fYGDes0RJsrKX3jeNLejcif8IuqbG0vRKqi0WGSIj2zOmdJiP
        PQAbW6E5uxyV/MHvUv0Bx/6siA==
X-Google-Smtp-Source: ABdhPJyf3nDN5LDKdSKYE48IyBU6XZ6U0kgAEb02GCT83X4HerFr5BHXcsaa/epIdRev4YLuR0GG8A==
X-Received: by 2002:a37:6f01:: with SMTP id k1mr4613354qkc.252.1612980247944;
        Wed, 10 Feb 2021 10:04:07 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id j46sm1828038qtk.1.2021.02.10.10.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 10:04:06 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1l9tqP-0068Ck-JW; Wed, 10 Feb 2021 14:04:05 -0400
Date:   Wed, 10 Feb 2021 14:04:05 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Cc:     David Hildenbrand <david@redhat.com>,
        "Wangzhou (B)" <wangzhou1@hisilicon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>,
        "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
        "chensihang (A)" <chensihang1@hisilicon.com>
Subject: Re: [RFC PATCH v3 1/2] mempinfd: Add new syscall to provide memory
 pin
Message-ID: <20210210180405.GP4718@ziepe.ca>
References: <1612685884-19514-1-git-send-email-wangzhou1@hisilicon.com>
 <1612685884-19514-2-git-send-email-wangzhou1@hisilicon.com>
 <a587bd61-9194-4b46-c122-8b4da7b941a8@redhat.com>
 <20210208183348.GV4718@ziepe.ca>
 <0dca000a6cd34d8183062466ba7d6eaf@hisilicon.com>
 <20210208213023.GZ4718@ziepe.ca>
 <0868d209d7424942a46d1238674cf75d@hisilicon.com>
 <20210209135331.GF4718@ziepe.ca>
 <2527b4ac8df14fa1b427bef65dace719@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2527b4ac8df14fa1b427bef65dace719@hisilicon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 10:22:47PM +0000, Song Bao Hua (Barry Song) wrote:

> The problem is that SVA declares we can use any memory of a process
> to do I/O. And in real scenarios, we are unable to customize most
> applications to make them use the pool. So we are looking for some
> extension generically for applications such as Nginx, Ceph.

But those applications will suffer jitter even if their are using CPU
to do the same work. I fail to see why adding an accelerator suddenly
means the application owner will care about jitter introduced by
migration/etc.

Again in proper SVA it should be quite unlikely to take a fault caused
by something like migration, on the same likelyhood as the CPU. If
things are faulting so much this is a problem then I think it is a
system level problem with doing too much page motion.

Jason
