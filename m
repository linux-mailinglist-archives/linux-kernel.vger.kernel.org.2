Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 454D145EC03
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 11:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbhKZLBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 06:01:49 -0500
Received: from smtpcmd0642.aruba.it ([62.149.156.42]:52526 "EHLO
        smtpcmd0642.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbhKZK7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 05:59:48 -0500
X-Greylist: delayed 423 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Nov 2021 05:59:48 EST
Received: from [192.168.1.56] ([79.0.204.227])
        by Aruba Outgoing Smtp  with ESMTPSA
        id qYnFmw0PIyoivqYnHmHB7U; Fri, 26 Nov 2021 11:49:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1637923769; bh=kyc0TKWuwA0jfdKVVt4S2Y2x34C+N8IQ8uMz1rSXGPw=;
        h=Subject:To:From:Date:MIME-Version:Content-Type;
        b=HxA5WYhAJiUhTysuhnamP19RgVyiAZyFP1D4jvbyBHDaKzf5YQF8gfMedRx3JUPL7
         TqIPQ011++nAVWD9OcrNJDAxT9LCbulAfrFtBojzb4RvPvO7seS+d3XsmXwLpcVXWB
         SdmghVtoI0rMQjFACRTeprZjtfPF7Duub41S//rniaqVtRU5aFZvaNB4uo7DtBTGpT
         65c9kHRrkyBbfG/EIqjG6wfApcPOIU9E1HMfZDEbI1DLSPKcPmoBRMX7lSga0L0ivp
         CbdODnOjkoyVlkKqrlAaQK/bgSQTKp6gqIqkABml69R8kc7k0LCCvt3/WfE5P+mI4r
         TFXmek4/5w0Vw==
Subject: Re: [PATCH 1/1] Calculate the monotonic clock from the timespec clock
 to generate PPS elapsed real-time event value and stores the result into
 /sys/class/pps/pps0/assert_elapsed.
To:     Alexander Komrakov <alexander.komrakov@broadcom.com>,
        linux-kernel@vger.kernel.org
References: <20211118032217.244985-1-alexander.komrakov@broadcom.com>
 <20211118032217.244985-2-alexander.komrakov@broadcom.com>
From:   Rodolfo Giometti <giometti@enneenne.com>
Message-ID: <a2dd9fa7-c6d2-d234-7652-53014672fe0a@enneenne.com>
Date:   Fri, 26 Nov 2021 11:49:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211118032217.244985-2-alexander.komrakov@broadcom.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJFEXWg8qhnIcI0Yf4CtGRJ0GittNU71kOi7zlWsOrAKdzFkUFGBXv4uvPUzLlBFqfymyiMS5UTELSdH7fYxkr3DAJiNrU8mqRc2yNPK1DRxqPAxyJVX
 wn3FPjrc1orqjzMnq7ZeOsRhWgrBq6tkVKtaCPzz6ucfK6dEBzmPYyuSeET1Djb4g2HtpSCl+giBZ4OwZBbdwPdC8RIXGIajicVXQIyD1mRld6GWCK1N1Ic2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/11/21 04:22, Alexander Komrakov wrote:
> From: alexkom <alexander.komrakov@broadcom.com>
> 
> Because we have requirements to make sure the delta between standard time, say the GPS Time, and elapsedRealtime < 1 millisecond, regular linux clock timestamp is not enough for our use case.
> The pin PPS will generate elapsedRealtime event at 1 sec boundary which is an exact value of the monotonic clock from the kernel PPS driver (/sys/class/pps/pps0/assert_elapsed).
> 
> Whenever AP receives this pulse, kernel's pps driver timestamp this elapsedRealtime event and let this time available via sysfs node (/sys/class/pps/pps0/assert_elapsed).
> 
> Signed-off-by: alexkom <alexander.komrakov@broadcom.com>

Acked-by: Rodolfo Giometti <giometti@enneenne.com>

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
