Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1054176AC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 16:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345971AbhIXOPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 10:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbhIXOPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 10:15:40 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C19C061571
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 07:14:07 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id r43-20020a05683044ab00b0054716b40005so6419150otv.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 07:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8K4PrtN7OiONQx5lRLM4t8rDUMaxWp8v0q/xipOZJhQ=;
        b=Xi0XuivaEIrO+GSXqPZiG2AVUrhMgxq5Xd2mrvhBXmLL1K2Ra8+1Pj5uVCYrWJPl5a
         J6103kv3+tewtdVyIFABqogT3WJU0zD/45S6WSn5WSyxh+AnN4piAT7OJDzLiPH72RYr
         bHG6C9MVWldKDhuSag4yWOY7+bYlZA2w+BrBEvAu1FzM0brOsDdPi4oVv7tA+QlhSCam
         DS2z2oyuqmJwA3KPnuObgokqdzssdMVZnP2S7Y3L2zCjzojwH1TuQZgjYLzwY6opkaJZ
         4VWbWC2AdvyLPGg/DYo+8hfeOye7cXbZijjh+xHTrYiCqa0qeewghb+hk+fhwJhFhyyO
         UT4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8K4PrtN7OiONQx5lRLM4t8rDUMaxWp8v0q/xipOZJhQ=;
        b=ag308PsfH5/QUaOoPB1j8MwTw1qb1kf6fDdCnmlNNxyGHRkS+5pbLgngpCj3pt5/pb
         sPZJ/rcsE0VBsnNwiG1FnUJ7stANJhI0mgOWxCObKgwap6G6Wu/khE1pDLP9hN7YsyHR
         6o789JQEhY9gQjmuCmjm6UwXGyWkGqgwmGProTpYuhlxgaco7QgeT0hSqd5S+k4N/x2m
         kHVkrulwovhZHfo4ChXAWsRvm2Qk4WOLOpjaj1IQdHZpIqd1ILJnoic98kW4XxsJaS9o
         8prwZU5eYDrz1wLisfqpsWzpJ+CbyKyZlGBUTlAEiu4FXZyPeR8dkU2xuvYBQerZshUN
         25zg==
X-Gm-Message-State: AOAM530qFlX24TAQr6X63qMSLjQ4rQoqyQmRBe0oA4SUuSn2TdEmc03m
        F1UfxC+Q5kllPmYMLhUCYJSsXjIWpqF14HefMjvsSQ==
X-Google-Smtp-Source: ABdhPJwbJUHVLc9n11N5tQ+Sx1J70AO6/auS7KX7WvVSqARGdj7zxIcuHgPjpLy7waUrdkpGiU1JBpADebK25fFigLo=
X-Received: by 2002:a05:6830:791:: with SMTP id w17mr4311950ots.108.1632492846701;
 Fri, 24 Sep 2021 07:14:06 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20210924121457epcas5p39266266f9cef79177f2301a6a4f7d79a@epcas5p3.samsung.com>
 <1632485642-20625-1-git-send-email-manjeet.p@samsung.com>
In-Reply-To: <1632485642-20625-1-git-send-email-manjeet.p@samsung.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 24 Sep 2021 16:13:55 +0200
Message-ID: <CANpmjNMcgUsdvXrvQHn+-y1w-z-6QAS+WJ27RB2DCnVxORRcuw@mail.gmail.com>
Subject: Re: [PATCH] mm/kfence: Null check is added for return value of addr_to_metadata
To:     Manjeet Pawar <manjeet.p@samsung.com>
Cc:     glider@google.com, dvyukov@google.com, akpm@linux-foundation.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, r.thapliyal@samsung.com,
        a.sahrawat@samsung.com, v.narang@samsung.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Sept 2021 at 15:55, Manjeet Pawar <manjeet.p@samsung.com> wrote:
> This patch add null check for return value of addr_to_metadata().
> currently 'meta' is geting accessed without any NULL check but it is
> usually checked for this function.
>
> Signed-off-by: Manjeet Pawar <manjeet.p@samsung.com>

Your commit message does not make sense -- what bug did you encounter?

"usually checked for this function" is not a reason to add the check.
Adding a check like this could also hide genuine bugs, as meta should
never be NULL in __kfence_free(). If it is, we'd like to see a crash.

Did you read kfence_free() in include/linux/kfence.h? It already
prevents __kfence_free() being called with a non-KFENCE address.

Without a more thorough explanation, Nack.

Thanks,
-- Marco
