Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED12E409FA2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 00:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241449AbhIMW2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 18:28:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56893 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238060AbhIMW16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 18:27:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631572002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=X0eYnWNF2y6YPPW1SDm2g1rHLnrujH5b2Tuwd/lt0S4=;
        b=K4G9a28KFDKZ4a74hnuXKavpRvfd1a9qyswDQviuNY67LDyYk8X0T/yZzl7+ugQILqmkOK
        H87SYaGkT0Cit9Yq+LGeI4sJ108vqO9YNRfKs9yupB3Q6qulKicd++YoNnLNwrh+0Ik/1u
        +ZVTXhbKPXKiKJaAw3ZLD5u7Nak3zpQ=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-B_dp98__P0inMOw8Qh-Gdw-1; Mon, 13 Sep 2021 18:26:41 -0400
X-MC-Unique: B_dp98__P0inMOw8Qh-Gdw-1
Received: by mail-io1-f70.google.com with SMTP id n8-20020a6b7708000000b005bd491bdb6aso14963153iom.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 15:26:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X0eYnWNF2y6YPPW1SDm2g1rHLnrujH5b2Tuwd/lt0S4=;
        b=VX/OHiTJvneZh2j/efhOTNduqccNtrU4PsVZGCKK+kGRtJzmQoncgNSYZEj9w/h8ZE
         HvYMASnu+eEKMGvzMC8FNXKBzJ5VjdumNWeHRbG7RF+JtC6A0fG/hJ1hRkw3WjHb2fBe
         7N81GUPTA6/DycFNB+gHNTjufQ9AC4eLYuvvc+GXI5H7Uh2uLUR6UTOBM525DlK3HqFO
         o+U31ML6C9I8Xs/GsgjgQb7kg8OTk5JLIGdGX2Np7pL0lOBhc12lBBPLTzWqPTvpkaIj
         4s45BoL83D1KZDgQyCLtNb47LVJT6zKvmLe3imKMzX55I3UuwkM26naJnOg1TH7bcnIB
         CQ0w==
X-Gm-Message-State: AOAM531xdEFd9EsZgD24Cgi03jbLQDhETODRjVVhfrMhTwSmbkroKmp0
        DqYkGaM+nqEJKBHTtSL+cw4ongBy1hK3+HKSsJY1OOsOv1JUunxQMs/sipl9sRcB/CFs6sWw/nf
        nPEheEU+C6+lxwv5zuCc253Eq
X-Received: by 2002:a5e:9901:: with SMTP id t1mr11170108ioj.92.1631572000272;
        Mon, 13 Sep 2021 15:26:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxaY42b8/TD2CED+srsnZ5bcWSRI5yQ7JH4AJuJXMpvPucAzb14dlnxvRENYqAr72vuPA0Xmg==
X-Received: by 2002:a5e:9901:: with SMTP id t1mr11170096ioj.92.1631572000076;
        Mon, 13 Sep 2021 15:26:40 -0700 (PDT)
Received: from halaneylaptop.redhat.com (068-184-200-203.res.spectrum.com. [68.184.200.203])
        by smtp.gmail.com with ESMTPSA id d10sm5809457ilu.54.2021.09.13.15.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 15:26:39 -0700 (PDT)
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Jason Baron <jbaron@akamai.com>, Jonathan Corbet <corbet@lwn.net>,
        Jim Cromie <jim.cromie@gmail.com>
Cc:     Andrew Halaney <ahalaney@redhat.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Trivial dynamic debug fixups
Date:   Mon, 13 Sep 2021 17:24:37 -0500
Message-Id: <20210913222440.731329-1-ahalaney@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is round 2 of some trivial dynamic debug fixups. Hopefully I'm
sending the series correctly, first time trying that out.

v1 -> v2:
 * Use different example when showing misleading error message
 * Justify dynamic debug scanning the whole command line
 * Add patch removing ddebug_query
 * Add patch improving cli param examples for dyndbg/$module.dyndbg

v1: https://lore.kernel.org/all/20210909161755.61743-1-ahalaney@redhat.com/

Thanks!

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

