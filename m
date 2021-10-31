Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAE96440FE2
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Oct 2021 18:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbhJaRuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 13:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbhJaRuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 13:50:05 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37079C061714
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 10:47:33 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id l10-20020a17090a4d4a00b001a678eed8abso1024525pjh.3
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 10:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7MuoEHjjO8VeJaVuFed8XWzS0lEfBBHPNJTbN9pP/Kk=;
        b=4tOJMdKFSRsgNH+AUIYaqm2kjoYMRFX1rF2DJJ+SkN3TxFcC6WFZTlfZ/p19kQbT9K
         3ucowaD3UjTRl1wxq0AhkO2grIrwJ1CUzZL9iaOW9qQruYwZiNTLyT8xPdcntcGZTnKO
         oHouSuIItcBdIuUQi3se1/cFTWoJaoIMfatJqvTJNtdVS5k8eQGd7+SN6PbVUPLsaGtZ
         l1ZNkN5xiSBdq4V2xHL4j3AS7JUzTTQy6aixWFwT8tGnH7btlFyMUA6OKqRZ3rOIuHsc
         1ZLLqjh17RQWY85HyaOON7GqX1MfrrlXjw7ctSAkgQItKO1cowEaIPOliTgHjuC8pBHM
         Mnbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7MuoEHjjO8VeJaVuFed8XWzS0lEfBBHPNJTbN9pP/Kk=;
        b=z6ZP+ARAP5m8nCvBLTyagcjQO55eSXxn2zqRmMqFIPYFGpJQnTmPw4bAKKo0bg2QKG
         AoEdJQvOn18BkYI5q20Ls1GRKyiKhcBwwrBDaQot0itCb9InFdFBLwj8J6Z8pjI335zN
         YncEmX319PBhM6+FVDVHcamD6jzyE+uU4sJGaRhBH3DPw/wlb3DlcZHhC22UQGv4wtCO
         T8rjv64BLjDQome5JteQdeXL3Vh5quehqpFv3L3L9dHXu8hIkddoTuj0LzPvBFbyrVKW
         nPc6yy8Fo11hP1m2l/tdDUEABh7XO412J8TEQPp2PuyCl1KIWOI40bRsUfudfx1tJS+C
         rP0A==
X-Gm-Message-State: AOAM532/LAdd7ZCNh+38f+CQuPjIwO9RpKdK7KrkdrOYOmszrr4dzMXj
        WZ+Ytzh1gIM1sg3ASn23QqK72tTHf651bMc2fbMfhQ==
X-Google-Smtp-Source: ABdhPJyA7Laj0AUg2FKVlcU7XOrNA0zdW+Ju6E23SLHq82Op6ARxl3h9QltxEajuidxiYWqVOR7E35WaYaY6PyVeaf4=
X-Received: by 2002:a17:902:8a97:b0:13e:6e77:af59 with SMTP id
 p23-20020a1709028a9700b0013e6e77af59mr20648644plo.4.1635702452583; Sun, 31
 Oct 2021 10:47:32 -0700 (PDT)
MIME-Version: 1.0
References: <20211015235219.2191207-1-mcgrof@kernel.org> <20211015235219.2191207-4-mcgrof@kernel.org>
In-Reply-To: <20211015235219.2191207-4-mcgrof@kernel.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sun, 31 Oct 2021 10:47:22 -0700
Message-ID: <CAPcyv4gU0q=UhDhGoDjK1mwS8WNcWYUXgEb7Rd8Amqr1XFs6ow@mail.gmail.com>
Subject: Re: [PATCH 03/13] nvdimm/btt: do not call del_gendisk() if not needed
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Geoff Levand <geoff@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, Jim Paris <jim@jtan.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>, senozhatsky@chromium.org,
        Richard Weinberger <richard@nod.at>, miquel.raynal@bootlin.com,
        vigneshr@ti.com, Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-mtd@lists.infradead.org,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-nvme@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 4:53 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> We know we don't need del_gendisk() if we haven't added
> the disk, so just skip it. This should fix a bug on older
> kernels, as del_gendisk() became able to deal with
> disks not added only recently, after the patch titled
> "block: add flag for add_disk() completion notation".

Perhaps put this in:

    commit $abbrev_commit ("block: add flag for add_disk() completion notation")

...format, but I can't seem to find that commit?

If you're touching the changelog how about one that clarifies the
impact and drops "we"?

"del_gendisk() is not required if the disk has not been added. On
kernels prior to commit $abbrev_commit ("block: add flag for
add_disk() completion notation")
it is mandatory to not call del_gendisk() if the underlying device has
not been through device_add()."

Fixes: 41cd8b70c37a ("libnvdimm, btt: add support for blk integrity")

With that you can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
