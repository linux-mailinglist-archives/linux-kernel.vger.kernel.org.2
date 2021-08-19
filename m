Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 412FC3F17B8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 13:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238449AbhHSLJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 07:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238021AbhHSLJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 07:09:28 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3B7C061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 04:08:52 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id a21so7152045ioq.6
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 04:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5rak3fos7+/+7h7oxO17MqDUA5qjL3XWZkwvkReF0p4=;
        b=OHLsMDhqZiUkxlIxWQWrnQ0vPEFDGV+Qfi3NDFwtEC/jLegKxbdQrCadH4coYAoc+I
         AE47cTjbxnCcwq/pixNnTQ9F4QbofzYetKX90Ry1PpN2FgCjcl24AdbRBCQdvoiEyAb6
         oY0NAJM4GEVNkbx74xdeblfnmv5czqzmX8bELPuqLgClEyWXUEOq5D1nwXA3BjZ9xRO6
         8oUupdU6u4iv/yl6TVJQMnIiPkfYLoKA+mijvS5VoC3czkzdGcOWHii6jS/k5/GAk5Rh
         TpkLKE7CzxSemul0PQfE+OHl1ufX+7rE3+/iXKPB/3VU+uuYhLzMwPBMWkchAQ9iTIaZ
         //hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5rak3fos7+/+7h7oxO17MqDUA5qjL3XWZkwvkReF0p4=;
        b=YBomCxMy4FuG7Dyzb+ZTlg89rx4LfIVMh2gGDqiKo2C8s2iYeClMyB/DnHxZFoOCwy
         tebxydYRUEyWcfHhf5dL3tzNUJ5ZbDOL5IDpEMpNV46XFOdYZij5Nviv43WL3sMJ1/dg
         jmzbKU57DNMWixgloPBY/Mzh4JFXY0WLscWPa3C2otH3vXvjkRD7jCxLOim27hQ5Jvi8
         P9kPwHNMvZXhzLj9Dc9GAJBv1qJX0SrR7T99Me3oOOLzHVe40ikPHzJaomonkIoPjeE7
         LDI9lnV+i29GM+uuA0g3aB+sIoeOVVxMYRBE3gdeFNHIFwvSauUuW0aYv1H9srgkPeWk
         D1lQ==
X-Gm-Message-State: AOAM532LhG/CyiR13zfVvlkW43rTiH9D5oMpAS2SbtCucHc2nurak7gO
        jZcME54XteQgKuMHmLp8BDW5vW8mEi0BPQF8Gyk=
X-Google-Smtp-Source: ABdhPJz6xWqiUu4Z2zPOpvT1RlG+UQj40lEmUZd29fWnZDOnjPiWwZG9co6zOHjENcevEoVjWZcfviDEU2335d+eel8=
X-Received: by 2002:a02:a50d:: with SMTP id e13mr12320170jam.124.1629371331798;
 Thu, 19 Aug 2021 04:08:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210726060855.108250-1-pankaj.gupta.linux@gmail.com>
In-Reply-To: <20210726060855.108250-1-pankaj.gupta.linux@gmail.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Thu, 19 Aug 2021 13:08:40 +0200
Message-ID: <CAM9Jb+jDU7anniT8eL5yUQw1t_MZzndw=n1LWJ5fWV5k871+wQ@mail.gmail.com>
Subject: Re: [RFC v2 0/2] virtio-pmem: Asynchronous flush
To:     nvdimm@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>, jmoyer@redhat.com,
        David Hildenbrand <david@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Pankaj Gupta <pankaj.gupta@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gentle ping.

>
>  Jeff reported preflush order issue with the existing implementation
>  of virtio pmem preflush. Dan suggested[1] to implement asynchronous flush
>  for virtio pmem using work queue as done in md/RAID. This patch series
>  intends to solve the preflush ordering issue and also makes the flush
>  asynchronous for the submitting thread.
>
>  Submitting this patch series for review. Sorry, It took me long time to
>  come back to this due to some personal reasons.
>
>  RFC v1 -> RFC v2
>  - More testing and bug fix.
>
>  [1] https://marc.info/?l=linux-kernel&m=157446316409937&w=2
>
> Pankaj Gupta (2):
>   virtio-pmem: Async virtio-pmem flush
>   pmem: enable pmem_submit_bio for asynchronous flush
>
>  drivers/nvdimm/nd_virtio.c   | 72 ++++++++++++++++++++++++++++--------
>  drivers/nvdimm/pmem.c        | 17 ++++++---
>  drivers/nvdimm/virtio_pmem.c | 10 ++++-
>  drivers/nvdimm/virtio_pmem.h | 14 +++++++
>  4 files changed, 91 insertions(+), 22 deletions(-)
>
> --
> 2.25.1
>
