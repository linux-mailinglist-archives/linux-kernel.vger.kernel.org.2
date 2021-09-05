Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E62D400F1F
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Sep 2021 12:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237669AbhIEKat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 06:30:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:55320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233851AbhIEKas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 06:30:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C8E3661004;
        Sun,  5 Sep 2021 10:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630837785;
        bh=SQnamrSfmWm1+VwrX7zKerM9TE/6wIgo7gLmeG25mgk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oZllOPHKE5ITiaFi1rELaXaTzxoeyZuurtMzM8cLRDtU24ENlwnnC0gCBSx7TNAfF
         QMAbZa1U33eFqSQVQ8XlWn6BqTWtR5v7dAJhdUZ5LWS72Ahy2PC82KoNOdFD34IoCZ
         uCxrOngeuFeLQdUZsy8Rq4NvYwf+vevlPuBDzGFvRcJKzFXR3jNZEUWhevwHALd7ci
         ujFaVe6qVMVrGtagGwT8qDGQSaBYoju/iwKxG59p1QGlQPH1WvvBdAGNrLhvxwoOCR
         VUMtGXsLz/tv+XcxM9T9exOF6xoBrmwWQE95h3d5soIqXRy+pAHeHkApowvGHTJI6/
         KSJb00cqDR/cg==
Received: by mail-oi1-f173.google.com with SMTP id w19so5042845oik.10;
        Sun, 05 Sep 2021 03:29:45 -0700 (PDT)
X-Gm-Message-State: AOAM532/HMqAo0qeJhoGVl0ZoICQKOmhxmeLlOGYcSMYpI9SB6zl+yOx
        sKmFL0jhRJytEC1ToqSJSNMf6sXJ6zFdDFoUloM=
X-Google-Smtp-Source: ABdhPJyozsCCAejJVqJAJs6Qufm3Ly5L2PjLRe1v2Lqo9sBFKepwCxpwHhDYtsJUtQt18xHXcX/dIZyhmMJpWp/6K1I=
X-Received: by 2002:a05:6808:2193:: with SMTP id be19mr5074187oib.102.1630837785219;
 Sun, 05 Sep 2021 03:29:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210903080203.6136-1-colin.king@canonical.com>
In-Reply-To: <20210903080203.6136-1-colin.king@canonical.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Sun, 5 Sep 2021 13:29:18 +0300
X-Gmail-Original-Message-ID: <CAFCwf11PPvjg0vCoY2HUhnEwYYf+DPFPm-4=GW9rxt61VB+kRQ@mail.gmail.com>
Message-ID: <CAFCwf11PPvjg0vCoY2HUhnEwYYf+DPFPm-4=GW9rxt61VB+kRQ@mail.gmail.com>
Subject: Re: [PATCH][next] habanalabs: Fix spelling mistake "FEADBACK" -> "FEEDBACK"
To:     Colin King <colin.king@canonical.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel-janitors@vger.kernel.org,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 3, 2021 at 11:02 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in a literal string. Fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/misc/habanalabs/gaudi/gaudi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
> index 383865be3c2c..1d5fcca1ee0c 100644
> --- a/drivers/misc/habanalabs/gaudi/gaudi.c
> +++ b/drivers/misc/habanalabs/gaudi/gaudi.c
> @@ -395,7 +395,7 @@ static struct hl_hw_obj_name_entry gaudi_so_id_to_str[] = {
>
>  static struct hl_hw_obj_name_entry gaudi_monitor_id_to_str[] = {
>         { .id = 200, .name = "MON_OBJ_DMA_DOWN_FEEDBACK_RESET" },
> -       { .id = 201, .name = "MON_OBJ_DMA_UP_FEADBACK_RESET" },
> +       { .id = 201, .name = "MON_OBJ_DMA_UP_FEEDBACK_RESET" },
>         { .id = 203, .name = "MON_OBJ_DRAM_TO_SRAM_QUEUE_FENCE" },
>         { .id = 204, .name = "MON_OBJ_TPC_0_CLK_GATE" },
>         { .id = 205, .name = "MON_OBJ_TPC_1_CLK_GATE" },
> --
> 2.32.0
>

Thanks!
Applied to -fixes
Oded
