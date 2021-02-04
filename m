Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC7430F561
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 15:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236859AbhBDOub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 09:50:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236844AbhBDOiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 09:38:09 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3827CC0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 06:37:26 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id n2so3394211iom.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 06:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6WKbmgf+2ZIGCm/dE9FPQFIm79eTOH6MS53KyM+dR2s=;
        b=r4vyQkjzXvpYLOKwhE/8h97tN0TZDkJogkAAj7FoT87Id3rGALm6nbbQG6UxEbx9po
         On5BqiliIKar0Lk04plkntapUUECmMraXLFrkk/SBzYedeZGK6H96SuNVvAndg4tKcm2
         DxtmpbZo4WsRhMQTjtG4anXtrBnmWxG8KYXXTeidFMVbsTG8bkPLj8VmqnV3lo9rEry0
         Swpyj4rt9XOb81L6OVqRtcVSYtYizt5NoK7JLKjgFQ5rw4E50Tj3clBWQb9xbx3Bh7eX
         92o+zZwiDPIl9OSDbKG8BT9ER8SFtveTF/hrgGXq2eGLLNetUatOtUQ+UcuaoOUXxC9c
         AsCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6WKbmgf+2ZIGCm/dE9FPQFIm79eTOH6MS53KyM+dR2s=;
        b=POzGOuE0lyrdwn5cOGLlv+YSQMyDKxqv806MO1lREs/BzuK3aO4yMTiiuZKPbGJceI
         fGu8okdp9NZn6WbCCMbWdPPBEEvcE9dQreV1VNr5b2UNIcughH+nyZ2D0OMHIZqjRcWi
         eVRNp13hrrquo3mfInDijDRwHwyjgYd7hJ6w8yWdE2f8w3eVwQXaXdvdbLJs6iAS18o/
         mo2MC+S7giqml0l21HvVfz9mI/gXZP6cRVpOqZ+cBk0XKYk9C02qDX+FZEqjZUcgldE+
         CAtQtlfpMotjX5iDBqbccQnL/Nc2T1yaqQWSzTweSrX5M8pDENdzTKYVW+ngqZqqT+EU
         bGeQ==
X-Gm-Message-State: AOAM533l1idy5NfkdZ6n/XDxaRAEpL2tgaB6s2y515dUm6Q6/IRUQb7a
        +idg5YJwY4ESX9YhOSHy/NlIQQ==
X-Google-Smtp-Source: ABdhPJxKA5Vxq5X3o3KFodyPKGEYbk4IgNMPD3Tk8eHB/YEud3CDUYpQ697oyidW2sBhnc4NFrkTsQ==
X-Received: by 2002:a05:6638:2686:: with SMTP id o6mr8310988jat.68.1612449445609;
        Thu, 04 Feb 2021 06:37:25 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id h23sm2557045ila.15.2021.02.04.06.37.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Feb 2021 06:37:25 -0800 (PST)
Subject: Re: [GIT PULL] Floppy patch for 5.12
To:     efremov@linux.com
Cc:     linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jiri Kosina <jikos@kernel.org>, Kurt Garloff <kurt@garloff.de>
References: <45f555f4-b694-ca8e-c088-f34dea9fc7c7@linux.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ba300e13-dc16-af15-a386-0c5348e0f919@kernel.dk>
Date:   Thu, 4 Feb 2021 07:37:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <45f555f4-b694-ca8e-c088-f34dea9fc7c7@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/21 3:12 AM, Denis Efremov wrote:
> The following changes since commit 0d7389718c32ad6bb8bee7895c91e2418b6b26aa:
> 
>   Merge tag 'nvme-5.21-2020-02-02' of git://git.infradead.org/nvme into for-5.12/drivers (2021-02-02 07:11:47 -0700)
> 
> are available in the Git repository at:
> 
>   https://github.com/evdenis/linux-floppy tags/floppy-for-5.12

Pulled, thanks.

-- 
Jens Axboe

