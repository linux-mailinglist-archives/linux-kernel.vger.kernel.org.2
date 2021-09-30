Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4E7641D7BD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 12:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349945AbhI3Kb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 06:31:58 -0400
Received: from mga12.intel.com ([192.55.52.136]:24620 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349927AbhI3Kb4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 06:31:56 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10122"; a="204639562"
X-IronPort-AV: E=Sophos;i="5.85,336,1624345200"; 
   d="scan'208";a="204639562"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2021 03:30:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,336,1624345200"; 
   d="scan'208";a="438807328"
Received: from dingu.tm.intel.com (HELO dingu2.tm.intel.com) ([10.237.54.29])
  by orsmga003.jf.intel.com with ESMTP; 30 Sep 2021 03:30:11 -0700
From:   Antti Kervinen <antti.kervinen@intel.com>
To:     tklauser@distanz.ch
Cc:     Jonathan.Cameron@huawei.com, akpm@linux-foundation.org,
        andriy.shevchenko@linux.intel.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        song.bao.hua@hisilicon.com, tiantao6@hisilicon.com,
        yury.norov@gmail.com
Subject: Re: [PATCH] cpumask: Omit terminating null byte in cpumap_print_{list,bitmask}_to_buf
Date:   Thu, 30 Sep 2021 13:30:10 +0300
Message-Id: <20210930103010.2716097-1-antti.kervinen@intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210916222705.13554-1-tklauser@distanz.ch>
References: <20210916222705.13554-1-tklauser@distanz.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


An original function, bitmap_print_to_pagebuf() in lib/bitmap.c,
returns the number of printed characters, excluding terminating null.

Commit 1fae5629, a cause of this regression, introduced new functions
to lib/bitmap.c:

- bitmap_print_to_buf()
  (return value doc missing)

- bitmap_print_bitmask_to_buf()
  (return value doc not explicit about terminating null, but
  can be considered misleading)

- bitmap_print_list_to_buf()
  (the same as above)

Unlike the original function, the return value of new functions
include the terminating null.

As this behavior is clearly opposite to the original function, and
functions that print to buffers in general, I would suggest fixing
this problem by alignign these new functions with the original one:
excluding the terminating null. And documenting this behavior
unambiguously.

The suggested change to cpumask_print_{bitmask,list}_to_buf()
functions decrements possible errors (like -ENOMEM) returned by
bitmap_print_to_buf(). This must not happen.
