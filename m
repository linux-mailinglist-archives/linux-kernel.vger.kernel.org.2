Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37DA93F215A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 22:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbhHSUK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 16:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhHSUK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 16:10:27 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8883BC061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 13:09:50 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id w17so14475734ybl.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 13:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hEHyflATa8ZJ9MWfAJnBQNhj3JsC3JBcJ/6ag3O0bBs=;
        b=TZhIXS2Nkzr4Lx+5LUIlp18eYdMQ7B0cjj8Z0IbEZ/ObpK6HI3T8NOujHdCs0PcSOa
         OGE3Komvk0XoGwMQ6mQbA972igMURrCNEebMzS3qw2irQ2osaRdSSunn7/vzyBqrAI77
         IIri+i7ziX5jVotImaZ8iaMqR1/hSP+ToXytirSjCJ8TjQ2cKM5ekG7v3oyRuiKHoHvp
         ZBLdGsec7YdoL/7bzXY5JUiJMO7+k0jd08tPHrNoqCoLf62+AlykjKvxLyuV34fk3FJU
         3HVg8nxdBmKopszRY+bGAjBOprKXwp2CA6ppsyyyccBa1IeNlAqvSw1vG46Du1YlT9eV
         ruIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hEHyflATa8ZJ9MWfAJnBQNhj3JsC3JBcJ/6ag3O0bBs=;
        b=cS3st57IOxdjBy0cPgl84QCtz+H9UULWRszEZmxVSGvWwhfQ5j3MxuXCmrpjeSsqvP
         BPW9WBU3m+N65JynT/uEioyu+BTasR6+c5VkG42mHwlwibHbNFCwMar5/Tdrrdripwhu
         DL2F5dxIYg2Dzt+p/GhgFQunvxwuxOJi6e17Ndqe6rZoTSaEdzcg4SSuQotxsaYeIxDh
         aA2qb/6p3n7aBgWDxhbxf/ItyBO3Qw+q0jyN8wsOHtltyaP3Cd8ALbi9OoMLb1TJqhDg
         4UHLMN+QXAMAbaWW2EgiuaOQsmoLQKkADFkViWooqTqBax7imGbXNP//QpLxo8xPX0TP
         L6uA==
X-Gm-Message-State: AOAM53076h8liWoZ3MHRR+e8QaSiHqn9eXPIi2B/w2pqqpIZNgwnSPev
        pquwrAizNx02b0nlMhpdUP/yF7/GiWWQNHbx9IQNdg==
X-Google-Smtp-Source: ABdhPJz9REtAlpPPWBzlps4aOZ4ceCSluRsgzQkI6/CvoCsw+7JW8jhAmlHPSp8SA452+ladiFR6Jq44WxLC2htI3mY=
X-Received: by 2002:a25:ab62:: with SMTP id u89mr21409435ybi.93.1629403789500;
 Thu, 19 Aug 2021 13:09:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210819150712.59948-1-songmuchun@bytedance.com>
In-Reply-To: <20210819150712.59948-1-songmuchun@bytedance.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 19 Aug 2021 13:09:38 -0700
Message-ID: <CALvZod7SCzKM-ROAMSpTK4o3aBtX9m6LX0Bz1zOtx=1oHtkgRw@mail.gmail.com>
Subject: Re: [PATCH v2] mm: introduce PAGEFLAGS_MASK to replace ((1UL <<
 NR_PAGEFLAGS) - 1)
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 8:07 AM Muchun Song <songmuchun@bytedance.com> wrote:
>
> Instead of hard-coding ((1UL << NR_PAGEFLAGS) - 1) everywhere, introducing
> PAGEFLAGS_MASK to make the code clear to get the page flags.
>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
