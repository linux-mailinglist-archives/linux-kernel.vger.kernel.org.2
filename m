Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B84D5389DFE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 08:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbhETGeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 02:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbhETGeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 02:34:16 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E6EC061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 23:32:54 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id et19so16396353ejc.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 23:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Men5rmBujePBODaPqTxdL7d5Hadu/ohxPE3843bVkM=;
        b=A7yY9vj41fmYGyDYrkBklpQ9dUGDZHKmyUG0IoLZvByGjHFG/UW2ZN1aqLORfLHnBx
         QqYKMTRtEi7Z9I16QUhEMhIryMW5cMGumf2bXTMpReFl4KvhBJ3IsB6RpkNcmCxlgSz9
         zt6OskmxaC4qYaDH8kQvnsFnMUNFKpFwJCeNoqGTrCLTLnN39ys3Gz96V3X6WIhj/Njj
         Peep5jzTFtVG5kL0RROyLmX/J8k4buO/vDp/GNp2LMt4Al8eRZqhCFBuCEywseyKvRzf
         qFl4sFlV+mKrMgjVfanq31xDK3tYoh7pWzsFiEb3w3btIjndenXixOANombxaU5ncyPv
         WbJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Men5rmBujePBODaPqTxdL7d5Hadu/ohxPE3843bVkM=;
        b=g+jeGX085Jpj4hh4uXwRG0kHdarRwrG7XVpxuZRimpof1fXiAiBmNcgKeQzmY77fHu
         IxynVuuq/AIhg0En6XP+uWdzgVppdRtegrYVMd1aIwdje3Pbl2tAPm1hGSa7S2u3Jpbw
         xvmYIRqAgdpTaBHl5kXz4LmtrV8cEZJmyhb2ZnOGx+60O3v69iwZZ19GFBqaLtP3eOpL
         eQeLE/882LUS+j/agwZ1OYsOUxGvBMp0ayEIISHt1bYdvo1MEJEtAOVohZZqPOvR4yIv
         ThBJIgSzYYLTKXXI9kYaDBl3mp3TEi+oRk4RWKvaglpz87xGOk4Xroxyq28Jkn1IR/xG
         UytQ==
X-Gm-Message-State: AOAM532ecs4tmk+sRNWZ3LJqoUT8sYK1iTg/+pEUMnv/r+F4bC7td9KW
        w5Fe8T7xBLfyIBnBB0WXYhN3ego90m4/Z2rkIz7S
X-Google-Smtp-Source: ABdhPJx6xRY71uAWPKVPYMZsfI1C2ZOby/JHxCV6UkDwez9y1Wuqisip7Dr7L+8aPN3fVQWQls2IuNvwZo9GmF/km/A=
X-Received: by 2002:a17:906:456:: with SMTP id e22mr3000572eja.427.1621492373326;
 Wed, 19 May 2021 23:32:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210517095513.850-1-xieyongji@bytedance.com> <20210517095513.850-3-xieyongji@bytedance.com>
 <YKX/SUq53GDtq84t@zeniv-ca.linux.org.uk>
In-Reply-To: <YKX/SUq53GDtq84t@zeniv-ca.linux.org.uk>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Thu, 20 May 2021 14:32:42 +0800
Message-ID: <CACycT3uD-D78EXu+njGb5Wctb1qV4VzwyfcN1803x8SY65QSTA@mail.gmail.com>
Subject: Re: Re: [PATCH v7 02/12] file: Export receive_fd() to modules
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Parav Pandit <parav@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christian Brauner <christian.brauner@canonical.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, bcrl@kvack.org,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>,
        Dan Carpenter <dan.carpenter@oracle.com>, joro@8bytes.org,
        virtualization <virtualization@lists.linux-foundation.org>,
        netdev@vger.kernel.org, kvm <kvm@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 2:18 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Mon, May 17, 2021 at 05:55:03PM +0800, Xie Yongji wrote:
> > Export receive_fd() so that some modules can use
> > it to pass file descriptor between processes without
> > missing any security stuffs.
>
> Which tree is that against?  Because in mainline this won't even build, let
> alone work.
>

Oh, sorry for that. Now I'm based on vhost.git tree. But looks like I
miss Christoph's commit
42eb0d54c08 ("fs: split receive_fd_replace from __receive_fd"). Will
rebase on it in v8.

Thanks,
Yongji
