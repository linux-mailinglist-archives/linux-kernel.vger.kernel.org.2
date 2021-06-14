Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E563B3A6DE5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 20:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234895AbhFNSCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 14:02:25 -0400
Received: from mail-pj1-f47.google.com ([209.85.216.47]:55031 "EHLO
        mail-pj1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234458AbhFNSCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 14:02:20 -0400
Received: by mail-pj1-f47.google.com with SMTP id g24so10170408pji.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 11:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z/mqJ66EtHUK4IIeoN0FRfV100MhEBbh41UIGDSjmrc=;
        b=XBTMQDn494HW9Y3WQhbPxl5tK19gRjmkrgxg0gifqNoBp0tt+uEPE+ZEBKuE+YTrGF
         qFqZHBTYab0SWIx4jBKGBIugtF2uHniZ6If4vRYnLbEMALbRo8WyOH9Q74yq6R6nc436
         ++nVmdfBMokHeRQA1fPZRSHz6GtulKawqZYQ947Rx6IJo6QMUqIY5nW/yv9smUaUiI6j
         xn3YKpY2jvlJsrCB5iVRGd05J8GXsR8/BbdzHeqkiPnosQtjrIBvYvTNh1Wil02DdGUB
         Lf+L+X1dPP2D3IbyRQ/EBm8lxkspO9BjWPs+jx7kA/7hP8p8qEa7rDToxI17WBphzr9N
         hbLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z/mqJ66EtHUK4IIeoN0FRfV100MhEBbh41UIGDSjmrc=;
        b=W53//+GN0/IONjH4m+swhnGBZc2ELqg8u+diDP7pr48kvyN5v5d5NUL0FAFgwi/E06
         OVA1NEUzMLzijQ5/xFSMEwV7+qWkO315C4dkeesY8vaaniv64F+w1HMMw74hzrMZer87
         TPLssPEQcNZe+BTU34hdKk8Xi1RH8U/m57dWW8XsXVLHZFdB4GEdqc8ahhpnpljOxCsM
         Wr4Tydkq4XNSFnXPq13snU3V6DNIqSzFGlLYiifAEYG/jIrM1qYTHpgyeUpm9cWzxB7b
         75iyW0G1A1m0cOnopquJnDvLWygqAAw+DXyrzrDDcwVOPctJdZGubVPTk7ypUqNLWPLw
         t4Lw==
X-Gm-Message-State: AOAM531P5fyh80zfPqd7N6CQjWbxTIyhTus3uL/8UkkuiedssK9t+/66
        hmJIaPwKZg2P5Ptm55b98HS2Rw==
X-Google-Smtp-Source: ABdhPJz0wGH6nX6E6pGjZTqv+eSVTRLW7PeCv3qv4xu99QRbneSoXfdHUXIuckLC9LSu6RNS87mZig==
X-Received: by 2002:a17:90a:bd18:: with SMTP id y24mr334726pjr.83.1623693542814;
        Mon, 14 Jun 2021 10:59:02 -0700 (PDT)
Received: from p14s.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id z17sm13553246pfq.218.2021.06.14.10.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 10:59:01 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] coresight: Patches for v5.14
Date:   Mon, 14 Jun 2021 11:58:55 -0600
Message-Id: <20210614175901.532683-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good day Greg,

A small tally this time around - there might be a part 2 but that is not
clear at the moment.  Applies cleanly on today's char-misc-next
(db4e54aefdfe).

Regards,
Mathieu


Andy Shevchenko (1):
  coresight: core: Switch to krealloc_array()

Jeremy Linton (1):
  coresight: Propagate symlink failure

Junhao He (3):
  coresight: core: Fix use of uninitialized pointer
  coresight: core: Remove unnecessary assignment
  coresight: etm4x: core: Remove redundant check of attr

Sai Prakash Ranjan (1):
  coresight: tmc-etf: Fix global-out-of-bounds in
    tmc_update_etf_buffer()

 drivers/hwtracing/coresight/coresight-core.c       | 11 +++++------
 drivers/hwtracing/coresight/coresight-etm4x-core.c |  5 -----
 drivers/hwtracing/coresight/coresight-tmc-etf.c    |  2 +-
 3 files changed, 6 insertions(+), 12 deletions(-)

-- 
2.25.1

