Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2253343B1C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 09:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbhCVH76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 03:59:58 -0400
Received: from linux.microsoft.com ([13.77.154.182]:58400 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhCVH7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 03:59:46 -0400
Received: from [192.168.0.114] (unknown [49.207.199.95])
        by linux.microsoft.com (Postfix) with ESMTPSA id AA61920B5680;
        Mon, 22 Mar 2021 00:59:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AA61920B5680
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1616399986;
        bh=qmuAsbc1u2WB88iRPhSwaVj6CjbmseXJCuXVFQ8QZpg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=p9KpG2ksc/qSx9hiDockcv4LQgJIpQZvBk9roB/E3wKvqaa+raY8MnJBmRtuSRQRG
         4HseaVU/Cxf8JZ8ozFpiTetVljcsY3Qylhz9A0qwq+zL9T++cocS23W+QAmCQ3l4ew
         4ARO+a4pHwBr9gq01jgr3iU+8wHsBo5zemzcpFC4=
Subject: Re: [PATCH v2 1/2] optee: fix tee out of memory failure seen during
 kexec reboot
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Allen Pais <allen.lkml@gmail.com>, zajec5@gmail.com,
        bcm-kernel-feedback-list@broadcom.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>
References: <20210225090610.242623-1-allen.lkml@gmail.com>
 <20210225090610.242623-2-allen.lkml@gmail.com>
 <CAHUa44F5Ew6U80t7PPmV1J4KunXBm_izBxVrxg=x8azjBz0r9Q@mail.gmail.com>
 <9a6c017c-d156-f939-f907-d6dfe83c41ac@linux.microsoft.com>
 <CAHUa44FyGOj5=Z80km_2T-avKiJpGVD8cWjTC3ZCX8csazP3rw@mail.gmail.com>
From:   Allen Pais <apais@linux.microsoft.com>
Message-ID: <d0711e6f-b522-fe2f-7122-17bb86dba071@linux.microsoft.com>
Date:   Mon, 22 Mar 2021 13:29:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHUa44FyGOj5=Z80km_2T-avKiJpGVD8cWjTC3ZCX8csazP3rw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>>
>>>> [    0.368428] tee_bnxt_fw optee-clnt0: tee_shm_alloc failed
>>>> [    0.368461] tee_bnxt_fw: probe of optee-clnt0 failed with error -22
>>>>
>>>> tee_shm_release() is not invoked on dma shm buffer.
>>>>
>>>> Implement .shutdown() method to handle the release of the buffers
>>>> correctly.
>>>>
>>>> More info:
>>>> https://github.com/OP-TEE/optee_os/issues/3637
>>>>
>>>> Signed-off-by: Allen Pais <apais@linux.microsoft.com>
>>>> ---
>>>>    drivers/tee/optee/core.c | 20 ++++++++++++++++++++
>>>>    1 file changed, 20 insertions(+)
>>>
>>> This looks good to me. Do you have a practical way of testing this on
>>> QEMU for instance?
>>>
>>
>> Jens,
>>
>>     I could not reproduce nor create a setup using QEMU, I could only
>> do it on a real h/w.
>>
>>     I have extensively tested the fix and I don't see any issues.
> 
> I did a few test runs too, seems OK.

Thank you very much.
