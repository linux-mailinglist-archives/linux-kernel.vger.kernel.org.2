Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 741263D092F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 08:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234423AbhGUGHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 02:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234363AbhGUGCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 02:02:18 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB39C061762
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 23:42:54 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id j3so480777plx.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 23:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HnQeVhXuOX9+yZoqzGoFpF9iewGXCV7CV+LeZbxZaMg=;
        b=Pmj/RuIS76mVmFH/M/FOdsROetGEUMWwVpu8BoHzTLPXsbTOBhMJVQVFGqO48c7Ql6
         nUf6cgS+sAUkrqmA8f/gBtUZEXuMFCtvtHE24j/yhNFhm5URu9WwKEndGDiE2zlzoCxv
         rEnwpWOCFoXyeVBPGW6T2SEDe7cdx9PgZLc/k+dmmW/YtJlCBd0NGhmBbN6mhH5Dxf6U
         Qi6dAynDiKf3sl2oBuqFa2IdHDbLabR6MuWp5ObajbnBIdJmvnac3238QJrNwSpU52Bb
         Otl9aS0UnfpD+vsMugqokr++yFpFOmc/QCBZacffiM3coq44B+nedsTSykZIvqdKc5tv
         u4oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HnQeVhXuOX9+yZoqzGoFpF9iewGXCV7CV+LeZbxZaMg=;
        b=CrAzUeLL4/vm5Pc4sOEpJo8z1emdA1jwNwz4RWlQGKBhnZpELohCf730O5TV9XtCb9
         hkU6LfE55GWn2QSrbVsv9KkiSCge9aDH/Z2cqqkQC0T5bkcnhvd2p8ip2WDa0gZ6t2F/
         dTJzZ6bpBWxVX24c9f8S1HbD+gq+fTY2TkZBup5Xi48Ck1kIRfOgAul39VjEEv73CIa9
         NXEPqKIvTRhLIAoAxIat1LdRab/QSyk/NX9Q7n5h5h3QmysT/qxPvwVL5dDOQOR/lhK7
         2C1yEsM1Fat7LoT6WFcIBabY19Kbbvhh7lQKUaAQ77YJ6HTxkfev5lQ3RJsN0QPo0Xdt
         mwbQ==
X-Gm-Message-State: AOAM533BGUjH1yytGwinDUVyYndDyXxF12jFrMeL9lRP3qedOrgv5vVN
        6Ghk9B7dDbsTP+XvHOlYqbJ18/n3o+Agr+YqWsJQyg==
X-Google-Smtp-Source: ABdhPJyCXSHuecvMG3DJsf0O8itVJmdL+2pBjVFurynPhUimyjXIYc//t7JVWahYLQW6cwuneAlBSpw2OJRncRbzScA=
X-Received: by 2002:a17:90a:9b13:: with SMTP id f19mr33523688pjp.229.1626849773737;
 Tue, 20 Jul 2021 23:42:53 -0700 (PDT)
MIME-Version: 1.0
References: <1626683671-64407-1-git-send-email-xiyuyang19@fudan.edu.cn>
In-Reply-To: <1626683671-64407-1-git-send-email-xiyuyang19@fudan.edu.cn>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 21 Jul 2021 14:42:17 +0800
Message-ID: <CAMZfGtXFsxj9b--ZcZgAdcebeeMzivpmJPamBqtn76k4m0d3ZA@mail.gmail.com>
Subject: Re: [PATCH] mm/mempolicy: Convert from atomic_t to refcount_t on mempolicy->refcnt
To:     Xiyu Yang <xiyuyang19@fudan.edu.cn>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Feng Tang <feng.tang@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Yanfei Xu <yanfei.xu@windriver.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        yuanxzhang@fudan.edu.cn, Xin Tan <tanxin.ctf@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 19, 2021 at 4:34 PM Xiyu Yang <xiyuyang19@fudan.edu.cn> wrote:
>
> refcount_t type and corresponding API can protect refcounters from
> accidental underflow and overflow and further use-after-free situations.
>
> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>
