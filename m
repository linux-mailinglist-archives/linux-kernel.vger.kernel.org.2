Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 579C839FDC5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 19:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbhFHRfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 13:35:09 -0400
Received: from mail-pg1-f174.google.com ([209.85.215.174]:44585 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbhFHRfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 13:35:08 -0400
Received: by mail-pg1-f174.google.com with SMTP id y11so8939194pgp.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 10:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AHQbohLdOv212XWCgNAIki+QiBE294go+E+AnYbJF9M=;
        b=biLwqIL1ECQDpYXkKAkiuZYqmbzWdb0jGyciw3wmlN1bVkaAqUDBkQKGemUGGKPL9U
         Tuk/hQkeIOll0FNN/hDB8AaeP1VGf7Qh6LzsEwg0eZ8SWEGsKMvfxztXJlKPzFBPfqAq
         9CB7AN3O47sSHxkKxthkxvZ0/1sBjuSWXLyAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AHQbohLdOv212XWCgNAIki+QiBE294go+E+AnYbJF9M=;
        b=Ki/kfdnmwjFHTSFalH+uKcA9fe/83fTitD0poyaPCRENC2B1mKt7T/ubcANiBloNrg
         9+xYzO7uO9ZCHAB7xV/ink+cI8YI8KOlIjUlBa64wWVNsScRGe5+eSKS52VrIbqq3+1v
         y9o1yK9WdB2MMTuaZxGvccImDwmHMlXWGdW0dlYPu+cGrZySHjAAJk9zOuMUEoyA5zMy
         wGK2n6QHJ12qAeaQpTdUYktHR6UGqV2Gp2RHOL4cayjFGyHuKh9OYM/9VT6V31dDuQfz
         7K3FXF4X6nA83bupNXujsIuy9j1UBM7HFSD5srknwj7i+tMOoLSOWH1ildGAzL+AmYcP
         Oi+w==
X-Gm-Message-State: AOAM532bTDR8ywn7RE/RRYWUQRESJhiF1xKW3eQ4SEefrZfB8Pdz5+0C
        NIim50Ha6Vp4a8vSov8QvwWzYQ==
X-Google-Smtp-Source: ABdhPJzIuNZXhKV1ztPY/+fg/0E6Sqq1LW/i6wIG6EXJPGFBpvO72K9KL365GXBSM6yBmu+VJToBZA==
X-Received: by 2002:a62:1481:0:b029:2c1:1e90:c54 with SMTP id 123-20020a6214810000b02902c11e900c54mr982446pfu.55.1623173520075;
        Tue, 08 Jun 2021 10:32:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o7sm12557362pgs.45.2021.06.08.10.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 10:31:59 -0700 (PDT)
Date:   Tue, 8 Jun 2021 10:31:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Bhaskara Budiredla <bbudiredla@marvell.com>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH v5 1/2] mmc: Support kmsg dumper based on
 pstore/blk
Message-ID: <202106081024.09E42DA400@keescook>
References: <20210120121047.2601-1-bbudiredla@marvell.com>
 <20210120121047.2601-2-bbudiredla@marvell.com>
 <CAPDyKFoF7jz-mbsY8kPUGca5civFKRRyPpHbRkj9P=xevRRfbA@mail.gmail.com>
 <CY4PR1801MB2070F43EFCB9139D8168164FDE3A9@CY4PR1801MB2070.namprd18.prod.outlook.com>
 <CAPDyKFrVQbALjSeFBckaZQgkgwcBVuwHy563pdBxHQNA7bxRnQ@mail.gmail.com>
 <CY4PR1801MB2070B09D27404F8B7A84D446DE389@CY4PR1801MB2070.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR1801MB2070B09D27404F8B7A84D446DE389@CY4PR1801MB2070.namprd18.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2021 at 12:37:07PM +0000, Bhaskara Budiredla wrote:
> [...]
> >What patches are you referring to?
> 
> I was referring to this patch.
> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/pstore

I applied the first three:
https://lore.kernel.org/lkml/160685706687.2724892.9289969466453217944.b4-ty@chromium.org/

and explained my aversion to the others. Christoph never replied to my
notes on patch 8/9:
https://lore.kernel.org/lkml/202012011149.5650B9796@keescook/

-Kees

-- 
Kees Cook
