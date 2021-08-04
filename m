Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B12B93E040D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 17:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238920AbhHDPWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 11:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238324AbhHDPWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 11:22:04 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E34CC0613D5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 08:21:51 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id h10so1619481qth.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 08:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PVQ1V3ExogsGaCtov6jk1dJHF06/mvxhxmainNfgf8Y=;
        b=WhDDPEFlFUnZ/n4mkY5wKuDd9D4NlnpC53nPyhaUXTsS9ANdhKzdNVx5fakLYg2ld5
         53GgyApWfpJWTWn512PJAEbrjzkH1y6DcLkbSv2qLBD9Qp6s79jweDq44mCbnJeSulGL
         WMiUkGI5b+AsRhjGG1rnpemgEjwWKyOWN33wp7OWMq/D0VuLpRLrLJlXxBVAUrmslAbI
         JCDt2vljmNoDdhI3HK6gynnaCSn8i1E1Ua/ZiIq4ia1LBLlm1Zz/bQwBCUxfKmy24Dgn
         qU15RgjA75W5WwHdDOF6zqkIj19IRt3f14tZD1T5Op7jFviKOqpCdNSW7BYRhvpDGETc
         jA3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PVQ1V3ExogsGaCtov6jk1dJHF06/mvxhxmainNfgf8Y=;
        b=hGwgyc1DP2GTEZtIjtq/SwFA5PaFMUJWvW0052J8DI6reMzigWwCIZezrHUkwUp6hy
         fpOEJJZ8dhnlPqsOQIcKBUXRoDlQlYrZ+Tp/OCyMo6BXrQ6MmzlLqL4qM1voDo3PBIoV
         NXAYghd1P02O5KqcGO1QAo+rVK62zFrev8mEuwNWIxw96yAgJZMfLeYuI7kpqAHZoL2R
         nm5AnXp94N8ETAAJtIDLMgk7L0rQYgDurHpbbhBf67rw2ldROfQPOq4brxMiphnMchsE
         5IU3xFb4zFkD3ayMKADJd1Dp6xvU2xVOk+RLvOmt9mpf1jJ3kk2FaSEuFDnHZ/qGXV0Z
         ZWRw==
X-Gm-Message-State: AOAM533CG7hnxeolZ8nyo1j3fffWbVYMJfwRRTjSCgkJ4/ye0rcFU9Ms
        3puuDOhptoerV8jJ+lIMbLI71A==
X-Google-Smtp-Source: ABdhPJzIvP8prj+GuCuMKLyFZYhXKJCHI+G2lNJeGYxKjjOccHbhkJhB2OzLb/YU60cvxkm3wxDViw==
X-Received: by 2002:ac8:5b95:: with SMTP id a21mr104029qta.275.1628090510844;
        Wed, 04 Aug 2021 08:21:50 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id c16sm988323qtv.32.2021.08.04.08.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 08:21:50 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mBIiK-00CeGf-Ja; Wed, 04 Aug 2021 12:21:48 -0300
Date:   Wed, 4 Aug 2021 12:21:48 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jann Horn <jannh@google.com>
Cc:     Liam Howlett <liam.howlett@oracle.com>,
        Luigi Rizzo <lrizzo@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH] Add mmap_assert_locked() annotations to find_vma*()
Message-ID: <20210804152148.GI543798@ziepe.ca>
References: <20210731175341.3458608-1-lrizzo@google.com>
 <20210803160803.GG543798@ziepe.ca>
 <CAMOZA0JKjRFUHbs3zc4kiGcuXxR0arCN=oPZZsLCa4qHvRrH_A@mail.gmail.com>
 <20210803230725.ao3i2emejyyor36n@revolver>
 <CAG48ez2TEP0hsRjLACVmRppMEk6Z9aREcGL498EKhdBBXSRsoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez2TEP0hsRjLACVmRppMEk6Z9aREcGL498EKhdBBXSRsoA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2021 at 04:42:23PM +0200, Jann Horn wrote:
> Since I haven't sent a new version of my old series for almost a year,
> I think it'd be fine to take Luigi's patch for now, and undo it at a
> later point when/if we want to actually use proper locking here
> because we're worried about concurrent access to the MM.

IIRC one of the major points of that work was not "proper locking" but
to have enough locking to be complatible with lockdep so we could add
assertions like in get_user_pages and find_vma.

Jason
