Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 505D53D677D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 21:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbhGZSrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 14:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbhGZSrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 14:47:32 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8EF9C061757;
        Mon, 26 Jul 2021 12:27:59 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id k1so12801587plt.12;
        Mon, 26 Jul 2021 12:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=1UdDzrra23dH9YokfKPvE1AeA2jAHVIroGq1SNBQhuw=;
        b=MXRrw0ZZsitiE9Skwj7bh0DNNijMrePYVHp7uEChWsp7D77WbfAThhYYBC2WO+q2wf
         NboTspa5DGdHXqIcnd8mFfLYOI+5FKdyVzKeHFEYpiZ0KpdsrD7qErPAsgJvkbZfdXpL
         la1FgQ12OZkU6yz5Tobg/8FZL5+0L+yUMurqUlJZCZEw+AzrF1oRA+NEu1U49iYb/cPZ
         3wbOSkSn4YCqbJf+Brle4G9lbtySBXa0iOpQIAUnf5qhL+VAFwQJhC3quNE2oRApgrxA
         61BPag9gmZc5yd6sUq1sefi4+KZP7K0OytFa6obcpZBOBS6SWBKbNGXnFxAdbI8UOF/J
         fAfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=1UdDzrra23dH9YokfKPvE1AeA2jAHVIroGq1SNBQhuw=;
        b=RzjXrkGT0EzxCdWhcQulPFZpwf2VwDZTYgpdLpP2lsKlhJ3eVY/nhWJkQabtb50Noh
         XYjj9RUyIuV2uCb/2SdcrFYLuAtBdzNyAImWgRy2NKhDj4X6O8gMSqCRE+TAEOxnBPyM
         licLF446PNtOelf7cIaC+FeT2Fi+ZqDK7reV3r53gdJhV4pzpvRjlkSGU+9O73VdV67C
         Mn/PzuJakTWm/vOVE4i5NaHHnbdiTExLFNaSohwHzhVA3QYSxP6Jbp2jg4A37lmDrNkX
         1GBX5woC0ccaFcA6PABXEBfeDs9smpIPF0w/dy27pzfevgTghqf2Pz3Kdw+Ej38jeCXf
         /+hA==
X-Gm-Message-State: AOAM530+ZUIMfKeOh1yPLVkjkCF2wzhJduJ1VCsxtuMYzI7IoljdQNgD
        Ar7i0aLh9mxD/BYgB2LygZd9fymv8NTxQw==
X-Google-Smtp-Source: ABdhPJyKIa2tBdwRxa14RYdzaKZvi7hz0ilJLanTVJ8nLbjcw7fODHKHN0rhx5KhPD9MpwdXxNO31Q==
X-Received: by 2002:a17:90a:d250:: with SMTP id o16mr9430341pjw.181.1627327679240;
        Mon, 26 Jul 2021 12:27:59 -0700 (PDT)
Received: from localhost ([108.161.26.224])
        by smtp.gmail.com with ESMTPSA id 26sm413610pjj.27.2021.07.26.12.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 12:27:53 -0700 (PDT)
Date:   Mon, 26 Jul 2021 12:27:50 -0700
From:   Matt Turner <mattst88@gmail.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Michael Cree <mcree@orcon.net.nz>, linux-mm@kvack.org,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Regression bisected to fa3354e4ea39 (mm: free_area_init: use maximal
 zone PFNs rather than zone sizes)
Message-ID: <20210726192311.uffqnanxw3ac5wwi@ivybridge>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reply-To:

Hi Mike!

Since commit fa3354e4ea39 (mm: free_area_init: use maximal zone PFNs rather
than zone sizes), I get the following BUG on Alpha (an AlphaServer ES47 Marvel)
and loading userspace leads to a segfault:

(I didn't notice this for a long time because of other unrelated regressions,
the pandemic, changing jobs, ...)

BUG: Bad page state in process swapper  pfn:2ffc53
page:fffffc000ecf14c0 refcount:0 mapcount:1 mapping:0000000000000000 index:0x0
flags: 0x0()
raw: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
raw: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
page dumped because: nonzero mapcount  
Modules linked in:
CPU: 0 PID: 0 Comm: swapper Not tainted 5.7.0-03841-gfa3354e4ea39-dirty #26
        fffffc0001b5bd68 fffffc0001b5be80 fffffc00011cd148 fffffc000ecf14c0
        fffffc00019803df fffffc0001b5be80 fffffc00011ce340 fffffc000ecf14c0
        0000000000000000 fffffc0001b5be80 fffffc0001b482c0 fffffc00027d6618
        fffffc00027da7d0 00000000002ff97a 0000000000000000 fffffc0001b5be80
        fffffc00011d1abc fffffc000ecf14c0 fffffc0002d00000 fffffc0001b5be80
        fffffc0001b2350c 0000000000300000 fffffc0001b48298 fffffc0001b482c0
Trace:
[<fffffc00011cd148>] bad_page+0x168/0x1b0
[<fffffc00011ce340>] free_pcp_prepare+0x1e0/0x290
[<fffffc00011d1abc>] free_unref_page+0x2c/0xa0
[<fffffc00014ee5f0>] cmp_ex_sort+0x0/0x30
[<fffffc00014ee5f0>] cmp_ex_sort+0x0/0x30
[<fffffc000101001c>] _stext+0x1c/0x20

I haven't tried reproducing this on other machines or QEMU, but I'd be glad to
if that helps.

Any ideas?

Thanks,
Matt
