Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00F2A399F81
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 13:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhFCLI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 07:08:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43190 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229665AbhFCLI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 07:08:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622718433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dcBt514DAgpwi2c+GjWuvkXxC4u2Bwwf8osuVxsYnHg=;
        b=Slza+XIkmsUcNhfsezL7Y8yqo8oGc5sLLMyV68PYQDQUczr+urwUqG1op2cc8WOQ8eMGHf
        jV2YpOq/oKezz1V/IddaS4Qt65b1DrSp/ejwxybb/IheczqbRohGE8ShyykTq4/1YZ9R2R
        1B1hA94Sf2bRsdqnj9mw44WvZhx+57k=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-jUrU49XaNA-ncfZ9GvMHbg-1; Thu, 03 Jun 2021 07:07:11 -0400
X-MC-Unique: jUrU49XaNA-ncfZ9GvMHbg-1
Received: by mail-ej1-f71.google.com with SMTP id h18-20020a1709063992b02903d59b32b039so1829904eje.12
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 04:07:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dcBt514DAgpwi2c+GjWuvkXxC4u2Bwwf8osuVxsYnHg=;
        b=ADVSOGAKxdp3XBKggtf8yRtlFrJbbSkzYZuBxG3tnXniM3qdlyLAIeO370Py0sN9rl
         jNKZVVYFlGt/3hDQNQL1slgnGa5B7hW+Lu0OmJasHFPMVmlGNiTngln7oXo3GDmS4OyU
         DlOpQLZjUJ0+kAUykhsAEIGsNA6BMOcHdV9ohsLoSNBwPL5OY3A/6qZgS5SKcCSgygx7
         ktvdzEYyzb3isQvmModf7m4NjrGngDL/QH5pt3/8gOeS+RjRpCSi8RVQxEX/V1OhlC1G
         +dBnHfQMKt2AE/KpNYEsMjAoklJEv3TgPa1J3yQULIQCUESz/oPp/orofOYLiH+qZZeG
         Z5Ow==
X-Gm-Message-State: AOAM533S5uIXIU4vM99v58/jIdIUpZ5d/g97mbi27gmOhhL2+dago27G
        UJRGyZ7By4fGDcRkvpnj70hr7K1TAlW+LdamZr00I3dRvxnYuIvD0m20OQQneOqV/vZZ9g2gfXN
        W/nA++dFLRtNPcWadNxs8snM86HFx3BCizX0LB1gtGYSeNbyhcaz+O3X0B+Ab2AiMVYrjkq4O8R
        W/
X-Received: by 2002:a17:906:3f86:: with SMTP id b6mr38848961ejj.530.1622718430532;
        Thu, 03 Jun 2021 04:07:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy3PMVYbjbJddxU25OBr5xYm6aX3+jkxIqTirZdNAI+NdlxWC7RrIl49J72AZw4TNhaX7ujNQ==
X-Received: by 2002:a17:906:3f86:: with SMTP id b6mr38848948ejj.530.1622718430315;
        Thu, 03 Jun 2021 04:07:10 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id kj1sm1399239ejc.10.2021.06.03.04.07.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 04:07:09 -0700 (PDT)
Subject: Re: [PATCH] platform/surface: aggregator: Fix event disable function
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210603000636.568846-1-luzmaximilian@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <8e6330ca-a2ee-acd4-b5d7-0f7a828d132c@redhat.com>
Date:   Thu, 3 Jun 2021 13:07:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210603000636.568846-1-luzmaximilian@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/3/21 2:06 AM, Maximilian Luz wrote:
> Disabling events silently fails due to the wrong command ID being used.
> Instead of the command ID for the disable call, the command ID for the
> enable call was being used. This causes the disable call to enable the
> event instead. As the event is already enabled when we call this
> function, the EC silently drops this command and does nothing.
> 
> Use the correct command ID for disabling the event to fix this.
> 
> Fixes: c167b9c7e3d6 ("platform/surface: Add Surface Aggregator subsystem")
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

I'll also add this to the fixes branch, so that it gets included
in my next pull-req to Linus for 5.13.

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans

> ---
>  drivers/platform/surface/aggregator/controller.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/surface/aggregator/controller.c b/drivers/platform/surface/aggregator/controller.c
> index 8a70df60142c..a06964aa96e7 100644
> --- a/drivers/platform/surface/aggregator/controller.c
> +++ b/drivers/platform/surface/aggregator/controller.c
> @@ -1907,7 +1907,7 @@ static int ssam_ssh_event_disable(struct ssam_controller *ctrl,
>  {
>  	int status;
>  
> -	status = __ssam_ssh_event_request(ctrl, reg, reg.cid_enable, id, flags);
> +	status = __ssam_ssh_event_request(ctrl, reg, reg.cid_disable, id, flags);
>  
>  	if (status < 0 && status != -EINVAL) {
>  		ssam_err(ctrl,
> 

