Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABFF322D4F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 16:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233093AbhBWPTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 10:19:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbhBWPTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 10:19:15 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E94C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 07:18:33 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id 81so16440454qkf.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 07:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BEgzN/eWl9ypgO18zGxZMbgknCN0HuQ7lE1kZsV2Mqc=;
        b=1olQJtG/wvtNQelqBB7lkff1dMw5my00CEjeWJ1HstDl1DCMGbdlX+7YLDlDBZwK8C
         FjBU18p9rB4l/AUnaEq9Qxjl+WCChyHx3OQVGcWWqgdACPeyzBL0AdQEU7KkosHV80Ql
         ry7PE2TuhFrccnUA6Dyo2q9wTcfDkGwkbr/udctYwcZYbzmz9V3WU+zZEyiMPQXhaspB
         8FbO8VTuMKy4oOP9czAfGPOIDW3Pb8/QLa3XNYvFx5URd/JIhkT7kfTlOAAbWTfQBIdV
         Y+fBDVr3jrNydsKaeRtTuq9X8HZU60XJlsiVbDJ7x6VuqH20iGNfwwgMm3sfXgMqkePz
         657A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BEgzN/eWl9ypgO18zGxZMbgknCN0HuQ7lE1kZsV2Mqc=;
        b=k2h4NMq8h+5vg4+mJCEk/VJYAIeC+A58vKZCx54uKb+SZTseI4u5nnanNPShQPk/GL
         F/BcfcOREI7womwLeBSFzGZoJM8VyLkNpaHkoZUyHOgT3LcbAVu/+GWHYCEZK3mliC9J
         htARyEPZBCgIltcCNjk29iFh8KcI8xOvgN7VJ9ckyciyPJ0AillldG6rlO/+wTL+Q/U3
         MUOLqtxpDmU8M7/zpsapiQi5MY6cmKrt4ryhB3Xf20nnsD1QoX4+jHwfc4b7j5hXMt7d
         wQiSZei2EPzZutLQI85Qfext5BYPSltRQZo5Sb/iYTaICEGZpdLXz5DhT9r+DopzvvPw
         SYrQ==
X-Gm-Message-State: AOAM5330ROcnSwpmWdkmF/XCsify+s/cysYjYVSZm8iviC8lxGtXiljX
        2i0Kxk37pJZ9BNTSJJsIWoH/Sw==
X-Google-Smtp-Source: ABdhPJyxluBmo33wmV5Zdq8xSmAKSugIRQowaGA7cWV7LaCwSlnoQNrB4c6x0C4GImZr3BuOFDIxJg==
X-Received: by 2002:a05:620a:4152:: with SMTP id k18mr23885378qko.446.1614093512638;
        Tue, 23 Feb 2021 07:18:32 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:a2a2])
        by smtp.gmail.com with ESMTPSA id d1sm12739451qtq.94.2021.02.23.07.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 07:18:32 -0800 (PST)
Date:   Tue, 23 Feb 2021 10:18:30 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ying Huang <ying.huang@intel.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] mm: Fix missing mem cgroup soft limit tree updates
Message-ID: <YDUcxs5Zw+265Vpx@cmpxchg.org>
References: <cover.1613584277.git.tim.c.chen@linux.intel.com>
 <e269f5df3af1157232b01a9b0dae3edf4880d786.1613584277.git.tim.c.chen@linux.intel.com>
 <YC4BcsNFEmW7XeqB@cmpxchg.org>
 <d141f9ec-5502-b011-167f-e24d891b0dfe@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d141f9ec-5502-b011-167f-e24d891b0dfe@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 22, 2021 at 10:38:27AM -0800, Tim Chen wrote:
> Johannes,
> 
> Thanks for your feedback.  Since Michal has concerns about the overhead
> this patch could incur, I think we'll hold the patch for now.  If later
> on Michal think that this patch is a good idea, I'll incorporate these
> changes you suggested.

That works for me.

Thanks!
