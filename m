Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD6D3EEC4A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 14:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236950AbhHQMUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 08:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234866AbhHQMUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 08:20:07 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CE8C061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 05:19:32 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id w24so5804341wmi.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 05:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:subject:message-id:mime-version:content-disposition;
        bh=6ENXzKZr3llo+VrC9R9YSqAe2/24cY2AWp8C2U3ZFbo=;
        b=HDPzkcxl6uaS0otfcmjZWZMP9jQzSIg3fmqu0WU/HjDj5KCMLovUuJESRE9gkca9Pj
         Wkn5wASBPQoxigV6+D/9tuJnQtjd8xQqN2jA7dRcIYk35a8Kg3MCKXuMJ4nsihNr5ThQ
         d3CGoXtV7JGcLXNflDTZDtct4nNJ6YPOwXPlLsRuXmjtKMAWVd6+jryhAThttEvcK26O
         r7mSe9mqMESb3tHG3dWcYIzdgYVH+/UcuxUekCyTv17TtJUccnwOQcnwlefZijgrA2Pu
         5673Kz2OvgW0HwXs2USXtSc7dMAU5TNplM7Vow/ce4yedvcOuFHa5Di9nmNd/2lUo3nc
         zVaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:mime-version
         :content-disposition;
        bh=6ENXzKZr3llo+VrC9R9YSqAe2/24cY2AWp8C2U3ZFbo=;
        b=EHzAVYpH/8aRwP/WJFl9y1g+UObDyTOwXSUZjXzYBn3ZyoNaIvEdGzo7bkAFyoqPOc
         kHdk0JYOXNJhR9+gOxhGObYiHk59OWkse1QkBd/9c5BU8Mrz9P5AGLmu0Kq/dwXV/Fia
         ceI00bVXN0dBw9EWq4mKOlVSt3LSu/qhG4bQWIFqV8pnV5NgkpO4amKBTjxBnroesvsG
         FDUvFWP5jg8N6Lk0JACTylx35KVzUovYf2VF7gO33H2EcaL9E1dFiA+SNteeAlQ78TuE
         wazmu3OJGmsPn5xhAM//Tm8GJXiK0Hw0BWHvFX6tmz4IZMjTmo+D1MU9LZZ2cNBuE8o1
         W95Q==
X-Gm-Message-State: AOAM530FghNjTQpM8Ur9D6MV6jwB00sutquwNXkGeX1yXiXernNh+EGa
        +fbuXEP6vkHcyBQi066bkyNlP/vPsmE=
X-Google-Smtp-Source: ABdhPJzkf7vLvI71vtHvUG5G73rEk0lTN3GM5kylPRzy1kzvmkv6nUbyt7vIaEAAW745LNVCf+F80A==
X-Received: by 2002:a1c:1f07:: with SMTP id f7mr3020389wmf.116.1629202771120;
        Tue, 17 Aug 2021 05:19:31 -0700 (PDT)
Received: from saturne.home ([2a01:cb1d:16b:7e00:254e:383d:631e:66b2])
        by smtp.gmail.com with ESMTPSA id l12sm1800304wms.24.2021.08.17.05.19.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 05:19:29 -0700 (PDT)
From:   Laurent Stacul <captain.stac@gmail.com>
X-Google-Original-From: Laurent Stacul <laurent.stacul@gmail.com>
Date:   Tue, 17 Aug 2021 14:19:12 +0200
To:     linux-kernel@vger.kernel.org
Subject: XFS/mmap reflink file question
Message-ID: <YRupQKbg6uN8INCn@saturne.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I spent much time digging into the mmap mechanism and I don't have a clear view
on mmap'ing a file and a reflink to this file would be mapped twice in memory
(this only applies in case the filesystem supports reflink feature like XFS).

To describe my tests, I generate a file stored on an XFS partition and create a
reflink of it:

     % dd if=/dev/zero of=./output.dat bs=1M count=24
     % cp --reflink -v output.dat output2.dat
     % xfs_bmap -v output.dat
     output.dat:
      EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET          TOTAL
        0: [0..49151]:      3756776..3805927  0 (3756776..3805927) 49152 100000
     % xfs_bmap -v output2.dat
     output2.dat:
      EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET          TOTAL
        0: [0..49151]:      3756776..3805927  0 (3756776..3805927) 49152 100000

Then I mmap the first file twice using vmtouch tool:

     % vmtouch -l output.dat&
     [1] 15870
     LOCKED 6144 pages (24M)
     % vmtouch -l output.dat&
     [2] 15872
     LOCKED 6144 pages (24M)
     % pmap -X 15872 | grep -e 'Pss' -e 'output' | awk '{if(NR>1)printf("%16s %4s %6s %10s %10s %10s\n", $1, $2, $4, $5, $7, $8)}'
          Address Perm Device      Inode        Rss        Pss
     7fcbb9eb9000 r--s  fc:10    3755268      24576      12288

As we can see the Proportional Set Size is as expected the half of the Resident
Set Size because the memory is shared by the two processes. Now, I mmap the
reflink `output2.dat' of 'output.dat':

     % vmtouch -l output2.dat&
     [3] 15892
     LOCKED 6144 pages (24M)
     % pmap -X 15872 | grep -e 'Pss' -e 'output' | awk '{if(NR>1)printf("%16s %4s %6s %10s %10s %10s\n", $1, $2, $4, $5, $7, $8)}'
          Address Perm Device      Inode        Rss        Pss
     7fcbb9eb9000 r--s  fc:10    3755268      24576      12288

The Pss of mmap'ed file by the first process has not decreased (I expected a
value of Rss / 3 because I hoped the memory would have been shared by the 3
processes). If I look at the process map of the last process, we can interpret
a new memory area was allocated and locked.

     % pmap -X 15892 | grep -e 'Pss' -e 'output' | awk '{if(NR>1)printf("%16s %4s %6s %10s %10s %10s\n", $1, $2, $4, $5, $7, $8)}'
           Address Perm Device      Inode        Rss        Pss
      7f5adc53f000 r--s  fc:10    3755269      24576      24576

So my questions:
- Why can't we benefit from the memory sharing when reflinked files are mmap'ed
   ? It would be great because one application would be, in the context of
   containers, the possibility to share some read only areas between container
   that are built from the layer diff that are reproducible between images. We
   can imagine a layer that brings some shared libraries in an image from a
   reproducible FS diff so that containers would not load several times a
   library.
- I can think of many tricky cases with the behavior I was expecting (especially
   if a process has write access to the mapped area), but if you know a way, an
   option something to achieve what I am trying to do, I would be glad to hear
   it.
- Conversely, don't hesitate to tell me my expectation is just crazy.

Anyway, I am always looking forward to listening to valuable specialist insights.
Thanks in advance,

stac

PS: Please, add me is CC if this message deserves an answer.

