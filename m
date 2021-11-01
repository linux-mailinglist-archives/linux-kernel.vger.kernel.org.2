Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E941441E2F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 17:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbhKAQcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 12:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbhKAQcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 12:32:12 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C664C061764
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 09:29:39 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 71-20020a9d034d000000b00553e24ce2b8so21374959otv.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 09:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yMztWhCfAglGK8Jqxt8H7Nu8Sfhj9gYl1BXkqqHvdrI=;
        b=lAYyI2ghDFVS9OBei65Ta5hFe+Z0ZJweRC/wAmqcFmOBwl6ROV11QfgoWgXTbVIpo/
         3fL3otK9p4xv+bxJgry4JL0PERXg2IiYuE19n35+a0L40hZR3yv+kVhSqihA3oNOWqsq
         Gxat2zgmufRGJweJydGDlvbRCXCTGVJOz1pEu71RgZ+zQDYEn/SstiaOtHYmuxyMm99l
         Tik+gYRe4NGeIvGNV+nmU6nbj+kU1QbXQF/hOlBE92e0lm7u25rZaPISY+rkrtPn+Fvc
         qX6E3v7VrL/MSyV12axvnRhh2IdVF169IHX+SiuC1Dr67PvVQUO4sGq4/v/jEUYCJZ17
         5wiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yMztWhCfAglGK8Jqxt8H7Nu8Sfhj9gYl1BXkqqHvdrI=;
        b=5MDvuE3/3x2s5pcEBb7diyZvCsoiU/IVc+ZwZD6PoB81YKXNfA/uybOIHYv5s6Ycbt
         Gz8trKkBgaeuDS6j8k8lRsbQJyOmGycN3Vb65h3Q4orayYd7yk2x6GQiNjwA5zRqz05W
         zL1BARpppgKU9socXjAV1xslAdlkJ/BVehz6zP6wjqB9zhz40RZDfhfkEBTzDv/3pPkd
         Av4hsmRqLU9VDvR3ryLTDiO8LUTsELDy4kjjXTPvT21AiK+gEq1DR5fxO3gac3IuzgdY
         Qu4A2XE56PTk+SMwHmIMsu7X9xSXWnQVlVdmX4CEc2Xc0bvYE5EA5o5ynMvo9jXW5rq9
         GcPA==
X-Gm-Message-State: AOAM532qmzQp/znxbdvOimHWdeelMcz1prpVrVpImEY0gSgeiyZ384W5
        zFeDUQZIysPskpJjKsDTaH1/6FpV12NmMEjDIJQ+2A==
X-Google-Smtp-Source: ABdhPJy2kvGCpYG33j1mPhUCgVfVhwpEW5luRD+s/g/rEeYuypcAKOAFRoqudgXNk1+DB0HCsuY6IGyfAxvDh2BkGek=
X-Received: by 2002:a9d:171b:: with SMTP id i27mr20596402ota.25.1635784178082;
 Mon, 01 Nov 2021 09:29:38 -0700 (PDT)
MIME-Version: 1.0
References: <20211028175749.1219188-1-pgonda@google.com> <20211028175749.1219188-4-pgonda@google.com>
In-Reply-To: <20211028175749.1219188-4-pgonda@google.com>
From:   Marc Orr <marcorr@google.com>
Date:   Mon, 1 Nov 2021 09:29:27 -0700
Message-ID: <CAA03e5FV5FRFJm4K8WyL745B84URz65LVMNagi=LPFKP35xJGg@mail.gmail.com>
Subject: Re: [PATCH 3/4] crypto: ccp - Refactor out sev_fw_alloc()
To:     Peter Gonda <pgonda@google.com>
Cc:     Thomas.Lendacky@amd.com, David Rientjes <rientjes@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        John Allen <john.allen@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 10:58 AM Peter Gonda <pgonda@google.com> wrote:
>
> Creates a helper function sev_fw_alloc() which can be used to allocate
> aligned memory regions for use by the PSP firmware. Currently only used
> for the SEV-ES TMR region but will be used for the SEV_INIT_EX NV memory
> region.
>
> Signed-off-by: Peter Gonda <pgonda@google.com>
> Acked-by: David Rientjes <rientjes@google.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Brijesh Singh <brijesh.singh@amd.com>
> Cc: Marc Orr <marcorr@google.com>
> Cc: Joerg Roedel <jroedel@suse.de>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: David Rientjes <rientjes@google.com>
> Cc: John Allen <john.allen@amd.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Paolo Bonzini <pbonzini@redhat.com> (
> Cc: linux-crypto@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/crypto/ccp/sev-dev.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
> index e4bc833949a0..b568ae734857 100644
> --- a/drivers/crypto/ccp/sev-dev.c
> +++ b/drivers/crypto/ccp/sev-dev.c
> @@ -141,6 +141,21 @@ static int sev_cmd_buffer_len(int cmd)
>         return 0;
>  }
>
> +static void *sev_fw_alloc(unsigned long len)
> +{
> +       const int order = get_order(len);
> +       struct page *page;
> +
> +       if (order > MAX_ORDER-1)
> +               return NULL;
> +
> +       page = alloc_pages(GFP_KERNEL, order);
> +       if (!page)
> +               return NULL;
> +
> +       return page_address(page);
> +}
> +
>  static int __sev_do_cmd_locked(int cmd, void *data, int *psp_ret)
>  {
>         struct psp_device *psp = psp_master;
> @@ -1076,7 +1091,6 @@ EXPORT_SYMBOL_GPL(sev_issue_cmd_external_user);
>  void sev_pci_init(void)
>  {
>         struct sev_device *sev = psp_master->sev_data;
> -       struct page *tmr_page;
>         int error = 0, rc;
>
>         if (!sev)
> @@ -1092,14 +1106,10 @@ void sev_pci_init(void)
>                 sev_get_api_version();
>
>         /* Obtain the TMR memory area for SEV-ES use */
> -       tmr_page = alloc_pages(GFP_KERNEL, get_order(SEV_ES_TMR_SIZE));
> -       if (tmr_page) {
> -               sev_es_tmr = page_address(tmr_page);
> -       } else {
> -               sev_es_tmr = NULL;
> +       sev_es_tmr = sev_fw_alloc(SEV_ES_TMR_SIZE);
> +       if (!sev_es_tmr)
>                 dev_warn(sev->dev,
>                          "SEV: TMR allocation failed, SEV-ES support unavailable\n");
> -       }
>
>         /* Initialize the platform */
>         rc = sev_platform_init(&error);
> --
> 2.33.1.1089.g2158813163f-goog
>

Reviewed-by: Marc Orr <marcorr@google.com>
