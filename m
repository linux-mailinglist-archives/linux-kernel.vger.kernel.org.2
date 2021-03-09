Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F597331B37
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 01:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbhCIAAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 19:00:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbhCIAAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 19:00:14 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845AAC06174A;
        Mon,  8 Mar 2021 16:00:10 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 30F7C2B0;
        Tue,  9 Mar 2021 00:00:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 30F7C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1615248010; bh=SXirsMeQDAzZotqS7usdjFpJl2ClFAO2pWfJoF3RtTs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=G42tO9HnqlBS0QqWrhc0fmMVQneT+hn3jXS2NLoF+zphPFqZUTJFLBsCZPCLB6ok7
         WCE1zZxICW375koFYpVm0PWa6fiB0g+6ImG70qI+Yuk2atxc8IgujYbUrnBKRn5lMR
         XF1zhg9VvfTqD/6kv5ICMSJ7pPq4OlDix53Icf4saKeNYZ2X7LC1G4mioStmAG5vrB
         7WvU/4VdBbXYHTIBIYcELI3ef27IREvS4QGeObj3llc80etbxYYtZ5y8i+1yoHhZ+0
         bvCvDJj9oRmIQG+R+xTcOMavNSDbJUgY8M5slTng9ntPuNKvDF6YaMNn1AWcGg9Ty0
         2XcfpeggtLCDQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     hjh <huangjianghui@uniontech.com>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Harry Wei <harryxiyou@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PATCH Documentation translations:translate
 sound/hd-audio/controls to chinese
In-Reply-To: <20210304094556.5858-1-huangjianghui@uniontech.com>
References: <20210304094556.5858-1-huangjianghui@uniontech.com>
Date:   Mon, 08 Mar 2021 17:00:09 -0700
Message-ID: <87tupl5h86.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hjh <huangjianghui@uniontech.com> writes:

> Signed-off-by: hjh <huangjianghui@uniontech.com>
> ---
>  Documentation/translations/zh_CN/index.rst    |   1 +
>  .../zh_CN/sound/hd-audio/controls.rst         | 102 ++++++++++++++++++
>  .../zh_CN/sound/hd-audio/index.rst            |  14 +++
>  .../translations/zh_CN/sound/index.rst        |  22 ++++
>  4 files changed, 139 insertions(+)
>  create mode 100644 Documentation/translations/zh_CN/sound/hd-audio/controls.rst
>  create mode 100644 Documentation/translations/zh_CN/sound/hd-audio/index.rst
>  create mode 100644 Documentation/translations/zh_CN/sound/index.rst

Applied, thanks.

jon
