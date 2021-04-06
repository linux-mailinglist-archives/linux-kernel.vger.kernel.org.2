Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F57D354A48
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 03:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241936AbhDFBoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 21:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239501AbhDFBon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 21:44:43 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C4CC061760
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 18:44:33 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id f11so2840887vkl.9
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 18:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rgcv33+UDp0u2Q6Hp6HLXP+tMsI0iE4Muyp0O3zsJ1g=;
        b=WzH5CDdhkWte9pD3FsLaA3CmZCzZc5M20EXUZpl76FPfYEjuvw0/C9BLjx/lD5j1t8
         Y0yty4ko3PvYyX5R+HIaMWTcZdvFuViNeJsWBaGPyTgMG5dRriFFozSLjtyJWFU9iIR0
         GSOcpLzDmS4irrU+X2/mKsvFbP85MqM12sXEUYWzeAV80/7eTRujLI0EAmmCbGsqnFDT
         v1wMVN51xmSYQvew8zt5seaPcRPwQFFK0tqk5nBKRky54c6EHba+1Tjn+iQnSo+gwfeN
         TkOQ2L+EbKzqjfFhYFizh3KdG/+u0bxnmBx8HTZ4Fnd+DT3k4ZylhGWh9ffoaa5V1sUI
         Pffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rgcv33+UDp0u2Q6Hp6HLXP+tMsI0iE4Muyp0O3zsJ1g=;
        b=Zg/sudHm78HKRAV/MhSmMNn6+UOenX9w8vCA4XX2y9ntYLKGPgjXvNx0b/XR7l/mZz
         pW2qXA1osoXwjek5AO0qQBRZSH1SaQzEx/z+vWiW7Nd6+WjpaKusqBk06SuLPs1PgJ34
         9VirD+Ngid61wIIh1dQL8lHIvBjgIpdqCy0Dl4UWqEgMq1i/683Zj3oCWcSiSAro/Ltf
         4ycrE6uKDTvjDiOyKCnuPM/NWRSEkGlchsZxVXmlgg2F1w7Ude/Rg5XWWB1kJ3eR+LP3
         kFudercJE41R7XbNSTBdwevCOrl5z25BRJ5VgiR8q4Qn5THLue+777I59hZ4x87l43nw
         qizw==
X-Gm-Message-State: AOAM530oHuCHymM7V7mQ3gEoKNkaLFgyYAmoPNldpw5MDK9AdFulfdpN
        e8nxdpsBbG6Yr43zMuQixlwPQAKmJg9Dhb8jfJE62A==
X-Google-Smtp-Source: ABdhPJwoiGVXpHBLM23cBZSzDFyy3ZGjwlTn1/bLwQvwXQlIjTQ+7AywBtLtfqOspBEyHY9gjakZq6kR3W6b+0tLYXA=
X-Received: by 2002:a05:6122:11a6:: with SMTP id y6mr16290548vkn.6.1617673472563;
 Mon, 05 Apr 2021 18:44:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210317181249.1062995-1-badhri@google.com> <PR3PR10MB41420951E2867C2E0E5272B980699@PR3PR10MB4142.EURPRD10.PROD.OUTLOOK.COM>
 <CAPTae5J_GdHsGQvNxgpffk5otyGhY8D48vddvin3A4fkz3KWUA@mail.gmail.com>
 <PR3PR10MB4142450638A8E07A33E475B080689@PR3PR10MB4142.EURPRD10.PROD.OUTLOOK.COM>
 <CAPTae5KX_+_4TN3DAptP-ra=Lzxnf7LgBDwxsv5JWxg4y4hQqQ@mail.gmail.com>
In-Reply-To: <CAPTae5KX_+_4TN3DAptP-ra=Lzxnf7LgBDwxsv5JWxg4y4hQqQ@mail.gmail.com>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Mon, 5 Apr 2021 18:43:58 -0700
Message-ID: <CAPTae5+kTcDE_gqr_Jy1VO-vfKED4vtc0yL6jjYSC0LZMwzc9g@mail.gmail.com>
Subject: Re: [PATCH v2] usb: typec: tcpm: Invoke power_supply_changed for tcpm-source-psy-
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

Just sent out a patch stack
https://patchwork.kernel.org/project/linux-usb/list/?series=461087
to address the issue that you mentioned here.

Thanks,
Badhri


On Mon, Apr 5, 2021 at 6:43 PM Badhri Jagan Sridharan <badhri@google.com> wrote:
>
> Hi Adam,
>
> Just sent out a patch stack https://patchwork.kernel.org/project/linux-usb/list/?series=461087
> to address the issue that you mentioned here.
>
> Thanks,
> Badhri
>
> On Fri, Mar 19, 2021 at 9:32 AM Adam Thomson <Adam.Thomson.Opensource@diasemi.com> wrote:
>>
>> On 18 March 2021 20:40, Badhri Jagan Sridharan wrote:
>>
>> > > Regarding selecting PDOs or PPS APDOs, surely we should only notify of a
>> > change
>> > > when we reach SNK_READY which means a new contract has been established?
>> > Until
>> > > that point it's possible any requested change could be rejected so why inform
>> > > clients before we know the settings have taken effect? I could be missing
>> > > something here as it's been a little while since I delved into this, but this
>> > > doesn't seem to make sense to me.
>> >
>> > I was trying to keep the power_supply_changed call close to the
>> > variables which are used to infer the power supply property values.
>> > Since port->pps_data.max_curr is already updated here and that's used
>> > to infer the CURRENT_MAX a client could still read this before the
>> > request goes through right ?
>>
>> Actually that's fair but I think the problem here relates to 'max_curr' not
>> being reset if the SRC rejects our request when we're swapping between one PPS
>> APDO and another PPS APDO. I think the 'max_curr' value should be reverted back
>> to the value for the existing PPS APDO we were already using. I suspect the same
>> might be true of 'min_volt' and 'max_volt' as well, now I look at it. It might
>> actually be prudent to have pending PPS data based on a request, which is only
>> committed as active once ACCEPT has been received.
>>
>> Regarding power_supply_changed() though, I still think we should only notify of
>> a change when the requested change has been accepted by the source, in relation
>> to these values as they should reflect the real, in-use voltage and current
>> values.
>>
