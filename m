Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13FCA44473F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 18:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbhKCRhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 13:37:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24081 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229943AbhKCRhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 13:37:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635960900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yb/swhvZa5qb9s8IEKE3d1iS1AZRSbuUJkJPEO8CTz8=;
        b=LHnGDeG2uBiNlwMCAjoooXt9wc7LB5vf+n9V2T+QVViGEM3IPy3+cdrv2ofSygGrZpTJSH
        QTHPanHzjUOFBbJRlYyy4O2BxtAJ2TbCjIK14uyDx2hF76y15iooaBWu76kgjYnVPQbLHp
        WtFej1iats6cUwQiDRZKRZ1SnPYfl3g=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-A0QdYkF1NduFnH8TZxexOw-1; Wed, 03 Nov 2021 13:34:58 -0400
X-MC-Unique: A0QdYkF1NduFnH8TZxexOw-1
Received: by mail-ed1-f69.google.com with SMTP id d11-20020a50cd4b000000b003da63711a8aso3167454edj.20
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 10:34:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yb/swhvZa5qb9s8IEKE3d1iS1AZRSbuUJkJPEO8CTz8=;
        b=N3c2i2JVKOUqH+k4mpfDM1bc/lZemco3ybHoroThDGLQBmr0OQMNdmxhfwvhzuLalZ
         ncH+SXwmbFTpEv1Ob/WW/wRRfNag8482Gq95OvG8m4VeVLssKZg4ag1bwwo6OO/J5u/w
         zwoXaoA28R29CbyMqsXXjKTq2U2SvC5sf2XhiualLk/0BWW017AEwIod/XLHGXO4dw1t
         +20gBaDxdC2MxxoQoKZGRJ+YXsw2q6Fp8oobPGfPKdLnDGD1ApsY1+eMKRHukrslLJFx
         5fyLaMMenDB0chkLmXAn28vrH+tv9qS0+Lu3sbshH6bB+NfMQRo1Qw8D8G6HxgqHtNos
         qpdA==
X-Gm-Message-State: AOAM530NHZBTNKODqMscXbtuqV32xqZi9tdkDDQcnq+1Tmit+XPZ06xi
        RBMNMTBWG5yJ/Bn6G9LVT7RWYm7fIJLkqkyi5gLG7c+cv4TuR/Eg+AGiSo1P3DB8Qc3KOrBJNFR
        LiM2vZo/kkFT+foRjLSiZfp/R
X-Received: by 2002:a05:6402:3592:: with SMTP id y18mr14975572edc.343.1635960897586;
        Wed, 03 Nov 2021 10:34:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwo2pD5E2wICooHHebQM64IuMPntJs+qg93HEHJGKODzPl9A5pA3BTvXoSpk9JFSezgjDKPSQ==
X-Received: by 2002:a05:6402:3592:: with SMTP id y18mr14975549edc.343.1635960897438;
        Wed, 03 Nov 2021 10:34:57 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id de36sm1449430ejc.54.2021.11.03.10.34.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Nov 2021 10:34:57 -0700 (PDT)
Message-ID: <25338ce1-c663-3a3d-550f-5c8f74270615@redhat.com>
Date:   Wed, 3 Nov 2021 18:34:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 3/3] backlight: lp855x: Add support ACPI enumeration
Content-Language: en-US
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20211102225504.18920-1-hdegoede@redhat.com>
 <20211102225504.18920-3-hdegoede@redhat.com>
 <20211103171756.wxthncse2f4syeiz@maple.lan>
 <5d431db5-30dc-b51c-7abb-ab57a3de2f8f@redhat.com>
 <20211103173107.xlchsysme5xzpn24@maple.lan>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20211103173107.xlchsysme5xzpn24@maple.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/3/21 18:31, Daniel Thompson wrote:
> On Wed, Nov 03, 2021 at 06:28:15PM +0100, Hans de Goede wrote:
>> Hi,
>>
>> On 11/3/21 18:17, Daniel Thompson wrote:
>>> On Tue, Nov 02, 2021 at 11:55:04PM +0100, Hans de Goede wrote:
>>>> The Xiaomi Mi Pad 2 tablet uses an ACPI enumerated LP8556 backlight
>>>> controller for its LCD-panel, with a Xiaomi specific ACPI HID of
>>>> "XMCC0001", add support for this.
>>>>
>>>> Note the new "if (id)" check also fixes a NULL pointer deref when a user
>>>> tries to manually bind the driver from sysfs.
>>>>
>>>> When CONFIG_ACPI is disabled acpi_match_device() will always return NULL,
>>>> so the lp855x_parse_acpi() call will get optimized away.
>>>>
>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>
>>> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
>>
>> Thank you.
>>
>> So what is the process for upstreaming backlight patches,
>> do these go through drm-misc-next (in that case I can push
>> the series myself), or will you pick these up ?
> 
> Lee Jones gathers up the backlight patches and sends a PR (but, except
> in exceptional cases, treats my R-b as a pre-requisite before doing so).

Ok, thanks.

Regards,

Hans

