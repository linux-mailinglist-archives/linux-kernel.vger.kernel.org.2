Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB8A35D9CF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 10:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242328AbhDMIPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 04:15:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46020 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241668AbhDMIPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 04:15:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618301726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nTFiVrT0GgD5PF9g9cQQkkjhncBa1KbZqSegCvRQvn4=;
        b=ar0ktMVuWpiwvxzushO6MIOaH7s1FVMoTyfagDo7+VVnpBRZ7ColTNPR0MFwpCYubhP8Sm
        guSvdHTgDvp6SmaOMf7n2I+FvtUz+19901m9dY+MnJ7opkF3sj4GLEfUYqifX84A0hZ7Wn
        gDa4NUuiI8g6zLrwix12nl8LYThWxaM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-529-zlIbAxJLNhe2uNz80O9ISA-1; Tue, 13 Apr 2021 04:15:24 -0400
X-MC-Unique: zlIbAxJLNhe2uNz80O9ISA-1
Received: by mail-ed1-f71.google.com with SMTP id ay2-20020a0564022022b02903824b52f2d8so864147edb.22
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 01:15:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nTFiVrT0GgD5PF9g9cQQkkjhncBa1KbZqSegCvRQvn4=;
        b=oD4aBZPSH21Pnkpxf2WTaX4YjKcwJQcjNMDU+mHIP6qsFz6THLndLGOTMebyjK+HZ+
         XxZsMzu7Co2XP/TDoCK/+G/8jlzYDrRQorI0z1EnQJhLZgUgZ0YKzcznZpt6blns+OZ1
         TpU9fAP6AwUfGGPz7hHrynuo2Zuh5K01FHa7pX5CjbHn2foIVXXcD1DpT18ranxerDYi
         tZ8eVrHT5AO/6YOyfLcY/gd2ww9VhJd03JSo/Weqw5vjOt99ci7OekWqzXd0AJBKp8nb
         MXhIoQSSEHHGr+FgJcdfudbicZsKaNUzWOeD0fYfXMv1ymYayDFIoT9XTX32v6iVdAn1
         3gzQ==
X-Gm-Message-State: AOAM533mLlNp3oiUu+PgQ6s5NMnlBDw852WSsPaYf66AJlOMZm+rAFOI
        +DTyS1cZbMKxS+I6ybqfmbzktQfzI7JkfKg6JkJoIchBheumkn7B5HCXYzxjWfwxA6lwuuXm15X
        +EXiasUUT20ikuWTmP30uTv1Q
X-Received: by 2002:a05:6402:397:: with SMTP id o23mr19472034edv.337.1618301723432;
        Tue, 13 Apr 2021 01:15:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzbPHudOXUmsNugaD59P5i3wwKB0R8vC8IfvhLAFrMijrE1tBnQX1luZYokPoXHvmhSv5ej6Q==
X-Received: by 2002:a05:6402:397:: with SMTP id o23mr19472018edv.337.1618301723306;
        Tue, 13 Apr 2021 01:15:23 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id a24sm5082808ejr.58.2021.04.13.01.15.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Apr 2021 01:15:22 -0700 (PDT)
Subject: Re: [PATCH v2] platform/x86: pmc_atom: Match all Beckhoff Automation
 baytrail boards with critclk_systems DMI table
To:     Steffen Dirkwinkel <linux-kernel-dev@beckhoff.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
References: <CAHp75VeTK9TstuRCqOkVit9U7sV7TA_xcTQ1yZPGfLdZSt7_Gg@mail.gmail.com>
 <20210412133006.397679-1-linux-kernel-dev@beckhoff.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <99cf068d-1ead-e3a2-124e-1db4025afdc4@redhat.com>
Date:   Tue, 13 Apr 2021 10:15:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210412133006.397679-1-linux-kernel-dev@beckhoff.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/12/21 3:30 PM, Steffen Dirkwinkel wrote:
> From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
> 
> pmc_plt_clk* clocks are used for ethernet controllers, so need to stay
> turned on. This adds the affected board family to critclk_systems DMI
> table, so the clocks are marked as CLK_CRITICAL and not turned off.
> 
> This replaces the previously listed boards with a match for the whole
> device family CBxx63. CBxx63 matches only baytrail devices.
> There are new affected boards that would otherwise need to be listed.
> There are unaffected boards in the family, but having the clocks
> turned on is not an issue.
> 
> Fixes: 648e921888ad ("clk: x86: Stop marking clocks as CLK_IS_CRITICAL")
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans




> ---
>  drivers/platform/x86/pmc_atom.c | 28 ++--------------------------
>  1 file changed, 2 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/platform/x86/pmc_atom.c b/drivers/platform/x86/pmc_atom.c
> index ca684ed760d1..a9d2a4b98e57 100644
> --- a/drivers/platform/x86/pmc_atom.c
> +++ b/drivers/platform/x86/pmc_atom.c
> @@ -393,34 +393,10 @@ static const struct dmi_system_id critclk_systems[] = {
>  	},
>  	{
>  		/* pmc_plt_clk* - are used for ethernet controllers */
> -		.ident = "Beckhoff CB3163",
> +		.ident = "Beckhoff Baytrail",
>  		.matches = {
>  			DMI_MATCH(DMI_SYS_VENDOR, "Beckhoff Automation"),
> -			DMI_MATCH(DMI_BOARD_NAME, "CB3163"),
> -		},
> -	},
> -	{
> -		/* pmc_plt_clk* - are used for ethernet controllers */
> -		.ident = "Beckhoff CB4063",
> -		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Beckhoff Automation"),
> -			DMI_MATCH(DMI_BOARD_NAME, "CB4063"),
> -		},
> -	},
> -	{
> -		/* pmc_plt_clk* - are used for ethernet controllers */
> -		.ident = "Beckhoff CB6263",
> -		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Beckhoff Automation"),
> -			DMI_MATCH(DMI_BOARD_NAME, "CB6263"),
> -		},
> -	},
> -	{
> -		/* pmc_plt_clk* - are used for ethernet controllers */
> -		.ident = "Beckhoff CB6363",
> -		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Beckhoff Automation"),
> -			DMI_MATCH(DMI_BOARD_NAME, "CB6363"),
> +			DMI_MATCH(DMI_PRODUCT_FAMILY, "CBxx63"),
>  		},
>  	},
>  	{
> 

