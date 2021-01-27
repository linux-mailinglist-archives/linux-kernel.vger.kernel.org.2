Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE7DE305537
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 09:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234466AbhA0IE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 03:04:57 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:50741 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232847AbhA0ICj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 03:02:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1611734559; x=1643270559;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=FBaAWu00P+NtW9A01D/cjsmdlfjqq/fVoqdfUx7oSjE=;
  b=AVwV2xFPRyGCVMbOsv6ZLy5nmn5Dlpts/8ztuZvaKtkamlaEAM2HaLWQ
   /DXXb88ZPogEm3ju4VaO820oBFqn7oU+Jo+Tu0nC7+MppKwqbLC7a5Ulp
   OVTXo6xIU2T9exWjqHvGyvcjv5wuZU3SX8qo6H0v7tcBHSMwNuWPsFEJ1
   c=;
X-IronPort-AV: E=Sophos;i="5.79,378,1602547200"; 
   d="scan'208";a="106718576"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 27 Jan 2021 07:55:25 +0000
Received: from EX13D31EUA001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com (Postfix) with ESMTPS id F360CA264E;
        Wed, 27 Jan 2021 07:55:22 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.162.125) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 27 Jan 2021 07:55:18 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <zuoqilin1@163.com>
CC:     <akpm@linux-foundation.org>, <colin.king@canonical.com>,
        <ebiggers@google.com>, <sjpark@amazon.de>, <xndchn@gmail.com>,
        <linux-kernel@vger.kernel.org>, zuoqilin <zuoqilin@yulong.com>
Subject: Re: [PATCH] scripts/spelling.txt: increase error-prone spell checking
Date:   Wed, 27 Jan 2021 08:55:03 +0100
Message-ID: <20210127075503.27984-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210127060049.915-1-zuoqilin1@163.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.125]
X-ClientProxiedBy: EX13D36UWA002.ant.amazon.com (10.43.160.24) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jan 2021 14:00:49 +0800 zuoqilin1@163.com wrote:

> From: zuoqilin <zuoqilin@yulong.com>
> 
> Increase exeeds spelling error check.

Why don't you consolidate this with your previous patch[1]?

Also, I think you could improve the title and the commit message.  You could
refer to
https://lore.kernel.org/lkml/7937a406-812e-0a41-12c5-41576737a44f@lucaceresoli.net/

[1] https://lore.kernel.org/lkml/20210127030105.7244-1-dingsenjie@163.com/

> 
> Signed-off-by: zuoqilin <zuoqilin@yulong.com>
> ---
>  scripts/spelling.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/scripts/spelling.txt b/scripts/spelling.txt
> index 953f4a2..740aba3 100644
> --- a/scripts/spelling.txt
> +++ b/scripts/spelling.txt
> @@ -566,6 +566,7 @@ estbalishment||establishment
>  etsablishment||establishment
>  etsbalishment||establishment
>  evalution||evaluation
> +exeeds||exceeds
>  excecutable||executable
>  exceded||exceeded
>  exceds||exceeds

Similar misspellings should be grouped together, so this would be better to be
placed under exceds.

Thanks,
SeongJae Park
