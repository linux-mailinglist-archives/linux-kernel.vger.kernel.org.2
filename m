Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA5C93EC971
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 15:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238351AbhHON56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 09:57:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32736 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234012AbhHON56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 09:57:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629035847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z+FVfSl1vem65U43CNnC7At1r0k8wQFh2G3xl/DpsqI=;
        b=DMxqqPp+OeKlEEeRN+WHTNlSMBAy0VZih9t4o+s1ziyVZn+IHPKjvON5W0nDh3XrJ+OoYZ
        YbWml0SUNIFZFUWJsPvp7/GHo7MWr4jxN4EYYDDTQ7mFcLAH7978QOWzcnKJX5Lc9H0KmK
        X3rx6575tvU8ESAYZA0AN2YGtPPbdXY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-bCrIlSW-N3S41mTZCbcHhw-1; Sun, 15 Aug 2021 09:57:26 -0400
X-MC-Unique: bCrIlSW-N3S41mTZCbcHhw-1
Received: by mail-ed1-f71.google.com with SMTP id u4-20020a50eac40000b02903bddc52675eso7404314edp.4
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 06:57:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z+FVfSl1vem65U43CNnC7At1r0k8wQFh2G3xl/DpsqI=;
        b=lqw0kxGwrZypoHs6Bpxus+4n3i0GEmLz5XU8fR67eVriHEq0cwmiTGpXsne+Kv+A9Q
         9cBjjopAHI5F6Lj5J5FepRCFWvj+CMHUt1rXU3OdlTsmGpR8IyteSYo18gff8bAmXgOF
         HAYHEt+ObwiisbRBzrDkpdJmOAuyNnVNBfW623MMatOw6XMdoOQmUKDvk/T/fHZl4GHj
         AAOWQOT9OXWd1F3si9T3xjAhg5ndrR2JJn87tj9NpwO45d99c1GovVERgjFb7lYgq8xF
         SbSBn3rSNRA9Yvb0cihyNO0Ro1qmv5h51Z/o/wGTKEigSKnFN2htgG+VqJgOqwjKht1b
         IqJQ==
X-Gm-Message-State: AOAM531EaBPTQFnNLuVK/vZskKXt39RyAcy6E7ej1kpkjDGivR+DdW2y
        3sSZyS+B/R/tbHtf1LD/WzN5KixK4CEj6rVOhD2ztVlKjXI6ntI9OrykMy0CiUG5aYmfvv2otoG
        N0yHMCMmzxv1jr9GqesWg/VGl
X-Received: by 2002:a05:6402:1a45:: with SMTP id bf5mr14393020edb.169.1629035845008;
        Sun, 15 Aug 2021 06:57:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxLX3Yr9Fwj+3Wtl5Zf6O/XficUHUKs2h7TQ6NiRxBlG99y8ta+Fc76Qclsr6Kn8X5xkcetpQ==
X-Received: by 2002:a05:6402:1a45:: with SMTP id bf5mr14393012edb.169.1629035844887;
        Sun, 15 Aug 2021 06:57:24 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id h10sm3478652edb.74.2021.08.15.06.57.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Aug 2021 06:57:24 -0700 (PDT)
Subject: Re: [PATCH 5.10 12/19] vboxsf: Make vboxsf_dir_create() return the
 handle for the created file
To:     Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
References: <20210813150522.623322501@linuxfoundation.org>
 <20210813150523.032839314@linuxfoundation.org>
 <20210813193158.GA21328@duo.ucw.cz>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <26feedff-0fb4-01db-c809-81c932336b47@redhat.com>
Date:   Sun, 15 Aug 2021 15:57:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210813193158.GA21328@duo.ucw.cz>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/13/21 9:31 PM, Pavel Machek wrote:
> Hi!
> 
>> commit ab0c29687bc7a890d1a86ac376b0b0fd78b2d9b6 upstream
>>
>> Make vboxsf_dir_create() optionally return the vboxsf-handle for
>> the created file. This is a preparation patch for adding atomic_open
>> support.
> 
> Follow up commits using this functionality are in 5.13 but not in
> 5.10, so I believe we don't need this in 5.10, either?
> 
> (Plus someone familiar with the code should check if we need "vboxsf:
> Honor excl flag to the dir-inode create op" in 5.10; it may have same
> problem).

Actually those follow up commits fix an actual bug, so I was expecting
the person who did the backport to also submit the rest of the set.

FWIW having these patches in but not the cannot hurt.

Hopefully the rest applies cleanly, I don't know.

To be clear I'm talking about also adding the following to patches
to 5.10.y:

02f840f90764 ("vboxsf: Add vboxsf_[create|release]_sf_handle() helpers")
52dfd86aa568 ("vboxsf: Add support for the atomic_open directory-inode op")

I have no idea of these will apply cleanly.

Regards,

Hans


