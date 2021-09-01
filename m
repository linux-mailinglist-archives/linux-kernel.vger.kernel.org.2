Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 837873FD943
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 14:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243953AbhIAMKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 08:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243873AbhIAMKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 08:10:15 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8033AC061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 05:09:18 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id l10so3025182ilh.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 05:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8cZI3JCuLp/VE4CkVId11EMKSems40tyrkIK1Be1ftw=;
        b=BckSNcvNMOcvSd7v/oDs69GDBnbITTcsGLEeGp8WOKnquld8s9ItFWSEGz5vLrfhcg
         yZT1kbJOOWEFIjzCNC9W2lGpzCSJvssMvpUXf8N+Axb0aahsxStSy8NofhulPdABX4F9
         PQEhQGx63KhfCLo0nqeg29DuVeFqdO7s5JEkA07Vd6pEzuXT2moy4Rt3GMOrs6Ngd9/C
         zbzWY+GPjk3eKj2oGR2aoDlVz1Vm2z7uv2FCN/5IlVFvAXkrHQmXAceheN+crJ+7FscF
         ee0K2dpeSoHlQCOFIfd1+wc2lpL7rGJqsH+uSHL4Lru7Ma5brXDQ+lHnloOjiQ7/jaE2
         QY5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8cZI3JCuLp/VE4CkVId11EMKSems40tyrkIK1Be1ftw=;
        b=NE5qhr/1O7YwS9InHDP0qhUdXP8Aj3OHTGgite/5rvaMwwpKVo0QauvE5kyGddzbDC
         3cFszzbN4NRRme5uL4r+murEd49LxgT5fW/mzdoSKuVqCJY2GTRSiDHhwER9+Q8bvA0P
         jWzk3OnlPfYDvE5LHOalSV2sAv+XPiP2nRB537omtSr4O6ICP5to0ycTEyrWde0WRNtt
         +Bb70r/NDvprkk/5HgG1Z9Kj0jkiwqlKPDSDxV7svRwblBWKoRKzjdpbr7pjNT7mNGYl
         hQ7S4dEqKfwRzus7aHyjWd7OA0A6DoAWcIRhvDxy4OpLjqCebFI5akWgW+0f2uK+eibD
         nKFA==
X-Gm-Message-State: AOAM5307bKDHkpB7LtPLuRhImkwo49m5JehgJy8ZtQ7kT9CTlfzVWkPx
        gK42I7zsHBsz0lGgbG8XPYtuVwIbKfLwZ5RN
X-Google-Smtp-Source: ABdhPJwbWbqjZ2YXu2DKUD2OmK1e0Bsf5zCBQX/yZA3LIScSzqxAeN61s6ns9w3+r13R/STby73GUg==
X-Received: by 2002:a05:6e02:1d9e:: with SMTP id h30mr24434965ila.195.1630498157795;
        Wed, 01 Sep 2021 05:09:17 -0700 (PDT)
Received: from [172.22.22.26] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id z7sm12046546ilz.25.2021.09.01.05.09.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 05:09:17 -0700 (PDT)
Subject: Re: [greybus-dev] [PATCH v4] staging: greybus: Convert uart.c from
 IDR to XArray
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Johan Hovold <johan@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Alex Elder <elder@kernel.org>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, greybus-dev@lists.linaro.org
References: <20210829092250.25379-1-fmdefrancesco@gmail.com>
 <f7a25eb1-20f4-5031-a156-9e5dc019ad28@linaro.org>
 <YS3jSsGSs0yAw/Ba@hovoldconsulting.com>
 <6155058.TBsaUTXu4T@localhost.localdomain>
From:   Alex Elder <elder@linaro.org>
Message-ID: <794b3ff8-0240-ff14-8721-cdf510f52be3@linaro.org>
Date:   Wed, 1 Sep 2021 07:09:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <6155058.TBsaUTXu4T@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/21 6:50 AM, Fabio M. De Francesco wrote:
> I was wrong in assuming that trivial patches to Greybus are welcome as they 
> are for other drivers.

This is not a correct statement.

But as Johan pointed out, even for a trivial patch if you
must understand the consequences of what the change does.
If testing is not possible, you must work extra hard to
ensure your patch is correct.

In the first (or an early) version of your patch I pointed
out a bug.  Later, I suggested
 the lock might not be necessary
and asked you to either confirm
 it was or explain why it was
not, but you didn't do that.


I agree that the change appeared trivial, and even sensible,
but even trivial patches must result in correct code.  And
all patches should have good and complete explanations.

					-Alex
