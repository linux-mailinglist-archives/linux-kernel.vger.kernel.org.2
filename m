Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3583483D7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 22:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238525AbhCXVgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 17:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238503AbhCXVfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 17:35:34 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CEEC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 14:35:33 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id z25so515581lja.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 14:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XDJljzfzu/Pp4K7dzVQcnIMYdb0HCNsWWH/8/sbTawU=;
        b=TzPouaP5YtZ7Izi57anrcO5MEDp1eLuXcg9YVxsWRoomBQQF/LlGK12xuoW0cXUMLK
         imAdJyZe1TNXpUD2aUJWT/6FIxhnj8YVBw0f182l/4+ulmnyOHfhtC1XhlkDhtU5VAGE
         wImpKaw78H6id7mdHCNk1jhhdhnS4h9dcuHnJ3+GSqLfh5859LHgOpeBhQWXU1zr6JgI
         vQ/pQWS+fkJSUviqxIu/cqiu2eeyuqw5CKBTGsbaGoPwQQSxgrDFOX0s+aGssVDg/I6E
         8b8ERUEwXvIGjUKhsLibkb7xWbNDBwFpyEDHKeV5u119aVx+SHUYPDPe60g+7zpeC8Vu
         XCug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XDJljzfzu/Pp4K7dzVQcnIMYdb0HCNsWWH/8/sbTawU=;
        b=t6NUj9K4H4WtrmUUov5ki9wT14zqqZH9rly0un26KMmzbv+qK5vT/TREzba1LCzVyD
         EKmmNhGQgcBlhr527b3tpOZjIUv/PptobsoSN3akxGObrmu6U7zNCV4bP0/rI56x63+l
         +Y+ZRjU2gF7ZvIAM0xDpg0PR7GPs0KyQPDOzt4XkZJzgMc3N55D9viQSsUMB2lJWolfe
         0GmMpg6VOj3wU27ljCfN+L0bVTxR/VwfGzh2uZiKjeHifrm4I4OfMQ2innHbvZUp8yqU
         p7gkQ9OF5BxNXQqmh86r/6vsVdT6hwlQSIi8VLTZgxIl6vZAVLRcNmJ85rSdThtj6Z1u
         V5Mg==
X-Gm-Message-State: AOAM5303Sevaoj51EkeHzX6KzhQUE9CONSBkytN/1cS8/gnt5mcYUBvc
        6dSNLb8HsWUjgIeRWrli2ac=
X-Google-Smtp-Source: ABdhPJzgKGlPyb+12sTs/JbuUWqcSd/Oyb12cvlkvf0mxW5C3cyf5iVabDvHiAkwUatMIr9m1XseYQ==
X-Received: by 2002:a2e:8e70:: with SMTP id t16mr3430655ljk.489.1616621732090;
        Wed, 24 Mar 2021 14:35:32 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-60.dynamic.spd-mgts.ru. [109.252.193.60])
        by smtp.googlemail.com with ESMTPSA id g14sm456163ljj.3.2021.03.24.14.35.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Mar 2021 14:35:31 -0700 (PDT)
Subject: Re: [PATCH v7] mm: cma: support sysfs
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        gregkh@linuxfoundation.org, surenb@google.com, joaodias@google.com,
        jhubbard@nvidia.com, willy@infradead.org,
        Colin Ian King <colin.king@canonical.com>
References: <20210324205503.2132082-1-minchan@kernel.org>
 <65840bfd-4471-7c8d-ce71-c4705baf3bfe@gmail.com>
Message-ID: <c1d08eea-5e27-67a1-dca2-2c1430f36c48@gmail.com>
Date:   Thu, 25 Mar 2021 00:35:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <65840bfd-4471-7c8d-ce71-c4705baf3bfe@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

25.03.2021 00:31, Dmitry Osipenko пишет:
>> Reported-by: Dmitry Osipenko <digetx@gmail.com>
>> Tested-by: Dmitry Osipenko <digetx@gmail.com>
>> Suggested-by: Dmitry Osipenko <digetx@gmail.com>
> The tags are incorrect, I haven't suggested this change.

The reported-by also should be removed.
