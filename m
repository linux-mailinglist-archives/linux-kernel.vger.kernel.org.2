Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD72431CC01
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 15:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbhBPOe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 09:34:28 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:35856 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbhBPOeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 09:34:12 -0500
Received: by mail-ot1-f42.google.com with SMTP id 100so9154761otg.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 06:33:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a3J0pOhVqoouAqES+6flnoT27/qMn/K6JN5PDklQiBc=;
        b=fJ06IbQoxAtBZF8uwFu8GKQWpegFTEgDCHu0P+EGK+u/5XS9mT0tcwoh857kOqpWxw
         bnAha2tEu+/tJpH8MitsKiVmLxIzcIVhFp6SVfCLTlT0PZ/kPHnZJ8gG3ECHwYR2aPHu
         xfto33OF2lfL+TBijry99dJgtXie9oHvtMiOtqsszAvzyhIdMpA0uAbU1zcvD0CaFbuS
         i2hJMxL+qRjwwDn/cubv9Fwgb+oHN1brJRYPN/zdO3ig17+GYdpYGseVg0BNFvhnUYfo
         R09TJ7sjSAhZPQ+LD94/ChhSb6EQPdUA8zqfpin/JNE+Ir5XHDeOJkYwoUtqSj+lDlH6
         T3OA==
X-Gm-Message-State: AOAM532PTYz0PNky7O2o/93LzQN9bV7zCloW/9+nFyqX9nvC86Rg6ie7
        gtj8Oh5fLxoGe3RcfdiIBMOHw6ExU5CyNtr+l98=
X-Google-Smtp-Source: ABdhPJxIsteBx5buOK2kCnS6NRR0bo+fzAjsmyPdpkzPUXtXDjyBJymmrJIt1SzOfi2gZubCbd8kQ1oiTfMB2Wz7R18=
X-Received: by 2002:a9d:a2d:: with SMTP id 42mr15334833otg.321.1613486010971;
 Tue, 16 Feb 2021 06:33:30 -0800 (PST)
MIME-Version: 1.0
References: <20210216142400.3759099-1-gregkh@linuxfoundation.org>
In-Reply-To: <20210216142400.3759099-1-gregkh@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 16 Feb 2021 15:33:19 +0100
Message-ID: <CAJZ5v0hC7q59ZBNtLTqsZ3soszO9ect6bPpYGrYRPOKcWO_xpg@mail.gmail.com>
Subject: Re: [PATCH 1/2] driver core: component: remove dentry pointer in
 "struct master"
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 16, 2021 at 3:24 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> There is no need to keep around a pointer to a dentry when all it is
> used for is to remove the debugfs file when tearing things down.  As the
> name is simple, have debugfs look up the dentry when removing things,
> keeping the logic much simpler.
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/base/component.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/base/component.c b/drivers/base/component.c
> index dcfbe7251dc4..272ba42392f0 100644
> --- a/drivers/base/component.c
> +++ b/drivers/base/component.c
> @@ -65,7 +65,6 @@ struct master {
>         const struct component_master_ops *ops;
>         struct device *dev;
>         struct component_match *match;
> -       struct dentry *dentry;
>  };
>
>  struct component {
> @@ -125,15 +124,13 @@ core_initcall(component_debug_init);
>
>  static void component_master_debugfs_add(struct master *m)
>  {
> -       m->dentry = debugfs_create_file(dev_name(m->dev), 0444,
> -                                       component_debugfs_dir,
> -                                       m, &component_devices_fops);
> +       debugfs_create_file(dev_name(m->dev), 0444, component_debugfs_dir, m,
> +                           &component_devices_fops);
>  }
>
>  static void component_master_debugfs_del(struct master *m)
>  {
> -       debugfs_remove(m->dentry);
> -       m->dentry = NULL;
> +       debugfs_remove(debugfs_lookup(dev_name(m->dev), component_debugfs_dir));
>  }
>
>  #else
> --
> 2.30.1
>
