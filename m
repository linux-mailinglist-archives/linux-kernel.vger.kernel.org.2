Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05F12372354
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 00:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbhECW7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 18:59:16 -0400
Received: from ms.lwn.net ([45.79.88.28]:43168 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229680AbhECW7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 18:59:15 -0400
Received: from localhost (unknown [IPv6:2601:281:8300:104d:444a:d152:279d:1dbb])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id BE1A72ED;
        Mon,  3 May 2021 22:58:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net BE1A72ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1620082701; bh=/wxRzKKm9ILisw0zqzRx2o+KzRBSeU3HsFY9OdFVbZQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=AXgzGPJu34DrVSXQIh5XWU8SX2PKRRewKVqhrJNZ5Xy+Baywga9wFddCUIjJYPuu7
         znW0wa3fhMnXlb5/pFbvtxogR8lC95NPErcPEln3Yuo6HwDlso+6o6jrEF5MymPbpA
         ALVGfefnhZIhb4fmA8LBWrAaU6uZqeneOzgjVQlMZDHyXD5ZhO3t0W8JpcYcXeTy2H
         eLibrB1dhSwYpcmqsWXfp/eOLCRP9anBpaz1QxzmWqeDp11Z4LcZLZ697OdTQh0Y7f
         TTvdhddQz3FkqTN2gkWQ9xnqgGQZQKShSjTet75MQKM6Nw3dk5sYoPqYan3q4s7/MO
         U+89504DVS/hQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] docs: reporting-issues.rst: CC subsystem and
 maintainers on regressions
In-Reply-To: <e1d2e16a-60b8-0a55-20d4-53db11e6821c@leemhuis.info>
References: <dd13f10c30e79e550215e53a8103406daec4e593.1618482489.git.linux@leemhuis.info>
 <e1d2e16a-60b8-0a55-20d4-53db11e6821c@leemhuis.info>
Date:   Mon, 03 May 2021 16:58:21 -0600
Message-ID: <875yzzh1bm.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thorsten Leemhuis <linux@leemhuis.info> writes:

> Hi Jonathan. Wondering if this slipped through the cracks, as I haven't
> heart anything (or did I miss it?). Would IMHO have been nice to have in
> 5.13 as well, but it's not crucial.

Hmm...I was sure I'd applied this one, guess not.  Sorry.  Applied now,
I'll push it Linusward shortly.

Thanks,

jon
