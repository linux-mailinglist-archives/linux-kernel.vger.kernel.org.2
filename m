Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCC77337612
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 15:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233767AbhCKOrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 09:47:00 -0500
Received: from mail-pl1-f174.google.com ([209.85.214.174]:33970 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233608AbhCKOqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 09:46:47 -0500
Received: by mail-pl1-f174.google.com with SMTP id ba1so10318808plb.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 06:46:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WAsuQjpf+/JhUAJoA6HUw/xzMiy7p5e2gW3ZZQvzL2c=;
        b=NOWb/9QvmsnLZmcmxr3VONr0d2ONtNGQxtoi9Pkxb+wHrRwEmn9jnYvNZCZDiJZeh3
         I0bzWlPkqcM8A4w3EqHlVVpg0o1053ydGUZT6zJE3srp1YJiNCrPYS3zRZufdrai2Mm6
         E2nKIkTXvSOYJt2+xfwoeam+15elNCHMCG8ehtQ7cARTzQlabl0vv1m374iDXh+Q/rjm
         PRXDGvuNzKgXPUH4+9aUNrIw5dfA6fCGguqvXoZfQOQ8QoQJPGXx+kK2axACAfiCZ0Dm
         rnhvJUP0ZStAOMaY1g/pxYAvYVbjXmh9r89/eRZmvBBkVvvrjX6klFUiSTy2Ru9aFt/Q
         9OnA==
X-Gm-Message-State: AOAM533CUTudMOTGp9X8ij1mYlFos59ee8UyNPgSw9wzgH07crg5oeRe
        cJv3PDQMDsTs116jdMDDhaAh5lLQXR0g6A==
X-Google-Smtp-Source: ABdhPJwQDfSPsV3NmNj1e7Up1Q/4VmoqRHL9Bk54VAffoMgzGzP5KkENw7wYvDwEpa11gTkDBao31Q==
X-Received: by 2002:a17:90b:4c4d:: with SMTP id np13mr9484452pjb.81.1615474007449;
        Thu, 11 Mar 2021 06:46:47 -0800 (PST)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id 10sm2638348pfp.4.2021.03.11.06.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 06:46:46 -0800 (PST)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 81EA04024E; Thu, 11 Mar 2021 14:46:45 +0000 (UTC)
Date:   Thu, 11 Mar 2021 14:46:45 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     lyl2019@mail.ustc.edu.cn
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Re: Re: [PATCH] lib/test_kmod: Fix a use after free in
 register_test_dev_kmod
Message-ID: <20210311144645.GU4332@42.do-not-panic.com>
References: <20210311080246.11635-1-lyl2019@mail.ustc.edu.cn>
 <20210311130108.GS4332@42.do-not-panic.com>
 <17bb31cd.cc46.178217c9344.Coremail.lyl2019@mail.ustc.edu.cn>
 <20210311135833.GT4332@42.do-not-panic.com>
 <7c27e8b5.cf02.17821bb6891.Coremail.lyl2019@mail.ustc.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c27e8b5.cf02.17821bb6891.Coremail.lyl2019@mail.ustc.edu.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 10:40:33PM +0800, lyl2019@mail.ustc.edu.cn wrote:
> So, register_test_dev_kmod() will return a valid and freed test_dev, and cause use after free
> in function test_kmod_init().

Without looking at the details, in trying to improve the commit log
further:

Is there a way you can reproduce a real world UAF and crash? If not why not?
What is the risk of not merging this commit into the kernel tree. This
information is useful for folks to evaluate whether or not users of this
module might want to merge this and/or backport it into their testing
kernel.

If chances of this happening are 0, then this just a theoretical issue.

  Luis
