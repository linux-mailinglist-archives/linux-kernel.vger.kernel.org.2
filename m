Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA75643CC33
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 16:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242545AbhJ0OaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 10:30:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26774 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238437AbhJ0OaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 10:30:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635344874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KHHrb1tiDY2STHq9SuLRvZy3hZaADD9wEfu9gCQmDxI=;
        b=hCv8kQkNku+8meoACWj3g7MvMYCo0vjOu3KGRhPncCvf3E4W7QJdIv8n3/NGtPtz6YFdeq
        yR5anNlVrImLOXPvzlqqHoB8lr1dTGpOD7V5oi/8ZhEG6uYdC4XrTICU3IrWWnEQuf2quV
        l7t2mgtD24SzDm2bjmPVKLB++CZboOM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-549-X6o1R3l_PBa5FdcUMi6Ovw-1; Wed, 27 Oct 2021 10:27:52 -0400
X-MC-Unique: X6o1R3l_PBa5FdcUMi6Ovw-1
Received: by mail-ed1-f70.google.com with SMTP id g6-20020a056402424600b003dd2b85563bso2477768edb.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 07:27:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KHHrb1tiDY2STHq9SuLRvZy3hZaADD9wEfu9gCQmDxI=;
        b=RUdKQhvX/g7zzmAudMVJe68YxrQ6E8nnb2BaXRBihtIL+zQnrM3tdO57HApArLbd+u
         j3KbpJay93aSJSKIRSztrN1XtKwr5Bv5gZ/4Lb7S/r641iJ1k06wrjsC1Lj8dDJcHYe8
         QudoXF7sFIWW53DQ0wgTR7T+IO7YZKoogmMEp+Cm8o+pFmCz+7z1n1xN3KeLGGOCZUA/
         bdUBBrgQcUh45TbSjbppGlZ54OtnHbMUWn0bR5Vb6HNKEQCnREOZauF75CDyrYH7iMeR
         sWttVt3dZQmyQgfrRCqqBvZ/T5Xlpkh6577jbU/ku41EuEX8Lb2Bh9ZrkpL8ogH0LLwC
         ZiZQ==
X-Gm-Message-State: AOAM533L4U2/V2BGbQrTrnst3mDGbIcMFJmN6zzi/54wA/W/0B2bMfoz
        Sf3CgpnOUNu40p7pPU6+Owsw3/nvxC2kXfQCaTDDXW5imBCzRir/+k90IgLJv8cywpF1GH/4yn6
        Bx6YhPlt59eNC+ylmmPpgY9p2
X-Received: by 2002:a17:907:961a:: with SMTP id gb26mr17802489ejc.527.1635344871503;
        Wed, 27 Oct 2021 07:27:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7TA88/kBuw1NJY7C8S9WnDH4N9C07D2dZ27TMGAfrekL2kIaYn912rjHXCE9gQ/3xdFOx4A==
X-Received: by 2002:a17:907:961a:: with SMTP id gb26mr17802469ejc.527.1635344871372;
        Wed, 27 Oct 2021 07:27:51 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id q23sm47512ejr.0.2021.10.27.07.27.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Oct 2021 07:27:51 -0700 (PDT)
Message-ID: <3ad75583-b37e-8700-d062-42426966d912@redhat.com>
Date:   Wed, 27 Oct 2021 16:27:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v1 0/2] ACPI: scan: Honor certain device identification
 rules
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
References: <11860508.O9o76ZdvQC@kreacher>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <11860508.O9o76ZdvQC@kreacher>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/26/21 20:51, Rafael J. Wysocki wrote:
> Hi All,
> 
> There are some rules in the ACPI spec regarding which device identification
> objects can be used together etc., but they are not followed by the kernel
> code.
> 
> This series modifies the code to follow the spec more closely (see patch
> changelogs for details).

Both changes seem sensible to me; and since you make _HID take precedence
over _ADR I don't expect this to cause any regressions on BYT / CHT
hardware (the other way around will likely be an issue).

So for the series:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

