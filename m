Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9426D3266E0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 19:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbhBZS0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 13:26:42 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:44604 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229566AbhBZS0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 13:26:40 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1614363980; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=phgrcfweS7Ov1Upp/f1NcxKQ0crVZhRuuofK2pHBaf4=;
 b=OEc3uDCm1jtY95CKY3RzIFJ1A6V2cWH4vpd4y0PpW4EddIsDkX++Hq12wrK1ZHs1GHb5r3r3
 PILwF6BH3JL/oYQ64r9nw4TKFHW4sw5OYh1mzAg5/+gwLZI8JhavJPRFN07iNuxj2G4whcsT
 hhvnaBs3LyXZoLibbMjdynNFFLg=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 60393d3275e4458f08669c8f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 26 Feb 2021 18:25:54
 GMT
Sender: mdalam=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 674D0C433ED; Fri, 26 Feb 2021 18:25:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mdalam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 842A1C433CA;
        Fri, 26 Feb 2021 18:25:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 26 Feb 2021 23:55:53 +0530
From:   mdalam@codeaurora.org
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     mani@kernel.org, boris.brezillon@collabora.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        sricharan@codeaurora.org, mdalam=codeaurora.org@codeaurora.org
Subject: Re: [PATCH] mtd: rawnand: qcom: update last code word register
In-Reply-To: <20210224173644.592e73dc@xps13>
References: <1614024267-12529-1-git-send-email-mdalam@codeaurora.org>
 <20210223173449.1a55df1e@xps13>
 <a5650f33b493b987d45525ea57fdfd8a@codeaurora.org>
 <38da9d1d4a96f1b42ba0b194da265e6b@codeaurora.org>
 <20210224074850.0c74154d@xps13>
 <e0f0282b8552b0225f15a4c45a6894cd@codeaurora.org>
 <20210224173644.592e73dc@xps13>
Message-ID: <92fc28e79b5f6f56c8bfc6f229807edb@codeaurora.org>
X-Sender: mdalam@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-24 22:06, Miquel Raynal wrote:
> Hello,
> 
> mdalam@codeaurora.org wrote on Wed, 24 Feb 2021 22:00:05 +0530:
> 
>> On 2021-02-24 12:18, Miquel Raynal wrote:
>> > Hello,
>> >
>> > mdalam@codeaurora.org wrote on Wed, 24 Feb 2021 10:09:48 +0530:
>> >
>> >> On 2021-02-24 01:13, mdalam@codeaurora.org wrote:
>> >> > On 2021-02-23 22:04, Miquel Raynal wrote:
>> >> >> Hello,
>> >> >> >> Md Sadre Alam <mdalam@codeaurora.org> wrote on Tue, 23 Feb 2021
>> >> >> 01:34:27 +0530:
>> >> >> >>> From QPIC version 2.0 onwards new register got added to read last
>> >> >> >>                                a new
>> >> >> >>> codeword. This change will add the READ_LOCATION_LAST_CW_n register.
>> >> >> >>             Add support for this READ_LOCATION_LAST_CW_n register.
>> >> >> >>> >>> For first three code word READ_LOCATION_n register will be
>> >> >>> use.For last code word READ_LOCATION_LAST_CW_n register will be
>> >> >>> use.
>> >> >> >> "
>> >> >> In the case of QPIC v2, codewords 0, 1 and 2 will be accessed through
>> >> >> READ_LOCATION_n, while codeword 3 will be accessed through
>> >> >> READ_LOCATION_LAST_CW_n.
>> >> >> "
>> >> >> >> When I read my own sentence, I feel that there is something wrong.
>> >> >> If there are only 4 codewords, I guess a QPIC v2 is able to use
>> >> >> READ_LOCATION_3 or READ_LOCATION_LAST_CW_0 interchangeably. Isn't it?
>> >> >> >> I guess the point of having these "last_cw_n" registers is to support
>> >> >> up to 8 codewords, am I wrong? If this the case, the current patch
>> >> >> completely fails doing that I don't get the point of such change.
>> >> >
>> >> > This register is only use to read last code word.
>> >> >
>> >> > I have address all the comments from all the previous sub sequent
>> >> > patches and pushed
>> >> > all patches in only one series.
>> >> >
>> >> > Please check.
>> >> >>   The registers READ_LOCATION & READ_LOCATION_LAST are not associated >> with number of code words.
>> >>   These two registers are used to access the location inside a code >> word.
>> >
>> > Ok. Can you please explain what is a location then? Or point me to a
>> > datasheet that explains it.
>> 
>>    The location is the position inside a code word.
>> 
>> >
>> > Bottom line question: why having READ_LOCATION_0, _1,... an
>> > READ_LOCATION_LAST_0, _1, etc?
>> 
>>   READ_LOCATION_0, _1,... are used to extract multiple chunks from a 
>> code word.
>> 
>>   e.g If we wanted to extract first 100 bytes from a code word then 
>> (0...99) READ_LOCATION_0 will be configured.
>>       if we wanted to extract next 100 bytes (100...199) then 
>> READ_LOCATION_1 will be configured.
>> 
>>       same way for last code word READ_LOCATION_LAST_0, _1, will be 
>> used.
>> 
> 
> Nice explanation, and thanks for the below figures. So I guess there
> is some kind of "small SRAM" that is
> directly addressable perhaps?
> 
> I think I'm fine with your series now. Just a small nit: next time you
> send a series, please update the version number "[PATCH v6]"
> (automatically added with the -v6 parameter in git-format-patch). But
> no need to resend just for that.
> 

   Thanks Miquel. So now no need to test these patches further. I have 
already tested these patches on IPQ5018 SoC with mtd_test module & 
nand-utils tool.

> 
> Thanks,
> Miquèl
