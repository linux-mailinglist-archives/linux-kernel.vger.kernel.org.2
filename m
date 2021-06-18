Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45EE33AD168
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 19:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234349AbhFRRqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 13:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233934AbhFRRp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 13:45:59 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01C9C061574;
        Fri, 18 Jun 2021 10:43:49 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 662839A2;
        Fri, 18 Jun 2021 17:43:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 662839A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1624038229; bh=iKCbVo9gi3ZjjSKKEyz2Zad09JSjXGg0vDIegSBWoYk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=QKdnJYtZ9BuKZmB8io3ANEe2II8JbheRhgphfXaDAbs6/a5r2fTbU1RCOOGjIIcDj
         +yA9FHLZ/0aaE6uBevmFJFfN/0bL8f3CdB7L2Lt12koTltXfOhIYiR0kFPaOpcKArq
         V243qBwS3Ws9AtAzDb19nQ7yFfV8VR9Ay+O3E1U+tAMK1qV01yocn1xhq0DRxcPiKT
         C5fmzkDmDF2Ut5XEz79LxfDfhpQ2We7AHwwQC+gmCE/pwvAWtAmkb72hKneOBFWAFZ
         gb2eOhWQ7+XvZ8sLFVrYm7BtJbcfXtUqAA2/Bgwq+zxO/oI5PZHp2gsi8ULLSvdtwn
         sAtqaZFbc8I9g==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Hu Haowen <src.res@email.cn>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs: add traditional Chinese translation for kernel
 Documentation
In-Reply-To: <20210618014527.59826-1-src.res@email.cn>
References: <20210618014527.59826-1-src.res@email.cn>
Date:   Fri, 18 Jun 2021 11:43:48 -0600
Message-ID: <87o8c3qd9n.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hu Haowen <src.res@email.cn> writes:

> Add traditional Chinese translation (zh_TW) for the Linux Kernel
> documentation with a series of translated files.
>
> Signed-off-by: Hu Haowen <src.res@email.cn>

So this patch still adds a build warning:

  /stuff/k/git/kernel/Documentation/translations/zh_TW/admin-guide/security-bugs.rst:31: WARNING: unknown document: ../process/submitting-patches

Please do not resubmit this until you have built the result and know
that it adds no further problems.  Take your time; I'm about to draw the
line for 5.14, so there is no hurry at this point.

When you do post a new version (of any patch), please include a comment
describing what has changed since the previous posting.

Thanks,

jon
