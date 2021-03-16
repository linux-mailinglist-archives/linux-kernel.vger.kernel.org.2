Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3146E33D940
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 17:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238673AbhCPQXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 12:23:50 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:34625 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238622AbhCPQWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 12:22:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1615911772; x=1647447772;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=vPD06H1LkRpZt1zAd9kukHjpwYCUKBGZfoLpMEBFOBs=;
  b=B1cFYV5J0R3xzdbhXqsxma5/VEGqUIBt5aSbzWeMeB2nkx6BrFPYwPMu
   IZEM8A7aFLxESjXlk9ssQVVDIf/ayKmbo6AAi9PSkBgKL4GkZJWcuW5h7
   ZrVbt1S5X0KqSiYBQN2rhZ2AQ9Pig0DpNcImsmbL1f30+Uj5EQdpol4v3
   0=;
X-IronPort-AV: E=Sophos;i="5.81,251,1610409600"; 
   d="scan'208";a="95007291"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-87a10be6.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 16 Mar 2021 16:22:44 +0000
Received: from EX13D31EUA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2c-87a10be6.us-west-2.amazon.com (Postfix) with ESMTPS id 5B538A054F;
        Tue, 16 Mar 2021 16:22:43 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.162.68) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 16 Mar 2021 16:22:39 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
CC:     SeongJae Park <sjpark@amazon.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, <amit@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        SeongJae Park <sjpark@amazon.de>
Subject: Re: [PATCH v2] mm/shmem: Enclose shmem_mcopy_atomic_pte() with 'CONFIG_USERFAULTFD'
Date:   Tue, 16 Mar 2021 17:22:24 +0100
Message-ID: <20210316162224.5533-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAJHvVcgBrpg0pq4b4Lisc4Qsx4W_y=0_piEvO6AJV_Q2+o4ArQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.68]
X-ClientProxiedBy: EX13D27UWB002.ant.amazon.com (10.43.161.167) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Mar 2021 09:16:57 -0700 Axel Rasmussen <axelrasmussen@google.com> wrote:

> Sorry for the build failure! I sent a new version of my patch with
> this same fix on the 10th
> (https://lore.kernel.org/patchwork/patch/1392464/), and I believe
> Andrew has already included it in his tree.

No problem at all, thank you for letting me know! :)

FYI, I tested on 'master' of https://github.com/hnaz/linux-mm.


Thanks,
SeongJae Park

[...]



Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



