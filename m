Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C44CA412791
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 22:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbhITU6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 16:58:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20279 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232223AbhITU4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 16:56:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632171316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=FVcZB4VPTvjhHaXOVP62GVOHYPku8L3xyqgScZUKyyY=;
        b=ZbWxg3Vli/cueL0tTvu5nlHXkNGsOgViK2ZRec//vJq6Lg/2O7hQjzSynjZ3Ue1Z9LUxjd
        1oPTW0adcWnaQl6qTuDeky5DyxjdOqvw388dP2GFyths0B+IcBr6DRPbuCsTwqWzdhw8BA
        NjRo2tqfZFo6TuSzT81lNW4BKWD1uB0=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-ptioNFQ2PjCMgV4fJeRL_A-1; Mon, 20 Sep 2021 16:55:15 -0400
X-MC-Unique: ptioNFQ2PjCMgV4fJeRL_A-1
Received: by mail-io1-f72.google.com with SMTP id q5-20020a0566022f0500b005d5f7603bafso14020685iow.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 13:55:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FVcZB4VPTvjhHaXOVP62GVOHYPku8L3xyqgScZUKyyY=;
        b=u/cBAxIZWt6Iaab2xHz0X5ieXwjjsow9HdghPX6zDWFx7JFmD6ZdlfTp7EyNvTd37J
         2wAMd0z+cTsMarWyhxXM6hWP4tQeid6+sjZksc9DJFL9p00JqiMhqYmNyKheNtxa70Eb
         y0MtfaTSjy2vc/qH2NhScATh2yfqzQO3Gm6ZI1ewuxO2w8pS5d1CYrzwI2LEcf5/rwcq
         Z3oA41Q38Aq8CMPQRlPIykw3QH9RCzYL3QQM+BgUil7/iyhu6dZkCUac5/f9zD6UasOh
         wGSu69V2mmX/RYFZHlwQJcFftdq2xk45bg0n4rIHqnP4K/Whc8hbtytHCBoRyZ3UNfat
         KZjg==
X-Gm-Message-State: AOAM5306BreOzN+G3wMhbos0XOEkSRyjdVkMintX1SOguIaOKwu8aLhh
        vPG81tfG7ooyz38oiNVom5+XZBwxFBzK3D/iNtRJkQtQtTXGutd5gsYLXX5k3KsoAJZsk3PnbwN
        FtUGBL9CmnY2w+ALQwYv8u3H5
X-Received: by 2002:a6b:ce17:: with SMTP id p23mr20368462iob.90.1632171314803;
        Mon, 20 Sep 2021 13:55:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxIpmmM4pVXbXwtyxx7FYN9P8csF8/1qhnNGT9OksF0JiSvFJiciZN8ab7uo69Oqff3WczZog==
X-Received: by 2002:a6b:ce17:: with SMTP id p23mr20368448iob.90.1632171314562;
        Mon, 20 Sep 2021 13:55:14 -0700 (PDT)
Received: from halaneylaptop.redhat.com (068-184-200-203.res.spectrum.com. [68.184.200.203])
        by smtp.gmail.com with ESMTPSA id v9sm9268905ilc.16.2021.09.20.13.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 13:55:14 -0700 (PDT)
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Jason Baron <jbaron@akamai.com>, Jonathan Corbet <corbet@lwn.net>,
        Jim Cromie <jim.cromie@gmail.com>
Cc:     Andrew Halaney <ahalaney@redhat.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] Trivial dynamic debug fixups
Date:   Mon, 20 Sep 2021 15:54:41 -0500
Message-Id: <20210920205444.20068-1-ahalaney@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is round 3 of some trivial dynamic debug improvements.

v2 -> v3:
 * Use a more clear example in the cli param examples

v1 -> v2:
 * Use different example when showing misleading error message
 * Justify dynamic debug scanning the whole command line
 * Add patch removing ddebug_query
 * Add patch improving cli param examples for dyndbg/$module.dyndbg

v2: https://lore.kernel.org/all/20210913222440.731329-1-ahalaney@redhat.com/
v1: https://lore.kernel.org/all/20210909161755.61743-1-ahalaney@redhat.com/

Andrew Halaney (3):
  dyndbg: make dyndbg a known cli param
  dyndbg: Remove support for ddebug_query param
  Documentation: dyndbg: Improve cli param examples

 .../admin-guide/dynamic-debug-howto.rst       | 13 ++++-----
 .../admin-guide/kernel-parameters.txt         |  5 ----
 lib/dynamic_debug.c                           | 27 +++++--------------
 3 files changed, 14 insertions(+), 31 deletions(-)

-- 
2.31.1

