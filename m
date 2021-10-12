Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF24429C1B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 05:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbhJLDyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 23:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbhJLDyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 23:54:11 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B27EC06161C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 20:52:10 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id e63so6725111oif.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 20:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NNPWVTmqHYYTheYoSyfxxd70F0Xp/FkM4mnuo5eePh0=;
        b=Aafsrr68iA9HKOpovZYb3GwJ7kFdbOwwUutpvy65Heo/oUWK7hT8w/2EOMzfYx1ETg
         8kC2njZBYZba9QtrQe/KlQtRs2ZeroOZaeeweFhy/y8C/2/YLAbeVibPSo9OX4e8mEj/
         zhI3HQXgLx/06hX27ILWtCgMNQZFCePsu1naAcLw7seDhI/404gHkjMbE7yv27r/NWMZ
         hgsyD7Gg1cjBrycJZmLjdvS2w4iUlEkfY7zvWkGvuTPWA0aS1nZMuHvU8jcNI7uWEw85
         dwKt5uygQJzRMDYKhzV9cz7K2RgDWB7glJZJbnEYZEe0oQbM56RH0N7S3a8bY2AS4cRx
         EN8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NNPWVTmqHYYTheYoSyfxxd70F0Xp/FkM4mnuo5eePh0=;
        b=b+MTCBT/eD2sJshYhzWXh1VgIChO4Nv8U2EJE1oQBzojnhmUHbY9BWcI4ODGxC18nh
         eAilP9lG3gpJJRWrHkJyLXmKgShGlo6ezw9EwAKxy2N/JovNMDx55fMTyG6IftZfisJC
         IAIw4t+rp+Uf4G5LtGna3gFpimVdjkKsHscmozSmuuiaXaoWu/U6WgRocA3bsWqo9fAZ
         i4M/xlHvBzFgKGPFtlWt+cyoYUhxurMXzFjMOsq7hk7SaMXQmKNGeKKaUbpoe6zIjNXx
         vrAgJiaVjZAMrf0iJoZHKKtdOKvaHFHA60bQ5xtok14sYZZAqtCWGtKXMSOPDzhp2MAR
         kz1g==
X-Gm-Message-State: AOAM532OUAk9+IIiDjnKzUW2Mi+Az3XLpgMrxRJirsy8Ju7GWImRCB+K
        mO63hFbcov9V6OlnxAE18oe2ubQTUNhkDT/nEKZjtA==
X-Google-Smtp-Source: ABdhPJxrsw8hZgQ17Pfd5WjtGczHNNxErYfA32GKaC+oGiaig0ERN8ozmo0XbR+Chdm0f76r1y2PoRoQm+ZyoEMj4yY=
X-Received: by 2002:a05:6808:60f:: with SMTP id y15mr2021986oih.15.1634010729756;
 Mon, 11 Oct 2021 20:52:09 -0700 (PDT)
MIME-Version: 1.0
References: <20211005195131.2904331-1-pgonda@google.com>
In-Reply-To: <20211005195131.2904331-1-pgonda@google.com>
From:   Marc Orr <marcorr@google.com>
Date:   Mon, 11 Oct 2021 20:51:58 -0700
Message-ID: <CAA03e5FwivgMOuRugaAwiVHL9NEX5HnqcOiVaMjvuZq=JhWv0Q@mail.gmail.com>
Subject: Re: [PATCH] crypto: ccp - Fix whitespace in sev_cmd_buffer_len()
To:     Peter Gonda <pgonda@google.com>
Cc:     "Lendacky, Thomas" <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Rientjes <rientjes@google.com>,
        John Allen <john.allen@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 5, 2021 at 12:51 PM Peter Gonda <pgonda@google.com> wrote:
>
> Extra tab in sev_cmd_buffer_len().
>
> Signed-off-by: Peter Gonda <pgonda@google.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Brijesh Singh <brijesh.singh@amd.com>
> Cc: Marc Orr <marcorr@google.com>
> Cc: Joerg Roedel <jroedel@suse.de>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: David Rientjes <rientjes@google.com>
> Cc: John Allen <john.allen@amd.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: linux-crypto@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/crypto/ccp/sev-dev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
> index 2ecb0e1f65d8..e09925d86bf3 100644
> --- a/drivers/crypto/ccp/sev-dev.c
> +++ b/drivers/crypto/ccp/sev-dev.c
> @@ -134,7 +134,7 @@ static int sev_cmd_buffer_len(int cmd)
>         case SEV_CMD_DOWNLOAD_FIRMWARE:         return sizeof(struct sev_data_download_firmware);
>         case SEV_CMD_GET_ID:                    return sizeof(struct sev_data_get_id);
>         case SEV_CMD_ATTESTATION_REPORT:        return sizeof(struct sev_data_attestation_report);
> -       case SEV_CMD_SEND_CANCEL:                       return sizeof(struct sev_data_send_cancel);
> +       case SEV_CMD_SEND_CANCEL:               return sizeof(struct sev_data_send_cancel);
>         default:                                return 0;
>         }
>
> --
> 2.33.0.800.g4c38ced690-goog
>

Reviewed-by: Marc Orr <marcorr@google.com>
