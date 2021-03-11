Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E85133376EA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 16:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234096AbhCKPWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 10:22:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbhCKPVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 10:21:43 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F69C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 07:21:42 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id d20so20964536qkc.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 07:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wLIhdavW8MaDURDGJcZRIIUE4Aj3H3GIRyebjCvQFLM=;
        b=tH8SNVYbUkOa/85pkUQlHcQ9sJWhweqs7CAcvDIhcF4V3W/f3IGYUi51MiTRGcVbdk
         Wf9wbp6AGPVVHq+bGG66VzZbYZkkP5AjcsOrEMIl5yptJcJ5/a9wPNBcjv4MjrpwIw39
         FbEg+KKWp2d7IkzIbqndJnKmd4NX3JyC95xDFCP4MMYqe/mC70xlBWc2nrAbWeNJcEYw
         wpQNGGozxIlDk9CbeOXJmQISOhnkCdhkN/634b+Ehfo8LQzqcJf1UYZDnfEymVoNl05E
         FBUE8KeVAVDwFQuVYnMdLdH5kkBGozeihGdAlbo7DPp0KNl+9vsIZzvt27zBdmCjteAK
         ZnBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wLIhdavW8MaDURDGJcZRIIUE4Aj3H3GIRyebjCvQFLM=;
        b=RM64idoSJB0GGNHzKg2OAMeb7L1KYuJKpmwXzWO7ddrIv4JX5dgDBn3yD8oA5kfloe
         /b6ujSViDhBboAgPTkeAQZsx6V5BnGKbg75KPHIjheDlLXGucNL2XepishwYGduWqO4b
         wAhJ3vi4bBSf2rYUK1tBplCKu1Vd4y069n6cfTDi2PVJWbMWLwf5g5H4YvHmIvDBX3ho
         2dlHr/sVrbC/ubm3tCfkDsWbf4wDqvk747MG3Isx3GKE66clo4vaLtqg9FDi3X5g7IIj
         YLR5d4damsB05fQz6sAckPUTwXp0MyJuv4oqugvwh0mqkC7Ajcj3ZWW96msM6R5TOfSe
         To7A==
X-Gm-Message-State: AOAM531a9qy2METYeeX+AeBaw4x0j93C7Gl1g+6oPEgdsMLpWVs7aM6c
        Augwh/fl8UiyVThxGGJF7VzyXGKF/BpAVA==
X-Google-Smtp-Source: ABdhPJxAtYcFORaGg0aLnmlbrVA3vygapVhtj8/eqEOia+G6JLcfnW/wG6WkOQJ12+mBr5xjuyhU5w==
X-Received: by 2002:a37:a8d3:: with SMTP id r202mr8243024qke.383.1615476101342;
        Thu, 11 Mar 2021 07:21:41 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id s133sm2193001qke.1.2021.03.11.07.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 07:21:40 -0800 (PST)
Date:   Thu, 11 Mar 2021 10:21:39 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Zhou Guanghui <zhouguanghui1@huawei.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, hughd@google.com,
        kirill.shutemov@linux.intel.com, npiggin@gmail.com, ziy@nvidia.com,
        wangkefeng.wang@huawei.com, guohanjun@huawei.com,
        dingtianhong@huawei.com, chenweilong@huawei.com,
        rui.xiang@huawei.com
Subject: Re: [PATCH v2 2/2] mm/memcg: set memcg when split page
Message-ID: <YEo1gz6wuYl1Fuqt@cmpxchg.org>
References: <20210304074053.65527-1-zhouguanghui1@huawei.com>
 <20210304074053.65527-3-zhouguanghui1@huawei.com>
 <20210308210225.GF3479805@casper.infradead.org>
 <YEc5iI+ZP7dWr2fC@dhcp22.suse.cz>
 <20210309123255.GI3479805@casper.infradead.org>
 <YEdyJ+ZK2l7tu0rw@dhcp22.suse.cz>
 <YEnWrg2XFwZ2PR0N@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEnWrg2XFwZ2PR0N@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 09:37:02AM +0100, Michal Hocko wrote:
> Johannes, Hugh,
> 
> what do you think about this approach? If we want to stick with
> split_page approach then we need to update the missing place Matthew has
> pointed out.

I find the __free_pages() code quite tricky as well. But for that
reason I would actually prefer to initiate the splitting in there,
since that's the place where we actually split the page, rather than
spread the handling of this situation further out.

The race condition shouldn't be hot, so I don't think we need to be as
efficient about setting page->memcg_data only on the higher-order
buddies as in Willy's scratch patch. We can call split_page_memcg(),
which IMO should actually help document what's happening to the page.

I think that function could also benefit a bit more from step-by-step
documentation about what's going on. The kerneldoc is helpful, but I
don't think it does justice to how tricky this race condition is.

Something like this?

void __free_pages(struct page *page, unsigned int order)
{
	/*
	 * Drop the base reference from __alloc_pages and free. In
	 * case there is an outstanding speculative reference, from
	 * e.g. the page cache, it will put and free the page later.
	 */
	if (likely(put_page_testzero(page))) {
		free_the_page(page, order);
		return;
	}

	/*
	 * The speculative reference will put and free the page.
	 *
	 * However, if the speculation was into a higher-order page
	 * that isn't marked compound, the other side will know
	 * nothing about our buddy pages and only free the order-0
	 * page at the start of our chunk! We must split off and free
	 * the buddy pages here.
	 *
	 * The buddy pages aren't individually refcounted, so they
	 * can't have any pending speculative references themselves.
	 */
	if (!PageHead(page) && order > 0) {
		split_page_memcg(page, 1 << order);
		while (order-- > 0)
			free_the_page(page + (1 << order), order);
	}
}
