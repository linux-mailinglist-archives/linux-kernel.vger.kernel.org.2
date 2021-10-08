Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 720F5426CDF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 16:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240847AbhJHOoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 10:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbhJHOon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 10:44:43 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1282C061570;
        Fri,  8 Oct 2021 07:42:47 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id g2so9157746ild.1;
        Fri, 08 Oct 2021 07:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aD65N++qNJ05mDhdAztzUQUp3glaEsKomN2IiXw18IU=;
        b=OncWWgmiCxwRgwoVO5Rp4rQFyFhZ/aaOOgL9f2BzMhWKtoTnGi17rIEdZHAVbcpHoP
         TFnLKncm7su6XHwU4EwLUmswOvroQ/aIHKSyJ/B86QgTAgajqQRqpAPeo8xT5etrVwI4
         hQtlYfj864S0Wi346eTK/lGi5XqFfii2/ueGkAGvq6OpVuG5PQuFMoLj9HwYLLsxHlRC
         rQXvtOdOg+sWY/mVGGCdyk+LT8WcnNrPDfd7ym1rUpBasZBQR9RapCXn8H/S60gJVrZp
         mK1bLVbfu8T8d1+eHYxkjDlgcpiaReelRvWXw3m+sUbg4IV+8+Lrr5QiC4XDsHxKcFNH
         P9PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aD65N++qNJ05mDhdAztzUQUp3glaEsKomN2IiXw18IU=;
        b=mBU6CdHKlB8XAoG8Bga94FuMhJZL5MDc/FJzwcHYyIByFDr8YGis6GxyOzP0Zve8FP
         JaRhBPsIJwYeaPCQQZwYGKbG/W5FC/VoUfF00qum+9oJfTdyXNDoEhWgNDElhA7ayvtN
         Mhgi47Eca2AwwS7DGlSFbXiD/FjrG7aecbxOnPnvy730PfH+RbjTICruLAyWoX88J10a
         o8QTPoCGof/hsKysKHrStCnVwtm3DDyz/OjBJVssbYkujgTw+wgRAJrdL1pDTtjC7NWV
         iidM800Y/zgCLSfUeHgvEYDPI99CRgfxkU3giQZiWpC/MyLPsJa8jqjYIE8YyKVTgit+
         Q1jw==
X-Gm-Message-State: AOAM531DMbzMudeeoxBzOQgT8pCOigUJxfK5i3b8uaQtOK+FDLQewFOf
        fD4qK/kg7frehsT2wjCdrapn7hv7/RWPV0FKuIGa6HLi/9w=
X-Google-Smtp-Source: ABdhPJxHf31/FzDQq2IFsOfPS/cYFLyJznSRlzjoYZN7caXEM095WQPKmiWug5blt30P0KWeg1bcG4h1WIjz3t2ICpo=
X-Received: by 2002:a92:de41:: with SMTP id e1mr5811573ilr.289.1633704167116;
 Fri, 08 Oct 2021 07:42:47 -0700 (PDT)
MIME-Version: 1.0
References: <20211006222502.645003-1-pauk.denis@gmail.com> <20211006222502.645003-3-pauk.denis@gmail.com>
In-Reply-To: <20211006222502.645003-3-pauk.denis@gmail.com>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Fri, 8 Oct 2021 16:42:36 +0200
Message-ID: <CAB95QARh1SBm+QnZsMgvxLk0WqBVBzuk8o_J8Q4qFguHATnZ_A@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] hwmon: (asus_wmi_ec_sensors) Support B550 Asus WMI.
To:     Denis Pauk <pauk.denis@gmail.com>
Cc:     andy.shevchenko@gmail.com, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Denis,


On Thu, 7 Oct 2021 at 00:25, Denis Pauk <pauk.denis@gmail.com> wrote:
> +               if (si->addr.size == 1)
> +                       value = ec->read_buffer[read_reg_ct];
> +               else if (si->addr.size == 2)
> +                       value = get_unaligned_le16(&ec->read_buffer[read_reg_ct]);
> +               else if (si->addr.size == 4)
> +                       value = get_unaligned_le32(&ec->read_buffer[read_reg_ct]);

If you did not invert the encoding scheme the data in the buffer are
in BE order.

Best regards,
Eugene
