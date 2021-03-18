Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40D3634087E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 16:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbhCRPLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 11:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbhCRPLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 11:11:08 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE92C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 08:11:08 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id d20so2318515qkc.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 08:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MWKeb3ggn5dIOWz1bbbP6KWW8zV+fgH0S33ydz73K40=;
        b=oJdI5+VQ77I/Xsg1UoAmzbVV5ykG+VEUECp6rHpE7DctVJwC1+GuLouFtJHobzV807
         AU+XXyaXmY3ERZk4YUdcCUBTQZi00bTH6IO969As968zmtQQajcCLchwCRlLJAEqdvGk
         Eh9+4YumegO4ZYw/V0XI/cT4UeoYwpN+M6lGLfJWgcZWJHPH5Iz7ScmnLF9ixTM+7wnt
         XhpNnl/w70xhFLSBQQtuUYW7ElZKrKhYRqcITGJ52p46/OVRzsbeRq9csiZSEeAZ+ody
         50npKbz7mpbTJktHOD9klIEP+CHoMLDkGSQ8BzoDiau7hvCxzJDFJ25HFjJ5gvo/3JWc
         kCJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MWKeb3ggn5dIOWz1bbbP6KWW8zV+fgH0S33ydz73K40=;
        b=q6EiTfdXGo3IZXLL8G8baVwJhcQVTFbPKBVDuzh2dac2boBFyhlDSZ+k2gpfKCL8CG
         6qFf2t9HTDxjPXdAMDbSoov/LsRFt3a3LaD6/v7zGQHZOI8MbGiDf85+UmiMFT7h8Eo3
         VUO9Mia9Hx2WqpBke9X2gbK40GIyQKIICK6eK1MBBrU72mcbyMkvpw3L2gGs6QN3Fvd6
         ZG5+J8jLdam+Onq9nFLyJPedoPsBqwPdrPuvQUztZfPvBGTLivpfq+wsnuJ6ZRUCuKpj
         GyIgRDQnmNZFrRWZcgucdPEq4l+rQkj41leNP0nPM/hlZJQDcNwJmBJQcUXVOkajlvgt
         MiAg==
X-Gm-Message-State: AOAM531ib4muXKpaOO1kekVxRnDF8M5ygstAmy/+5hlVqpJ4gw3gNFkI
        jGivYjRf/NYq2bCfK3iL3YlfUA==
X-Google-Smtp-Source: ABdhPJxhqnAVTwfTW8Epbjdo0C4aW3QFwIyK3i4NrEG6CH9VuGNPsG2pcq+LEoKaWGyg1CMD2uvseg==
X-Received: by 2002:a37:a10a:: with SMTP id k10mr4665080qke.171.1616080267971;
        Thu, 18 Mar 2021 08:11:07 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:e46c])
        by smtp.gmail.com with ESMTPSA id d84sm1910262qke.53.2021.03.18.08.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 08:11:07 -0700 (PDT)
Date:   Thu, 18 Mar 2021 11:11:06 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     guro@fb.com, mhocko@kernel.org, akpm@linux-foundation.org,
        shakeelb@google.com, vdavydov.dev@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com
Subject: Re: [PATCH v4 3/5] mm: memcontrol: change ug->dummy_page only if
 memcg changed
Message-ID: <YFNtim0E1536F7ya@cmpxchg.org>
References: <20210318110658.60892-1-songmuchun@bytedance.com>
 <20210318110658.60892-4-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318110658.60892-4-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 07:06:56PM +0800, Muchun Song wrote:
> Just like assignment to ug->memcg, we only need to update ug->dummy_page
> if memcg changed. So move it to there. This is a very small optimization.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
