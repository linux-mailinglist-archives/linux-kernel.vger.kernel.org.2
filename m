Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4634F410158
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 00:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344812AbhIQWga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 18:36:30 -0400
Received: from mga04.intel.com ([192.55.52.120]:55758 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344810AbhIQWg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 18:36:28 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10110"; a="221007164"
X-IronPort-AV: E=Sophos;i="5.85,302,1624345200"; 
   d="scan'208";a="221007164"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2021 15:35:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,302,1624345200"; 
   d="scan'208";a="510114275"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.28.105])
  by fmsmga008.fm.intel.com with ESMTP; 17 Sep 2021 15:35:05 -0700
Subject: [PATCH 0/2] mm/migrate: 5.15 fixes for automatic demotion
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, ying.huang@intel.com,
        mhocko@suse.com, weixugc@google.com, osalvador@suse.de,
        rientjes@google.com, dan.j.williams@intel.com, david@redhat.com,
        gthelen@google.com, yang.shi@linux.alibaba.com,
        akpm@linux-foundation.org
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Fri, 17 Sep 2021 15:35:04 -0700
Message-Id: <20210917223504.C140445A@davehans-spike.ostc.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This contains two fixes for the "automatic demotion" code which was
merged into 5.15:

 * Fix memory hotplug performance regresssion by watching
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
