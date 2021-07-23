Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 402BB3D3114
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 02:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbhGWATQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 20:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232730AbhGWATP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 20:19:15 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A2DC061575
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 17:59:49 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id gv20-20020a17090b11d4b0290173b9578f1cso4915906pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 17:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2W4Y1AVSnOCr4H+Q6K/fkpHGhoCWhH4qklf0PRTZ8pU=;
        b=hP/Di7u70ZLV+s3kxQ6DhZDHqgJh19473Kf+TrodMGeLXR3iYdp8BWR6cICt6hQjds
         Bwf6tAiAi4AwH01jwrf7gcWw8+rDOhmrl/c8La76bpFB/n4ypahfaJ3NgIIrN4CyqsPy
         g0L/B0B28L2Qqev0gj3ruS0OKD5EO1TPiUWMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2W4Y1AVSnOCr4H+Q6K/fkpHGhoCWhH4qklf0PRTZ8pU=;
        b=W1KwI/OtNzf4/trksF5SkNgo05Yv52CJtv/TscZLiP6t+sxOdi7PAR9SXw5AZdOwm3
         Oh6SNEbI3zWmKX91SVR5Ha8EHKrVYlkPNT3rbeGd8hcdzjLBn009K71zgcvHmQpH/HEG
         2cRfH1TdYMcuX8gSnM4X8w7zD8YOXiJlyID6IIT+CkJIHVzbwzJm1E1EgCN37tlPkBh2
         dOc5FHjQGE+ebv7dQ2tBBuZCNyYrDfipNHUQKNews7gz4gOSaMjzynZX/tibzo0YtNRV
         gUKH19QJmzzeiC2ey+c0TueWNGaRwkGCAytUbQSClmZJRCoJbYlAGXUKs3bv5tvLzD/m
         RZfg==
X-Gm-Message-State: AOAM531M0sN/GuUb6H7vMp2lfygl4doDON1c9xISinBcn+V3Te/dADCl
        01axt8rAKRsfOJBK1OJ1tcZJjw==
X-Google-Smtp-Source: ABdhPJzEUCL87iEthcZhgUyN6/zHZjFYduESEb2wsJNm3zPFdCcV7COXSgtvmoJj1WxrUIQEr/KXjw==
X-Received: by 2002:a17:902:a710:b029:12b:9b9f:c461 with SMTP id w16-20020a170902a710b029012b9b9fc461mr1853546plq.59.1627001988721;
        Thu, 22 Jul 2021 17:59:48 -0700 (PDT)
Received: from dlunevwfh.roam.corp.google.com (n122-107-208-179.sbr1.nsw.optusnet.com.au. [122.107.208.179])
        by smtp.gmail.com with ESMTPSA id b2sm35185425pgh.9.2021.07.22.17.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 17:59:48 -0700 (PDT)
From:   Daniil Lunev <dlunev@chromium.org>
To:     kbusch@kernel.org
Cc:     Mario.limonciello@amd.com, axboe@fb.com, campello@google.com,
        hch@lst.de, hughsient@gmail.com, jorgelo@chromium.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        sagi@grimberg.me
Subject: [RFC 0/2] Split out firmware upgrade from CAP_SYS_ADMIN
Date:   Fri, 23 Jul 2021 10:59:41 +1000
Message-Id: <20210723005941.111198-1-dlunev@chromium.org>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210218170947.15727-1-mario.limonciello@dell.com>
References: <20210218170947.15727-1-mario.limonciello@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signal boost on this thread for we are interested in a mechanism like that to
avoid running firmware updater with root privileges. We are looking into using
the mechanism to be able to update NVMe and SATA devices from a user with
limited permissions, and to tighten the security for eMMC device, which
currently require only RAW_IO capability to perform a firmware upgrade.
