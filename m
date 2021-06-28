Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17E103B5ACC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 11:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbhF1JEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 05:04:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38120 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231935AbhF1JEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 05:04:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624870905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YSVaYiflx1SeHj//NhESyitcGuHf7twGbF1g3UdTqwM=;
        b=ZxxLiV5cKNhbywp+toIKn+YOs4YE7BRVQd9NNPa/rGDLl2tuGfk09zvRiB5VaQpJjkQjfL
        V++f82gbMud45uEnxv8qA+p2BwFcVtcryC56Q+Jp5HvTomeKGOasbmwTsHNe+uov7MYV4x
        C3cGOhMxfj4eapoXICRiF0/8i80CQhs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-OljiJ-MKP22Fudr1L-VBMg-1; Mon, 28 Jun 2021 05:01:44 -0400
X-MC-Unique: OljiJ-MKP22Fudr1L-VBMg-1
Received: by mail-ej1-f72.google.com with SMTP id ho42-20020a1709070eaab02904a77ea3380eso4092104ejc.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 02:01:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YSVaYiflx1SeHj//NhESyitcGuHf7twGbF1g3UdTqwM=;
        b=CsEd+Wr8JMy/l3ewmgEV6meYoiD3sUSL62uMeJE73r+JYkwI+l36Z3UbuXVZE8vdAL
         kEoFZTTxfOt0mbIPq5ragegBnTdK3MvKaCPNr1o2Kg+4AImqrVkvAZgXzFRNiddOuZPB
         u2cTDghU/rVbSiH95x2QSuKoUU5JL56z76qD3VBGktrNwgbPdPU9qcEsouMoATSz3jmD
         mqL/g7tDVE+ihujZ3zDVrMNjkEhmlS4WoLRqATjkNNmkhZ/WaJO6vMxFRSnwOtgNZXTE
         VJfeoQRCt/tabBJAyJYCY5OExqLKb3TVpa+UblZ8TcrMrpby/DQrGgoNvt59r+XKZVr+
         qcHg==
X-Gm-Message-State: AOAM533fbvEAg4TdkNPUGP71w9dk45IQdYav4+XJ144EcBleixEOjhXE
        0uRqJ8rr/Ncf65lr+dVKgij0VIsH8ABvedlJhTmwZj/DMP9tR1uL3mIdOA6UBzwi7Z9ie4aKpsT
        rWc0yxhIvUMvExPlg89cmRLpS
X-Received: by 2002:a17:906:2844:: with SMTP id s4mr23084238ejc.263.1624870902961;
        Mon, 28 Jun 2021 02:01:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxrx5m8n/Qj4hNbL00gXrN8ViquI032VdXMGuqLGnSgmbo1CV23S2WOpo6+cmsKSdDF5Wk/8Q==
X-Received: by 2002:a17:906:2844:: with SMTP id s4mr23084225ejc.263.1624870902816;
        Mon, 28 Jun 2021 02:01:42 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id o9sm4492306edc.91.2021.06.28.02.01.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jun 2021 02:01:42 -0700 (PDT)
Subject: Re: [PATCH] platform/x86: dell-wmi-sysman: Change user experience
 when Admin/System Password is modified
To:     Prasanth KSR <kosigiprasanth@gmail.com>, dvhart@infradead.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Prasanth KSR <prasanth.ksr@dell.com>,
        Divya Bharathi <divya.bharathi@dell.com>
References: <20210628084906.4233-1-prasanth.ksr@dell.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <e9818bf6-13fb-dec1-c2ee-87ecb2b2cc20@redhat.com>
Date:   Mon, 28 Jun 2021 11:01:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210628084906.4233-1-prasanth.ksr@dell.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/28/21 10:49 AM, Prasanth KSR wrote:
> Whenever user has changed an Admin/System Password using the sysfs,
> then we are automatically copying the new password to existing
> password field.
> 
> Co-developed-by: Divya Bharathi <divya.bharathi@dell.com>
> Signed-off-by: Divya Bharathi <divya.bharathi@dell.com>
> Signed-off-by: Prasanth KSR <prasanth.ksr@dell.com>

Thank you.

I assume this was tested?  The reason I'm asking because in the
Lenovo Think* case it turned out that the modified password only
becomes active after a reboot, so the right thing to do there was
to just keep current_password as is.

Regards,

Hans



> ---
>  .../x86/dell/dell-wmi-sysman/passwordattr-interface.c         | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/passwordattr-interface.c b/drivers/platform/x86/dell/dell-wmi-sysman/passwordattr-interface.c
> index 339a082d6c18..86ec962aace9 100644
> --- a/drivers/platform/x86/dell/dell-wmi-sysman/passwordattr-interface.c
> +++ b/drivers/platform/x86/dell/dell-wmi-sysman/passwordattr-interface.c
> @@ -95,9 +95,9 @@ int set_new_password(const char *password_type, const char *new)
>  
>  	print_hex_dump_bytes("set new password data: ", DUMP_PREFIX_NONE, buffer, buffer_size);
>  	ret = call_password_interface(wmi_priv.password_attr_wdev, buffer, buffer_size);
> -	/* clear current_password here and use user input from wmi_priv.current_password */
> +	/* on success copy the new password to current password */
>  	if (!ret)
> -		memset(current_password, 0, MAX_BUFF);
> +		strscpy(current_password, new, MAX_BUFF);
>  	/* explain to user the detailed failure reason */
>  	else if (ret == -EOPNOTSUPP)
>  		dev_err(&wmi_priv.password_attr_wdev->dev, "admin password must be configured\n");
> 

