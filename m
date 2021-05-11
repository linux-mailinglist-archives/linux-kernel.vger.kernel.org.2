Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1130037A902
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 16:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbhEKOWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 10:22:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43753 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231154AbhEKOWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 10:22:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620742905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MaXr32jxJy36c2DV6JqmjMB2rJjnpxQV3cgHFLstwPo=;
        b=UeJ/k5Sqd+AHsMpGGnZZsg7UOHLvLdAIVj9p+3LjMThEqR6w9VrOoLkD/i5IIqlLGfWiN1
        PDgdxF/FsVumTGk15H7oqKlzqg3ZyQZaKCaeX9tQITQwU+d8/NONmiF1I8bZbyvWeBXZz4
        UrMR/nGZoo7YCGCslMjGEgY1Hp0BvvA=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-XjB27L3fNb2G6nq0qGMInw-1; Tue, 11 May 2021 10:21:44 -0400
X-MC-Unique: XjB27L3fNb2G6nq0qGMInw-1
Received: by mail-qt1-f200.google.com with SMTP id k13-20020ac8140d0000b02901bad0e39d8fso13079090qtj.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 07:21:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MaXr32jxJy36c2DV6JqmjMB2rJjnpxQV3cgHFLstwPo=;
        b=tT9GLNBQyI0t9RuLvKbV8uF3hT4Yqwsgyu+dyVqXjRew8Ndiq+IDQwtR9xZZbaMoJH
         rcUSZwF/S1Of65xD/xgnguIU5S5sNVTmBY8CTo3kpnrqBF0sWlDF1t4T5Rk+3WzH5sgY
         Hyv5Znl6rwuSEyatb249XDURuRe/roEulLN6vbS2V02SEUMgUWEsunsSfeAs5JFwkk9G
         cpFVEOCINuIzCgf0OD+W6P1NqDrPOD4oXFFL5c7srBAXP4rtyZzzMklmDwtG52zEMUtV
         5oyMojzSTM3CFrW0h695jlNnVLltFJ7ch+OjIdxrNAenuSlt4RSm53Isuosw5Bjzt5Z9
         eIXA==
X-Gm-Message-State: AOAM531VnXyXL+33fIKsPn9uA79jnKE8+4ay/SmpeblOU9b+jwx4wxJX
        YdO6cTXFwv0G5Y5j/I6V3gR7XnB3IfRCu3zPSZt2fkrlzYaMCmtvCZu3lirkTimYuq79PxXMgqt
        Ra/m7UpbFCIDK5D0cjEMQYguTJjMDxkhKSbaEadOO
X-Received: by 2002:a37:a8cb:: with SMTP id r194mr28834690qke.349.1620742903560;
        Tue, 11 May 2021 07:21:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyEx3DOtXTVNCdTLwgAjAM9wZtAC0PHHLdvpjh/ChvYvBN9gc0U2MeRS4qYxHvxOi6HL2OaZiRtoLYV/z/b0e0=
X-Received: by 2002:a37:a8cb:: with SMTP id r194mr28834671qke.349.1620742903375;
 Tue, 11 May 2021 07:21:43 -0700 (PDT)
MIME-Version: 1.0
References: <202105032112.SJqOaXpO-lkp@intel.com>
In-Reply-To: <202105032112.SJqOaXpO-lkp@intel.com>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Tue, 11 May 2021 16:21:32 +0200
Message-ID: <CAOssrKcwq_wFc+B72Vvkaai-TgXoZPTJ9fvBu+BzUg4idnFoZw@mail.gmail.com>
Subject: Re: [kbuild] fs/fuse/dax.c:113 fuse_setup_one_mapping() warn: should
 'start_idx << 21' be a 64 bit type?
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, Vivek Goyal <vgoyal@redhat.com>,
        lkp@intel.com, kbuild-all@lists.01.org,
        lkml <linux-kernel@vger.kernel.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Peng Tao <tao.peng@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 3, 2021 at 3:27 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master
> head:   9ccce092fc64d19504fa54de4fd659e279cc92e7
> commit: c2d0ad00d948de73c78f05d2b3e5bdfa605035cc virtiofs: implement dax read/write operations
> config: i386-randconfig-m031-20210503 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> New smatch warnings:
> fs/fuse/dax.c:113 fuse_setup_one_mapping() warn: should 'start_idx << 21' be a 64 bit type?

Yes.

But does it make any sense to enable virtiofs and/or dax on 32bit
guest? We sure aren't testing it, as seen from this bug report.

Vivek, what do you think?

Thanks,
Miklos

