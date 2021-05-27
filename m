Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47C96392AAA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 11:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235793AbhE0JZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 05:25:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24928 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235740AbhE0JZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 05:25:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622107417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u/jxxyRApH7aRU/uOFFHnJ9R4si2NeFb5W7OXIxVnqE=;
        b=QLKZX6sfSGyT3G5FdE+i8QB3Ft8nd+p/QZ3WnJd2j3n6AfnDOEZPXrt09zQnkT5lvo6i1L
        rs8N16z6tad3Ey16S8fQqkNIg99EnfWly2Ia+Jif/zH+MGWD6uw0rnvqXUidQEd3Mwky3I
        AFHN0kPkm3gIOsf65xvw4JqDoePNPOs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-590-TPA4Aa4QNJybAVx0bDoxmQ-1; Thu, 27 May 2021 05:23:34 -0400
X-MC-Unique: TPA4Aa4QNJybAVx0bDoxmQ-1
Received: by mail-ej1-f71.google.com with SMTP id z1-20020a1709068141b02903cd421d7803so1427338ejw.22
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 02:23:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u/jxxyRApH7aRU/uOFFHnJ9R4si2NeFb5W7OXIxVnqE=;
        b=Wq0oyVbRciK6e3Js9VB0SZjnIZTkOX5FToifWHV4y1zeALk8YJRR6Bdenb53Tod+Pv
         pVo99mAs23jMVIQHzAFY1F12OC0Q6WtDXhkCcEHnD4b+NQMadG17U8jt80XIKrkfx0vJ
         8fETJcZVrs5W+GrP4DsUf4HoQpq4kx4u636sex+qYd3Lm4W584R4m5Vf77BwPPNOMPOJ
         HjLQBX/KuN0dgys7wzKDH3+wyFSy9IaW7MUT+cJNwKwQG0lSRJdSZP7M6s+DGBxX8XvU
         d2vpXvT4/4Idd3PCSwAKVuHR6lJhoMFrKWneodE1OUSp8zjkKRpChvUAAC2RDNUmp+Ye
         U1fQ==
X-Gm-Message-State: AOAM531MWoII+Aywrg8h59+3ktnh+jPl/VLRTvEGShrs4+N17qWBjH3d
        6BqnBfpJQ582bEreNFpbA1lnEdttHsWuOMqwV94pExCA3qO7Mdp2vUn/mHKEqX39fyVbAC4wh7c
        MQrjF9Wmn6++ntyCubs10vndYoOExCXyJHDQkXbCl4+OoqVlK3fsc2bFjvmG9G4LeHDgG9EeXzh
        P/
X-Received: by 2002:a17:906:5210:: with SMTP id g16mr2848900ejm.116.1622107413468;
        Thu, 27 May 2021 02:23:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwcjpCut/sI96DejpRN+VAuRaAHUFFepAK5jt0WONw18JAs+EBp7IO2oczxNea4slk7KA0wjg==
X-Received: by 2002:a17:906:5210:: with SMTP id g16mr2848872ejm.116.1622107413249;
        Thu, 27 May 2021 02:23:33 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id f18sm705138ejz.119.2021.05.27.02.23.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 May 2021 02:23:32 -0700 (PDT)
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: add X1 Carbon Gen 9 second
 fan support
To:     Til Jasper Ullrich <tju@tju.me>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc:     Mark Gross <mgross@linux.intel.com>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210525150950.14805-1-tju@tju.me>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <7a568685-9849-7642-c193-14e3bfc8cf77@redhat.com>
Date:   Thu, 27 May 2021 11:23:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210525150950.14805-1-tju@tju.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/25/21 5:09 PM, Til Jasper Ullrich wrote:
> The X1 Carbon Gen 9 uses two fans instead of one like the previous
> generation. This adds support for the second fan. It has been tested
> on my X1 Carbon Gen 9 (20XXS00100) and works fine.
> 
> Signed-off-by: Til Jasper Ullrich <tju@tju.me>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

I'll also cherry-pick this into the fixes branch so that it will
be included in my next pdx86/fixes pull-req for 5.13.

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans



> ---
>  drivers/platform/x86/thinkpad_acpi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index dd60c9397d35..edd71e744d27 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -8853,6 +8853,7 @@ static const struct tpacpi_quirk fan_quirk_table[] __initconst = {
>  	TPACPI_Q_LNV3('N', '2', 'O', TPACPI_FAN_2CTL),	/* P1 / X1 Extreme (2nd gen) */
>  	TPACPI_Q_LNV3('N', '2', 'V', TPACPI_FAN_2CTL),	/* P1 / X1 Extreme (3nd gen) */
>  	TPACPI_Q_LNV3('N', '3', '0', TPACPI_FAN_2CTL),	/* P15 (1st gen) / P15v (1st gen) */
> +	TPACPI_Q_LNV3('N', '3', '2', TPACPI_FAN_2CTL),	/* X1 Carbon (9th gen) */
>  };
> 
>  static int __init fan_init(struct ibm_init_struct *iibm)
> --
> 2.31.1
> 

