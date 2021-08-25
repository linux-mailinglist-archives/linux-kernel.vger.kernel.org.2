Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 676FF3F7A88
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 18:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240493AbhHYQa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 12:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235063AbhHYQa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 12:30:27 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B458FC061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 09:29:41 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id k14so202880pga.13
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 09:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=F1mBNZzXkhmLcRrSxvnNc8vUPy/DeUn4C4WdzY0Xs1Y=;
        b=lrD2ZeGT9LxGiKtet3ojNPt0skpiGvCm59mnedkZ3Q9FQ3v7oYwr7fI3tpIDfmLPki
         dMj0/D303rF1hN3OYzNLBMMYB2hQE5EdU5MgHwKjWtpDGmJMt1R5tLg1G8ZuflOB6xqg
         FoI62aE0ezTyHuXmtJhH7kx78OJlc/RDk28jk2W4GXLxHzdyzlN4kXcL3wrFaN7Fph3z
         KTPX4QgYeG3Vu4L/F1cFbKPLfcuxqGec/K4UtPpL5G/JCbuJJeem/HKC90JJAAssomZU
         4Cm92zrUWIko/POR3vfBXTGqcZW3o3NYn77C2F/KBhG0vjItk0b3Q6iDLlcfTGbH4Ofy
         49cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=F1mBNZzXkhmLcRrSxvnNc8vUPy/DeUn4C4WdzY0Xs1Y=;
        b=qYjEvsULO+aT5H88pzyoUnSQSPwUBNKKiATkV5w+jBeHRiuXgPN3M2Go56j5nMcwNP
         7psrUGT+y3rFN4Q1a9Zigr7UqYaLb5ARMfQ/QGPbaihZyxsGhrW08H+4lt2kTa0VuhXJ
         sTWrHXCSrvMrMVKSkGzuu6L0hn+LBWBGjHz98hP0l3IsMgnP2uWVWXkCbZ06qWoRYfG7
         RKgjCGs4njj4NRCNvQv95R3ZWUe0AYKzyu7SU70jFPd43ic0ajKMRxS3xLc91xi6a+vs
         keE29Sek8+V2KFrEebI1/nKh3LwLlt4YZoPpg33i+DpvWeHA52QV5J97q1KWGPNlb5hk
         81cA==
X-Gm-Message-State: AOAM530bceyd28gCcNp/Bk/MMmGrb9lJRxEQUwnj1GCwJ4UQYO09Jy0k
        2AchUOzUF/KCpqSrFb959WY=
X-Google-Smtp-Source: ABdhPJy9ioGHbzmFpcDaF/H6MSYT6Vj6bnjwyI4SI/SVkFtmfyzTV9WQ0LOSU/UHcM+RDRW46rpq6Q==
X-Received: by 2002:a65:414a:: with SMTP id x10mr30233346pgp.403.1629908981273;
        Wed, 25 Aug 2021 09:29:41 -0700 (PDT)
Received: from [10.230.31.46] ([192.19.223.252])
        by smtp.gmail.com with UTF8SMTPSA id pc11sm6088023pjb.17.2021.08.25.09.29.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 09:29:40 -0700 (PDT)
Message-ID: <3be84c2b-bb86-65c4-4c32-957767ffa577@gmail.com>
Date:   Wed, 25 Aug 2021 18:29:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.2
Subject: Re: [PATCH v4 02/12] firmware: arm_scmi: Add configurable polling
 mode for transports
Content-Language: en-US
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
References: <20210824135941.38656-1-cristian.marussi@arm.com>
 <20210824135941.38656-3-cristian.marussi@arm.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20210824135941.38656-3-cristian.marussi@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/24/2021 3:59 PM, Cristian Marussi wrote:
> SCMI communications along TX channels can optionally be provided of a
> completion interrupt; when such interrupt is not available, command
> transactions should rely on polling, where the SCMI core takes care to
> repeatedly evaluate the transport-specific .poll_done() function to
> determine if and when a request was fully completed or timed out.
> 
> Such mechanism is already present and working on a single transfer base:
> SCMI protocols can indeed enable hdr.poll_completion on specific commands
> ahead of each transfer and cause that transaction to be handled with
> polling.
> 
> Introduce a couple of flags to be able to enforce such polling behaviour
> globally at will:
> 
>   - scmi_desc.force_polling: to statically switch the whole transport to
>     polling mode.
> 
>   - scmi_chan_info.no_completion_irq: to switch a single channel dynamically
>     to polling mode if at runtime is determined that no completion interrupt
>     was available for such channel.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
