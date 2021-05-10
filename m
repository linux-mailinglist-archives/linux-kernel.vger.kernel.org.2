Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43E56379A59
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 00:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbhEJWr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 18:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbhEJWrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 18:47:25 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B406C061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 15:46:20 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id v5so9522343edc.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 15:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dV2fbQ9we9uyPGgdf7bI2BbfhIiau/JyLnqbyj6Q3Sw=;
        b=QUPiMooSz0l5MjoNONoFhTr1BKLywkNA4HKVyO9v2XFl5BuXItbnHwz8N6SJwuGYx8
         cXqeK1PxzondZ7oHEePXD8yCJcCcvbVI9osgErLGQbcKSyoXOhQoewDVXKzXVbjANOsY
         FwpkfOvnrsVEYBxvQwnRnvZzmR5APOd72JnVOrCAhNzMicD9hVcuqy3+oh975JDMWFem
         OHzc7dVn7Q8UHD3TbUY3OiITbyXh7chwYJs5Bb2afrf8Z2GR2QF8tfNVje+80KlDLl4d
         lzTa0ufQAe9pa5BwS57psy3PM+bMkFccqZGiSrilb+Bc0swItlCblOQKfzOzj/ea+Ymx
         C7PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dV2fbQ9we9uyPGgdf7bI2BbfhIiau/JyLnqbyj6Q3Sw=;
        b=fLgaVTZeJftJ+aFiWnbCPqD4aOAoRqXnehgzL3YDweEthbE0agUowpWe9ZLDurpVxW
         sHELPL1yeGSIzvdDxaDcE2MFLYEh+B5uB6mUMnG8wfZizfuFZfhagBfSQLy404/oSoup
         KQm6ZVouKdYh9tmTb9N6qDqBwnQsQ4XaPShzbJk8rFpZg22JxkCodqI1YHT+d8BniyvX
         5jOj5UGSr3GOuJJuyz4gqqY6mw1ruzWUyK+lw2xaJijkGFAVVHpUpT6EocYDr/6r8Mzx
         mWLsZx5IkghvPGwBUolVTzxrpLUGxX1lKNwwXa21xtJ0rlJ++iXUQ8VctKgg0yYsnCXG
         QqRA==
X-Gm-Message-State: AOAM531c/AlgZr2Jq+x3OsMoPgKwcLRmKJTHRblSNB9Vo933PSFmmxEE
        vu0PwNtw8EPK3MJrlvRVxIcJEKMiYQBGQ3YTIjAIUnUcCw==
X-Google-Smtp-Source: ABdhPJyECo9u60lYqEC4PUIr8xxZkeLBHjQ+oOV7bZ3nKJ3N26zglkzRfv8eEhECFQ2SXRD0VYsFZcYIihFUdjmbGCw=
X-Received: by 2002:a05:6402:b2c:: with SMTP id bo12mr32474141edb.196.1620686778767;
 Mon, 10 May 2021 15:46:18 -0700 (PDT)
MIME-Version: 1.0
References: <YJLFrrsN2jOx9ooS@kitten-GF63-Thin-9SCSR>
In-Reply-To: <YJLFrrsN2jOx9ooS@kitten-GF63-Thin-9SCSR>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 10 May 2021 18:46:08 -0400
Message-ID: <CAHC9VhRcRW9zGpJsdZCCNTjdZDDfEXMmH-JGy3VjOY4BaO=PYg@mail.gmail.com>
Subject: Re: [PATCH] audit: add blank line after variable declarations
To:     Roni Nevalainen <catmaster.kissa@gmail.com>
Cc:     Eric Paris <eparis@redhat.com>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 5, 2021 at 12:20 PM Roni Nevalainen
<catmaster.kissa@gmail.com> wrote:
>
> Fix the following checkpatch warning in auditsc.c:
>
> WARNING: Missing a blank line after declarations
>
> Signed-off-by: Roni Nevalainen <kitten@kittenz.dev>
> ---
>  kernel/auditsc.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)

Merged into audit/next.

-- 
paul moore
www.paul-moore.com
