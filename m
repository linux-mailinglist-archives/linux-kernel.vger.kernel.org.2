Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD1B421A7D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 01:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235023AbhJDXQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 19:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbhJDXQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 19:16:49 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5930FC061745;
        Mon,  4 Oct 2021 16:15:00 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 0743D378;
        Mon,  4 Oct 2021 23:14:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0743D378
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1633389300; bh=NKf6tKkCeZfYWSdLW5H+s4j362cQN1B2SvKGsWJV1BA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=FvTeECJKE3ezCQCf3xjo2KRDVo/NJjgu8syTbhCBLdpOcOoJOUraAoZvKiZytYI1F
         dGitVgArUusqsTPTkfsGIJDyrTmFh/HoNc3vfBJvYaU1HFk7V25g3ht4GagwqCwV0R
         d4VJF0f3LzuFu9CZvqWj1ETGt1THzNxNTr30NZ5D2MG/CnOzEfjgFertg101PDoIby
         bP8amB9ljgaYcfZ88rv3SYjpI0McciBnzxSKx7vtUQfIc1io5mEfIvvWB/m9f029UW
         R19ZtOzSlvyW3TluQMw/01VMxyO8lkRY1cJvE1q2tCRpQNcqZIfyOp7ALwNqyA3AeA
         Zxu8tjVXXpw9Q==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Akira Yokosawa <akiyks@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915/guc, docs: Fix pdfdocs build error by removing
 nested grid
In-Reply-To: <3ec7d7c5-301f-ad34-fd40-844e81e1cdb9@gmail.com>
References: <4a227569-074f-c501-58bb-d0d8f60a8ae9@gmail.com>
 <87czozba5c.fsf@intel.com>
 <3ec7d7c5-301f-ad34-fd40-844e81e1cdb9@gmail.com>
Date:   Mon, 04 Oct 2021 17:14:59 -0600
Message-ID: <87fstg7570.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Akira Yokosawa <akiyks@gmail.com> writes:

> Jon, as this has reached upstream, can you back-merge v5.15-rc4
> into docs-next so that "make pdfdocs" can complete?

OK, I've just done that.

Thanks,

jon
