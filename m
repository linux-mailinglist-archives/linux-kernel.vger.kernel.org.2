Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C804F3D4E11
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jul 2021 16:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbhGYNgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 09:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbhGYNgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 09:36:39 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25878C061757;
        Sun, 25 Jul 2021 07:17:10 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id EA5DC2B0;
        Sun, 25 Jul 2021 14:17:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net EA5DC2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1627222629; bh=vS9GL4cCyVYTFMVmKAM/z8rmv2039bjeF2pRxMYLfWA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=cs3bMLRE+sD6PDWff38D7XP7g0o/EwcoHbiBGye/mF+UzBF5wos/fSqT/gaotSFp0
         OtHQ7iEyy6r+o4GVmA7w7bTemef6KoF5XioWkaAcTpnZHgVts8Lor7eS5g9scc2FSc
         zNXtnKODEpBzDKJBVb+r88BWlQowY4DFH1NHUbMS6N0/cy0B2fVacm0ddsADHa1eiK
         1HLra5+V/YdX7xmOPmuEa8SiVL09dMJGoBAIwRVvsGuQpNETAFcLoOz29qSjhkHMzD
         DqcQ6pCKZj92yn1yWCvwM56QAz3fZOcSWIjjWZkhuV8BbmMGhtzqF/EYXvuOx2SLCi
         SKDtDhdvd2wDA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Hu Haowen <src.res@email.cn>
Cc:     panyunwang849@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] docs: add traditional Chinese translation for
 kernel Documentation
In-Reply-To: <20210725141435.112074-1-src.res@email.cn>
References: <20210721142537.29409-1-src.res@email.cn>
 <20210725141435.112074-1-src.res@email.cn>
Date:   Sun, 25 Jul 2021 08:17:08 -0600
Message-ID: <87eebmwk9n.fsf@meer.lwn.net>
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
> Reviewed-by: Pan Yunwang <panyunwang849@gmail.com>

When you send a new version of a patch set, please include (after the
"---" line) what changed.  Otherwise maintainers have no idea why you
keep sending the patch out or whether it seems to be stabilizing.

Thanks,

jon
