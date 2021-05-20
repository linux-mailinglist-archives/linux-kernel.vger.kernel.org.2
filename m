Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4F438B816
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 22:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237770AbhETUIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 16:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237436AbhETUIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 16:08:32 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731A5C061574;
        Thu, 20 May 2021 13:07:10 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 27128301;
        Thu, 20 May 2021 20:07:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 27128301
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1621541230; bh=CNxnOCJVOJKAJIvZB7szAnJIgPV0VeU9F7svfsG8P3I=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=nCLQOmE5Xx9lLM9ejGMysPE6efYmduP6+8wUZktVfTkQI3EijzKIiOxmhHTXxmF9v
         8Uhn0aHC2IRzN4S7c2M8TDt+HB+arlVIoZ/5GnyYVKXhuv92MOoi7UKxeEjOHfDQsD
         PC8vGNQqNaFLeiioVhR+T2tN9pZiOiSISFedhBV14h3eJYmDLM7Ch8PGP/qU1p51YF
         mEBziD4bbv2BX3v5c8w83vqPAQ+u34mMrJsK9vTLagtcjChJjW5aOtp9EZB3N5huYm
         KLX2DmKdoYfk5XKyuiWcuEyiEQ5HN/JB843/d8cqL4+vM/kJ5r1fL4r2SUDOph/qkz
         O/7C93JlWA67w==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Wei Ming Chen <jj251510319013@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, federico.vaga@vaga.pv.it,
        alexs@kernel.org, Wei Ming Chen <jj251510319013@gmail.com>
Subject: Re: [PATCH] docs: Use fallthrough pseudo-keyword
In-Reply-To: <20210515155142.2490-1-jj251510319013@gmail.com>
References: <20210515155142.2490-1-jj251510319013@gmail.com>
Date:   Thu, 20 May 2021 14:07:09 -0600
Message-ID: <87o8d5np8y.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wei Ming Chen <jj251510319013@gmail.com> writes:

> Replace /* fall through */ comment with fallthrough, make
> it align with original process/coding-style.rst
>
> Signed-off-by: Wei Ming Chen <jj251510319013@gmail.com>
> ---
>  Documentation/translations/it_IT/process/coding-style.rst | 2 +-
>  Documentation/translations/zh_CN/process/coding-style.rst | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

jon
