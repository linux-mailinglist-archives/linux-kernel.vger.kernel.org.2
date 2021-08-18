Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 698093EFE1C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 09:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240044AbhHRHpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 03:45:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43714 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239331AbhHRHpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 03:45:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629272682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZDR9dCcFnqRjQs5BKATK3dgD8MpAQds3bSLfGElXMe8=;
        b=WlAhQdAbYFWddbS6F8X00DrfUXo8+l/ErQ3McYq8trxzgrP/k+OwvwqBHEVYUc7PR6hk7K
        c4KfE9ttDIcuNmTSkOVbRHW7IARmT2yxZqhKd+La7/nXjuiuEyJkyWQd/CRhmgJXddHr7P
        VdUUq2C8bHyjKevBTaq7NGswwYJtkDU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-rnDZ9SHwM12SrOjPw4sJ4g-1; Wed, 18 Aug 2021 03:44:41 -0400
X-MC-Unique: rnDZ9SHwM12SrOjPw4sJ4g-1
Received: by mail-ed1-f69.google.com with SMTP id u4-20020a50eac40000b02903bddc52675eso609440edp.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 00:44:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZDR9dCcFnqRjQs5BKATK3dgD8MpAQds3bSLfGElXMe8=;
        b=rd5b2ZkGuYMjp7kk9KRQxbJU1HYblMjqJGcjAujt8dJ1ZKkwmFtSI59/swmj1QdJ6K
         y3jBHIQt5WFIH8kALbty4l3mUNvjYXzjZzcz4wCNjUIeukXw+3lfGv+L7x/M6kHyjFBN
         OTDfTq4YTW3glzoK4ulz6ia6sTFBBqMMlobCGvhyXuTPEI9zg6ziJUIy3eoTqF5Ayb9e
         r/2joDByInAubcNtULVfBXpbLjivFdwKbUE78h4kpWnkwsbjgVFFjf5ccuPN4ePUCoeG
         PkZRhbIJXLwEfaIEu3QvRjvgx82nB6tFs9liDw9raSu+N5/AJIBGwoLbiG6LAJSqSoFU
         5n6w==
X-Gm-Message-State: AOAM532N+bR45RFdYVaVg4xUw0uPAQgTAof3PFC/mPSDguT1MFAcrIMk
        bWTMqge9YCAHZDQX2j7hjG9+xjqXyteQ9xCHGHtNj2xXYv/SnBB6MmiOWI3xoCNXhnGN6tcuMYf
        r0Lkdw8OzTi2ly7N9Jjqs3tSwO1W8QryRyBSkyIAtlcXKnU5X7o6+INpiOSCTKjnzIhlYwGC6cl
        dg
X-Received: by 2002:a17:907:7704:: with SMTP id kw4mr8246928ejc.23.1629272679692;
        Wed, 18 Aug 2021 00:44:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJukV8qhSL3IKMdZaVPX1Am3u9IqxVfcSdgXafbeyr5DVxLVIs4LXx7LTNaUwgrNB8vmKAbQ==
X-Received: by 2002:a17:907:7704:: with SMTP id kw4mr8246912ejc.23.1629272679404;
        Wed, 18 Aug 2021 00:44:39 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id b5sm1660448ejq.56.2021.08.18.00.44.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Aug 2021 00:44:39 -0700 (PDT)
Subject: Re: [PATCH] platform/x86: gigabyte-wmi: add support for X570 GAMING X
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        platform-driver-x86@vger.kernel.org,
        Mark Gross <mgross@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
References: <20210817154628.84992-1-linux@weissschuh.net>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <b1b43dfd-7057-6ef4-6f03-154f1df4cb4b@redhat.com>
Date:   Wed, 18 Aug 2021 09:44:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210817154628.84992-1-linux@weissschuh.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/17/21 5:46 PM, Thomas Weißschuh wrote:
> Reported as working here:
> https://github.com/t-8ch/linux-gigabyte-wmi-driver/issues/1#issuecomment-900263115
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

I've also added this to the fixes branch so that it will be
included in the next (and last) fixes-pullreq to Linus for 5.14 .

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans

> ---
>  drivers/platform/x86/gigabyte-wmi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/x86/gigabyte-wmi.c b/drivers/platform/x86/gigabyte-wmi.c
> index 5529d7b0abea..d65aa43e6f72 100644
> --- a/drivers/platform/x86/gigabyte-wmi.c
> +++ b/drivers/platform/x86/gigabyte-wmi.c
> @@ -146,6 +146,7 @@ static const struct dmi_system_id gigabyte_wmi_known_working_platforms[] = {
>  	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("B550M DS3H"),
>  	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("Z390 I AORUS PRO WIFI-CF"),
>  	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("X570 AORUS ELITE"),
> +	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("X570 GAMING X"),
>  	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("X570 I AORUS PRO WIFI"),
>  	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("X570 UD"),
>  	{ }
> 
> base-commit: 009c9aa5be652675a06d5211e1640e02bbb1c33d
> 

