Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA2A329FBA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381024AbhCBDqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 22:46:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235463AbhCAVJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 16:09:43 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4321DC061788;
        Mon,  1 Mar 2021 13:09:01 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 455662B8;
        Mon,  1 Mar 2021 21:09:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 455662B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1614632940; bh=od1sDN7Zm/FSSJnE/q/cJkLnrEPDy/KT4dueDh8t/0c=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=olIOF2Sp6H7WQ+15LoJTSiFB4NP6f3Q4WQDJ37wdyGjxVnwLzDsW7S6tr8Tweu5bF
         +rnh0IJe2TaJBPklX7YdUwxPqsvPYFtNYus3ZEx9EPmDtH+606iRqiWpU3oinukoMf
         iVdFzrd2H5+eQ4N2fXqReRyuw0OEXeU3RWbEE3+dFUhjxLwVSqXaXGMHhWQ+FQyx91
         UfcmMRAXjiQWMUhU6B7KMQMnq4geQfTN5/3mhl86N5zLBvcsfN8RNiBgkAcPGD/bj9
         xAQd2bEcXtb+g4ZZTcWGGi98NIWZnjeRRrzamr+j6+dihQtFIgdQSAg+oCR6Z7EUqe
         yaqj+xZ06FA0g==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: Re: [PATCH V2] docs: sphinx: Fix couple of spellings in the file
 rstFlatTable.py
In-Reply-To: <20210301201052.11067-1-unixbhaskar@gmail.com>
References: <20210301201052.11067-1-unixbhaskar@gmail.com>
Date:   Mon, 01 Mar 2021 14:08:59 -0700
Message-ID: <877dmq4m50.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bhaskar Chowdhury <unixbhaskar@gmail.com> writes:

> s/automaticly/automatically/
> s/buidler/builder/
>
> ..and a sentence construction fix.
>
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  Changes from V1:
>  Incorporating Randy's observations ...i.e sentence construction
>
>  Documentation/sphinx/rstFlatTable.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

jon
