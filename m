Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA7242E83E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 07:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbhJOFHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 01:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbhJOFHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 01:07:46 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36312C061570;
        Thu, 14 Oct 2021 22:05:40 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id j12so1409121qkk.5;
        Thu, 14 Oct 2021 22:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J7E+ySUt0IP6s5yPl9p5TK7CMGdGMSyK+lCNwRqZdwc=;
        b=KQRULNlCzYx2te2lSPOF3+nT+fpoJb0xK9Cy469Fjixte15tNXDlmYjq26SxOB206Q
         SIa6RvHHm8D2RgIwHd0Yrzjx8zwoqmYaK4BlLpk3cRPJz31RDzHRspGWWwQEohzy4Cma
         bMREGnxppMeIiS+ht+uVd6FLicOzW5qf5vMJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J7E+ySUt0IP6s5yPl9p5TK7CMGdGMSyK+lCNwRqZdwc=;
        b=cUvbxP2jhCNngz+gK381XWGdB4wZ2b9QPwFJiygzaUoHp+118TISuVUrC5x+Py2Gld
         p1ZEWM9XL+XtYl1xPWLvW0LHUEK7dXLIg4pp8aIEH/LBCxEb1UtcgF24yxE1XtDf3d5g
         h1OeKU3RrABEDKcFvbEk5Dx7F7nEI6FGK/C240g4XQgg1NHJl71JBO+hPF1jVjSX2Q6a
         Tv/oHF43HfnsIH2NLgAR4JgOtb5PWozcrVP+d1ahM6c9wJJwEAIsFkNnuHFbfTo+j3op
         L2oEvN7nisrwqCNODooldv3lYXG2PKQ6tS+a3SuKfsbliC5xXzwNbogVygkgy9h8XRbS
         o1og==
X-Gm-Message-State: AOAM5324LuKD54+ScbkiSTo4ey2/CoTN4Ilk9ltu8Pas7LlkKpb3BLeE
        BoBYvLy/khkm4JxQqS7ZI/VVQuzMu5ILoiJ04sMXo6G2
X-Google-Smtp-Source: ABdhPJxl3h5W7e9msCVOntLw1RCNlx52YalpfzWdwLbr4MApfik9EfRJP64+UoBIRyvR26RlSWUGKPHN0J4lyi7obB8=
X-Received: by 2002:a05:620a:5e4:: with SMTP id z4mr7190031qkg.395.1634274339215;
 Thu, 14 Oct 2021 22:05:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210927155925.15485-1-eajames@linux.ibm.com> <20210927155925.15485-3-eajames@linux.ibm.com>
In-Reply-To: <20210927155925.15485-3-eajames@linux.ibm.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 15 Oct 2021 05:05:27 +0000
Message-ID: <CACPK8XfAL2-07M+ZWZ74X42Mvo8UvAdKPJ-51YWgKb_nzS-ffQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] fsi: occ: Store the SBEFIFO FFDC in the user
 response buffer
To:     Eddie James <eajames@linux.ibm.com>,
        Amitay Isaacs <amitay@ozlabs.org>
Cc:     linux-fsi@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org, Jeremy Kerr <jk@ozlabs.org>,
        Alistair Popple <alistair@popple.id.au>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Sept 2021 at 15:59, Eddie James <eajames@linux.ibm.com> wrote:
>
> If the SBEFIFO response indicates an error, store the response in the
> user buffer and return an error. Previously, the user had no way of
> obtaining the SBEFIFO FFDC.

How does this look for userspace?

Will existing userspace handle this?

>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
> Changes since v1:
>  - Don't store any magic value; only return non-zero resp_len in the error
>    case if there is FFDC
>
>  drivers/fsi/fsi-occ.c | 66 ++++++++++++++++++++++++++++++-------------
>  1 file changed, 47 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/fsi/fsi-occ.c b/drivers/fsi/fsi-occ.c
> index ace3ec7767e5..1d5f6fdc2a34 100644
> --- a/drivers/fsi/fsi-occ.c
> +++ b/drivers/fsi/fsi-occ.c
> @@ -55,6 +55,9 @@ struct occ {
>         int idx;
>         u8 sequence_number;
>         void *buffer;
> +       void *client_buffer;
> +       size_t client_buffer_size;
> +       size_t client_response_size;
>         enum versions version;
>         struct miscdevice mdev;
>         struct mutex occ_lock;
> @@ -217,6 +220,20 @@ static const struct file_operations occ_fops = {
>         .release = occ_release,
>  };
>
> +static void occ_save_ffdc(struct occ *occ, __be32 *resp, size_t parsed_len,
> +                         size_t resp_len)
> +{
> +       size_t dh = resp_len - parsed_len;

Is there any chance that parsed_len is larger than resp_len?

> +       size_t ffdc_len = (dh - 1) * 4;
> +       __be32 *ffdc = &resp[resp_len - dh];

Should you be checking that this number is sensible?

> +
> +       if (ffdc_len > occ->client_buffer_size)
> +               ffdc_len = occ->client_buffer_size;
> +
> +       memcpy(occ->client_buffer, ffdc, ffdc_len);
> +       occ->client_response_size = ffdc_len;
> +}
