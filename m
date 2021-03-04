Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2D932D726
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 16:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235851AbhCDPwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 10:52:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235819AbhCDPwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 10:52:51 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48490C061574
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 07:52:11 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id l4so13430286qkl.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 07:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UVTHD8LhK8UyWLEkqfiBsImG1nDjl1nSzP50Iq84vq4=;
        b=xDlUk5LDqYnvOZfLk2uhMtwxHSfTd9qm5AkR8hSwcV9x6vspQSOwRQMB44GtB7/tnO
         B4qdvHAQBjz6juy5G0vWMSZDh/5MOVerzItjEK4W82luWG2fNalBzWQSmZ0kb9iitQU8
         E6USb76BAxlvbo9toTBXC9uLyWA0nrtsE/InKO7HpLGDSps0egOwZTT49cxOd9sU93aW
         rioa9S6y/vmTac1pRuIfCfpqsmBX2nv2TFybF2g2Bf/aZp6f4kPSfuFqEm9wCVJXUBpz
         NwjX9qIzTFsjpc7BXrA0TW/YLzTgKzCx5D+T4FPiPep3hqkbDhzQc4KiDIN8P36dt+8I
         GWkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UVTHD8LhK8UyWLEkqfiBsImG1nDjl1nSzP50Iq84vq4=;
        b=Uo8SwK2XqKigT4lzinLt/6clYXpn0EuC8vLNcxYsX5Pe15XKpSytN1XpIfiIorfRi8
         iugWm9umaBpkvH4eJI13ekiUgje+PN8OjKh++FzvwkNrFYy/vN083katNYBw69wV90is
         1geSSuG0wuLwpHQoWvadNVshKoTqHXyio2BsY17R45EBGoBv52qb4aR7cPS7C1hcc1np
         0Whie9S8upIQ0frSlnE2IKJCExQjrRbp4yFD8oGsV6rLUm739Lj6yBvtqIbmxoLx+93h
         dDROq1smwHfbtyan/FpJHaGGq8SIFpSG8EoNo+CrJnzYXAEC+moTBXpIxCixVUs784LP
         FkMw==
X-Gm-Message-State: AOAM530WlEpgOfsJimAoMJjjh1aQWkEzPKS2DZlMnAp0abKvclxuZPvD
        D5kbDWdQ3o0ziUOrNZ7xO9n1uA==
X-Google-Smtp-Source: ABdhPJxmN5Rio80nCTCLHjH7lxKNtGYfwSnGRAItL/DXSd41sbJu+3DF9XoFIZY0iUyhTUiSI4OfQw==
X-Received: by 2002:a37:a615:: with SMTP id p21mr4596903qke.352.1614873130597;
        Thu, 04 Mar 2021 07:52:10 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:b28e])
        by smtp.gmail.com with ESMTPSA id a9sm17591946qtx.96.2021.03.04.07.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 07:52:10 -0800 (PST)
Date:   Thu, 4 Mar 2021 10:52:09 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Zhou Guanghui <zhouguanghui1@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, mhocko@suse.com, hughd@google.com,
        kirill.shutemov@linux.intel.com, npiggin@gmail.com, ziy@nvidia.com,
        wangkefeng.wang@huawei.com, guohanjun@huawei.com,
        dingtianhong@huawei.com, chenweilong@huawei.com,
        rui.xiang@huawei.com
Subject: Re: [PATCH v2 2/2] mm/memcg: set memcg when split page
Message-ID: <YEECKZBBWpK/Gl6R@cmpxchg.org>
References: <20210304074053.65527-1-zhouguanghui1@huawei.com>
 <20210304074053.65527-3-zhouguanghui1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304074053.65527-3-zhouguanghui1@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2021 at 07:40:53AM +0000, Zhou Guanghui wrote:
> As described in the split_page function comment, for the non-compound
> high order page, the sub-pages must be freed individually. If the
> memcg of the fisrt page is valid, the tail pages cannot be uncharged
> when be freed.
> 
> For example, when alloc_pages_exact is used to allocate 1MB continuous
> physical memory, 2MB is charged(kmemcg is enabled and __GFP_ACCOUNT is
> set). When make_alloc_exact free the unused 1MB and free_pages_exact
> free the applied 1MB, actually, only 4KB(one page) is uncharged.
> 
> Therefore, the memcg of the tail page needs to be set when split page.
> 
> Signed-off-by: Zhou Guanghui <zhouguanghui1@huawei.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
