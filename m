Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1617440A52
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 19:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbhJ3RGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Oct 2021 13:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbhJ3RGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Oct 2021 13:06:17 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A3CC061714
        for <linux-kernel@vger.kernel.org>; Sat, 30 Oct 2021 10:03:47 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id h81so7613383iof.6
        for <linux-kernel@vger.kernel.org>; Sat, 30 Oct 2021 10:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=mxOtNLa1eAMR0wpGD1VMaJkJmBISmLqnmjVIAsRcHvc=;
        b=TxRznXHiVxPacqnwtNIIT0ht6nYzSE2RDLvhKozr3LBin/ehB9sdFZDpWWjj4OSd+b
         wNVCVAvLw46JGTiAgUNZvEmvOxN66IADWaxYxM1QrR9lkXlSakotxqRDVZM1H74gZzC3
         dptCLtGLLsAefANWtuy2n0rGMRlWfacf/IHiKhBgdqwAXaaJe6kpIkKpb32JNyUJDsPQ
         h2JfNkORS5+nxcLRKrwXOlVNT9+6p7ra3ZV/bu0Di5bdLiqfxKarFy4zEtd9fllr2oYp
         7Q6VyWuncWNiiodyabAkyjZysJUsC526HyMFP48mdzk4scwMLVB6FI1dgulKgRvL0IOy
         PuLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=mxOtNLa1eAMR0wpGD1VMaJkJmBISmLqnmjVIAsRcHvc=;
        b=wDPMBzBfRuQjUgPjQy00apvInFv8IWVyOTHHL7QEBXia/2RrOFz7SlORcyNNQIKMsX
         1Zvey9mEKuPBP0gFu8ru3ePeJzxXW+eVMUcNwBZf9uz9hfgMySgaHE3F0+dJ/fC4DTHe
         q7OQEJy9olyBvUR7Nu82B1WA9zaLpkOF3EaUQiOE8T26o/Xdry6dmIUN5KukEQ1Sr+8H
         uH2xsF9Qs2HugXvxMJUfMTSROLU2q9Mqdu4uYoXTdylxJVVSXg2qsPasjgd6F7vCGOAL
         OW9XyrvNTmU1hnN0h1uu4L+aNHQTbQi1L1LrN1H1rIX8GF6spBSvhNPXErdVovDbCzU9
         54HQ==
X-Gm-Message-State: AOAM5306agVpS5LBv2c+XDvgsoNSkJi6/2CvYP+JgQiw4Br7rnoZ0y+q
        B4kpKmojj2Rlvu73z5yT7TqklQ==
X-Google-Smtp-Source: ABdhPJzMkwx+8CSrFVSVUQuPKJKJNsEs+j3d0vp9XLDv6RRzhAFgLrCeu1vNWGVlfsmYjr2iZBeQpQ==
X-Received: by 2002:a05:6602:2a44:: with SMTP id k4mr13067137iov.56.1635613426348;
        Sat, 30 Oct 2021 10:03:46 -0700 (PDT)
Received: from [127.0.1.1] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id z26sm4948483ioe.9.2021.10.30.10.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Oct 2021 10:03:45 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     kbusch@kernel.org, dan.j.williams@intel.com, richard@nod.at,
        jim@jtan.com, vishal.l.verma@intel.com, dave.jiang@intel.com,
        miquel.raynal@bootlin.com, vigneshr@ti.com, ngupta@vflare.org,
        ira.weiny@intel.com, senozhatsky@chromium.org, hch@lst.de,
        paulus@samba.org, Luis Chamberlain <mcgrof@kernel.org>,
        sagi@grimberg.me, mpe@ellerman.id.au, minchan@kernel.org,
        geoff@infradead.org, benh@kernel.crashing.org
Cc:     linux-mtd@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        nvdimm@lists.linux.dev, linux-block@vger.kernel.org
In-Reply-To: <20211015235219.2191207-1-mcgrof@kernel.org>
References: <20211015235219.2191207-1-mcgrof@kernel.org>
Subject: Re: (subset) [PATCH 00/13] block: add_disk() error handling stragglers
Message-Id: <163561342513.76453.10042066842818606438.b4-ty@kernel.dk>
Date:   Sat, 30 Oct 2021 11:03:45 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Oct 2021 16:52:06 -0700, Luis Chamberlain wrote:
> This patch set consists of al the straggler drivers for which we have
> have no patch reviews done for yet. I'd like to ask for folks to please
> consider chiming in, specially if you're the maintainer for the driver.
> Additionally if you can specify if you'll take the patch in yourself or
> if you want Jens to take it, that'd be great too.
> 
> Luis Chamberlain (13):
>   block/brd: add error handling support for add_disk()
>   nvme-multipath: add error handling support for add_disk()
>   nvdimm/btt: do not call del_gendisk() if not needed
>   nvdimm/btt: use goto error labels on btt_blk_init()
>   nvdimm/btt: add error handling support for add_disk()
>   nvdimm/blk: avoid calling del_gendisk() on early failures
>   nvdimm/blk: add error handling support for add_disk()
>   zram: add error handling support for add_disk()
>   z2ram: add error handling support for add_disk()
>   ps3disk: add error handling support for add_disk()
>   ps3vram: add error handling support for add_disk()
>   block/sunvdc: add error handling support for add_disk()
>   mtd/ubi/block: add error handling support for add_disk()
> 
> [...]

Applied, thanks!

[08/13] zram: add error handling support for add_disk()
        commit: 5e2e1cc4131cf4d21629c94331f2351b7dc8b87c
[10/13] ps3disk: add error handling support for add_disk()
        commit: ff4cbe0fcf5d749f76040f782f0618656cd23e33
[11/13] ps3vram: add error handling support for add_disk()
        commit: 3c30883acab1d20ecbd3c48dc12b147b51548742

Best regards,
-- 
Jens Axboe


