Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDA4239FDEE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 19:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233824AbhFHRnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 13:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233407AbhFHRnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 13:43:18 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89621C061574;
        Tue,  8 Jun 2021 10:41:25 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id w23-20020a9d5a970000b02903d0ef989477so16722829oth.9;
        Tue, 08 Jun 2021 10:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=/sggUjKo4ERU4nDD0hl9g9wOyDxCbIlg3GFVLsbW8R0=;
        b=EqCboDcS3h7/bZhJx1HNnUBUbiPHY3zU0uwxmBYnphB/NbhP3FJ9UX1PC4htg7pDbY
         SnusgUcXxyV74u0iY9wb3ebXGjDiUoj61ZxOxegxlsXd7U0zjBonJwVCFhzlODj4zA00
         JGlKj2bYMtOBgc1RWhhA14vK35rhZwx5J4vpo8v4Vo4JCr+kgu9lZlRVKKX/bgOVUrOO
         i7rSMwPsXwrMa2LNnGdNwvFK9vNLldFD0qBU+ctwSMNJb9Tk540rbdLDBMAFtMgJWN0U
         fh0RRo7iZHjBT8P25DvPQzlXUsphAAO3/K1UJwQXmx+am9QHWYxGRomgwm1a0RzjfX1K
         RxsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:cc:from:subject:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=/sggUjKo4ERU4nDD0hl9g9wOyDxCbIlg3GFVLsbW8R0=;
        b=c6DDcrc1gQjfLf2F5HUgQA3xdV/DuTvLATR+rz9mozfa8zRajR6Z7oqvNfvZKEhxpC
         n/3Q32D+IIvgxA6kknap4lWFCSj3tEW4Wecn+PmSrPrWAZ7h+xdRjbj4lb8GqJ0Nppm+
         IWP568E+nwX8b16fTXhgq27apbBA2rIUDSAtWIMh/365/83QQyWOnEbDyKJu1UCGx53h
         sjykcRXvHr93Q5BUA9QT9mG6sBYde0TKHRUejWkSK5htVajEmXJX92j5xkoq7CNbDqG1
         V/qbvIPPEPKD6SlljAzNOFC6xjFeZEb52RohBnX5KjJmfrz0yIVBrLWnQuzihUA731om
         PCmg==
X-Gm-Message-State: AOAM532nX1WuwushLPsilfwVwlHmGfnbZBXYEpzG9xfiILgAbVe5/sdR
        0JKRmQWYz/pXGuhDY1yELPI=
X-Google-Smtp-Source: ABdhPJyjPrkBTCH5CCqvLhr5CJ8xpPzjN9UfP2QdyobLcoO8qj382Qb3bPg/pKthTSA9W6Y3euED+w==
X-Received: by 2002:a9d:4911:: with SMTP id e17mr19358922otf.38.1623174084930;
        Tue, 08 Jun 2021 10:41:24 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id m18sm2114905otr.61.2021.06.08.10.41.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 10:41:24 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
To:     linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Cc:     ierturk@ieee.org
From:   Larry Finger <Larry.Finger@lwfinger.net>
Subject: Strange problem with USB device
Message-ID: <cfc37ce0-823e-0d19-f5d7-fcd571a94943@lwfinger.net>
Date:   Tue, 8 Jun 2021 12:41:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In https://bugzilla.suse.com/show_bug.cgi?id=1186889, a user is reporting that 
his Bluetooth component of a Realtek RTL8822CE is not being found in openSUSE's 
kernel 5.3.18. His lsusb scan is as follows:

$ lsusb
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 003: ID 13d3:56c9 IMC Networks HP TrueVision HD Camera
Bus 001 Device 002: ID 045e:07fd Microsoft Corp. Nano Transceiver 1.1
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub

The Bluetooth device is found and works in Windows 10, where the Device Manager 
reports hardware ID's of 0bda:b00c. This combination is in driver btusb.

Is there a bug in the USB bus scan in kernel 5.3.18 that has since been fixed, 
or is there still a bug that misses this device?

Thanks,

Larry


