Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8AFD40BEF9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 06:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbhIOEpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 00:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbhIOEpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 00:45:39 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB48C061764
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 21:44:21 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d18so836895pll.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 21:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3ke2SRIGg+XGVFQMj2Nt31WiTZWFxp5XafAaSq0r4/4=;
        b=IgddcRQ7nEVsnQHD4blpqVfJkt+DwRZsn1JfhZcfU2PVTGfTd0vg73tM/KT+8U8CQe
         4e69bwZ4MTnHmixKqECl7S9IKK7tTvMFMonN6yRO1YQYg+hWwpT4triYtph1/StYGx34
         3bofmcgWihb/3d3zyXxlicz/EYNzLwjDzqSrrO6LtGFPJ8hBS24ssqZsBwkjHjJvIFRw
         1LVMGNbMDi/vkbi8B0Njra7wFPNrPBo9GjErDIN+CFkpa5XmGBMjkjEsbGZYud0bxZPj
         whnHExG6NPVNyWtCjro3XhdA0frBCxVdE62aac/hH0dUtSGi67RZez0dr3ad+kmbhlap
         y0Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3ke2SRIGg+XGVFQMj2Nt31WiTZWFxp5XafAaSq0r4/4=;
        b=R5Fkk7KDPv4O4pOrfXhdZirdEnlhhTOr//WOte9d4n3rDpKIFQrI7eCddXLrxAccYL
         ocQTnssMz1UBI5N5R3T6qXYZjvQCRoE8ZLSUc12v1EE2BMi8ARbWhkbcOGqclmL7SkyS
         aqmSi8LZunjCLzgkgXImE9a6irDLhcV88S6yUz4V7SZi1sNSA6ffitEma8pDOUYr7r5A
         i21LUM4rqaM8CKoeQl0iCE8PIugDbBn7xoCT1xL106oBVGAaB+pyaJ1CE5sJrd7lTuWd
         gBUgT10fbcmzTns3ShetNdY6ClRYFA+yNmIly/xSbI+FovkCW/JvK2viD5Vf7e7kJvku
         P6mQ==
X-Gm-Message-State: AOAM531YjK1W63yzAl5qYQXdWCG371aVSJCJFgwbphy6X0zVTA4GEKpl
        ORHk44DjZC8ycGeK/nZSJb+s9KJMR8otor+jW9gjng==
X-Google-Smtp-Source: ABdhPJzx4g82CIHm0nZUdlQbdJR7J9Aag191pgYrsfIq2kmSlUsJ+IEAjsXoy1QVMvB9zFyoHYJ5VLm80IwNQqJLsCc=
X-Received: by 2002:a17:90a:d686:: with SMTP id x6mr6263231pju.8.1631681061030;
 Tue, 14 Sep 2021 21:44:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210914233132.3680546-1-jane.chu@oracle.com>
In-Reply-To: <20210914233132.3680546-1-jane.chu@oracle.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 14 Sep 2021 21:44:10 -0700
Message-ID: <CAPcyv4h3KpOKgy_Cwi5fNBZmR=n1hB33mVzA3fqOY7c3G+GrMA@mail.gmail.com>
Subject: Re: [PATCH 0/3] dax: clear poison on the fly along pwrite
To:     Jane Chu <jane.chu@oracle.com>
Cc:     Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 4:32 PM Jane Chu <jane.chu@oracle.com> wrote:
>
> If pwrite(2) encounters poison in a pmem range, it fails with EIO.
> This is unecessary if hardware is capable of clearing the poison.
>
> Though not all dax backend hardware has the capability of clearing
> poison on the fly, but dax backed by Intel DCPMEM has such capability,
> and it's desirable to, first, speed up repairing by means of it;
> second, maintain backend continuity instead of fragmenting it in
> search for clean blocks.
>
> Jane Chu (3):
>   dax: introduce dax_operation dax_clear_poison

The problem with new dax operations is that they need to be plumbed
not only through fsdax and pmem, but also through device-mapper.

In this case I think we're already covered by dax_zero_page_range().
That will ultimately trigger pmem_clear_poison() and it is routed
through device-mapper properly.

Can you clarify why the existing dax_zero_page_range() is not sufficient?

>   dax: introduce dax_clear_poison to dax pwrite operation
>   libnvdimm/pmem: Provide pmem_dax_clear_poison for dax operation
>
>  drivers/dax/super.c   | 13 +++++++++++++
>  drivers/nvdimm/pmem.c | 17 +++++++++++++++++
>  fs/dax.c              |  9 +++++++++
>  include/linux/dax.h   |  6 ++++++
>  4 files changed, 45 insertions(+)
>
> --
> 2.18.4
>
