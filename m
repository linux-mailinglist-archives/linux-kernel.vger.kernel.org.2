Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96A943528D1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 11:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234747AbhDBJcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 05:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhDBJct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 05:32:49 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213D1C0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 02:32:49 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id r18so1244326pjz.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 02:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=trKfGY9uhUqGYG99eS6DDb3u4HvS8gho5043rTjuAIE=;
        b=otyqSWdA0X9lbf9YSg2AosoTSed9WnhA0MDCP8OwCPAOnOWeHUcb4W5N9Lw5DQE7dV
         iae6S2snE76CvZ7gUB0l4aeRX8yvNKSSVwNTtSakhuHtAzhCBkjXJUmWSZ/4wMLwHvot
         NFrGGWYIO6Re1kejnSpdVXWVKz0oyv2cEWpL1IgrgyWx13PRYmvk/JCSvvVGrYU/eK6J
         4d0o5UMP40bKtbnlXnFGM440DnnEkG+93hXl1m5GN8BGOgDJGEDumcHYht2xN049Ymxv
         gRI7kgcbad6Ow0Ido/dMxvmEQhSnRlDIggi3CSw+mC7xB2MMuU46X1CQcvSnfvImeTa7
         FG9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=trKfGY9uhUqGYG99eS6DDb3u4HvS8gho5043rTjuAIE=;
        b=ZriT+8m+AJbxcNBJP6IqBRLq1/oOdsghQra9opma/mXOqhBuCWgdAzixSCS80kyKS6
         c0lezvSb20zEdGvQJOjPvASdRd2ocDn3icTN29qxublQQPsmkiqraLFM3sr+zyqmlGi/
         GJczPuB/mN6C7JlkHvyd0pMvwJj7wHjQuvG9OdaZF9TzNwIMLkr2xuKm45D93vKNTvnO
         Y0QVaTxnGkxhqzKBsnDtsmB723jWKPhCz20/l9gVBA5/FG572XElBM5HBI0NfNnR+Mpf
         qjP/bjYX/A55OIwRpX5QF4WmFn0qW8Wh25jkD9lP6UBfdRMHXPl8/ZhnM5oL0GQM3wuE
         WLMg==
X-Gm-Message-State: AOAM533x+X8nOvojMIfY4NaxKcumerATFO16X+SfuGSYgdPhIO+Wrxu3
        zYyOzPLGqsZbO7ebqc7esnrGUBv55Kh+L+bOx9PXjQ==
X-Google-Smtp-Source: ABdhPJz7bFan7cRo+1G4QGaBQRj1CIdg1b8H1JoG4yC3cbLh2WW0JiRZiau+Sl1tIDCycW4tO39W5m5g5y+/HxICAXQ+bw==
X-Received: from mactruck.svl.corp.google.com ([2620:15c:2cb:201:29f7:72aa:ed3e:9c33])
 (user=brendanhiggins job=sendgmr) by 2002:a63:f247:: with SMTP id
 d7mr10876971pgk.112.1617355968529; Fri, 02 Apr 2021 02:32:48 -0700 (PDT)
Date:   Fri,  2 Apr 2021 02:32:28 -0700
In-Reply-To: <20210222225241.201145-1-dlatypov@google.com>
Message-Id: <20210402093228.755260-1-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20210222225241.201145-1-dlatypov@google.com>
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: Re: [PATCH] kunit: tool: make --kunitconfig accept dirs, add
 lib/kunit fragment
From:   Brendan Higgins <brendanhiggins@google.com>
To:     dlatypov@google.com
Cc:     brendanhiggins@google.com, davidgow@google.com,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> TL;DR
> $ ./tools/testing/kunit/kunit.py run --kunitconfig=lib/kunit
> 
> Per suggestion from Ted [1], we can reduce the amount of typing by
> assuming a convention that these files are named '.kunitconfig'.
> 
> In the case of [1], we now have
> $ ./tools/testing/kunit/kunit.py run --kunitconfig=fs/ext4
> 
> Also add in such a fragment for kunit itself so we can give that as an
> example more close to home (and thus less likely to be accidentally
> broken).
> 
> [1] https://lore.kernel.org/linux-ext4/YCNF4yP1dB97zzwD@mit.edu/
> 
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
