Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAF03997FC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 04:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbhFCCWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 22:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhFCCWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 22:22:18 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA61C06174A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 19:20:34 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id o9so4091930ilh.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 19:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uB50XVLqLm8HgEti+PdVVEanfFXkb0FvvSIprZT7Pmc=;
        b=pqgesQYtxRDsI2ENE1Hf2iP1rslYHeLh9dKf3KcTzocC5PPt1KvtZqriKLahqP6ocC
         DTlH0pmxr3jk0jWShApCe0Rh+vq4b9gj1jp1BcySAd9VJyjd5yygfGjYappzYApIehaC
         e2zvrEPl+g7MXJO4MuyIGMI0s1C76TqR4XSOdFohoENUdkstKxfEjMCdNKsmyZ7VH35Z
         +Whj4PbzFHpMJ8b6zXoUYGHMnpIZNKznH8orRyjvPTQICPX0Rj8A/LRP8MHW+sj8of+N
         nOeL/A1Uz1PODa53CUto/QuLRQN8R7IrC6QQSEdz8MVhDcwXgShOZhCH+o3zSFuliFAO
         ZGmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uB50XVLqLm8HgEti+PdVVEanfFXkb0FvvSIprZT7Pmc=;
        b=J8hvEprPMq6N2HvUWWRkmo6hMk1XJ8U+v4ZexhxbuZRyRuqJnBm2Z9pQ+RqxFGBehT
         jY6yg6/cgxfzF/ojngeFr5E6KTeQRP4VYSD2kaQIr9Wirn4Hzm93lUGVp9Vg/wzmvRaP
         FCCcDviv92jzGoLXYLS8mevg9EBaOf3xgx6OuHc7UwSFVAYiDi7Y/Lr9p4RQqjfH54Ey
         QtveFHHb5q3e4ReMc5s0rEhKGbYjW2Z2GKn5UNXZHRrKGh3Z2AccmRXXpeUvVAy9SUeU
         xudsEzoNtMwno4f8PvZEbefl+ndxk7SfzBWE6wNY1QvqMpZqUQb8vyaAuYk2Z8mJQx3o
         3UrQ==
X-Gm-Message-State: AOAM533iCs0k+unfYfAcnWr6kiueKtiYh/hIzXBbyN4LLLWo2E4km/5s
        DVHBLDSGeLN8zL2x1CitgiMBnBJGQJoHOKTm1Dlpik0G
X-Google-Smtp-Source: ABdhPJyXjJ3EB1RDhPa7UUNEDEKAZBp9HGtFcFRcykIWQUhg2XlT34SUU4HrBaISJ+KGapmR3oEl8Wq8rcP4cHQB9OE=
X-Received: by 2002:a05:6e02:5ce:: with SMTP id l14mr5217919ils.94.1622686832443;
 Wed, 02 Jun 2021 19:20:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210602111655.3808580-1-jwi@linux.ibm.com>
In-Reply-To: <20210602111655.3808580-1-jwi@linux.ibm.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Thu, 3 Jun 2021 10:20:20 +0800
Message-ID: <CAJhGHyCq8Zy65XpnH1gFPQKq4+q3GbVAFtpvwz0+mHYqKgaXjw@mail.gmail.com>
Subject: Re: [PATCH wq/for-next 1/2] workqueue: replace open-coded work_pending()
To:     Julian Wiedmann <jwi@linux.ibm.com>
Cc:     Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For both of these patches

Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>


On Wed, Jun 2, 2021 at 7:17 PM Julian Wiedmann <jwi@linux.ibm.com> wrote:
>
> Use the right helper to check whether a work item is currently pending.
>
> Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
> ---
>  kernel/workqueue.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 50142fc08902..8a700ccfa313 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -3209,7 +3209,7 @@ EXPORT_SYMBOL(flush_delayed_work);
>   */
>  bool flush_rcu_work(struct rcu_work *rwork)
>  {
> -       if (test_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(&rwork->work))) {
> +       if (work_pending(&rwork->work)) {
>                 rcu_barrier();
>                 flush_work(&rwork->work);
>                 return true;
> --
> 2.25.1
>
