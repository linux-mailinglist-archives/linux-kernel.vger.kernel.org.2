Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2AA37C383
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 17:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234617AbhELPUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 11:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233472AbhELPJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 11:09:34 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A34C06123B
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 08:01:52 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id o202-20020a4a2cd30000b02901fcaada0306so5006420ooo.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 08:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UDD7PJOLLYReV+ki1w4vWVhaqVdnK70fMH/aRuBsi+U=;
        b=j3EdvE/qBJ2JgHC4pSAw8ptUM/hHYSlfqrJ2bFDGn2AgF1DuvwJnsQErvNFeapmoOd
         WjwGhq3dj825FTLXsKh1Y9BvNJuxB88Y9b89ERwOhntkFG2VFxwix0XuqvpuMkAUFqt4
         ZeskQ1YsAtuToGOXwdrcTTAJe1mpr9sVsXp+emzb8tXoNI2EDxzP9yTiqce+6RneGFO0
         VNRovDzDjhR4MOq45H8TRVrwsITF4/08VWL3lnmNzeXHLCoB6GGezkgw52AAnEi7iMYU
         OVhqRAqlOA2T2q78oVkxMizPE6DhFLwRDwU8C3pgADouxAKG/fP07vGY3pmNGJBNJEM+
         cDPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UDD7PJOLLYReV+ki1w4vWVhaqVdnK70fMH/aRuBsi+U=;
        b=RwJ2HEomA95c4PLsxSSMhf5a5GKOnZbdO/b7xaGNS/vvJjfZ/cKa48Em9tXkRIyM9h
         ojx0DdsBHvnEIh6296Vkib37FKV4jkj3OWV+NAt/cIe/yyR4qf1ZO3QnPkvitphvHWQA
         kgdsqyweTFyYfjOpuvaSpRSvcMjUBtDUCqUlyvXmt8s5dlTVOvw4JfX3ws/mSIodJxhy
         dtZeb7MK8Zs3vLY7aWtAosFoYA/s6XpnMY0w7GB2bEL2B/6x+RZg6ThnHeWNRsd91ygd
         1VF9+wysim09ITVWCEPAfon25xo0RRmy6mEl+BVY9oAUBiL4t7NEACr5PfpBIVXHiv7G
         2cwg==
X-Gm-Message-State: AOAM531PUEoL0lXNT09TUN3MMdzz9LkMQtX3DrWW4ku5Ynnpk2MzHNLo
        +lk0dkm4tOXKDAW3HpTYGIY=
X-Google-Smtp-Source: ABdhPJwIUfudclyVSUS4OIM+Wq5qc8wnqq6eG4UzeB9J9g6dbK3zWJSX32nnnjigVzYpJ7b4h3l69A==
X-Received: by 2002:a4a:98a4:: with SMTP id a33mr28096899ooj.21.1620831711875;
        Wed, 12 May 2021 08:01:51 -0700 (PDT)
Received: from ceres ([2603:300b:7b5:c800:1cf6:4c9f:4e7:d116])
        by smtp.gmail.com with ESMTPSA id h184sm34435oia.1.2021.05.12.08.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 08:01:51 -0700 (PDT)
Date:   Wed, 12 May 2021 09:01:49 -0600
From:   Connor Davis <connojdavis@gmail.com>
To:     Juergen Gross <jgross@suse.com>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] xen: Export dbgp functions when CONFIG_XEN_DOM0 is
 enabled
Message-ID: <20210512150149.nfzsgh3hnx7o7caf@ceres>
References: <cover.1620776161.git.connojdavis@gmail.com>
 <291659390aff63df7c071367ad4932bf41e11aef.1620776161.git.connojdavis@gmail.com>
 <0ef85b32-4069-4e94-0a2f-2325cd21510f@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ef85b32-4069-4e94-0a2f-2325cd21510f@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On May 12, 21, Juergen Gross wrote:
> On 12.05.21 02:18, Connor Davis wrote:
> > Export xen_dbgp_reset_prep and xen_dbgp_external_startup
> > when CONFIG_XEN_DOM0 is defined. This allows use of these symbols
> > even if CONFIG_EARLY_PRINK_DBGP is defined.
> >
> > Signed-off-by: Connor Davis <connojdavis@gmail.com>
>
> Acked-by: Juergen Gross <jgross@suse.com>

Thank you.

- Connor

