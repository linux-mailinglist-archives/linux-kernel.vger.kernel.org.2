Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F63F419533
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 15:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234587AbhI0NkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 09:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234359AbhI0Nj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 09:39:59 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42268C061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 06:38:21 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id v18so34218533edc.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 06:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Vfh9KgsSP5BS01eoNyHXbYSyVcws0Zy+EOjKOnp3P8E=;
        b=OrR/WvkvrCcU2JkTzAR28z5yCEBU6NmpL8A9PQ/OezThMZ73yeCPVAWA25UTs+q1y5
         rWcmEX3ByfwWpUUT1+3lMYA7uvsWMbE8cClXS18a/aICVYB0l73Mw8ZWHpd9xJic4FSy
         xrqHvHJqnT+FmJOExmkX4OwVoJU8Pkne59NCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Vfh9KgsSP5BS01eoNyHXbYSyVcws0Zy+EOjKOnp3P8E=;
        b=1GucYpbcDLUnbNC9FIGRCQ/vsNhI+E2BXJPNUnacO9Sh0MW6cdhCsgOdcLMz9U48Sc
         IPQ2NqzjWwPoj+0z8jd9SYfBcC9SbDepnH6ADvb6KYl/UMnQTevrTRCu17Rta8chd4uL
         lH3pfd41aHr6Pl/2i+/BhFk8lZM74SzhY9yr7Ps1jwvd+WAMkb0lftoUsSC6c/y+lVxt
         1J7fLuQPSua46DDRjzVzieP8y4lDpX13lFFzh0nk3mCDZNFFULwC4lJbhdHomvvLmAuC
         HGKYAdA0VYOMHlBIEblnEHKS70xzziTbEG84qRxtbzLdRdQTLpjRcXibc6Y+j9ISHWLY
         DX+A==
X-Gm-Message-State: AOAM530SqZMX8uTYlslOUKR8ZPkpWdioxety/FRuXWkDfPnYldiDFSXx
        bEeuKfMuMQAbFdgBDPKD+CGVug==
X-Google-Smtp-Source: ABdhPJw8T4czYppZUGA/cNfzdAv8mXU5pSwjFFaXF8JTL2wc1biR2uhah7881crI+rmaqRn6SGsN9Q==
X-Received: by 2002:aa7:c2d3:: with SMTP id m19mr5923709edp.267.1632749898737;
        Mon, 27 Sep 2021 06:38:18 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:6664])
        by smtp.gmail.com with ESMTPSA id u19sm10910035edv.40.2021.09.27.06.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 06:38:18 -0700 (PDT)
Date:   Mon, 27 Sep 2021 14:38:17 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jessica Yu <jeyu@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Subject: Re: [PATCH] printk: avoid -Wsometimes-uninitialized warning
Message-ID: <YVHJSXYXl4QnF/7O@chrisdown.name>
References: <20210927125007.1581919-1-arnd@kernel.org>
 <YVHE1qclD6ZyjvvD@chrisdown.name>
 <CAK8P3a3_0njnrTokeXmOuZ1vA00Nk9pqbxsOZw+6QcCL-Ng=xg@mail.gmail.com>
 <YVHILl7E5RI3ohyX@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YVHILl7E5RI3ohyX@chrisdown.name>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To be clear, I appreciate that some tradeoffs need to be made for the nice 
warnings that clang gives -- and to that extent I'm ambivalent to the patch -- 
but I object to "Fixes:" for something that doesn't fix anything at all.
