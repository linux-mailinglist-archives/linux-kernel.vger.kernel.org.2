Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D529E354336
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 17:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241453AbhDEPOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 11:14:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:44512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237769AbhDEPOH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 11:14:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C681A613B1;
        Mon,  5 Apr 2021 15:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617635641;
        bh=Ih0Qe9Pw8gSPYjAQO3XkaRxgLzp5k35Ll7cQMaUbUdE=;
        h=From:To:Cc:Subject:Date:From;
        b=WMRAdAy5g5ahZMYLsLN/xZ0Y/Ycm8viWE0DCXDAqByInIN+sYsjFaWdMWkpGxW14e
         mlA0gZpDeHHme8/0zoBU9X6qFPgXyOgFPRk6MAdSXLiQD7R6OZDfQ7CWF8UFLwvVt6
         7FFHjiFSCz/bJOJ3zG8wiy+feqIensoNEP+VS8h2n31n5V8s/ygSHpsQj7Ur5JHYdI
         bmT6sQInv3wLDAyr2+69Vz4gB8F0C9CvbtGBO4jJT4rkPKPc9mn9UALlogklPfbHKi
         I26dZfNdGWiItdszDTukvPUuvl1ciU2kORTlak3EY9qefILTpM8Fyq1TQY9RXYkKEC
         7OYKGxu+UUYvw==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] minor cleanups of include/linux/mm.h
Date:   Mon,  5 Apr 2021 18:13:53 +0300
Message-Id: <20210405151355.9867-1-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Hi,

While looking at recent page_mapping_file() changes I've noticed that
page_rmapping() and page_anon_vma() could be moved from include/linux/mm.h
and we don't need two forward declarations of page_mapping().

I've also noticed that except page_mapping_file() we have somewhat similar
page_file_mapping(), which seems superfluous, but I didn't dig further to
see how one of them can be dropped. 

The patches are vs v5.12-rc5-mmots-2021-03-31-22-26.

Mike Rapoport (2):
  mm: move page_rmapping() and page_anon_vma() to mm/internal.h
  include/linux/mm.h: remove duplicated declaration of page_mapping()

 include/linux/mm.h | 4 ----
 mm/internal.h      | 3 +++
 2 files changed, 3 insertions(+), 4 deletions(-)

-- 
2.28.0

