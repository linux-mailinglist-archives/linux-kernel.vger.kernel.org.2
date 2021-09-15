Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4367540CD48
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 21:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbhIOThY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 15:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbhIOThX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 15:37:23 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B9EC061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 12:36:04 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id jo30so2648697qvb.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 12:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B61mktkGbwP68xIW0td59BfsAzYam3YtrOnmVe0s/1A=;
        b=Ig9CzW/vjNhJIsfW4jX8l7BewU8rEU/GiEtrw/p2YPnjActKU/GLnn1sOqz9pxYqpY
         UHZcfmg2EmcXcGbJ5ZSmey/gOiIHOqdPDsslVQbl/ElBSacIkwPgGeqX37g2k5cflIpA
         zQCi+scLoXx5XfFNOoL3nRK/eOi0eQLTfdmbWZbrN94ttEzH2pLXqPnkwTABUrhffQEK
         HOuroAaNJ+run9GrILkzP0WwYAjtmEVLeWb+F89TWllbGFCrJVZfU26NQAsZYtw1j9KV
         f0xbfpOKTREXvSP8rfjxbYHs3Vu9UvTGX9mta5Wty3YQJaXs0w/3DGzbWvjpQ0YrFq8b
         GsjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B61mktkGbwP68xIW0td59BfsAzYam3YtrOnmVe0s/1A=;
        b=a8AKizB82MSz3JHIzXIqZlUThjBaNZKoZyuNsIyNy/OVfUu3ne807hCv7/WwUT49bz
         ikPXTlsxLwPefYLshYaqmic/vz+JJomgy9H0h3HTIw9Kg2vWoDtCo6h8DxA0r2dvn+wx
         ihuvmrGeQizi7MnA5MWEXnQuKgw6ooRpsVl/H/LPFWj1zHQEroHMEI/ALsXa0Y6Xaen3
         Hrmgc5QVkfHvy/DYXZgc1Y1v5wIkTlSviJFQRjyykyU5j3645kMitk0JYNXq80W43J6m
         8KxKP0ijg+uSXKcSUB25grBmreeyFEGnRQVyGXRUe/HXxLWSoYR9C74BUu0zpdRKIjG9
         x5yA==
X-Gm-Message-State: AOAM531x+Qr9tupqHSV9nJGoJAW/PEJOLFXEBzNqpZkxLSsLe/T+iqJ8
        vA5PdUcXBNih8bdFN3gedTV/Bg==
X-Google-Smtp-Source: ABdhPJxM0PJDqbxTr6c3/m/wscBTasnEP9fiWGJKG0sZ90MispV4sp8cEU/235Sfk+ksqsxFFTFPpw==
X-Received: by 2002:a0c:90c4:: with SMTP id p62mr1676493qvp.50.1631734563237;
        Wed, 15 Sep 2021 12:36:03 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id s7sm736031qkp.18.2021.09.15.12.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 12:36:02 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mQahN-0016Gk-Bj; Wed, 15 Sep 2021 16:36:01 -0300
Date:   Wed, 15 Sep 2021 16:36:01 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     syzbot <syzbot+dc3dfba010d7671e05f5@syzkaller.appspotmail.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KASAN: use-after-free Read in addr_handler (4)
Message-ID: <20210915193601.GI3544071@ziepe.ca>
References: <000000000000ffdae005cc08037e@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000ffdae005cc08037e@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 05:41:22AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    926de8c4326c Merge tag 'acpi-5.15-rc1-3' of git://git.kern..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11fd67ed300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=37df9ef5660a8387
> dashboard link: https://syzkaller.appspot.com/bug?extid=dc3dfba010d7671e05f5
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+dc3dfba010d7671e05f5@syzkaller.appspotmail.com

#syz dup: KASAN: use-after-free Write in addr_resolve (2)

Frankly, I still can't figure out how this is happening

RDMA_USER_CM_CMD_RESOLVE_IP triggers a background work and
RDMA_USER_CM_CMD_DESTROY_ID triggers destruction of the memory the
work touches.

rdma_addr_cancel() is supposed to ensure that the work isn't and won't
run.

So to hit this we have to either not call rdma_addr_cancel() when it
is need, or rdma_addr_cancel() has to be broken and continue to allow
the work.

I could find nothing along either path, though rdma_addr_cancel()
relies on some complicated properties of the workqueues I'm not
entirely positive about.

Jason
