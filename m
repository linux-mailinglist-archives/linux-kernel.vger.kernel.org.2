Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED7963A0083
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 20:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235529AbhFHSoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 14:44:19 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:38887 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235438AbhFHSkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 14:40:02 -0400
Received: by mail-ot1-f51.google.com with SMTP id j11-20020a9d738b0000b02903ea3c02ded8so7702674otk.5;
        Tue, 08 Jun 2021 11:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fXnxcS6kEAxEn6nbciu1v+xKHBzhUefd1Jecud7zYTA=;
        b=rg7dYFciYn0hCBMBKH0jVt3QmhtQZHD0007h6sgwdv8MzzuQ0vdzjcm/Vm9lAAUl4H
         nAEFy+46HKL8Qg/MBv9z66VhCRUG2eGo29se5cV6KAriKS6tMTs7oeiW+m94dAQscpWs
         AA38Mk3EM1paqKGQUEmUB1RCKrLrREZ5tVQMDXHFtbLiBF77clrjENO/+D+u86GVDFq8
         5y+0x6cCoeiVkXgeOaOasE6NMgqEfo5/201tpqiqI1szhfXbUmkrNBUgpPkT9AjWCOcX
         CoSY9fq4mW2Ax1Yz2/sy4Cj2MtvWUMzmJWKmWaK++s/Dy0D7WRx1aHW/lyqIadWvKW4T
         OCiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fXnxcS6kEAxEn6nbciu1v+xKHBzhUefd1Jecud7zYTA=;
        b=M0LupWaDyQvMpuRDtNz0B/OJYaOugr3Cai555kQVrb+/1Rec7ktAtdZY2cUyfdTkHR
         o4vDXsLmxBcsCAOy1IalYsgVdylxrm39R8YUlXmckBddnGSDamY2bMkRbJVa+ukXfzIB
         BhpTjU0bdgf8kMPsHVbTTDhkLq6DTyrsnGQasUJU5sR8cncwA3yXAcMjnNwNNd/tKSsd
         x7vKVPNu3YyE6Si+X21s3ZWiAXCCX2DPnJ+emvqtp9c/K5h0llrcDq8Lk+sY8YDR7Mb8
         rvCFqcu6y8x1x9xl3FyzIcBS27Ww2VODJ18btT4RmKfBD81G3ffgCJIT+npcIIyqgwh/
         BFuA==
X-Gm-Message-State: AOAM533s0uyoi9k2Mw9ez31EAFLYUZz3at10shUaGOB4xM7JQvD3xI+m
        80YPMEtg0JjNEUxyqop+dvvsMI4mBnI=
X-Google-Smtp-Source: ABdhPJzaPNPTNRRIrTWc2A+fBRnIynMgMakPZS7WzrWc2EOTNfVzpeSVM4z/obky3EyTIr76Z25Cqg==
X-Received: by 2002:a9d:5d14:: with SMTP id b20mr19392178oti.307.1623177428795;
        Tue, 08 Jun 2021 11:37:08 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id b26sm2652156otq.43.2021.06.08.11.37.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 11:37:08 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: Strange problem with USB device
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        ierturk@ieee.org
References: <cfc37ce0-823e-0d19-f5d7-fcd571a94943@lwfinger.net>
 <20210608182038.GA1812516@rowland.harvard.edu>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <a7c7ba62-a74f-d7db-bfd9-4f6c8e25e0b8@lwfinger.net>
Date:   Tue, 8 Jun 2021 13:37:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210608182038.GA1812516@rowland.harvard.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/21 1:20 PM, Alan Stern wrote:
> On Tue, Jun 08, 2021 at 12:41:23PM -0500, Larry Finger wrote:
>> Hi,
>>
>> In https://bugzilla.suse.com/show_bug.cgi?id=1186889, a user is
>> reporting that his Bluetooth component of a Realtek RTL8822CE is not
> 
> Is that a USB device?  That is, does it connect to the computer
> via a USB cable?  I'll assume it does...
> 
>> being found in openSUSE's kernel 5.3.18. His lsusb scan is as follows:
>>
>> $ lsusb
>> Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
>> Bus 001 Device 003: ID 13d3:56c9 IMC Networks HP TrueVision HD Camera
>> Bus 001 Device 002: ID 045e:07fd Microsoft Corp. Nano Transceiver 1.1
>> Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
>>
>> The Bluetooth device is found and works in Windows 10, where the Device
>> Manager reports hardware ID's of 0bda:b00c. This combination is in
>> driver btusb.
>>
>> Is there a bug in the USB bus scan in kernel 5.3.18 that has since been
>> fixed, or is there still a bug that misses this device?
> 
> Given only the information you have provided, it is impossible to
> answer that question.  Broadly speaking, lots of bugs in the USB
> subsystem have been fixed since kernel 5.3.18, but I don't know
> if any of them would affect detecting new devices on the bus like
> this.
> 
> One thing you might try is to turn on USB debugging before
> plugging in the device:
> 
> echo 'module usbcore =p' >/sys/kernel/debug/dynamic_debug/control
> 
> The additional information this adds to the dmesg log may be
> helpful.

The BT device is part of the same card as the PCIe wifi device, thus there is no 
"plugging" it in a conventional sense. Is there some way to add the usbcore 
debugging statement to the kernel options line at boot time?

As I told GregKH, I am having the person with the problem try a rescue system 
with a 5.12 kernel.

Larry

