Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A926362407
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 17:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343790AbhDPPel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 11:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343730AbhDPPek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 11:34:40 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D578C061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 08:34:15 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id a25so18231500ljm.11
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 08:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zLDzDS9UlIWp51s2VYij1UMAETw6FlEgnQT5aRCLKZ8=;
        b=DirpUMunw7EJUFeo+SjDvEj+yxk4h+B0bfUUPJg74pxOGjtiQ7fNb9Oq58fXbOZ+mu
         D//Ql481hiNCpWPsetH1q0ztOVvxhFhVkFsq6cNIfQcWfrRRSksKD8UXIEGTUXIjJ1eX
         +oGhlhG+lOI8eNadbFYgc8soiLSGydn4hLUPxsUNepf8lTcXFcL5DLBV8lo9w3lhTkNa
         t1Z0VlCHvWjXr2FCpP68tOLtp9uy8Nrn4ZIZBL+X8dH4ydFOdaAun9Lk8E5NtKKeL64x
         k3kvzoGm8+XO26Ni3LixU3DAhEt4BV1A0MGf+uFwRATaU/KQ4nhRLAv0oV2Cgj3/mAjD
         v8VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zLDzDS9UlIWp51s2VYij1UMAETw6FlEgnQT5aRCLKZ8=;
        b=ilSnOTqzcXNUsGekMHPIEho4BG5pxOnzZlm7jx5ZJRAnUeOhvYYtW7i0sD1HGRdEtL
         9hQzAJPQM7WDjQofYrQnfxaY+1hIV7SGIcT2ioW9i8VXovAaKnGGao4FILMulqAcZAkN
         HM8SttX7fqzvylZV3P2kaPDJzs1ingcEGduoF2WnixGstFsmr3tp90aTk6fSbHikubrq
         NkB6mHjxTj9fUkqI5kYvMh8o0wSnH+uSl8ai1kAB7qPPlTu84tPoXdQrFoYBrsVw3WPS
         RNdyNPmxn6iFG2whaCg7l5/rQxs2dLNdU6n8EGKrbKnOPt/G8hMLc5xJBzcKVreBRSO9
         +biA==
X-Gm-Message-State: AOAM531XRb0VBvwzpd4LkIrV5dCkZktYcS6N5tINoY72VpZbOgTtPt0d
        4kGMpbUw5ezi2jzmwweXYGIYzfvLK590wn94VNrbaw==
X-Google-Smtp-Source: ABdhPJztGzHRBxHR8pp9VZ2uuYnoN0E9ouY8yRDZ9cBnXqQkZiysaZaIKiKr0D5i9LgzlVDWPmnNKqQYFcG0sgjuN1Q=
X-Received: by 2002:a2e:b17b:: with SMTP id a27mr837141ljm.160.1618587253744;
 Fri, 16 Apr 2021 08:34:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210416051407.54878-1-songmuchun@bytedance.com> <20210416051407.54878-6-songmuchun@bytedance.com>
In-Reply-To: <20210416051407.54878-6-songmuchun@bytedance.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 16 Apr 2021 08:34:02 -0700
Message-ID: <CALvZod6Ok6ELDmQCirLMYZfXavs=7miJK2v1DW2OKZzpP-aqeQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] mm: memcontrol: rename lruvec_holds_page_lru_lock
 to page_matches_lruvec
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 10:16 PM Muchun Song <songmuchun@bytedance.com> wrote:
>
> lruvec_holds_page_lru_lock() doesn't check anything about locking and is
> used to check whether the page belongs to the lruvec. So rename it to
> page_matches_lruvec().
>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
