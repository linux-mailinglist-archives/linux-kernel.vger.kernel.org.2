Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E51EA4149B0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 14:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236130AbhIVMxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 08:53:23 -0400
Received: from foss.arm.com ([217.140.110.172]:48546 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236064AbhIVMxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 08:53:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B38B11B3;
        Wed, 22 Sep 2021 05:51:50 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.50.100])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 16FCD3F40C;
        Wed, 22 Sep 2021 05:51:48 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org
Cc:     James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] Don't immediately close events that are run on invalid CPU/sink combos
Date:   Wed, 22 Sep 2021 13:51:43 +0100
Message-Id: <20210922125144.133872-1-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v1:
 * Replace goto with return after failure to maintain original failure behaviour
 * Add Mathieu and Suzuki's reviewed-by tags
 * Repeated testing

James Clark (1):
  coresight: Don't immediately close events that are run on invalid
    CPU/sink combos

 .../hwtracing/coresight/coresight-etm-perf.c  | 29 +++++++++++++++----
 1 file changed, 23 insertions(+), 6 deletions(-)

-- 
2.28.0

