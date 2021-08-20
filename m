Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF4543F2F83
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 17:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241070AbhHTPd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 11:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241033AbhHTPd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 11:33:26 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEE0C061575
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 08:32:48 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id a13so12761776iol.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 08:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7l8H8Y0rF80m7YqaAzVc3GzuPRr7dFgVXX3tlciBEAU=;
        b=odsNVhpNdv4vMzIXtXNzorCOSEg1XTOmlY/Zpt4SYivx7wZOXCnVARLBzUoRi7DpF8
         O9UQQLCVWoX2zUe2/oeUu7/OdyTGRNa5U1M5PittB9xoxi+OZ0Lid3kCULq0f7rp7K/w
         SH3ck1hEia0CRBNGqhxxqU1658MGbT5vzoR4igyhBAerKgKVabAX3qVh9InOrvGncW4Z
         byJGTeGEpz3EfS1hbP+CBfB8S6iXizagU/EO33J9jogPERqbmfXVLDt0SxbJH9H8vm4X
         +cZwh+Sf4OO4v+P6wXk7WFmb7xBs+wkvoF+OrLVUtnHjjFDjqR9En/S0w1qQXIQfSz68
         Quqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7l8H8Y0rF80m7YqaAzVc3GzuPRr7dFgVXX3tlciBEAU=;
        b=AhvjRO8LqnyGksntt5nLYaqHakA6KULJd2HZGnjyb2rP56mbGQZsPPq4gYgVAS0X4H
         KEfuFmrZ/SC37MviVN0xWOYr+r58MwAyKyzrtf6tU/XwDqhJLQPq8gqTFxsFi9hvEMsw
         S/BqKVUhw9O3oFN27w1mgWXa0fxrTMOj7gUaM3JOELTeOsWfaNbHd5POE9MUY8aXu7x4
         8S+qxHYWOO8Qblx8iudBW5JhT0sLLcKNDsrP6AXufz08wqwTvxm0sgUpSnffItz7jLcF
         QD/IdeWsvuTXZY95by9SeQmt+aQBWvCUGXkBzDegaaD+dtIpYYv2kSjxF+wxBJb+cnww
         qkrw==
X-Gm-Message-State: AOAM530y3SFFl9wpc0BgVAYtAxWVyuSXxp1jA2wC40lVL0oXp3xknO2B
        eu3bWha+bcrYTaSSBaehzZv7pdq9QzLzWnSmjcWH3qqN2/g=
X-Google-Smtp-Source: ABdhPJx3tlhhuzmh/GzSkvYT8uFEH2egsx9NxHFdVczyQLSaP/fTto+ctMD+aok0FcRL8HbxzruphblClTLGOPezg5M=
X-Received: by 2002:a05:6638:974:: with SMTP id o20mr18123410jaj.10.1629473567039;
 Fri, 20 Aug 2021 08:32:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210701065735.159336-1-joyce.ooi@intel.com>
In-Reply-To: <20210701065735.159336-1-joyce.ooi@intel.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Fri, 20 Aug 2021 10:32:36 -0500
Message-ID: <CABb+yY0MAkZc8qgZ09VxiiDWhMJBzzws32njJG0k4XY19nuHwQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Replace Ley Foon Tan as Altera Mailbox maintainer
To:     Joyce Ooi <joyce.ooi@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ley Foon Tan <lftan.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 1, 2021 at 1:58 AM Joyce Ooi <joyce.ooi@intel.com> wrote:
>
> This patch replaces Ley Foon Tan as Altera Mailbox maintainer as she has
> moved to a different role.
>
> Signed-off-by: Joyce Ooi <joyce.ooi@intel.com>
> ---
I am sure it's all legit, but there hasn't been an Ack yet from Lee Foon Tan.
Ideally this patch should come from the original maintainer asking
them to be replaced by the new maintainer, followed by ack from the
nominated maintainer.
In this case, at least an ack from Lee Foon Tan is required.

cheers.
