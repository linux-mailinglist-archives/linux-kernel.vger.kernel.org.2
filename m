Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D021370154
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 21:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbhD3TiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 15:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhD3TiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 15:38:16 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BCFC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 12:37:26 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id m7so71311380ljp.10
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 12:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ojW04pTTBQuwFAYIuJX83wagA1+sJZvXJIs45pEY1Cc=;
        b=T/QeiNHmF/TAkd0R68dxA9bdEHpyhyt4JHhgAhSs0wyo7exB2KJ5cf0VzYIUZtaH9i
         GORF5lTUTNDZPm6oBF7NAkvXAmxG4aCphsJ6FPHwIzbfR4tXbl2iQ1jLvcfuggQfTOu5
         02aeG4jwbOtUd7eRBmd56qDdou2uaF9Yh8FbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ojW04pTTBQuwFAYIuJX83wagA1+sJZvXJIs45pEY1Cc=;
        b=r61hIel7ciBPXSd8HXQ5Hw3jcRXbXPZsfa8JSZmtRBdZxeOtn6C1QWZJEB+LuTSv9u
         R8+V1aVVErjJqOropH36Ae6tlNxZpzrCByaNUkmgmb+7F2J2SpPLEUFQugfL/bZ1St3v
         Tk8Sl4G1F+DTrF1wx7NbLkatV2A0ibAwUN82BLX9vzJB/kvENn46rdFRzA76JVNxop4p
         gc6hQxdHmAb3DsYNe0esXAcRZ3tTxF7kF8TAQPTQIpxYtIBFwl4zk3HF9VHHtZ0A9+8K
         bs6fEmiAix7EG8pXy93QJt4n/XGFY5zjhtSMS/5IcCqGppcfC8FCTBhv8ZmmhHFVW3tD
         2IDA==
X-Gm-Message-State: AOAM531/4MK3vUszvFHtslevwmVzbEF6ZTo4Lwb0N205MVOqBkGgY57K
        rmEYSG6anEU36+ATpNEzjPIjfXlKYgNSlmlH
X-Google-Smtp-Source: ABdhPJwn66gBYukmwcEvUZeGeH7DZpdOVhWpMlyqVFG8K85tRI1WsBnmsobA4ddXLSI1m4XhRLTeCA==
X-Received: by 2002:a2e:9c07:: with SMTP id s7mr4873021lji.26.1619811444606;
        Fri, 30 Apr 2021 12:37:24 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id w7sm24566ljo.43.2021.04.30.12.37.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Apr 2021 12:37:24 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id 4so51851538lfp.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 12:37:23 -0700 (PDT)
X-Received: by 2002:a05:6512:a90:: with SMTP id m16mr4179629lfu.201.1619811443761;
 Fri, 30 Apr 2021 12:37:23 -0700 (PDT)
MIME-Version: 1.0
References: <YIlcBHhuR9LvKZ7q@gunter>
In-Reply-To: <YIlcBHhuR9LvKZ7q@gunter>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 30 Apr 2021 12:37:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgoC=9tJZg391exBryFYK04e_BSpKwCmJLMwDntar4x_w@mail.gmail.com>
Message-ID: <CAHk-=wgoC=9tJZg391exBryFYK04e_BSpKwCmJLMwDntar4x_w@mail.gmail.com>
Subject: Re: [GIT PULL] Modules updates for v5.13
To:     Jessica Yu <jeyu@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 5:58 AM Jessica Yu <jeyu@kernel.org> wrote:
>
>    Therefore, load the __exit sections even when
>    CONFIG_MODULE_UNLOAD=n, and discard them after init.

So I've pulled this, but I have two questions based on reading the patch..

 (a) Where's that "discard them after init" logic?

 (b) ARM has its own module_init/exit_section() functions, and now
seems to have different logic than everybody else as a result..

but maybe I'm not reading that patch right.

               Linus
