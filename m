Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98B0D45C97E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 17:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242274AbhKXQHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 11:07:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbhKXQHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 11:07:14 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483EFC061714;
        Wed, 24 Nov 2021 08:04:04 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id r11so12608593edd.9;
        Wed, 24 Nov 2021 08:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c1VDQu25EqDwBPY6LlhaPS6fngYyAPs1ECOjZ0kQDxU=;
        b=izl96R1Y/jbpk+WtWDTyDevxWALbEyeRNmW5HJMQm28ZlaeeFd7cdx2XR5FBDN9rQd
         HIk0+LNbVv6LfjOACZMvYpAgZFKr0t2NHF/G7iKs7QIMyEOZ4ehnPs782fVWxsiZejR9
         ZsCCVBL9sl1GP14ul9sb39uQp0VbFt5FWgRhuQZ6YO6g5w0scbJ3hMI33M8vhMEi2EcO
         DJpESv3naPQ6wGRI2HIM/uaF4k74lZLJylSV0ngZSZwBL9RkDmObTl+J7tvKrY/JTfQb
         Utdk7xuX4XHhLhpo9i35ZTnX+jhfGN8kES7wBnZCS0A8JIBBlwba1DyOcHbMHo2wxQ/D
         HfnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c1VDQu25EqDwBPY6LlhaPS6fngYyAPs1ECOjZ0kQDxU=;
        b=rkXSYCGVuGQf/FrhV7gscHgCj0cj2s+1E4UpYCQsansk/1A0IQW0u1RhevcEQn6uda
         FvZ0CiSKAw2kRBkfH8VSXX0cuAUIVG4e8sTRzEKfA9hWPqA4VyU3cYlELdel9dheuVMM
         yCUJmT3dewGjZJMUh0rk7HJQ00ghYLMz6AIU4GJFcIPO5O6BoGukHsLPdZhg2N1yrcUU
         wss4MJ3neYHGxeTaL51uiVkCdsUD35noG/fe0wE46gn6xPFln5PBAduZDQaVkNvTKnw4
         5i78qjag3WEAskIulk++qylGb3ZbJp4EbboZuflx6TAJBqQQaiExBpMES8KVcT8UMXeL
         nqkw==
X-Gm-Message-State: AOAM533tk2yyXPdutXH6fXB/UzNL2ettof4260gQ8dpLbB/vXd6zyom4
        cU2LT3dKTqXe33TQfqKfGkwI7wwME6ri7rCHWTUOkChDQ2WeYQ==
X-Google-Smtp-Source: ABdhPJx1veB8KD6wzSkj9tpFNskWY8oTmADzuOn7ikIjVXYN1pHKhvGroW5VsgPILmn9eD+uSUmUKQmsFJ6RPsf9TWA=
X-Received: by 2002:a05:6402:2067:: with SMTP id bd7mr26633668edb.240.1637769842738;
 Wed, 24 Nov 2021 08:04:02 -0800 (PST)
MIME-Version: 1.0
References: <20211122212850.321542-1-pauk.denis@gmail.com> <20211122212850.321542-2-pauk.denis@gmail.com>
In-Reply-To: <20211122212850.321542-2-pauk.denis@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 24 Nov 2021 18:03:25 +0200
Message-ID: <CAHp75VfAAyHEnOS7npPOJqpgMgJpaukFcYC+1TH+UhTK5iksMg@mail.gmail.com>
Subject: Re: [PATCH 1/3] hwmon: (nct6775) Use nct6775_*() lock function
 pointers in nct6775_data.
To:     Denis Pauk <pauk.denis@gmail.com>
Cc:     Eugene Shalygin <eugene.shalygin@gmail.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        thomas@weissschuh.net, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021 at 11:29 PM Denis Pauk <pauk.denis@gmail.com> wrote:

Better subject line (after prefix): Use lock function pointers in nct6775_data
(note no period and drop of redundancy)

> Prepare for platform specific callbacks usage:
> * Use nct6775 lock function pointers in struct nct6775_data instead
>   direct calls.

...

> +static int nct6775_lock(struct nct6775_data *data)
> +{
> +       mutex_lock(&data->update_lock);
> +
> +       return 0;
> +}
> +
> +static void nct6775_unlock(struct nct6775_data *data, struct device *dev)
> +{
> +       mutex_unlock(&data->update_lock);
> +}

Have you run `sparse` against this?
Install `sparse` in your distribution and make kernel with
`make W=1 C=1 CF=-D__CHECK_ENDIAN__ ...`

It might require using special annotations to these functions to make
static analysers happy.

-- 
With Best Regards,
Andy Shevchenko
