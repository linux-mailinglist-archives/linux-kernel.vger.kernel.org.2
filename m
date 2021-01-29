Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BABCC3084D1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 06:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhA2FGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 00:06:09 -0500
Received: from a1.mail.mailgun.net ([198.61.254.60]:39896 "EHLO
        a1.mail.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbhA2FGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 00:06:08 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1611896745; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=ZJ29Q1zTcKf8BOTIllzMQ0k52SASQ7ZW0y10kmshp2I=;
 b=ixRTgxxYxYpCHf+WylYTl83llpVYhHeHLsv1necvQSvDJHxi1r8y8Q8j4shfDNPx/hRv5iS9
 u8TtMW5JWhQ/v0ZNE2VIgXX6K77HQiAJkLXL40eLIapdodbgCq29RVjjFBbbhsRgGme3ylfg
 eAgaIH8XMQtnS9gQvqiJOkobfps=
X-Mailgun-Sending-Ip: 198.61.254.60
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 60139789262adddd45b1c6ad (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 29 Jan 2021 05:05:13
 GMT
Sender: mdalam=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CEC93C433ED; Fri, 29 Jan 2021 05:05:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mdalam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 11E29C433C6;
        Fri, 29 Jan 2021 05:05:13 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 29 Jan 2021 10:35:12 +0530
From:   mdalam@codeaurora.org
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     manivannan.sadhasivam@linaro.org, richard@nod.at, vigneshr@ti.com,
        boris.brezillon@collabora.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, sricharan@codeaurora.org
Subject: Re: [PATCH V3] mtd: rawnand: qcom: update last code word register
In-Reply-To: <20210128231110.64266932@xps13>
References: <1610251305-20792-1-git-send-email-mdalam@codeaurora.org>
 <20210114165325.3d510355@xps13>
 <769ea3fe77eab9b37d863251e97bcb29@codeaurora.org>
 <20210128231110.64266932@xps13>
Message-ID: <189aaad7cfaf9e4cadd525b936430c8b@codeaurora.org>
X-Sender: mdalam@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-29 03:41, Miquel Raynal wrote:
> Hello,
> 
> mdalam@codeaurora.org wrote on Fri, 29 Jan 2021 03:18:46 +0530:
> 
>> On 2021-01-14 21:23, Miquel Raynal wrote:
>> > Hello,
>> >
>> > Md Sadre Alam <mdalam@codeaurora.org> wrote on Sun, 10 Jan 2021
>> > 09:31:45 +0530:
>> >
>> >> From QPIC version 2.0 onwards new register got added to
>> >
>> >                                 a
>> >
>> >> read last codeword. This change will update the same.
>> >
>> >        the?           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> >                       Please reword this sentence.
>> 
>>    Fixed this in V4 patch.
>> >
>> >> For first three code word READ_LOCATION_n register will be
>> >> use.For last code word READ_LOCATION_LAST_CW_n register will be
>> >> use.
>> >
>> > "For the first three codewords, READ_LOCATION_n registers will be used.
>> > The last codeword register will be accessed through
>> > READ_LOCATION_LAST_CW_n."
>> >
>> > Also, please specify what these registers store.
>> 
>>    The location register is mainly use for reading controller
>>    buffer via BAM mode. The bits of the register 
>> "NAND_READ_LOCATION_LAST_CW_n, n=0..4"
>>    as follow:
> 
> Perhaps what I do not understand is: when is this "last_cw" register
> more useful than the previous set?

   From QPIC Version 2.0 onwards it is mandatory to use 
"NAND_READ_LOCATION_LAST_CW_n, n=0..4"
   register to extract last code word data from controller buffer. Using 
register "NAND_READ_LOCATION_n, n=0..4"
   we can extract all code words except last code word.
> 
>>    [9:0]-bits : (OFFSET) This bit defines the offset from the buffer 
>> base address to be picked up for DMA.
>>    [25:16]-bits: (SIZE) This bit of every register will define the 
>> size of the chunk for DMA.
>>    31-bit :      (LAST) If this bit is set, the controller takes the 
>> particular register to specify the last chunk
>>                        of data made available for DMA. This chunk is 
>> part of the internal buffer of the controller.
>> 
>> >
> 
> Thanks,
> Miquèl
