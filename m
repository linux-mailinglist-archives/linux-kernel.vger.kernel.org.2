Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3717417842
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 18:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347343AbhIXQO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 12:14:29 -0400
Received: from mga11.intel.com ([192.55.52.93]:43617 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347225AbhIXQOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 12:14:25 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10116"; a="220906285"
X-IronPort-AV: E=Sophos;i="5.85,320,1624345200"; 
   d="scan'208";a="220906285"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2021 09:12:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,320,1624345200"; 
   d="scan'208";a="551865357"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.28.105])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Sep 2021 09:12:51 -0700
Subject: [PATCH 0/2] [v2] mm/migrate: 5.15 fixes for automatic demotion
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Dave Hansen <dave.hansen@linux.intel.com>,
        ying.huang@intel.com, mhocko@suse.com, weixugc@google.com,
        osalvador@suse.de, rientjes@google.com, dan.j.williams@intel.com,
        david@redhat.com, gthelen@google.com, yang.shi@linux.alibaba.com,
        akpm@linux-foundation.org
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Fri, 24 Sep 2021 09:12:51 -0700
Message-Id: <20210924161251.093CCD06@davehans-spike.ostc.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes from v1:
 * Use memory_notify->status_change_nid to detect node online/offline
   events instead of building a new mechanism.

--

This contains two fixes for the "automatic demotion" code which was
merged into 5.15:

 * Fix memory hotplug performance regression by watching
   suppressing any real action on irrelevant hotplug events.
 * Ensure CPU hotplug handler is registered when memory hotplug
   is disabled.

Cc: "Huang, Ying" <ying.huang@intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Wei Xu <weixugc@google.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: David Rientjes <rientjes@google.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Greg Thelen <gthelen@google.com>
Cc: Yang Shi <yang.shi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
