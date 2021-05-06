Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D986375169
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 11:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbhEFJVe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 6 May 2021 05:21:34 -0400
Received: from mga05.intel.com ([192.55.52.43]:42090 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231206AbhEFJVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 05:21:33 -0400
IronPort-SDR: n6LGtBF6uQyDAmqD/KtlhgyNvQVM/AJX6RE/AwBEbq8lFQ4pP8RXHHMW5BmDjC/4Bw5mAryeqS
 VEvc1weNdRPA==
X-IronPort-AV: E=McAfee;i="6200,9189,9975"; a="283865155"
X-IronPort-AV: E=Sophos;i="5.82,277,1613462400"; 
   d="scan'208";a="283865155"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2021 02:20:32 -0700
IronPort-SDR: Fnl/OdPMVwymfaYw/LUJyLygpAIKce28nGygN9MUOwtYn9C4h7FbuQuRnMEATvH2iVbjRpzV3X
 UYhKeonWFV5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,277,1613462400"; 
   d="scan'208";a="464668133"
Received: from um.fi.intel.com (HELO um) ([10.237.72.62])
  by fmsmga002.fm.intel.com with ESMTP; 06 May 2021 02:20:31 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        alexander.shishkin@linux.intel.com
Subject: Re: [PATCH] intel_th: Remove an unused exit point from
 intel_th_remove()
In-Reply-To: <20210505203748.200499-1-u.kleine-koenig@pengutronix.de>
References: <20210505203748.200499-1-u.kleine-koenig@pengutronix.de>
Date:   Thu, 06 May 2021 12:20:30 +0300
Message-ID: <87zgx8jk0x.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Uwe Kleine-König <u.kleine-koenig@pengutronix.de> writes:

> As described in the added comment device_for_each_child never returns
> a non-zero value. So remove the corresponding error check.
>
> This simplifies the quest to make struct bus_type::remove() return void.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Picked up, thanks! Out of curiosity: does the mentioned quest have a
message-id or a git branch?

Thanks,
--
Alex
