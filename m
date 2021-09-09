Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89B39405FCE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 01:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348136AbhIIXBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 19:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244621AbhIIXBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 19:01:42 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E76C061575
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 16:00:32 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id z4so4790892wrr.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 16:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RqlFooijnqgBWG+n4PheUUBY3UoPu5druSxjQVNP4pc=;
        b=hOMBnlDSEDR7iy5R+ZtkYVvrSGdlNfwJFf7ywDphMox/DSdk7yBZ3TZqL8p4+ehChs
         29wgkR4PCK6M+7KqMBIiYHjsEiekpQw4QJDtuRxrMq2o2o9GZTK7aAvHeOuwCXNhHqYn
         e/lu5rCffUglGlQJwapgXHo/qpQOXfFNMMpHbclyie5P4NHoIM9L8l0TREOligfEq/Gf
         aGuCG+zkTaQXe3wrBtnQmWoDGz/dsYKIXzqkyGlyldalsICpY9vPu+2v70swutX2q64I
         PA1ySp+r0lDBNT6Dmnjp7hj4Fu9auQPtpOpk4YMldONK2MfxbY3zFT/xMIQhZdWLdo1F
         W1jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RqlFooijnqgBWG+n4PheUUBY3UoPu5druSxjQVNP4pc=;
        b=osjp+AJHspjsiRZzPZic+HWkngxREP3XyjI9brSDYrFvZxscLjLA1BHoTw2Ymry8OE
         af39IXyDw8UytZA/qWx+JNb5/ZNd9k5hsUutAg17tPaYcA2WcusO+EuAOFUYm+Z6H7yS
         a0BYh8hRC60POvOONvd28qEycaZC2GhBMzuL2ziAnOekbA0UfIhjc+i//AO0sSbpkTpN
         yLU5qWS608hlVVkSkWJhReO5DQOdIHrIG9lCiFVD8csWK7URVeDm9b8m1C+g+OmOeCxJ
         er4IL8pRE6N0lOM0T37hEI93TVwdIXPDyOBgQzqt1KvNvUnH8RlZ1gvRZagr6Svu165n
         wk1w==
X-Gm-Message-State: AOAM530GzadI6Cqh7/EZ9u3YBlCjpz0fok+DSbPYJDilW3WLkxC6qIQ9
        f7Ou1ZYE6ffwqEKmJJpxxQszNg==
X-Google-Smtp-Source: ABdhPJxWt4e+LY4UUMeuzojh6FRWGxJqFBaTYQ3llxyKt+xTVT0/VVt/URICnQniJcCgsPMT0aDKeA==
X-Received: by 2002:a5d:6750:: with SMTP id l16mr6265555wrw.174.1631228430980;
        Thu, 09 Sep 2021 16:00:30 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id x9sm2593289wmi.30.2021.09.09.16.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 16:00:30 -0700 (PDT)
Date:   Fri, 10 Sep 2021 00:00:28 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     hch@infradead.org, axboe@kernel.dk, linux-kernel@vger.kernel.org,
        lumip@lumip.de, linux-block@vger.kernel.org
Subject: Re: [PATCH v2] drivers/cdrom: improved ioctl for media change
 detection
Message-ID: <YTqSDICXcjdrC+vt@equinox>
References: <YTcILRYw/AKen0X4@infradead.org>
 <20210909001721.2030-1-phil@philpotter.co.uk>
 <409876e1-1293-932d-8d37-0211bef07749@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <409876e1-1293-932d-8d37-0211bef07749@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2021 at 05:42:30PM -0700, Randy Dunlap wrote:
> Documentation/process/coding-style.rst says:
> 
>   The preferred limit on the length of a single line is 80 columns.
> 
> checkpatch only checks lines > 100 columns since that is OK in a few
> cases, like a long quoted string.
> 
> So try to limit line lengths to 80 columns unless there is some
> other reason not to do that.
> 

Dear Randy,

Thank you for clarifying this, appreciate it. Will try and bear it in
mind in future :-)

Regards,
Phil
