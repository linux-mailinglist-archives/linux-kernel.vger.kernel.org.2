Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4C4D3F2E37
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 16:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240910AbhHTOhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 10:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240898AbhHTOhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 10:37:14 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077D8C061575;
        Fri, 20 Aug 2021 07:36:36 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id r9so21113299lfn.3;
        Fri, 20 Aug 2021 07:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XDqog7eA/iJHQBOPdK08fND+NmYBo4Qy/uDTYkx8BoM=;
        b=evBr/m1z8ate6foVjh98sF+mVQ/qZDlrQCid8kB+PSYQZPhvsuVE0XqNShLY93HCsG
         wy7TO+anEbD1o+MYd+TQ2vULqMImwVh1SZ+JH84g/g6SgScty3Po2OXZVSLAxJ0tF5m8
         AN6Ow6+C2tDavLYBudJbXQHT8cb6um1HuSkHLTg3VxlDnLCLqEa1NukOH+b70XJjaqo1
         6lcdfQHBfd9AiRXCw4xU9T6HKdyBZQKd/gfZ6oc77yhGruU5lsYsLfWXYnqVPeIPn64F
         rxpf4xinkt6v3OnABIWhR/VeGtdu8mZg8p0+XZWIcv85mkc8ZJvwn+8yHTgngKunYxrE
         Xtew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XDqog7eA/iJHQBOPdK08fND+NmYBo4Qy/uDTYkx8BoM=;
        b=Tgm8fNq70qscrzuyjfJsqLiKVH7CqS/yTVtth37pYFoyvq4sIet7xYt56Y/m39rV2B
         CeEhllMxZZsDp2LFS6y+crBAOBaJ75PNO8U7pFQljgWlVlxf8kZAX/cZ3DbfjB2zNHDB
         48qfmvCo/7c9msLScsVQZmbroZQCbOeZVu/zHeiboN/+U+lsDkfEyPKTOcTs4lOiTUcY
         ONZKNBUEcQhtprby2Kj87TfQDctCxEvFZG3XSz5k1iFXpLXs7lOsHmKlDOii4WOb7fgM
         ItJsXRoSkWNPb1iY12GE/tVqsF2N4ZwXgwr0defS1vNnPmSjZRg5ObiWROmbHwUZNv0U
         DNoA==
X-Gm-Message-State: AOAM531n/KDDKfbxipZgRAOSUfRBkvK+ffyPncnivBmsqh1k7wwt6vEF
        4B5sc/9UJif1XMuRwACPJEE=
X-Google-Smtp-Source: ABdhPJyCEYBrWNq2SC4n6u9+2CJTCo3bVEn7EvKt/Hf39WEgjKGtZTbtQ9XFFsCSaemsZC7L8A/EzQ==
X-Received: by 2002:ac2:5fa8:: with SMTP id s8mr15652944lfe.514.1629470194386;
        Fri, 20 Aug 2021 07:36:34 -0700 (PDT)
Received: from reki (broadband-95-84-198-152.ip.moscow.rt.ru. [95.84.198.152])
        by smtp.gmail.com with ESMTPSA id m5sm618753lfj.72.2021.08.20.07.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 07:36:33 -0700 (PDT)
Date:   Fri, 20 Aug 2021 17:36:32 +0300
From:   Maxim Devaev <mdevaev@gmail.com>
To:     Maciej =?UTF-8?B?xbtlbmN6eWtvd3NraQ==?= <maze@google.com>
Cc:     balbi@kernel.org, stern@rowland.harvard.edu,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ruslan.bilovol@gmail.com, mika.westerberg@linux.intel.com,
        jj251510319013@gmail.com, linux-usb@vger.kernel.org,
        Kernel hackers <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] usb: gadget: f_hid: optional SETUP/SET_REPORT mode
Message-ID: <20210820173632.053b1b2d@reki>
In-Reply-To: <CANP3RGejWk7Zj2XMGGPgrGMSjqRY+ZaVFha6jG720RCSF9HEkQ@mail.gmail.com>
References: <20210814031231.32125-1-mdevaev@gmail.com>
        <CANP3RGejWk7Zj2XMGGPgrGMSjqRY+ZaVFha6jG720RCSF9HEkQ@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej =C5=BBenczykowski <maze@google.com> wrote:
> perhaps better to rephrase as 'the host ceases to change the status of
> the gadget/keyboard LEDs',
> unless this is actually driven by the keyboard as opposed to the other
> way round (which is what I'd expect from AT, PS/2 keyboards).

Since I'm describing the behavior on the gadget side,
it seemed to me that the explanation about the impossibility
of receiving it was more appropriate.

> Not clear what 'not poll' means here.  Why would they (the host) need
> to poll an OUT endpoint?

Poll the IN Endpoint, fixed

> Additionally it seems like any keyboard gadget would want to default
> to the older more compatible mode?
> Or are there compatibility problems with it as well?

Yes, any keyboard should use SETUP/SET_REPORT if it wants maximum
compatibility. This mode has no problems with hosts. I suggest it
as optional only because for the last 9 years the default behavior
has been OUT Endpoint and in the place of those people who use it,
I would be upset if this was changed, since it could lead to strange
problems like lack of a queue and loss of events if f_hid is used
for data transmission, and not for emulating input devices.

> if you look down below, this isn't actually dynamic, should we just
> have hidg_interface_desc_{intout,ssreport} structs?

DYNAMIC is indirectly provided by the no_out_endpoints flag.
I preferred to avoid duplicating the code here.

> may be better to just use an if (hidg->use_out_ep) status =3D
> usb_assign_descriptors(...) else status =3D usb_assign_descriptors(...)

Yep, you're right

> maybe it would be better to use consistent naming...
>=20
> hidg->no_out_endpoint =3D opts->no_out_endpoint
>=20
> or call the option 'use_ssreport' instead of 'no_out_endpoint'
> (negatives are harder to think about)

Yea, I also thought about it and made such a name precisely
based on consistency. The rest of the code contains the out_ep
variable, so it was logical to make the use_out_ep flag.
In addition, there are no long names like *_out_endpoint anywhere.
At the same time, abbreviations are not used in configfs
and I didn't want to make a flag there that the user should change
to 0 if he does not want to use out endpoint. I would prefer
to leave it as it is, because it does not use negation logic,
and it will be easy for you to grep something like out_ep\>

> Anyway, nothing in here is particularly important, just loose thoughts.
> In general this seems pretty nice.

Thank you for the review! I will fix this and make a third version of the p=
atch.

