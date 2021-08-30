Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBFE63FB209
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 09:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234084AbhH3HpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 03:45:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25098 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233318AbhH3Ho7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 03:44:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630309445;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VbCYBJ5L58cJSBbw8FF7cXPHj0GCoH2oZb8jcw5g0h8=;
        b=SK07Gkh6tX65EksT9/dJz9cOu1sVKE3Y+eMoS0tCs9Qv20cz/lbVc3GQv98GfwsNcJ5Zdn
        WqNVpRhNw0DuPMYJJPHyySDVbnQBSombzwxhJsr2NVEgOtKdv7+emC8IeKiTcOH1skH3f5
        sfXgfuYUF/Y5ZlZvyTqJ5gbpWclg7EA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-qMpD1J5RMLmmmfLZkKOf5w-1; Mon, 30 Aug 2021 03:44:03 -0400
X-MC-Unique: qMpD1J5RMLmmmfLZkKOf5w-1
Received: by mail-ed1-f69.google.com with SMTP id s25-20020a50d499000000b003c1a8573042so6093007edi.11
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 00:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VbCYBJ5L58cJSBbw8FF7cXPHj0GCoH2oZb8jcw5g0h8=;
        b=jqNqeSugdtWcuZy+pWBi6cBxc7Pq3thhs+3VUZqbQ2VXgDlaTqUAxvm+uyENtyCxK9
         9K1xjUKn1cmxTd1qKIzWhfjtXMQneGpHKjNnuGpOJf2eNS4KYeW/9qAFW9cqgp8Kx9Qw
         3tCXznlUagsq9/V+BAcK+UJH1c8Mfi99sOBnp47RyZ4ygPCNikYSy9feSgX6Q48Wy2L8
         qrz/B1p/PiE4F5V8GmbWQBuxRlyI1JgVu0qmw0d1RyYT/jOOjfYhWIZr1ZohWFJCoK/y
         R/UDIoXuXVEsjFF4R9FR8I31g7upbBh8G4aVmjrkK65ZS4sKQTnI3o33Dw2WZeaG5xGH
         507Q==
X-Gm-Message-State: AOAM533aQFel5xeVMrUsn7YEnYLnQ+T4/u2MV8emNEYAnVFO7heAvKFD
        yq/OCCm96Az4wGLvqIL9fbiIDlFLEnjhTZE9JnIdlBXYJooYqh3gXs5dCDQIPQoCo0KVE5F0XAS
        KfcEH8ho3r055R1+jBwZznbvV2zv3m+yrLkLikH0RooLm2RqB9Or4owpsJg67sygA0E3zf5SHof
        WM
X-Received: by 2002:a50:8ad7:: with SMTP id k23mr22927475edk.310.1630309442373;
        Mon, 30 Aug 2021 00:44:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJytmTh1FuKFfXv/3tgJfJ6JpdS3PLc9jKKnTuqyAPzyF74S8/dKUzr1ZIs7kfe5olfMkIWLmg==
X-Received: by 2002:a50:8ad7:: with SMTP id k23mr22927451edk.310.1630309442116;
        Mon, 30 Aug 2021 00:44:02 -0700 (PDT)
Received: from x1.localdomain ([81.30.35.201])
        by smtp.gmail.com with ESMTPSA id b8sm7108980edv.96.2021.08.30.00.44.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Aug 2021 00:44:01 -0700 (PDT)
Subject: Re: [PATCH 0/3] staging: rtl8723bs: remove lockdep warning
To:     Fabio Aiuto <fabioaiuto83@gmail.com>, gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <cover.1630307025.git.fabioaiuto83@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <85ef4038-24e7-fdd4-fe42-35416f705b99@redhat.com>
Date:   Mon, 30 Aug 2021 09:44:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <cover.1630307025.git.fabioaiuto83@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/30/21 9:09 AM, Fabio Aiuto wrote:
> This patchseries removes a lockdep warning that turned out to
> be a false positive.
> 
> All "lockable" queues in the driver are initialized by
> a single function. This confuses lockdep which puts all
> locks in the same unexistent class.
> 
> Fixed it by doing the initalization of queues in place.
> 
> Done a small code cleaning and removed the no more
> used function.
> 
> Tested-on: Lenovo ideapad Miix 300-10IBY

Thank you so much for fixing this.

The entire series looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

For the series.

Regards,

Hans





> 
> Fabio Aiuto (3):
>   staging: rtl8723bs: unwrap initialization of queues
>   staging: rtl8723bs: remove unnecessary parentheses
>   staging: rtl8723bs: remove unused _rtw_init_queue() function
> 
>  drivers/staging/rtl8723bs/core/rtw_ap.c       |  3 +-
>  drivers/staging/rtl8723bs/core/rtw_cmd.c      |  3 +-
>  drivers/staging/rtl8723bs/core/rtw_mlme.c     |  6 ++--
>  drivers/staging/rtl8723bs/core/rtw_recv.c     | 12 ++++---
>  drivers/staging/rtl8723bs/core/rtw_sta_mgt.c  | 15 ++++++---
>  drivers/staging/rtl8723bs/core/rtw_xmit.c     | 33 ++++++++++++-------
>  .../staging/rtl8723bs/hal/rtl8723bs_recv.c    |  6 ++--
>  .../staging/rtl8723bs/os_dep/osdep_service.c  |  7 ----
>  8 files changed, 52 insertions(+), 33 deletions(-)
> 

