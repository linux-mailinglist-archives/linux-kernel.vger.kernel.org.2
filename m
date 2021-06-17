Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB7203AB25B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 13:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbhFQLTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 07:19:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34662 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232480AbhFQLTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 07:19:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623928655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=ut8mBDS/J21Tbda7DvgLRQmHjd21yKq2MA4wJcOqS9o=;
        b=Z8sawRvR6sourkTADP3v3/t8emCFzXabCYGjF4TjCO8wAn0bR9XJZ9/52896PmjZ0pTTF3
        5A6g9Iq69Efj9EVeNvjnorqX2/7eFj6UgMUmv2Q+3WDdSsQ83jDuKNS/HXYaT15aYT0kmN
        RHcSWv4SNv0uDdfFcSeDpzQqofw0jD4=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-rdSNBiZdMK6e014nt95RCg-1; Thu, 17 Jun 2021 07:17:34 -0400
X-MC-Unique: rdSNBiZdMK6e014nt95RCg-1
Received: by mail-yb1-f198.google.com with SMTP id a17-20020a5b09110000b0290547160c87c9so7870384ybq.19
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 04:17:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ut8mBDS/J21Tbda7DvgLRQmHjd21yKq2MA4wJcOqS9o=;
        b=o8cKQESXppynpxSc+oOAJy48ViGgGoHC2zXvYQmITisXk7HKmWxNadHov64b9AX2wB
         SOHMNl3PHxBP2sQqDukHo21x2igNwBFUKMhkhUNakWOaoSyEPbXLq338DgZkwURxxUoE
         12C0zv++zfHVHsqyshGhJkPopvMDA5U45OFnqXuPOWJknzjXNPTnVx0Tj81wJWL+0PuE
         /0IxJNL2NRUcFOq5sluP7sk37PVXHdX7GGqj26QAoYMhZv8OP0F05iPv+JW0J7Nx8kLL
         SI9CAbo1qxE4H5Y5yMm/xkIswzkIvJhE3ffYTdKy8mhTcRabx2ut0Pnw5ko5uOqU57w1
         fHGw==
X-Gm-Message-State: AOAM532n5NX1q/orcafiW3brjTkcejH2gz3xxXNlTze7BVEt24PgWyH9
        cdV5Pc7T0MnUEt8XNIcA5lQo2w+6wUpMGNCFzShWgkolS78Sc+OREPv9rzLcQx5zrBK6PWS61Pm
        3cN+jgIeZE/aTeT8GvqJHe9NEKSm+KB7yxPQjxrig
X-Received: by 2002:a25:354:: with SMTP id 81mr5383487ybd.134.1623928654039;
        Thu, 17 Jun 2021 04:17:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxzNxOVXVniR7azNK6QqojUcyleUy/9jraJw0k8tqORFUUqHsc6saxsCzJhpnNSwV7cjxwNOBzaz9bZRMiMM7E=
X-Received: by 2002:a25:354:: with SMTP id 81mr5383471ybd.134.1623928653895;
 Thu, 17 Jun 2021 04:17:33 -0700 (PDT)
MIME-Version: 1.0
From:   Ming Lei <ming.lei@redhat.com>
Date:   Thu, 17 Jun 2021 19:17:23 +0800
Message-ID: <CAFj5m9+ckHjfMVW_O20NBAPvnauPdABa8edPy--dSEf=XdhYRA@mail.gmail.com>
Subject: [Bug] fio hang when running multiple job io_uring/hipri over nvme
To:     linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

fio hangs when running the test[1], and doesn't observe this issue
when running a
such single job test.

v5.12 is good, both v5.13-rc3 and the latest v5.13-rc6 are bad.


[1] fio test script and log
+ fio --bs=4k --ioengine=io_uring --fixedbufs --registerfiles --hipri
--iodepth=64 --iodepth_batch_submit=16
--iodepth_batch_complete_min=16 --filename=/dev/nvme0n1 --direct=1
--runtime=20 --numjobs=4 --rw=randread
--name=test --group_reporting

test: (g=0): rw=randread, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T)
4096B-4096B, ioengine=io_uring, iodepth=64
...
fio-3.25
Starting 4 processes
fio: filehash.c:64: __lookup_file_hash: Assertion `f->fd != -1' failed.
fio: pid=1122, got signal=6
^Cbs: 3 (f=0): [f(1),r(1),K(1),r(1)][63.6%][eta 00m:20s]

Thanks,

