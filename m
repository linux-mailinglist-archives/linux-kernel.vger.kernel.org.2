Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57E18394251
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 14:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236057AbhE1MKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 08:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbhE1MKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 08:10:35 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050::465:101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D427C061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 05:09:00 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Fs3Ph57FhzQjVP;
        Fri, 28 May 2021 14:08:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mailbox.org; h=
        content-transfer-encoding:content-type:content-type:mime-version
        :subject:subject:message-id:from:from:date:date:received; s=
        mail20150812; t=1622203733; bh=qmRVtgKH5KcVuczEKLMzuL/gLl6UPj+N2
        waMLRTwVNY=; b=JQoeGQA7/C60HG+1qYSIkoTs1ZbhdGZ+KuQ2ckslO4x9wdUep
        N+T+QXU5veI5Y6c9bgwzi1yM+26jGE6IIspkZMRl83MoxIk0OMQ/GeY5MICfA7wM
        corwTo3ZPt09YkPsIEHSAYGip6m0zfzL1A5D0dQ6wyEUrezAj9zmXzyEz5btlUFU
        YXQ/CYkQKP3oJiTLZIXONg3cl/YdMMqFPJQu82Kzncti+okyC8y7vCkikCrkdCE8
        L6MAjrwHLjVqvCiSdaQH2DUD4MdHZvuW7gPEYfSevUGNlrDRA9aGlFk+RPt3JSVq
        oREi2paR1zpPbekNbodtKlu8M5NOUKCuVymeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1622203734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=2zUdfESLewKQxZBRQJJmyqbif3VULyS7oSvuoupAakc=;
        b=EKS6oVmqbvy1JVf4yj8qzLvV/7woO9CWdl9uEhGOq3gO2E9nfNPYqof08Dcspy6w+24n4d
        YHKPPoG52oYebqLHx34ktvGsBdeO57Ty1A4sMm/ARNxxygrAMQyKaSKQHOJ7Vhv7DHCHpw
        j3CgP7ZBOyQh9Zmv1nui219B3pEtJ0Sat5+XHdYmvxs8N8gognYeDr7Gli1qenlX4uGaN9
        SfjbuyBlyP/ESiG3coCfxppEPZq8yMFFpBdB9SecHsNHVaubDQ0LE3bqW6fttiyNN0rh53
        BnNMul414Q/OhDKtUIZtqiI/5n4H6N8prXREKmxN8jVm15+G8SzmxZEWplVgjA==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id jiVzwCLQsXZ5; Fri, 28 May 2021 14:08:53 +0200 (CEST)
Date:   Fri, 28 May 2021 14:08:53 +0200 (CEST)
From:   torvic9@mailbox.org
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>
Message-ID: <1825464932.40588.1622203733380@office.mailbox.org>
Subject: [Question] mm/vmpressure.c: ilog2 calculation in constant
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-MBO-SPAM-Probability: ***
X-Rspamd-Score: 3.69 / 15.00 / 15.00
X-Rspamd-Queue-Id: AEBED181C
X-Rspamd-UID: 46fe9c
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

in mm/vmpressure.c, we have defined this constant:

  static const unsigned int vmpressure_level_critical_prio = ilog2(100 / 10);

My question is: Why do we calculate ilog2 instead of simply setting the constant to '3'?
Then, I guess, we could also get rid of the log2.h include.
Note that this is just a question, not a request, as I'm sure there is a reason for this.
(given the help text in the comment just above)

Greetings,
Tor Vic
