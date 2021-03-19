Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2335C341B2F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 12:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhCSLKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 07:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbhCSLKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 07:10:12 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28000C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 04:10:12 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id bf3so10281307edb.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 04:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8B0a0EdllmYlGiT/rpLNY2Bhn7KsHQ1lj7+dw2VrguA=;
        b=KKzYPWb5mPWk0IdcP8KlJ1H9MXyYPvIufjrrAWG7cz7usZ5S/BwWWQQIaAjINoviVg
         T2Uzj2TpTMj2N1HFnyU8/tvt0+kmQnWqSKaVFItKeQbksTF/2/g39kV1f+MdUI73eBtB
         xmYLBDeisqXwhHFUmkeRG67ShY7gTdR3jB+JBUifCngUo4n6DVjeQom9w1BF1YNmhFTA
         b7bY9FYdLCAmJSSG9c10ZQeP/mr91HFIN4p6tnxjLJC3dkZlmnhlcjvCy+In2zt6HzcC
         BGbqxql2NspfH5xYMpS8zR6zLRsVZOreJ2dQAVyB/pCfGN4qyhTa0ygGKYXrgFOzergv
         ta4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=8B0a0EdllmYlGiT/rpLNY2Bhn7KsHQ1lj7+dw2VrguA=;
        b=TVIEzkD5sMT+0C1MEVZAGPywdVx1/tTPVhWchH3h5G9aTi1/F22MZHy8fxxx6qn/Bc
         +UklmYy2InXxat/+QAl7VWd2KP6lzFQiILp1wMfmvf3YeTGa0IP3ApR2nD29+Xg95FjM
         JThLHZNJbBHex+eZZuDz0SpaEWbujL6R3so4qhT1W+0K+T3C0c5/G3jUk/uZBPGFZ2qy
         KCzSE/TWFu+srxTUMLOcgiP9bHztQhKMRu7+dV2W2KInzncqJD4pbDkK4zV3kyfimszn
         8xXAbluWem/cNZ3uiQCdskwrERniYAxIoy6rohQaKHDOdA1I48ysuKEJew6JXKNQywC2
         yRLg==
X-Gm-Message-State: AOAM533rAcn8j5MdqWHpnjddq7tCs0CwfbKChJCAIRNL6vKS+Dtt1X9W
        4mq6BHraW9rLwCQEJbpxBM8=
X-Google-Smtp-Source: ABdhPJxlyvp4ztIb/4FN/fkbPns9/QU+TE2eH92u5lloV6kjrWOpTswWi8SsluNumqJ7QxC4TJH/HQ==
X-Received: by 2002:a05:6402:447:: with SMTP id p7mr8848007edw.89.1616152210825;
        Fri, 19 Mar 2021 04:10:10 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id gz20sm3556111ejc.25.2021.03.19.04.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 04:10:10 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 19 Mar 2021 12:10:08 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH-tip 0/5] locking/locktorture: Fix locktorture ww_mutex
 test problems
Message-ID: <20210319111008.GA4029764@gmail.com>
References: <20210318172814.4400-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318172814.4400-1-longman@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Waiman Long <longman@redhat.com> wrote:

> This is a follow-up patch series for the previous patchset on fixing
> locktorture ww_mutex test problem [1]. The first 3 patches of that
> series were merged into tip. It turns out that the last one of the
> three wasn't quite right. So this patch series revert the last patch.

I zapped that 3rd commit from locking/urgent yesterday already, so we 
can cleanly apply the 4 patches from this series.

Thanks,

	Ingo
