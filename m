Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C17C843B544
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 17:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235166AbhJZPRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 11:17:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48995 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231531AbhJZPRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 11:17:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635261318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QPSy4Q8SWeSmWCbT1tw01Ne6NKKk7aTJ9QrBbBlrGOk=;
        b=SRbqBD3rTebTLq+rbfqfE+WKGzTXijXNpLHq+H1QCkrdaym0VWTnZVb2JhRWOU0Wm8bmxn
        WdeHtPdnaX4MKURCzw3o62gfqsKXMQz1fTMFzNyrLgwWNAhzhH/bkuj+k3XF8YEjaCX0JT
        tAI9AARgF8OTPLKe0RqIeapMhxXme/c=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-CDU1I4FYM6yljvcP2-mxSg-1; Tue, 26 Oct 2021 11:15:16 -0400
X-MC-Unique: CDU1I4FYM6yljvcP2-mxSg-1
Received: by mail-ed1-f72.google.com with SMTP id i9-20020a508709000000b003dd4b55a3caso3728454edb.19
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 08:15:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QPSy4Q8SWeSmWCbT1tw01Ne6NKKk7aTJ9QrBbBlrGOk=;
        b=seS/MxDaVs+LXqxiBvuffA+MfA+8pP8E9wDBpx2WOlW76z3RpCWqjReMAvLNc0CEWa
         3i4ttz85mlaRplEBTwbHt3Nzh1r1C/mvGUhYzCwyjEAfMPa8rbYH4RUy9a66gbGkexZ9
         3YaWY6b6tBt38wZAUOlYdacD1UPW1N0FWgo5PAjt3V4L72p3PBXz0Gx8emTkkl0+z51o
         0lzqO50q7bLX4soRFCb3p+Vqu5cDNkspBLe7H5m1QgZ7E7onOWSbPVEobDtuWBCnDhWs
         vjjeETP/67aovV0jye6r8/uQdX0yIF14DQXH6FND/5m0RXiE/qO2ZDi1s8hIWAfFeujy
         ydcg==
X-Gm-Message-State: AOAM532J5+o9RAPIdswzg6cZ9NjsGO3LfZwT+imhiXA/5BxW9cEJvgfq
        qeyJduA7ovpV546Gj+tSJ4K3qXjYgaszQftbRZL5XPhvwkhL6F5/9X598NY+yg3/M8Z8QofMora
        5iq2aJ5TH//wDyR5yGOmgAS8P
X-Received: by 2002:a50:ec06:: with SMTP id g6mr27147897edr.144.1635261315039;
        Tue, 26 Oct 2021 08:15:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyLnTCMW1fg+5kTF7B11mVpoXzJrYGwUFdz/5P/EbbrO/QW3dZ+rAFbhk7FNvjJHWhZxL5ohA==
X-Received: by 2002:a50:ec06:: with SMTP id g6mr27147868edr.144.1635261314855;
        Tue, 26 Oct 2021 08:15:14 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id yd8sm4743361ejb.33.2021.10.26.08.15.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Oct 2021 08:15:14 -0700 (PDT)
Message-ID: <eb7db8fa-0557-425f-b08d-1d55ac07610a@redhat.com>
Date:   Tue, 26 Oct 2021 17:15:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2] staging: rtl8723bs: core: Refactor nested if-else
Content-Language: en-US
To:     kushal kothari <kushalkothari285@gmail.com>,
        Mike Rapoport <mike.rapoport@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        fabioaiuto83@gmail.com, ross.schm.dev@gmail.com,
        marcocesati@gmail.com,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, kushalkothari2850@gmail.com
References: <20211026134253.7868-1-kushalkothari285@gmail.com>
 <YXgOdpebeA/dFWIz@kernel.org>
 <CALtHPQuKDa23Ui4wBVed=7FOkf6u+-MjL1VU-4CD6hXSjmsq6g@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CALtHPQuKDa23Ui4wBVed=7FOkf6u+-MjL1VU-4CD6hXSjmsq6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/26/21 17:12, kushal kothari wrote:
> Yes!
> Also initializing  variable pstat->has_legacy_ac = false;  //false
> which is previously set to true before the loop so it can be removed too.

Note please do not make too many changes in a single patch.

It is best to do refactoring like this in small steps making
only 1 change at a time, that makes things a lot easier to
review / to verify that there are no functional changes.

Regards,

Hans


> 
> On Tue, Oct 26, 2021 at 7:49 PM Mike Rapoport <mike.rapoport@gmail.com <mailto:mike.rapoport@gmail.com>> wrote:
> 
>     On Tue, Oct 26, 2021 at 07:12:53PM +0530, Kushal Kothari wrote:
>     > Refactor nested if-else to avoid deep indentations. There is no change
>     > in the logic of the new code, however, now it is simple because it gets
>     > rid of five unnecessary else conditionals and it combines nested if into
>     > single if-else-if. This refactor also leads to fix warning detected by
>     > checkpatch.pl <http://checkpatch.pl>:
>     > WARNING: Too many leading tabs - consider code refactoring
>     >
>     > Signed-off-by: Kushal Kothari <kushalkothari285@gmail.com <mailto:kushalkothari285@gmail.com>>
>     > ---
>     >
>     > Changes in v2: Fix the bug of not handling properly the else logic
>     > when p is not null in else-if. Also, reword the subject line and break
>     > it up at 72 columns.
>     >
>     >  drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 69 ++++++++-----------
>     >  1 file changed, 29 insertions(+), 40 deletions(-)
>     >
>     > diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
>     > index 0f82f5031c43..267d853b1514 100644
>     > --- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
>     > +++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
>     > @@ -1192,50 +1192,39 @@ unsigned int OnAssocReq(struct adapter *padapter, union recv_frame *precv_frame)
>     >               p = pframe + WLAN_HDR_A3_LEN + ie_offset; ie_len = 0;
>     >               for (;;) {
>     >                       p = rtw_get_ie(p, WLAN_EID_VENDOR_SPECIFIC, &ie_len, pkt_len - WLAN_HDR_A3_LEN - ie_offset);
>     > -                     if (p) {
>     > -                             if (!memcmp(p+2, WMM_IE, 6)) {
>     > -
>     > -                                     pstat->flags |= WLAN_STA_WME;
>     > -
>     > -                                     pstat->qos_option = 1;
>     > -                                     pstat->qos_info = *(p+8);
>     > -
>     > -                                     pstat->max_sp_len = (pstat->qos_info>>5)&0x3;
>     > -
>     > -                                     if ((pstat->qos_info&0xf) != 0xf)
>     > -                                             pstat->has_legacy_ac = true;
>     > -                                     else
>     > -                                             pstat->has_legacy_ac = false;
>     > -
>     > -                                     if (pstat->qos_info&0xf) {
>     > -                                             if (pstat->qos_info&BIT(0))
>     > -                                                     pstat->uapsd_vo = BIT(0)|BIT(1);
>     > -                                             else
>     > -                                                     pstat->uapsd_vo = 0;
>     > -
>     > -                                             if (pstat->qos_info&BIT(1))
>     > -                                                     pstat->uapsd_vi = BIT(0)|BIT(1);
>     > -                                             else
>     > -                                                     pstat->uapsd_vi = 0;
>     > -
>     > -                                             if (pstat->qos_info&BIT(2))
>     > -                                                     pstat->uapsd_bk = BIT(0)|BIT(1);
>     > -                                             else
>     > -                                                     pstat->uapsd_bk = 0;
>     > -
>     > -                                             if (pstat->qos_info&BIT(3))
>     > -                                                     pstat->uapsd_be = BIT(0)|BIT(1);
>     > -                                             else
>     > -                                                     pstat->uapsd_be = 0;
>     > -
>     > -                                     }
>     > -
>     > -                                     break;
>     > +                     if (p && memcmp(p+2, WMM_IE, 6)) {
>     > +                             p = p + ie_len + 2;
>     > +                     } else if (p && !memcmp(p+2, WMM_IE, 6)) {
>     > +                             pstat->flags |= WLAN_STA_WME;
>     > +                             pstat->qos_option = 1;
>     > +                             pstat->qos_info = *(p+8);
>     > +                             pstat->max_sp_len = (pstat->qos_info>>5)&0x3;
>     > +
>     > +                             pstat->has_legacy_ac = false;
>     > +                             if ((pstat->qos_info&0xf) != 0xf)
>     > +                                     pstat->has_legacy_ac = true;
>     > +
>     > +                             if (pstat->qos_info&0xf) {
>     > +                                     pstat->uapsd_vo = 0;
> 
>     This variable and other variables below are set to 0 just before the loop,
>     so the initialization here can be removed.
> 
>     > +                                     if (pstat->qos_info&BIT(0))
>     > +                                             pstat->uapsd_vo = BIT(0)|BIT(1);
>     > +
>     > +                                     pstat->uapsd_vi = 0;
>     > +                                     if (pstat->qos_info&BIT(1))
>     > +                                             pstat->uapsd_vi = BIT(0)|BIT(1);
>     > +
>     > +                                     pstat->uapsd_bk = 0;
>     > +                                     if (pstat->qos_info&BIT(2))
>     > +                                             pstat->uapsd_bk = BIT(0)|BIT(1);
>     > +
>     > +                                     pstat->uapsd_be = 0;
>     > +                                     if (pstat->qos_info&BIT(3))
>     > +                                             pstat->uapsd_be = BIT(0)|BIT(1);
>     >                               }
>     > +                             break;
>     >                       } else {
>     >                               break;
>     >                       }
>     > -                     p = p + ie_len + 2;
>     >               }
>     >       }
>     > 
>     > --
>     > 2.25.1
>     >
> 
>     -- 
>     Sincerely yours,
>     Mike.
> 

