Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34C2E35F05E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 11:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbhDNJDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 05:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbhDNJDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 05:03:03 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA465C061756
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 02:02:42 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id l11so1492854vsr.10
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 02:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ve208t/RK2O5KKA1Tytd/3SnK5wVjxvj8UwjAFmW0A4=;
        b=PP+vQbwka8RkOrkMB+NhaqUGiWztFql/zPxeSR5HtPBJcqExUKf+kRnJg0jn/jHCWQ
         yT+BPzbnZlqaszEiNmIifyyMUPkADCZDBxV40m6ViFnyalFPs1AVq/zaig81R2kq/rhP
         J2qGcnekVuX9VSo6oH3Crg8BzN7Lnc2T28CI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ve208t/RK2O5KKA1Tytd/3SnK5wVjxvj8UwjAFmW0A4=;
        b=uCH5txSPz2B5Yk3/8t5afwlv04oLFQ5ovMclQjJrKDTVGFG4Aar8QACZkS5Z4FeIzt
         jRs8I4j3O3AsjdrGxLKZCyq/sq6yGHK1KF3gccKrGMAlxQKVHiBMvEO0NBJ1UFqfvcAj
         ep2HROGpc2/1edhoHKYH8EcjPcV0oIdPQ/qqCladbl3IgVZPi0IbwskHRCV1b8/ABVtA
         IH1+YH4uaaKnkN/Ntn887fbSmD0KoK5k+Eq9gqBpycb7QBk+O6HXS7zG5GvkY0GK8Io9
         P1tNT0hW9afPgsXsC4JAcGNLiH4if4c2oQJVVFK1cLGbuMzqONN+KPbZYlS5ncPxZ1fD
         cHXQ==
X-Gm-Message-State: AOAM532jHYSCCOK+m4a+eQubp046znhAHK76jc7peHhoKjQVCfvdINzd
        4BUiWZpAXLOj8DBEkifJGg6qp9xyhNRkcSu6OxiaAQ==
X-Google-Smtp-Source: ABdhPJyDuyMa4F6hAu3fNjHYFx6RQZ5dQfSkW2XG+XWw8KImgVRaUTb+FCtc04tKKlRDbVgsVoaEBuyoyrNUwKdrdsk=
X-Received: by 2002:a67:1643:: with SMTP id 64mr11142777vsw.0.1618390962045;
 Wed, 14 Apr 2021 02:02:42 -0700 (PDT)
MIME-Version: 1.0
References: <807bb470f90bae5dcd80a29020d38f6b5dd6ef8e.1616826872.git.baolin.wang@linux.alibaba.com>
 <f72f28cd-06b5-fb84-c7ce-ad1a3d14c016@linux.alibaba.com> <CAJfpegtJ6100CS34+MSi8Rn_NMRGHw5vxbs+fOHBBj8GZLEexw@mail.gmail.com>
 <d9b71523-153c-12fa-fc60-d89b27e04854@linux.alibaba.com>
In-Reply-To: <d9b71523-153c-12fa-fc60-d89b27e04854@linux.alibaba.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 14 Apr 2021 11:02:31 +0200
Message-ID: <CAJfpegsurP8JshxFah0vCwBQicc0ijRnGyLeZZ-4tio6BHqEzQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] fuse: Fix possible deadlock when writing back
 dirty pages
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     Peng Tao <tao.peng@linux.alibaba.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 10:42 AM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:

> Sorry I missed this patch before, and I've tested this patch, it seems
> can solve the deadlock issue I met before.

Great, thanks for testing.

> But look at this patch in detail, I think this patch only reduced the
> deadlock window, but did not remove the possible deadlock scenario
> completely like I explained in the commit log.
>
> Since the fuse_fill_write_pages() can still lock the partitail page in
> your patch, and will be wait for the partitail page waritehack is
> completed if writeback is set in fuse_send_write_pages().
>
> But at the same time, a writeback worker thread may be waiting for
> trying to lock the partitail page to write a bunch of dirty pages by
> fuse_writepages().

As you say, fuse_fill_write_pages() will lock a partial page.  This
page cannot become dirty, only after being read completely, which
first requires the page lock.  So dirtying this page can only happen
after the writeback of the fragment was completed.

I don't see how this could lead to a deadlock.

Thanks,
Miklos
