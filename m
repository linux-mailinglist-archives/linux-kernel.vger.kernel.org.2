Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E955D3B8336
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 15:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234919AbhF3NfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 09:35:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57655 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234912AbhF3NfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 09:35:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625059957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B29ak5IExuV5xQ1UDepJEEmvvBRdoZ1X4KzbA2i8hEA=;
        b=RkYILSBCb6t5tgujBehohOGsQrD64RpXL0lJaXDHah3aGAqHFC8/Pp3TAHrCcqDkKfkWlT
        NUf+GRz/p/mZ56phGl35bcf40vJj/u2qtRgeSW2Qcc/IGWjy52xC6//YNQ1VRp6dUlSrDQ
        dZtmEQ+tBgJ3kzi1/A34tgV735ml+Hc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-xMiVQ7rTMeayuJ4qLGTlaA-1; Wed, 30 Jun 2021 09:32:36 -0400
X-MC-Unique: xMiVQ7rTMeayuJ4qLGTlaA-1
Received: by mail-ej1-f70.google.com with SMTP id gn22-20020a1709070d16b02904baf8000951so764815ejc.10
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 06:32:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B29ak5IExuV5xQ1UDepJEEmvvBRdoZ1X4KzbA2i8hEA=;
        b=Up38KeNU6zDZxqJZSqL0fwH5/bGebpGBRDyhCVWM5GukCyTt9aysqAmTB0hBNC6d4/
         V9bzHptqBo2ZgHCQF9/Jv6RuFuFHS5c74wVx8N8+ZCFoCrmtCKus1pOorhMoNWPz/uMg
         XdSv4cvgru/sITQoeVxw3GAW1oXXBM6o72Q1PqqXR4CFISlvvYx4ADw6cWAUrady4K3V
         dR7ftgEouH8Kku/izDcNTQprMc+Ig2yBxL70/y47kzn/ONxAN3KyUQPiYX6tKF5PFf51
         5Qe2ogSRIfkl7mLmQJZ8v/GUEn6AIupzu8jduglcYFzC6GBS7KYhhATmO2hpB30pwJTy
         QMaQ==
X-Gm-Message-State: AOAM532DZ2VhJM+HqIqGqZPaz3rrpDwZo9vwJfbSPMmBRn0B6J/mHTLW
        0jYqkUAkiJ/+roTOVkbJO4UCHqzquvQMLNCo7Xb/lGQu75RfiWHfYV6G6TXhhkSowCNEzYv7oIf
        h7FQsj1lCTyuFP+oBn2dxizo7
X-Received: by 2002:a17:906:dbec:: with SMTP id yd12mr34810485ejb.102.1625059955163;
        Wed, 30 Jun 2021 06:32:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQ5GhWHaEAX58lymQvyY8OwdxenbawrCEZf5DE+XckN7hrGGFvvP7XTqTStlpUqZk2fj1vcQ==
X-Received: by 2002:a17:906:dbec:: with SMTP id yd12mr34810464ejb.102.1625059954972;
        Wed, 30 Jun 2021 06:32:34 -0700 (PDT)
Received: from x1.bristot.me (host-79-46-33-140.retail.telecomitalia.it. [79.46.33.140])
        by smtp.gmail.com with ESMTPSA id q5sm9396081ejc.117.2021.06.30.06.32.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jun 2021 06:32:34 -0700 (PDT)
Subject: Re: [PATCH][next] trace: osnoise: Fix u64 less than zero comparison
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Colin King <colin.king@canonical.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ingo Molnar <mingo@redhat.com>
References: <20210629165245.42157-1-colin.king@canonical.com>
 <c74e711e-71c9-df9c-8406-b9e92ef12da0@redhat.com>
 <20210630090544.13c0a4df@oasis.local.home>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <2b6cf10b-d1e1-d0a4-f27e-79625d55e6c9@redhat.com>
Date:   Wed, 30 Jun 2021 15:32:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210630090544.13c0a4df@oasis.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/30/21 3:05 PM, Steven Rostedt wrote:
> On Tue, 29 Jun 2021 19:19:25 +0200
> Daniel Bristot de Oliveira <bristot@redhat.com> wrote:
> 
>>> Addresses-Coverity: ("Unsigned compared against 0")
>>> Fixes: bce29ac9ce0b ("trace: Add osnoise tracer")
>>> Signed-off-by: Colin Ian King <colin.king@canonical.com>  
>> Steven, can we merge the flags?
> I don't usually do that. 

Ack!

-- Daniel

