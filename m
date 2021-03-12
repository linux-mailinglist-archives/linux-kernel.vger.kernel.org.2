Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC62C338A80
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 11:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233533AbhCLKrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 05:47:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233471AbhCLKrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 05:47:08 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4165C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 02:47:07 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id v11so1501687wro.7
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 02:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5ymDbMltNO7AK4M17L49pS5zx0qn/VHAwdqQvYtor6Q=;
        b=BarfDnQLt/Zdf2RCd2yLRFzYcB8i+HL6FKXcNBoENRawbNyDgoDHEGlL9kpw0u8L3U
         5hPDFvB98/t0VhGyIE7r/+b3ZqyVSWL0lMiDqqfTPb0vGkzoaYsew6TCkdIBHAkUkQMO
         qjKLthNM8XnCmN2b0/jKpi8YlPHkQlVWyzh+O/9T5EVDGgxRjU4YOmiw/WXayMNWN/EM
         E+bvgoVGIZEP6ze4o0cpVcOxBT5PFZ7NIlbkFWVXExw4kiEqhsW+Jm7i+0DIv/iUSQSS
         nGtZh0DB1mQkzp5TIlqa6YZQXmpmBJEocXosFKjFn0o2/7BVe7CB61NzzzlXMcpQZLua
         EB1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5ymDbMltNO7AK4M17L49pS5zx0qn/VHAwdqQvYtor6Q=;
        b=KtdDKsdnnsBS0A+Xo9X+2kZ89Gc4VBm1jXbnlvkjAtymDN0U5ZAiCR4+xsgjgtpSTJ
         CkuGqEWgneh6KH9+NsOUU8+5fsdYKBTqH0B6urCnrsdQ/URtRhZMDkcCXubskAep1b9x
         DXsj5zt2WgoUytQxdT5bJZMlVGpZqGir3r5cMaQIH84eTj7im1Nj4DYC/SEx26DL4/+A
         mSr5eyxYdiMdw8rP1SsLw0BLgphJBZL4roA+RjFJKKkSpAV9GGnzYuEcZ9cvRFeGPGbJ
         XnYIOotw8CX+qNsJDn5HE1r1UJMoc9SvIl7lOtd9HUO9H3GeeLI39vycmtpXYx7z4Gmo
         FJ6w==
X-Gm-Message-State: AOAM532QsnhkBwhanyrOKICxrrnPfweXYO6Vlnzr+AM6dj+p/GPzw+eY
        U+0+orNEcQI7gHb28wd/9y53dw==
X-Google-Smtp-Source: ABdhPJx5JgsXZsUdFOhi57zEwvGUxbL3WpLElH4aEmrHEz6NDKtHNSzoiyIoc5exSSL0CqC+EAAFcA==
X-Received: by 2002:adf:b1c9:: with SMTP id r9mr13647480wra.51.1615546026490;
        Fri, 12 Mar 2021 02:47:06 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:d5de:d45f:f79c:cb62])
        by smtp.gmail.com with ESMTPSA id t14sm7771955wru.64.2021.03.12.02.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 02:47:05 -0800 (PST)
Date:   Fri, 12 Mar 2021 11:47:00 +0100
From:   Marco Elver <elver@google.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/11] kasan: docs: update tests section
Message-ID: <YEtGpCV6jwWk1ZNO@elver.google.com>
References: <f6efb2f36fc1f40eb22df027e6bc956cac71745e.1615498565.git.andreyknvl@google.com>
 <f9e2d81b65dac1c51a8109f039a5adbc5798d169.1615498565.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9e2d81b65dac1c51a8109f039a5adbc5798d169.1615498565.git.andreyknvl@google.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 10:37PM +0100, Andrey Konovalov wrote:
[...]
> -With ``CONFIG_KUNIT`` enabled, ``CONFIG_KASAN_KUNIT_TEST`` can be built as
> -a loadable module and run on any architecture that supports KASAN by loading
> -the module with insmod or modprobe. The module is called ``test_kasan``.
> +   With ``CONFIG_KUNIT`` enabled, KASAN-KUnit tests can be built as a loadable
> +   module and run by loading the `test_kasan.ko`` with ``insmod`` or

s/`test_kasan.ko``/``test_kasan.ko``/
(Missing `)

Also, "the" before test_kasan.ko is incorrect if nothing follows ("the
test_kasan.ko module" on the other hand would be fine).

> +   ``modprobe``.

