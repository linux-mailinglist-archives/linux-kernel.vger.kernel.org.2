Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED2D432ED45
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 15:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbhCEOh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 09:37:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60395 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230261AbhCEOhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 09:37:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614955066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=56Lhi7IGAbk10zBLaXtZqqEqwjnTSWPuQuSN6YXXg00=;
        b=OMMyg8Dy/j6n1/RcPIU7TgdcLztGkoTM8bxCQmauxStjnJ3lSAdizBcQfF1DGifLRTn6VE
        BB49ok2l7+/LAObgOzKeX5ucXHd63WRgPRwryPu7e5Gt4Fw1A53v4vEDdrlUy9ZT1wMBjo
        79Kf/71zL/7xEEtCBXIK/MgWH89SrGk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-kjDRpmISPXKIaZR1Y6q9mQ-1; Fri, 05 Mar 2021 09:37:44 -0500
X-MC-Unique: kjDRpmISPXKIaZR1Y6q9mQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D4049876E07;
        Fri,  5 Mar 2021 14:37:42 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C294D5D9C0;
        Fri,  5 Mar 2021 14:37:38 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        kernel test robot <oliver.sang@intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        Oleksii Kurochko <olkuroch@cisco.com>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, linux-nvdimm@lists.01.org
Subject: Re: [block]  52f019d43c: ndctl.test-libndctl.fail
References: <20210305055900.GC31481@xsang-OptiPlex-9020>
        <20210305074204.GA17414@lst.de>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Fri, 05 Mar 2021 09:38:19 -0500
In-Reply-To: <20210305074204.GA17414@lst.de> (Christoph Hellwig's message of
        "Fri, 5 Mar 2021 08:42:04 +0100")
Message-ID: <x49y2f1aco4.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@lst.de> writes:

> Dan,
>
> can you make any sense of thos report?
>
> name='nfit_test'
> path='/lib/modules/5.11.0-rc5-00003-g52f019d43c22/extra/test/nfit_test.ko'
>> check_set_config_data: dimm: 0 read2 data miscompare: 0
>> check_set_config_data: dimm: 0x1 read2 data miscompare: 0
>> check_set_config_data: dimm: 0x100 read2 data miscompare: 0
>> check_set_config_data: dimm: 0x101 read2 data miscompare: 0
>> check_dax_autodetect: dax_ndns: 0x558a74d92f00 ndns: 0x558a74d92f00
>> check_dax_autodetect: dax_ndns: 0x558a74d91f40 ndns: 0x558a74d91f40
>> check_pfn_autodetect: pfn_ndns: 0x558a74d91f40 ndns: 0x558a74d91f40
>> check_pfn_autodetect: pfn_ndns: 0x558a74d8c5e0 ndns: 0x558a74d8c5e0
>> check_btt_autodetect: btt_ndns: 0x558a74d8c5e0 ndns: 0x558a74d8c5e0
>> check_btt_autodetect: btt_ndns: 0x558a74da1390 ndns: 0x558a74da1390
>> check_btt_autodetect: btt_ndns: 0x558a74d8c5e0 ndns: 0x558a74d8c5e0
>> check_btt_autodetect: btt_ndns: 0x558a74d91f40 ndns: 0x558a74d91f40
>> namespace7.0: failed to write /dev/pmem7
>> check_namespaces: namespace7.0 validate_bdev failed
>> ndctl-test1 failed: -6

This is from test/libndctl.c in the ndctl repo:

        fd = open(bdevpath, O_RDONLY);
        if (fd < 0) {
                fprintf(stderr, "%s: failed to open(%s, O_RDONLY)\n",
                                devname, bdevpath);
                return -ENXIO;
        }
...
        ro = 0;
        rc = ioctl(fd, BLKROSET, &ro);
        if (rc < 0) {
                fprintf(stderr, "%s: BLKROSET failed\n",
                                devname);
                rc = -errno;
                goto out;
        }

        close(fd);
        fd = open(bdevpath, O_RDWR|O_DIRECT);
...
        if (write(fd, buf, 4096) < 4096) {
                fprintf(stderr, "%s: failed to write %s\n",
                                devname, bdevpath);
                rc = -ENXIO;
                goto out;
        }

HTH,
Jeff

