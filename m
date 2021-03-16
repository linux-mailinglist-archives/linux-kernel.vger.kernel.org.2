Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C04833D4BF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 14:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234847AbhCPNVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 09:21:45 -0400
Received: from linux.microsoft.com ([13.77.154.182]:41564 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234806AbhCPNVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 09:21:09 -0400
Received: from [192.168.0.114] (unknown [49.207.206.253])
        by linux.microsoft.com (Postfix) with ESMTPSA id A6A77209C340;
        Tue, 16 Mar 2021 06:21:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A6A77209C340
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1615900868;
        bh=/HhHLcw0Zaoz9msZE8YkI9qb0aU2DiNbyWd7BALqXzA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=iQrv1KyJeecpIb05+awvMxMnR+XoFPneksxyu8fUntwlZ/IRWv0gAnLQdrcbNEY16
         hkhHwZBr2s1TANs7Oph/B54BYoronwOzr7WDCsFlNe4wFnzzdWFSXTmwGStBBwJrfj
         SD6ij9tigA6dsvVHO4PhiOfBwTsKBadyltVJTNFA=
Subject: Re: [PATCH v2 1/2] optee: fix tee out of memory failure seen during
 kexec reboot
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        Allen Pais <allen.lkml@gmail.com>
Cc:     zajec5@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        op-tee@lists.trustedfirmware.org
References: <20210225090610.242623-1-allen.lkml@gmail.com>
 <20210225090610.242623-2-allen.lkml@gmail.com>
 <CAHUa44F5Ew6U80t7PPmV1J4KunXBm_izBxVrxg=x8azjBz0r9Q@mail.gmail.com>
From:   Allen Pais <apais@linux.microsoft.com>
Message-ID: <9a6c017c-d156-f939-f907-d6dfe83c41ac@linux.microsoft.com>
Date:   Tue, 16 Mar 2021 18:51:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHUa44F5Ew6U80t7PPmV1J4KunXBm_izBxVrxg=x8azjBz0r9Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>>
>> [    0.368428] tee_bnxt_fw optee-clnt0: tee_shm_alloc failed
>> [    0.368461] tee_bnxt_fw: probe of optee-clnt0 failed with error -22
>>
>> tee_shm_release() is not invoked on dma shm buffer.
>>
>> Implement .shutdown() method to handle the release of the buffers
>> correctly.
>>
>> More info:
>> https://github.com/OP-TEE/optee_os/issues/3637
>>
>> Signed-off-by: Allen Pais <apais@linux.microsoft.com>
>> ---
>>   drivers/tee/optee/core.c | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
> 
> This looks good to me. Do you have a practical way of testing this on
> QEMU for instance?
> 

Jens,

   I could not reproduce nor create a setup using QEMU, I could only
do it on a real h/w.

   I have extensively tested the fix and I don't see any issues.

Thanks.
