Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD81354DAE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 09:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244225AbhDFHT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 03:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244248AbhDFHTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 03:19:11 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC30CC06174A;
        Tue,  6 Apr 2021 00:19:04 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id o5so14081626qkb.0;
        Tue, 06 Apr 2021 00:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F/E3mnw+SzAWsPtR8983X5bcPLQszmcwQkseH/FRIxE=;
        b=n1NsyGS59xz4/avvBAoukVFz+DmnFnS/dGPNcI/ARBec9MOzIk3pfGSnjXu3iM6wG6
         La4eM3roMAHX/ErXcGN9Gb+X2CtlAJ98uBZJHkJPibPIsy4FhU68QnEd6PjpoVhcxY1e
         n8ARJyrbIcpiaL6kMmnmtLCb7+0lmI45vep4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F/E3mnw+SzAWsPtR8983X5bcPLQszmcwQkseH/FRIxE=;
        b=P7cIIikKqTGY0A8VSELHn+XqAZK2S8IWsn1SxPvq/Mebtm4jQENFC70oQcYlVQtyBc
         NZSuRjG01YQGW8nvdVAkiVBo2vpGSONvQL8TzniJI61KGvDNKAKnjHf47Wdmj4SVd3xb
         07RLk1ZHhyIl6y4buCDrpQZ+2NN5kbMIpTufooCLdhcKSgTSfVGStZprEbShlKtB2Iq/
         XThLaSbcvUhoP6AZ9eF8N4CeuMyyogupEQRzZC9eVi0dFmXW0hmxLuXcXoKepWz0qYEf
         85OSvkHUcJ2YpNPHZg5NaNaIBmJNhod69gYYXIQ//3jqk6IWufq1StBdYMow0Og/eZV5
         ytTA==
X-Gm-Message-State: AOAM533Y9bIuxdxZpjlYojYT4vr45NMvyU+i5/+C7nI1RJjIICOBAg4U
        uN4ajV7cJcois0wWj+87gCaI+BsC/Cn0ZCSKEL3GG9IkLP8V0w==
X-Google-Smtp-Source: ABdhPJyjbYOH7FKhV0Jqs4iLqUsLd6cOJzjUYIrn9v60+oI4wHXMvb/JiJKlxzSG4DoiqVrkMRg715PevKSfuxSJBVI=
X-Received: by 2002:a37:a147:: with SMTP id k68mr28481817qke.66.1617693543360;
 Tue, 06 Apr 2021 00:19:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210209171235.20624-1-eajames@linux.ibm.com> <20210209171235.20624-2-eajames@linux.ibm.com>
In-Reply-To: <20210209171235.20624-2-eajames@linux.ibm.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 6 Apr 2021 07:18:51 +0000
Message-ID: <CACPK8XdahP1SfBVEkfQ3ivBeznv1RO=Qgw3msk=YB=DEyDuS6g@mail.gmail.com>
Subject: Re: [PATCH 1/4] fsi: occ: Don't accept response from un-initialized OCC
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

On Tue, 9 Feb 2021 at 17:12, Eddie James <eajames@linux.ibm.com> wrote:
>
> If the OCC is not initialized and responds as such, the driver
> should continue waiting for a valid response until the timeout
> expires.
>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

I guess we should add this too?

Fixes: 7ed98dddb764 ("fsi: Add On-Chip Controller (OCC) driver")


> ---
>  drivers/fsi/fsi-occ.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/fsi/fsi-occ.c b/drivers/fsi/fsi-occ.c
> index 10ca2e290655..cb05b6dacc9d 100644
> --- a/drivers/fsi/fsi-occ.c
> +++ b/drivers/fsi/fsi-occ.c
> @@ -495,6 +495,7 @@ int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
>                         goto done;
>
>                 if (resp->return_status == OCC_RESP_CMD_IN_PRG ||
> +                   resp->return_status == OCC_RESP_CRIT_INIT ||
>                     resp->seq_no != seq_no) {
>                         rc = -ETIMEDOUT;
>
> --
> 2.27.0
>
