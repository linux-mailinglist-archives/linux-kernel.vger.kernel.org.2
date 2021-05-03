Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF2D7372359
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 01:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbhECXBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 19:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhECXBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 19:01:37 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0C7C061574
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 16:00:44 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d:444a:d152:279d:1dbb])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id AD9F42ED;
        Mon,  3 May 2021 23:00:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net AD9F42ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1620082843; bh=7QzaaOkwmh13wZdRAr98OAUey3znS9WX2rvQecaBhSY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=BzwwcY3wf8Xkv5MO3VoR+L0XGx6jkM+qebHSYS6LFnjB2xp0wOnxUbqBB4nul8s66
         QIETfWvBxzXdLrbhuRFx2IR2H2j7/y+X9Rc5rFuziEXasRJN7hpzM6Cd1pI0v39kFY
         nwIq+NP1oP6jFW9svbwIKZjAwnWtydVTGBP23BlF1PY276bzzp/tgH5hWG8acYymkT
         aCs95NPEU3GzEoWtyuBCM9iZ+IxNta8ToFbz4eT9ktaMoY4FOcwyYSordMXNI8oxJN
         LSYMBkyHmxW+I+Y4J2DZRnaCcpkmYxrK8kHQ459WuwQ/F3Gcfr3UwNJIH1haJsB+R4
         gDrIb0MHulupw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, nathan@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: Re: [PATCH 0/3] Removed oprofile stale entries
In-Reply-To: <cover.1619181632.git.unixbhaskar@gmail.com>
References: <cover.1619181632.git.unixbhaskar@gmail.com>
Date:   Mon, 03 May 2021 17:00:43 -0600
Message-ID: <871ranh17o.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bhaskar Chowdhury <unixbhaskar@gmail.com> writes:

> This patch series trying to clean out remaing debris of removed
> functionality.Kindly see the commit : 24880bef417f(oprofile-removal)
>
> Bhaskar Chowdhury (3):
>   Removed the oprofiled version option
>   oprofiled version output line removed from the list
>   Enlisted oprofile version line removed
>
>  Documentation/process/changes.rst                    | 1 -
>  Documentation/translations/it_IT/process/changes.rst | 1 -
>  scripts/ver_linux                                    | 1 -
>  3 files changed, 3 deletions(-)

I've applied the set, thanks.

jon
