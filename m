Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC6E23FC3C2
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 10:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239822AbhHaHjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 03:39:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52235 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231537AbhHaHjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 03:39:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630395489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5mQhLKnJ2xoUp4bk3hcpO+tGdeMZNuwhxgy5Bf2xxIw=;
        b=HrTBd8O1NIvc16KxTg+z+jMW94eprrgOQzsHMJoNAdM74MBWudKlaks7TzLWGTnFsoI6Xg
        tsNzvJXqCkC2PxT+2JvCyn5pG9M7lJIbR4BotEz/uLqK9SRny7WbdkZMChIZomY6SrC5sG
        uE6R/q9N9PJ9hJpwHhsopupQ8BMntuY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-uu9qxoYxNDSHhtgoyAcG2g-1; Tue, 31 Aug 2021 03:38:07 -0400
X-MC-Unique: uu9qxoYxNDSHhtgoyAcG2g-1
Received: by mail-ej1-f71.google.com with SMTP id v19-20020a170906b013b02905b2f1bbf8f3so698561ejy.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 00:38:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5mQhLKnJ2xoUp4bk3hcpO+tGdeMZNuwhxgy5Bf2xxIw=;
        b=BUca0xqVmMXdxvlUy3zB7PsTtzrPG9kcN03v+cPu2p20yolhMvZWPEWX2u/yHTHgxU
         dvxF1QDB9njpAm2JgYltGNbHmwfmz7126SlwhvQ1BcPYf0nUvtPNunpABljhhXu0fT27
         JC7JAOFgvX2VJiWgl76fw+KufTrvYmEx1QdBvFSXxyPXcU4UHl5xsPAh320Q2u80ev3B
         oAJdHQwMsfSIYqJ8fqVY53b6tHPfyDcGespq/LazsBbzJciTEWZfSdmgXZ9Ye9zp2c/7
         s2xVLj5mdRzv3akVJJXNIfgLKKctidw23TBYSI3T30MStMSDQcxjJ5EsvfnHwwhn4Nxj
         eZHg==
X-Gm-Message-State: AOAM5327Zj7SJAxiRyYueGxfSPrw4AJrgjUtcdizX9ArrtJF5hIbJ3tM
        mT7QsUbTqEHo6NJSZwTcau62ML/lvJV/ZqOJL5F4Tm5Xiy26gy9ttepxdaBEPkhaJJx2nIybNwr
        zwcSikFdMXaVJNlDzHma+feiSIxDWJHvnw+nMgX6pnyixBMumupufsauFOuvQVOVCQq0GhoaNnk
        Kx
X-Received: by 2002:a17:906:7716:: with SMTP id q22mr30015663ejm.457.1630395485929;
        Tue, 31 Aug 2021 00:38:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxLUWFAXTEKfEy/di0/LWfct67mDIywsCfy24A1pBzQGFAYAhL7mGPAFEZNKhwTmY5sUCRFsw==
X-Received: by 2002:a17:906:7716:: with SMTP id q22mr30015653ejm.457.1630395485727;
        Tue, 31 Aug 2021 00:38:05 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id f30sm7609956ejl.78.2021.08.31.00.38.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Aug 2021 00:38:05 -0700 (PDT)
Subject: Re: [PATCH v3 0/1] libata: Add ATA_HORKAGE_NONCQ_ON_AMD for Samsung
 860 and 870 SSD.
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Kate Hsuan <hpa@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210830144253.289542-1-hpa@redhat.com>
 <DM6PR04MB708147357F91D5AEB6128A2AE7CB9@DM6PR04MB7081.namprd04.prod.outlook.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <a76b2acd-edfa-55b2-907c-f1faa8ce4914@redhat.com>
Date:   Tue, 31 Aug 2021 09:38:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <DM6PR04MB708147357F91D5AEB6128A2AE7CB9@DM6PR04MB7081.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/30/21 11:45 PM, Damien Le Moal wrote:
> On 2021/08/30 23:43, Kate Hsuan wrote:
>> Many users reported the issue when running the system with Samsung 860,
>> 870 SSD, and AMD chipset. Therefore, completely disabling the NCQ can
>> avoid this issue.
>>
>> Entire disabling NCQ for Samsung 860/870 SSD will cause I/O performance
>> drop. In this case, a flag ATA_HORKAGE_NONCQ_ON_AMD is introduced to
>> used to perform an additional check for these SSDs. If it finds its parent
>> ATA controller is AMD, the NCQ will be disabled. Otherwise, the NCQ is kept
>> to enable.
> 
> For a single patch, generally, a cover letter is not needed. Especially so in
> this case since your cover letter message is the same as the patch commit message.
> 
>>
>> Changes since v3
>> * Modified the flag from ATA_HORKAGE_NONCQ_ON_ASMEDIA_AMD_MARVELL to
>>   ATA_HORKAGE_NONCQ_ON_AMD.
>> * Modified and fixed the code to completely disable NCQ on AMD controller.
> 
> Technically, this is a v2 right ? Also, by "completely", did you mean "always" ?
> (see patch comments).

Right, as mentioned in my reply to the v1 which was accidentally labelled v2
I suggested to just make this v3 to avoid confusion, otherwise we would have
2 v2-s.

Regards,

Hans

