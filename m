Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEC7348460
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 23:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238730AbhCXWLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 18:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238743AbhCXWKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 18:10:55 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25880C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 15:10:55 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 75so34293664lfa.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 15:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=j0l7eiiq8CWRu9MPymBYBipX2XMrx1zSlUAn92LEz9s=;
        b=prAK/tdVYyzvKAyhR9HYfsl5vI/cAtAN+WSO5OdAfJtfsBklBZi5YFyj0ixvTlh1aJ
         W/FA+fHPlN+PqJ/Bsk1Yzq/v2Whx7dwi8Zm84GPU/x0tUWrXyp751wAd9M0mpuO8BDHX
         /REV7YbbuzmH/X2C0wLcVWKFvXI3IQ4m6KYCLQ1mWglbhPrYPFJA9bxJDDGdN8EaIggh
         BN/XUa7Hxgi+XzXrIAWFLzzUYrgkIKMI3ZXNCZXdvKy5rlNqj6f0ruHBUFv+k9tf2wmw
         pEirfc1E8JCkq8oPILupO3BzhOsdxiw9OeuCnI7AkMXp4M3oHFCzV49siOgiRSS1ZUhx
         S8IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j0l7eiiq8CWRu9MPymBYBipX2XMrx1zSlUAn92LEz9s=;
        b=ie+PlMqJ8UkUACaBO0Luh+yHmWTow8nF+G8dG8bBCh3n21KzjWrvigwmFVbgcDx1Fc
         C3Jjc5Wk7H0GFllgdYKPxjRzKw+YbzqtM2+ecQc7sz13DSqfxtZODOT5L2GFjxRDFn8B
         2+R0Snxb1SbuMcc5Q7w+di21JE4rc7ixw/RK9oIXzMcxRdyuDRJtxD4WseeqIkiDodiF
         jgToVsAB6HOUKoxob9+SHUfO6A76+WbQ+euzVsQTINqKpizBPLbm4s0zEkNDT9ukkW/7
         9jDMOwAikPL7Yi8vXkbVqG26gt1DC468che6WMR7rgh9nmTva37H8q4cuCkdkTK75JPL
         ivjg==
X-Gm-Message-State: AOAM532yqtubB5s+mIBmD9NFLfg45JOYLBiVXKiLnSK8v14Cwa6GO8Ux
        5NCEecXft2zrHSGoG8niuYo=
X-Google-Smtp-Source: ABdhPJyG75Hd7V1XqgIIWn2i689vlqBkvH4ThTf5TsKmeKu9nukYUV+QxwfkxSAzf4vpU9OP+3VO+A==
X-Received: by 2002:a19:ad06:: with SMTP id t6mr3215100lfc.8.1616623853690;
        Wed, 24 Mar 2021 15:10:53 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-60.dynamic.spd-mgts.ru. [109.252.193.60])
        by smtp.googlemail.com with ESMTPSA id y8sm494045ljk.9.2021.03.24.15.10.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Mar 2021 15:10:53 -0700 (PDT)
Subject: Re: [PATCH v7] mm: cma: support sysfs
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, gregkh@linuxfoundation.org,
        surenb@google.com, joaodias@google.com, jhubbard@nvidia.com,
        willy@infradead.org, Colin Ian King <colin.king@canonical.com>
References: <20210324205503.2132082-1-minchan@kernel.org>
 <65840bfd-4471-7c8d-ce71-c4705baf3bfe@gmail.com>
 <YFu1QoiPEnAOAvXS@google.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <7d9ccfac-b705-8682-d05c-cb239c215677@gmail.com>
Date:   Thu, 25 Mar 2021 01:10:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YFu1QoiPEnAOAvXS@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

25.03.2021 00:55, Minchan Kim пишет:
>> There are no dereferences fixed by this patch.
> Let me add this:
> https://lore.kernel.org/linux-mm/20210316100433.17665-1-colin.king@canonical.com/
> 

The tag is invalid now, since you squashed the fix. I think you may add
"Co-developed-by: Colin Ian King <colin.king@canonical.com>", but this
also should require to add the s-b from Colin, if he doesn't mind.
