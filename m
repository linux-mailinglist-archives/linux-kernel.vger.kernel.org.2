Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F67F354DBD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 09:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244264AbhDFHVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 03:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233867AbhDFHVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 03:21:39 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC622C06174A;
        Tue,  6 Apr 2021 00:21:30 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id g24so10483928qts.6;
        Tue, 06 Apr 2021 00:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aaECJtyHrwCrmwmUkMpyb/gK8YTqTtwgL5h0zup5Z5c=;
        b=hQ8HAf1GhqPA8G4ZZh1+4aNbdg33gNWNfGUlPDLellRazUbljOUKOF8AZFDJ7P9Kmy
         rAKfnqX2F9hphJdHkS3j8m3T3fRqr3OY7McUEauzqlBNAhkJy/8UTslZa+aae3sbixg+
         IerLKIaxzrwsJLUcsYRKeAKDA4pjwg8m+CPpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aaECJtyHrwCrmwmUkMpyb/gK8YTqTtwgL5h0zup5Z5c=;
        b=GegCUo1VoN2wMtwVAp8mTD+1VmUXhK3HBlhKWZ3mSqB+25MU8idSqGka8wrkzKCFqk
         1OXW5WJBS+cCzz4anpRj0sAf9PMv22/xMNRJaLWhULYrZc/DRCNj8wgUIRv38whyxEFk
         FtR+v/fou1mvLJaTk8Ve0M67e2DqSltilhmJW+0m2Wqueri2agYdTrWViiDXELm4hYdA
         7FiitcSvL4sVDmpB/OhnD0gK3BC8JFU3MaosAShjvpnPUzIVRgkaLnjlolWwc7bn6rzD
         eqQqzL4GOz/Y0JHmEFZjhPxUMWPpUL4JOF+/hMXN8J6qI3ZrvdensZl0pQkZX+RNk0Un
         /T3g==
X-Gm-Message-State: AOAM5310VDvsxRSauf7YTBjfY1Gm3QkytbB0gI6uL+cs1kLT7Afs9q65
        AsdKv8R//ZTgtzVDGdKrNT3z6kbD+/ZLxZi5Agw=
X-Google-Smtp-Source: ABdhPJyIZqS8C6OGtyWKccIESTnghs9ucvap1xm0KKnyu2I/V8r6Xcdh1ZS7CWVl3SnXcTYRaiq9lk942QP07LqPiZE=
X-Received: by 2002:ac8:7fc1:: with SMTP id b1mr26335902qtk.363.1617693687587;
 Tue, 06 Apr 2021 00:21:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210209171235.20624-1-eajames@linux.ibm.com> <20210209171235.20624-3-eajames@linux.ibm.com>
In-Reply-To: <20210209171235.20624-3-eajames@linux.ibm.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 6 Apr 2021 07:21:15 +0000
Message-ID: <CACPK8XdbCpqqotgKtX+8_T8rBwrkLQiQuJSxPiDg7jwh8nF2CQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] fsi: occ: Log error for checksum failure
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-hwmon@vger.kernel.org, linux-fsi@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Alistair Popple <alistair@popple.id.au>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Feb 2021 at 17:13, Eddie James <eajames@linux.ibm.com> wrote:
>
> Log an error if the response checksum doesn't match the
> calculated checksum.

Reviewed-by: Joel Stanley <joel@jms.id.au>

>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  drivers/fsi/fsi-occ.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/fsi/fsi-occ.c b/drivers/fsi/fsi-occ.c
> index cb05b6dacc9d..524460995465 100644
> --- a/drivers/fsi/fsi-occ.c
> +++ b/drivers/fsi/fsi-occ.c
> @@ -223,7 +223,8 @@ static const struct file_operations occ_fops = {
>         .release = occ_release,
>  };
>
> -static int occ_verify_checksum(struct occ_response *resp, u16 data_length)
> +static int occ_verify_checksum(struct occ *occ, struct occ_response *resp,
> +                              u16 data_length)
>  {
>         /* Fetch the two bytes after the data for the checksum. */
>         u16 checksum_resp = get_unaligned_be16(&resp->data[data_length]);
> @@ -238,8 +239,11 @@ static int occ_verify_checksum(struct occ_response *resp, u16 data_length)
>         for (i = 0; i < data_length; ++i)
>                 checksum += resp->data[i];
>
> -       if (checksum != checksum_resp)
> +       if (checksum != checksum_resp) {
> +               dev_err(occ->dev, "Bad checksum: %04x!=%04x\n", checksum,
> +                       checksum_resp);

Just confirming that this is unexpected, we won't see this eg. if the
system is booting or when the BMC is reset while the host is running?

>                 return -EBADMSG;
> +       }
>
>         return 0;
>  }
> @@ -533,7 +537,7 @@ int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
>         }
>
>         *resp_len = resp_data_length + 7;
> -       rc = occ_verify_checksum(resp, resp_data_length);
> +       rc = occ_verify_checksum(occ, resp, resp_data_length);
>
>   done:
>         mutex_unlock(&occ->occ_lock);
> --
> 2.27.0
>
