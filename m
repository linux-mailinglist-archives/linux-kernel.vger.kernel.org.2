Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 819E945E2C5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 22:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236315AbhKYWAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 17:00:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243723AbhKYV6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 16:58:41 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C83BC0613FD;
        Thu, 25 Nov 2021 13:51:00 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id t5so30945817edd.0;
        Thu, 25 Nov 2021 13:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R/Erpcm/WNvaYSUhwEFbeIzCnJJAcHdfnCW3GKs0C+k=;
        b=U0VkuRIraspHOx6nHKK0clNFxsX//vGRJT6aipzmZ6NJyYeDdzW7YdrIvP89+Ps3al
         Rp8Tq/mwYJHcCfM7/M+cvhFhShSwMSiZ2/i/QS7slC2IL0Q3jmdxmpsts8v9k6OnhoRR
         /8EeRvrCdhoVsHxkp3AtCDrLwm6R2qQ9CnRwAyei57Ew48n14P7aTlYxLLssIi573cGU
         yQcHDVQqzfjE5HMM2wu9ODfUq/Gn+Ugd36+fwZP/oNzlwMMPl0RM3RnXNnYyXrJDMsPK
         tyPoGMVuJH+5AgMgKInkaQ2j3KcVuCUoF/s084Y2fBfvKZ/qmvbgNoDptV36DpeYFFwo
         FG7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R/Erpcm/WNvaYSUhwEFbeIzCnJJAcHdfnCW3GKs0C+k=;
        b=A43fujdspwNEhXTQon5wxdenkaDFz9XW3oVnOwmwNbD+57ib2v2rrImvHMoO/YrW0n
         ZsUfQVyvdu7O2ISeRpf7O1R7CG5I9bUAxYOmx6jci/ad/knYfyDt1vLy+2Ns/z72yE6+
         P+9jAebYHt4mCGM9LeH4B44VTTy7oxQjKjJuukjbGbz03v3jQoDtWd1IjtdsTLQ+OoPz
         v98j2hXTBF3O9kXyClywKqnndkYsQCG/IeegxrBX6p6c1DdR01zowV1mJOej2r1/jNNo
         kqMjiga2Kkfvoxaj9+oBn+hxhspIp/typlKv8S0QbqruDf+B60bG+0vmK0T/VN/w01FV
         cPhg==
X-Gm-Message-State: AOAM531SWkvA8G4sGy4WlRjDMX+J815ZiXJxexLowBqfc0bO1I4oWw1/
        WJbQlXT+Xc9nxd6A6aGFwdH38zKKt020lnp7CWfriClZZ7s=
X-Google-Smtp-Source: ABdhPJzhQq8ARQAnFFrOCE3lgvaN8dh9tnBhnjsKbQ+iLmyM1YwNVAESMx+yOEFAaC7Ok2t07w/lvRBBIFh3pq8eSjk=
X-Received: by 2002:a17:906:6a0a:: with SMTP id qw10mr36680838ejc.141.1637877058536;
 Thu, 25 Nov 2021 13:50:58 -0800 (PST)
MIME-Version: 1.0
References: <20211122212850.321542-1-pauk.denis@gmail.com> <20211122212850.321542-2-pauk.denis@gmail.com>
 <CAHp75VfAAyHEnOS7npPOJqpgMgJpaukFcYC+1TH+UhTK5iksMg@mail.gmail.com> <20211125230730.485ca7b0@netbook-debian>
In-Reply-To: <20211125230730.485ca7b0@netbook-debian>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 25 Nov 2021 23:50:22 +0200
Message-ID: <CAHp75Vf059Exu4LxjsWg_qugCX3AjCqFun08Gvh=krFDg41sSA@mail.gmail.com>
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

On Thu, Nov 25, 2021 at 11:07 PM Denis Pauk <pauk.denis@gmail.com> wrote:
> On Wed, 24 Nov 2021 18:03:25 +0200
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Mon, Nov 22, 2021 at 11:29 PM Denis Pauk <pauk.denis@gmail.com>
> > wrote:

...

> > > +static int nct6775_lock(struct nct6775_data *data)
> > > +{
> > > +       mutex_lock(&data->update_lock);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static void nct6775_unlock(struct nct6775_data *data, struct
> > > device *dev) +{
> > > +       mutex_unlock(&data->update_lock);
> > > +}
> >
> > Have you run `sparse` against this?
> > Install `sparse` in your distribution and make kernel with
> > `make W=1 C=1 CF=-D__CHECK_ENDIAN__ ...`
> >
> > It might require using special annotations to these functions to make
> > static analysers happy.
>
> Thank you, I will validate my patches before sending with sparse also.
>
> I have tried with sparse==0.6.4:
> ---
> $ make CC="ccache gcc" W=1 C=2 CF=-D__CHECK_ENDIAN__ 2>&1 | grep
> nct6775 -n5
> ....
> 27219-  CHECK   drivers/hwmon/nct6683.c
> 27220:  CHECK   drivers/hwmon/nct6775.c
> 27221-  CHECK   drivers/hwmon/nct7802.c
> ....
> ---
>
> It has not showed any warnings. Have I missed some flag?

No, you are all good!

-- 
With Best Regards,
Andy Shevchenko
