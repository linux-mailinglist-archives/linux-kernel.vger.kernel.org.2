Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE1C45E1F5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 22:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242097AbhKYVOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 16:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233583AbhKYVMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 16:12:36 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94AEC06175E;
        Thu, 25 Nov 2021 13:07:35 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id z8so14727080ljz.9;
        Thu, 25 Nov 2021 13:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fDWVlGc9bkfdx0uGoZEsq0fC8zJhCxYYZIKbBpnGA24=;
        b=AEN2AeDMq5pd5sT+WTKPV6Ck8A2r0WdZyPZ/BTTvBFM9W3KRgcQS40P9g9m2HPwbWK
         56oYBQb9QqEbwy//ALKtx869/tFjcbpTTxaGVb9Agc29MUK/CR6YzXiAb55KXfurgkKs
         uf9Tnkm8gb7qy0ohdwIgRuBf2+g0z1eUnhnHNVWRZq6eW+qpGGPq/ydqWB6lk4eG1NYH
         VUSwirp1RfInXfko4Eob3zBr61jiY5qkRm09/abMq6hKjx5GxGxhobQvNrkY57mJScp3
         tnWbdZiW8B4UYJBkpALG8mAEG1+YdmpkpoA/I5U2UkVEMk5qUK+9yK8ZW+P9wgJ0qOTj
         jNkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fDWVlGc9bkfdx0uGoZEsq0fC8zJhCxYYZIKbBpnGA24=;
        b=TNnQtqFgUT1yUZ2AzAdrWEPpXQwvq5QKvuHv4JBOpa3BO1V/ETM6wc1KTUBb14NMiW
         Ft67iQHd2A6KqHFZVFcxSPYit+M1cFRIkOYYIOnUiJGcGKcwQ8r/S7mqPf8W6g/qlTe3
         oyau0a1wCY9X5B86IUsKt7p3nahptt0PvYjdVGzdxwLzprocuUHXItHUBqn6DF7pHGXY
         CekTWOxtwPZ8Ml93jPehnD7D/4niSSyG7J0R7YiPMiB7JItwM5XdlcoBZslSrE0Y8GFa
         QaVXSzaO8kGoVwImt1ql15gSXxE/DGHv9TrNqLRtYa79lpTbSEA95YTFn+BQVI4mrROB
         q2aA==
X-Gm-Message-State: AOAM530dhzOkiHnre+znV/hJioXeDWpChbpwbwQbBxHzG/UkUz3J0UiZ
        sJt15eU+7yi/x94D/HjesM4=
X-Google-Smtp-Source: ABdhPJyAn1heOEmcVZdI7bU/B89WZITYQzw3nQ9+EMs5qbVA6MfZ6P6S7Q6k+29KOR+5bxgzQrzSdw==
X-Received: by 2002:a2e:a378:: with SMTP id i24mr28530130ljn.290.1637874454136;
        Thu, 25 Nov 2021 13:07:34 -0800 (PST)
Received: from netbook-debian (110-38-179-94.pool.ukrtel.net. [94.179.38.110])
        by smtp.gmail.com with ESMTPSA id u22sm347968lff.118.2021.11.25.13.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 13:07:33 -0800 (PST)
Date:   Thu, 25 Nov 2021 23:07:30 +0200
From:   Denis Pauk <pauk.denis@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Eugene Shalygin <eugene.shalygin@gmail.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        thomas@weissschuh.net, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] hwmon: (nct6775) Use nct6775_*() lock function
 pointers in nct6775_data.
Message-ID: <20211125230730.485ca7b0@netbook-debian>
In-Reply-To: <CAHp75VfAAyHEnOS7npPOJqpgMgJpaukFcYC+1TH+UhTK5iksMg@mail.gmail.com>
References: <20211122212850.321542-1-pauk.denis@gmail.com>
        <20211122212850.321542-2-pauk.denis@gmail.com>
        <CAHp75VfAAyHEnOS7npPOJqpgMgJpaukFcYC+1TH+UhTK5iksMg@mail.gmail.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Nov 2021 18:03:25 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Mon, Nov 22, 2021 at 11:29 PM Denis Pauk <pauk.denis@gmail.com>
> wrote:
> 
> Better subject line (after prefix): Use lock function pointers in
> nct6775_data (note no period and drop of redundancy)
> 
> > Prepare for platform specific callbacks usage:
> > * Use nct6775 lock function pointers in struct nct6775_data instead
> >   direct calls.  
> 
> ...
> 
> > +static int nct6775_lock(struct nct6775_data *data)
> > +{
> > +       mutex_lock(&data->update_lock);
> > +
> > +       return 0;
> > +}
> > +
> > +static void nct6775_unlock(struct nct6775_data *data, struct
> > device *dev) +{
> > +       mutex_unlock(&data->update_lock);
> > +}  
> 
> Have you run `sparse` against this?
> Install `sparse` in your distribution and make kernel with
> `make W=1 C=1 CF=-D__CHECK_ENDIAN__ ...`
> 
> It might require using special annotations to these functions to make
> static analysers happy.
> 

Thank you, I will validate my patches before sending with sparse also.

I have tried with sparse==0.6.4:
---
$ make CC="ccache gcc" W=1 C=2 CF=-D__CHECK_ENDIAN__ 2>&1 | grep
nct6775 -n5
....
27219-  CHECK   drivers/hwmon/nct6683.c
27220:  CHECK   drivers/hwmon/nct6775.c
27221-  CHECK   drivers/hwmon/nct7802.c
....
---

It has not showed any warnings. Have I missed some flag? 


Best regards,
             Denis.
