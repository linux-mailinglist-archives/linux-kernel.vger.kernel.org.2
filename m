Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 479E63531D4
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 03:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235626AbhDCBLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 21:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234821AbhDCBLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 21:11:08 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972EAC0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 18:11:06 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 12so9555207lfq.13
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 18:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f4qgLvucY0towbKBWbt2D03ufnCif8gBNVZdzFUpcrc=;
        b=eXrvkjPSf/fPPB1l4l26YyJ+bAarsI9LJVJvwYkGHWtyQrsOGRf/klTPoIVH1noGlc
         +MwmIDXs6iO8QfBebmm7/VfligvMvD6x0xgKlUKZggb2DRrgJukpGxOfy3/2sTMyReV+
         VUn6XkbUPdbFHGFviNBZyhHlKwZzZabP2BFbwf72cEPY7QBmuupufoy9NMXOq3FrJVra
         bSFbirOr4jWNGdpexHXzmLGwJ+mwNkBlZYMqpGol7GGg7zZYAOZG/FxsQ2dc2lChTVfq
         OdmdXmgr7mCspUb6pwyhqJUzAfkfJc8B1PQf9oPmJ9sm8btSoSPhtGkGwDX4oS3rM2CX
         QYTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f4qgLvucY0towbKBWbt2D03ufnCif8gBNVZdzFUpcrc=;
        b=RiylTO8k3JB34573IHoQZ4ZXM9GwB1lxSz3JmdSobx3gekWVODea7PtCCs9Ni8SSVE
         ebDygGEIp/wauaugpIPOCvOMqsX26v/CyK2JgnOB8oakkpbdOGMIfcnKiEGXWlAtreIw
         XOcDlkZqwqM9oP4Ql7BMER+n4tuVHvTyIePx1HmOvhXwO2KWW11CM9DRzudHqyXhd95e
         N2xoh2oymjQtc6a98cV5aH/ajzm/YSJY/LHycawLNGj4w1wJ/9KFy+ggoxVYRAzpGme0
         7+BL8m0vdJ5zljkRnmXtMa6mOMcvUBKiriE8744WL4vK0ZvEmc+AViPxljsNjhHLLTy7
         idBw==
X-Gm-Message-State: AOAM533wyuL3O1oF77APfz1TiqUK3Mf+0L66FrScO/LNbQXCjFUsKUYb
        ZmEcUoyU1she8TaFVIJr/eMEoxTGBKk/uwHVRQho3g==
X-Google-Smtp-Source: ABdhPJxLcxJqp7ZTc/a+c05m05GlRq8eKjCl2BGJgLfE8Y9reNaQm2aSnDkRQnFlm9CrH7FbnMRZG94rj9BPN/UjzOI=
X-Received: by 2002:a05:6512:c04:: with SMTP id z4mr10396546lfu.299.1617412259753;
 Fri, 02 Apr 2021 18:10:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210401030141.37061-1-songmuchun@bytedance.com>
 <5c183fe6-637f-151c-67f0-fe19a0ce3356@huawei.com> <YGU/ZojpKXXK9AnU@carbon.DHCP.thefacebook.com>
 <20210402180454.c28395d38396b58659c15fcc@linux-foundation.org>
In-Reply-To: <20210402180454.c28395d38396b58659c15fcc@linux-foundation.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 2 Apr 2021 18:10:48 -0700
Message-ID: <CALvZod4O-Y2LBQhEKQjWShm_dd6VNi0GUuev7PmMw_6GqGWFPA@mail.gmail.com>
Subject: Re: [PATCH] mm: memcontrol: fix forget to obtain the ref to objcg in split_page_memcg
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Roman Gushchin <guro@fb.com>, Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 2, 2021 at 6:04 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Wed, 31 Mar 2021 20:35:02 -0700 Roman Gushchin <guro@fb.com> wrote:
>
> > On Thu, Apr 01, 2021 at 11:31:16AM +0800, Miaohe Lin wrote:
> > > On 2021/4/1 11:01, Muchun Song wrote:
> > > > Christian Borntraeger reported a warning about "percpu ref
> > > > (obj_cgroup_release) <= 0 (-1) after switching to atomic".
> > > > Because we forgot to obtain the reference to the objcg and
> > > > wrongly obtain the reference of memcg.
> > > >
> > > > Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
> > > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > >
> > > Thanks for the patch.
> > > Is a Fixes tag needed?
> >
> > No, as the original patch hasn't been merged into the Linus's tree yet.
> > So the fix can be simply squashed.
>
> Help.  Which is "the original patch"?

"mm: memcontrol: use obj_cgroup APIs to charge kmem pages"
