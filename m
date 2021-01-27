Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2112730550A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 08:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbhA0HwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 02:52:21 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:50115 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234329AbhA0Hs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 02:48:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1611733707; x=1643269707;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=DVq3lTZS/z36XTlMLn0tse7sHtfW43ky943dGwMj45w=;
  b=C55x9xaVeWamPQAjZXcAjT9zOZmNq8mBkQozvIqrObDb6HJCwTWipBpU
   MS7g1rZx9ohgtUEkg6vvMHH2qCI7LYir5M9O0WPbcuYDoCd/H0uMVdRyb
   KRbDeMOED7oX9zY2ff+RAq8GcfinNz6ka8897o0n7ImuHpAJCJji+gjPS
   g=;
X-IronPort-AV: E=Sophos;i="5.79,378,1602547200"; 
   d="scan'208";a="81858135"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1e-c7c08562.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 27 Jan 2021 07:47:39 +0000
Received: from EX13D31EUA001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1e-c7c08562.us-east-1.amazon.com (Postfix) with ESMTPS id 40E11240A86;
        Wed, 27 Jan 2021 07:47:36 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.162.125) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 27 Jan 2021 07:47:30 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <dingsenjie@163.com>
CC:     <akpm@linux-foundation.org>, <colin.king@canonical.com>,
        <naoki.hayama@lineo.co.jp>, <xndchn@gmail.com>, <sjpark@amazon.de>,
        <ebiggers@google.com>, <joe@perches.com>,
        <linux-kernel@vger.kernel.org>, dingsenjie <dingsenjie@yulong.com>
Subject: Re: [PATCH] scripts/spelling.txt: increase error-prone spell checking
Date:   Wed, 27 Jan 2021 08:47:16 +0100
Message-ID: <20210127074716.25987-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210127030105.7244-1-dingsenjie@163.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.125]
X-ClientProxiedBy: EX13D27UWA003.ant.amazon.com (10.43.160.56) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jan 2021 11:01:05 +0800 dingsenjie@163.com wrote:

> From: dingsenjie <dingsenjie@yulong.com>
> 
> Increase allocted spelling error check.

I think you could improve the title and the commit message.  You could
refer to
https://lore.kernel.org/lkml/7937a406-812e-0a41-12c5-41576737a44f@lucaceresoli.net/

Thanks,
SeongJae Park

> 
> Signed-off-by: dingsenjie <dingsenjie@yulong.com>
> ---
>  scripts/spelling.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/scripts/spelling.txt b/scripts/spelling.txt
> index 953f4a2..5fa8ec2 100644
> --- a/scripts/spelling.txt
> +++ b/scripts/spelling.txt
> @@ -103,6 +103,7 @@ alloated||allocated
>  allocatote||allocate
>  allocatrd||allocated
>  allocte||allocate
> +allocted||allocated
>  allpication||application
>  alocate||allocate
>  alogirhtms||algorithms
> -- 
> 1.9.1
> 
