Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F331A326900
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 22:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbhBZU4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 15:56:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbhBZU4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 15:56:18 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB86C061756
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 12:55:37 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id do6so17000429ejc.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 12:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=luqx3cU12gW6l31P+oloN1EmDovQOrEz+j/E4ZvRIEo=;
        b=N7R0KM77yXb5Q4ragmQ+c1Y18LNttK0H8Cf8chtF14NxpHhnVDeUleN04i4hEhbR39
         UqiPg2hPKRLhazAGbUZ2TXVYGcOWmxqVDPigh59vyQmi0wpK9Mr91l059lpTPnmQqfQo
         bSFd/tb6HrzZfMhv5XrmNopU/03Z5fm+xgPxkiQdjc6tB60kpV+AU3jpq+HYgh9YDr5/
         JQJWihoPjw+V5WP33x63wwKHUWc42EixYD45J/Zx6H4Af/gNIfRHLORqGp6ghPnsaAzA
         oTYgdy5TFzXMi7lH4f+Fkai9dMUGP6TUwiLbdRQFofkI5qMJ7iEjWQGqTcs4J1X5FzwN
         jMLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=luqx3cU12gW6l31P+oloN1EmDovQOrEz+j/E4ZvRIEo=;
        b=sJzc9hyU6H7GaW90d6s9vtgOoY53dvfg/TN4Fb9IVluTEvNKgSOiRksmGDnM7Qy9zo
         PidT0Ze8yQYFJvvHWZ8xlQA9wtUS/wGsTJIEYL2Mku9TsmWFCTCDHT93X3xF86WRcXfy
         TVX+SFH7x+j5nkSfeunl3Ec39PTngKCMte6Jhr6ow1BS+x+508Pwu8IDxlTxGlj2uOCJ
         oi18K7JM/FEzaPF6pqjydoRxRYnqmJgQZ2EVUddu9V+cqoluqMw4My3rlD32ArYeSSyp
         TQcsEQj1yV2Vwv19G+ZUqm/7hDk/OykFyfJyELaPdHyewiqUkMdEQcPap3aA/thkerqm
         Ev3w==
X-Gm-Message-State: AOAM532GgRJu3H7mZZar/ElqNRn6Qm9KUoETBsg2QnZGf4gqRkIK6FTy
        wSxYk+TCPS2yIEXhBXmYjhgFdBQ4FwHlm9Q/mrXQ/w==
X-Google-Smtp-Source: ABdhPJwqQp9Aelw/XXCeN0Yu1s0zfwetVb/ScUA0ulc18ycRDHuH7TtrBNR/oZNq1kKDTKCfrG1kl+t9Gk3A4ucH0w8=
X-Received: by 2002:a17:906:ae88:: with SMTP id md8mr5230087ejb.264.1614372936636;
 Fri, 26 Feb 2021 12:55:36 -0800 (PST)
MIME-Version: 1.0
References: <20210226204552.45399-1-konrad.wilk@oracle.com> <20210226204552.45399-2-konrad.wilk@oracle.com>
In-Reply-To: <20210226204552.45399-2-konrad.wilk@oracle.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 26 Feb 2021 12:55:25 -0800
Message-ID: <CAPcyv4iXhsOK0ZdHuHkQ-FwZbvT6H2M+FHRoZVr=Pv8SUdpT+g@mail.gmail.com>
Subject: Re: [PATCH] cxl: Make loop variable be 'i' instead of 'j'
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     "Schofield, Alison" <alison.schofield@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 12:46 PM Konrad Rzeszutek Wilk
<konrad.wilk@oracle.com> wrote:
>

Hey, Konrad, thanks for fixing this up. Some more cosmetic changes to
fold in below...

> .. otherwise people spend extra cycles looking for the
> inner loop and wondering 'why j'?
>
> This was an over-sight when initial work was rebased

s/over-sight/oversight/

> so lets fix it here.

s/lets/let's/

> Fixes: 583fa5e71cae ("cxl/mem: Add basic IOCTL interface")

Since it's just cosmetic, I don't think it needs a "Fixes:". The
AUTOSEL-bot need not worry about this.

> Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> ---
>  drivers/cxl/mem.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 244cb7d89678..2b8265b03b0d 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -698,7 +698,7 @@ static int cxl_query_cmd(struct cxl_memdev *cxlmd,
>         struct device *dev = &cxlmd->dev;
>         struct cxl_mem_command *cmd;
>         u32 n_commands;
> -       int j = 0;
> +       int i = 0;

Let's move this initialization down to right before the loop. If this
ever gets refactored and @i gets reused this will break.

>
>         dev_dbg(dev, "Query IOCTL\n");
>
> @@ -716,10 +716,10 @@ static int cxl_query_cmd(struct cxl_memdev *cxlmd,
>         cxl_for_each_cmd(cmd) {
>                 const struct cxl_command_info *info = &cmd->info;
>
> -               if (copy_to_user(&q->commands[j++], info, sizeof(*info)))
> +               if (copy_to_user(&q->commands[i++], info, sizeof(*info)))
>                         return -EFAULT;
>
> -               if (j == n_commands)
> +               if (i == n_commands)
>                         break;
>         }
>
> --
> 2.13.6
>
