Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE44D31FECE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 19:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbhBSS3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 13:29:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbhBSS3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 13:29:34 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7280BC061574;
        Fri, 19 Feb 2021 10:28:54 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 12CE5372;
        Fri, 19 Feb 2021 18:28:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 12CE5372
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1613759334; bh=n3p+IX/s+VfEyw21LgCGvV7L1okdca73+xJRAZxNUqc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=OzM8h9qyyqsB2Y7SVNULu8jAY5pt4IAJeVmU8/XB/1S1Xu5m0PynXWQZzy8xC4Gaq
         tkBdqQX7Gosss101txq5HFpS1KGuX11hpNNoN2z2B8n7mq7/6HyEOoZ/LXKpn7SdRj
         R52NaS+Zb9VPall4Aqv/zU8wp8VJp/Uvyp08yQPaYsgJoXr8ZewCRUgTRkExMiYURP
         cNccbKA/sEJOBpfHjqyQ64rJ6WjxJyuHvKGpfFZeFwAPI9dRK+Faj2JoyuOFQmEhCj
         iqP577lS8FVzef+ZSaWtVohl82K5c4ZvMAVpW5m+LgJg3+IRBnK/Ie7vEz4uU76oE0
         ODhEH6+/UAIjw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     hjh <huangjianghui@uniontech.com>
Cc:     Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] [PATCH] Documentation/translations: Translate
 sound/hd-audio/controls.rst into Chinese
In-Reply-To: <20210219144856.27362-1-huangjianghui@uniontech.com>
References: <20210219144856.27362-1-huangjianghui@uniontech.com>
Date:   Fri, 19 Feb 2021 11:28:53 -0700
Message-ID: <874ki7oqsa.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hjh <huangjianghui@uniontech.com> writes:

> Signed-off-by: hjh <huangjianghui@uniontech.com>
> ---
>  .../zh_CN/sound/hd-audio/controls.txt         | 117 ++++++++++++++++++
>  1 file changed, 117 insertions(+)
>  create mode 100644 Documentation/translations/zh_CN/sound/hd-audio/controls.txt

Thanks for working to improve the documentation.

When you add a new file, you need to put it into an index.rst file
somewhere so that it gets built with the rest of the kernel docs.

As for *which* index.rst...I kind of wonder how you chose that document,
in particular, to translate?  If we want to start translating the sound
documentation, I think it would be better to start with the top-level
page and build the structure downward.  So can I please ask you to start
in Documentation/translations/zh_CN/sound, with some sort of basic
index.rst file there, then add onto it from there?

Thanks,

jon
