Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62EA241D9CD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 14:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350828AbhI3Mbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 08:31:34 -0400
Received: from mga09.intel.com ([134.134.136.24]:60998 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350264AbhI3Mbd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 08:31:33 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10122"; a="225214996"
X-IronPort-AV: E=Sophos;i="5.85,336,1624345200"; 
   d="scan'208";a="225214996"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2021 05:29:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,336,1624345200"; 
   d="scan'208";a="520360373"
Received: from dingu.tm.intel.com (HELO dingu2.tm.intel.com) ([10.237.54.29])
  by fmsmga008.fm.intel.com with ESMTP; 30 Sep 2021 05:29:48 -0700
From:   Antti Kervinen <antti.kervinen@intel.com>
To:     gregkh@linuxfoundation.org
Cc:     Jonathan.Cameron@huawei.com, akpm@linux-foundation.org,
        andriy.shevchenko@linux.intel.com, antti.kervinen@intel.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        song.bao.hua@hisilicon.com, tiantao6@hisilicon.com,
        tklauser@distanz.ch, yury.norov@gmail.com
Subject: Re: [PATCH] cpumask: Omit terminating null byte in cpumap_print_{list,bitmask}_to_buf
Date:   Thu, 30 Sep 2021 15:29:47 +0300
Message-Id: <20210930122947.2730542-1-antti.kervinen@intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <YVWU3f5elbnRctae@kroah.com>
References: <YVWU3f5elbnRctae@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Why not test the patch there (and in linux-next) and let us know if
> it resolves the issue you see or not.

Yes, I conform that the patch fixes this issue in my userspace. Too
bad that I was obviously late with my code review notes.

Thanks!

Antti
