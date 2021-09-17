Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D586A40F81A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 14:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244661AbhIQMmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 08:42:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:35484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244509AbhIQMmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 08:42:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 43BDF61244;
        Fri, 17 Sep 2021 12:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631882442;
        bh=7I3VN2TJr2FWD8F9+tCl5FdS9G4uwRCLDG9GEssTxlk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K2tPbJpUEemc4NZxEDcav+iPOgDR39LxtI+S5VMmeBLxMqWfoYuBgY6rvi+5Ryz2K
         FYWjgJlH7Pwax8qJwe7wJx+hSr/VM6T/vQTfdvRLRF0ebsauvsH4veTEOdPuZ6tLJX
         vKCnlPDc+bf9yrGhv5p6+UvjVRelrdTPVyc4W8jQwQ1cMB47ktmtwuPJjgjzSs7vL+
         Jz+sES+t5K9EaduUu+fYHsm9wN2hi8oZ4Xxkonwk7vvghPKD4aOGRgfHCFhbGw4/yo
         WMoGGYo6aGXBYumqnb02wFPOTYLyB0Gw+6w2w9azARB6JTyg833/moXWwvfQf4tcuv
         nx6ZB230B5JYQ==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     corbet@lwn.net, sj@kernel.org, linux-damon@amazon.com,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sjpark@amazon.de>
Subject: [PATCH 3/5] docs/vm/damon: Remove broken reference
Date:   Fri, 17 Sep 2021 12:39:56 +0000
Message-Id: <20210917123958.3819-4-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210917123958.3819-1-sj@kernel.org>
References: <20210917123958.3819-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Building DAMON documents warns for a reference to nonexisting doc, as
below:

    $ time make htmldocs
    [...]
    Documentation/vm/damon/index.rst:24: WARNING: toctree contains reference to nonexisting document 'vm/damon/plans'

This commit fixes the warning by removing the wrong reference.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 Documentation/vm/damon/index.rst | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/vm/damon/index.rst b/Documentation/vm/damon/index.rst
index a2858baf3bf1..48c0bbff98b2 100644
--- a/Documentation/vm/damon/index.rst
+++ b/Documentation/vm/damon/index.rst
@@ -27,4 +27,3 @@ workloads and systems.
    faq
    design
    api
-   plans
-- 
2.17.1

