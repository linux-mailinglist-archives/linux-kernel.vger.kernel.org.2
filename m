Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0CAA30999B
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 02:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbhAaBUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 20:20:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbhAaBUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 20:20:11 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67C6C061573
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 17:19:30 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id lw17so7987342pjb.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 17:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=r4XQvxNNoGLJfrMyiuidxyu3QDem5+Pe8JibIIsychI=;
        b=P/3zdPV7ZT34vyrVy9B+HRiisfmQe69UckhlSgox8Jjvi7v+s7v9FL8J3v4m/P8Qjr
         HREpcNpk9ED09Pg0lPfOip+Nn04HDhL4OT1XUpiKAjZbNngEOu+AxLb7Ipx3BcCdbaB2
         exEWJ2tQ09UuLW8I6P9rHwWck/pJ+47qJL4Iyt0vEY2Hxq9Cce4HMDtwqX2hRUhnONGL
         9MWiKo7IbgzjLsiIvO7D7AiSaHk6LQ1J+qxEfZn0ya18RR0tw3j19rpdCW1wid/Kvml5
         Y4cLdUa70OB9seYgTJh6HiHncHHuQFro+OJsZ5yBNxEKYoyfJy0gx4c68AGr8qldVKZF
         kfkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=r4XQvxNNoGLJfrMyiuidxyu3QDem5+Pe8JibIIsychI=;
        b=sB7RmpXNZJq0pw0ouUrlRBw4d1pxESwaNl7WDmG9tkyWYdN2Ue0xupinPd6X2mZg+h
         U7wdLl+D9PlC62OV2cq8jjquV5x7RbWCGb/lQZxU6u2FYoVwwzHgl0nrFMWx7rxDLOtb
         7+7CWGOh5gAZSMHlu4AQPJA+VOzJLO0SVicon6FDJULw6prluqeq+R887aMixuYWs3u0
         8IKZNjd3O7DngBrk1nHkhcxHdltbL23/rzHRRASKW981uQN79mImJ1zOiOgA9GaQ+rdf
         NGXmhaNyTc0D6SxZHEyaB2EtmHPFNAt4ntKhVWMJNmUTjz8H9A6ndt0dlvDJ7wBkY5Cx
         LkLQ==
X-Gm-Message-State: AOAM533uzT7qDRP8/Yz/1R1TUCYPuzCeZhOEKO0+Vs5A2202F3Xsp/H/
        /0b7OPuqHKC15xgtiWskwtIALkqazGnbLw==
X-Google-Smtp-Source: ABdhPJw9CHRQ+nGcktmizYwkcUqgqyeIAUs422wBi7+OoHVvlsWsk3hXAtOrh+jpwhAx6aYzTFTyRA==
X-Received: by 2002:a17:90a:5410:: with SMTP id z16mr10755167pjh.110.1612055970357;
        Sat, 30 Jan 2021 17:19:30 -0800 (PST)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id y5sm13468278pfq.96.2021.01.30.17.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 17:19:29 -0800 (PST)
Date:   Sat, 30 Jan 2021 17:19:28 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>
cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        yang.shi@linux.alibaba.com, ying.huang@intel.com,
        dan.j.williams@intel.com, david@redhat.com, osalvador@suse.de
Subject: Re: [RFC][PATCH 04/13] mm/numa: node demotion data structure and
 lookup
In-Reply-To: <20210126003419.43281680@viggo.jf.intel.com>
Message-ID: <6115c2e-99b7-75f7-f0dd-bc44e69e21e7@google.com>
References: <20210126003411.2AC51464@viggo.jf.intel.com> <20210126003419.43281680@viggo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jan 2021, Dave Hansen wrote:

> diff -puN mm/migrate.c~0006-node-Define-and-export-memory-migration-path mm/migrate.c
> --- a/mm/migrate.c~0006-node-Define-and-export-memory-migration-path	2021-01-25 16:23:09.553866709 -0800
> +++ b/mm/migrate.c	2021-01-25 16:23:09.558866709 -0800
> @@ -1161,6 +1161,22 @@ out:
>  	return rc;
>  }
>  
> +static int node_demotion[MAX_NUMNODES] = {[0 ...  MAX_NUMNODES - 1] = NUMA_NO_NODE};

__read_mostly?

> +
> +/**
> + * next_demotion_node() - Get the next node in the demotion path
> + * @node: The starting node to lookup the next node
> + *
> + * @returns: node id for next memory node in the demotion path hierarchy
> + * from @node; NUMA_NO_NODE if @node is terminal.  This does not keep
> + * @node online or guarantee that it *continues* to be the next demotion
> + * target.
> + */
> +int next_demotion_node(int node)
> +{
> +	return node_demotion[node];
> +}
> +
>  /*
>   * Obtain the lock on page, remove all ptes and migrate the page
>   * to the newly allocated page in newpage.
> _
> 
