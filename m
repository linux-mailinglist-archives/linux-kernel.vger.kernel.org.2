Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E194342E084
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 19:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233665AbhJNRwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 13:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbhJNRwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 13:52:16 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04490C061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 10:50:11 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id k23so5355951pji.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 10:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nxMwCOQC0YdnJMfBTtrw73j7Po2etBW+G2sHBxcCjWs=;
        b=QH7GRT/SpH58c1RQtll53kBjddBVU5mBBMjaxMqXnQinf9VD8Ze+ZD8FeNmWLnaMT0
         fv3H2osimP7Qx0VswZonCrDR/2P8RrcydFhjeLKXIYdy3p1wEcucuPhWqaxP+9UeIeox
         Gtj8T1YHBs3opq6wwUf6rGPirXifVhSb7LlUrqbJMWL/KKHC8Thxf+Wx85GeGSXQvJEf
         3HZwoHL1ukOewHHxeOBK4vHLq9Fa/zUKhcYzWcXvI0OBFWuTH9ziJotoxd4c0UXKRgID
         K85bacTjtWuW7q6fYQq1UidUyEzUkgLv3Pzvn89ptmogeucqI5Bqxh+hVO4iX8vgV2F8
         SK7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nxMwCOQC0YdnJMfBTtrw73j7Po2etBW+G2sHBxcCjWs=;
        b=zr/nNLvEfp8M10TPWMQ9RL94I8RD4bZSCVxB2PT6IjJomS+RapRiQDK8frjFd3Y33s
         wTOqJQXGSsqLrySta5IB5RI7dca0msV/DZ3BTb+z0TmhqCAkqhxhFdJPfpPvzK2URV3x
         ppcGJFFhaDX1uu8O7KZNR5MN2Ce78y+I3dvsKri/oJPjZpYEfOf/AK18RxCl8SKxMDMX
         5ar9vSdthrZPFpNGdz3yOWywvdEmuEJ3w04lDEfgzpohWqb9Ymz7XUSJiyYkS4U1snqa
         cU14cfqg2jzPIrKVDz6Q9iMy7CnzSzTkoEQZs+pNgACyuGLsE/VH641YqO/q7uSpFHdZ
         wRDQ==
X-Gm-Message-State: AOAM532b9wRa1ZHKmUbbQgvmSTTF2VpW1GqfMgU41qtIVf4T4cTv8JUH
        ZXe6v4PI5cFT7I7qBHV3l9Kjz6kW+qGu8XwDusnLOA==
X-Google-Smtp-Source: ABdhPJxR85BHTUgh2B9uDC+TU+JJ1acvNOU62PyXU7qBjG5Frdg+JsyNyE07dZVp+4pMhLw33L5iuz3apaa8nesG34E=
X-Received: by 2002:a17:902:8a97:b0:13e:6e77:af59 with SMTP id
 p23-20020a1709028a9700b0013e6e77af59mr6249033plo.4.1634233810499; Thu, 14 Oct
 2021 10:50:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210928062311.4012070-1-ruansy.fnst@fujitsu.com>
 <20210928062311.4012070-8-ruansy.fnst@fujitsu.com> <20211014170622.GB24333@magnolia>
In-Reply-To: <20211014170622.GB24333@magnolia>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 14 Oct 2021 10:50:00 -0700
Message-ID: <CAPcyv4gGxpHBBjB8e23WEQyVfo4R=vT=1syrJXx1tWymCDV51w@mail.gmail.com>
Subject: Re: [PATCH v10 7/8] xfs: support CoW in fsdax mode
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        Christoph Hellwig <hch@lst.de>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        david <david@fromorbit.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 10:38 AM Darrick J. Wong <djwong@kernel.org> wrote:
>
> On Tue, Sep 28, 2021 at 02:23:10PM +0800, Shiyang Ruan wrote:
> > In fsdax mode, WRITE and ZERO on a shared extent need CoW performed.
> > After that, new allocated extents needs to be remapped to the file.
> > So, add a CoW identification in ->iomap_begin(), and implement
> > ->iomap_end() to do the remapping work.
> >
> > Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
>
> I think this patch looks good, so:
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
>
> A big thank you to Shiyang for persisting in getting this series
> finished! :)
>
> Judging from the conversation Christoph and I had the last time this
> patchset was submitted, I gather the last big remaining issue is the use
> of page->mapping for hw poison.  So I'll go take a look at "fsdax:
> introduce FS query interface to support reflink" now.

The other blocker was enabling mounting dax filesystems on a
dax-device rather than a block device. I'm actively refactoring the
nvdimm subsystem side of that equation, but could use help with the
conversion of the xfs mount path. Christoph, might you have that in
your queue?
