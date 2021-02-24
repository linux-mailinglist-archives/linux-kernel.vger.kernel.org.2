Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 651C532423A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 17:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235378AbhBXQgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 11:36:54 -0500
Received: from z11.mailgun.us ([104.130.96.11]:49337 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234037AbhBXQbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 11:31:20 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1614184240; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=NhSnOaCLeI8pDb6ppCC1jHhKymGxeQ/61aDy+sDsO4s=;
 b=C0Xy4V5MzQjt04M8l518OxIPoh7DcAktDnDrEvpEQf2/H3nNUK+bCDWhHlgQ17MZJesnkA92
 uQpmFkPMIRvYxQdhbAs4PJ5RBmAau6AgoKgFzHeU8Bn6t/RO/VeM7+cfgJo630ul70LRIqvZ
 pd4lN8+riPTddlILeVQs4fOlY5Q=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 60367f0f2a8ee88ea5c38ff0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 24 Feb 2021 16:30:07
 GMT
Sender: mdalam=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A35ACC433C6; Wed, 24 Feb 2021 16:30:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mdalam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A40D4C433CA;
        Wed, 24 Feb 2021 16:30:05 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 24 Feb 2021 22:00:05 +0530
From:   mdalam@codeaurora.org
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     mani@kernel.org, boris.brezillon@collabora.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        sricharan@codeaurora.org, mdalam=codeaurora.org@codeaurora.org
Subject: Re: [PATCH] mtd: rawnand: qcom: update last code word register
In-Reply-To: <20210224074850.0c74154d@xps13>
References: <1614024267-12529-1-git-send-email-mdalam@codeaurora.org>
 <20210223173449.1a55df1e@xps13>
 <a5650f33b493b987d45525ea57fdfd8a@codeaurora.org>
 <38da9d1d4a96f1b42ba0b194da265e6b@codeaurora.org>
 <20210224074850.0c74154d@xps13>
Message-ID: <e0f0282b8552b0225f15a4c45a6894cd@codeaurora.org>
X-Sender: mdalam@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-24 12:18, Miquel Raynal wrote:
> Hello,
> 
> mdalam@codeaurora.org wrote on Wed, 24 Feb 2021 10:09:48 +0530:
> 
>> On 2021-02-24 01:13, mdalam@codeaurora.org wrote:
>> > On 2021-02-23 22:04, Miquel Raynal wrote:
>> >> Hello,
>> >> >> Md Sadre Alam <mdalam@codeaurora.org> wrote on Tue, 23 Feb 2021
>> >> 01:34:27 +0530:
>> >> >>> From QPIC version 2.0 onwards new register got added to read last
>> >> >>                                a new
>> >> >>> codeword. This change will add the READ_LOCATION_LAST_CW_n register.
>> >> >>             Add support for this READ_LOCATION_LAST_CW_n register.
>> >> >>> >>> For first three code word READ_LOCATION_n register will be
>> >>> use.For last code word READ_LOCATION_LAST_CW_n register will be
>> >>> use.
>> >> >> "
>> >> In the case of QPIC v2, codewords 0, 1 and 2 will be accessed through
>> >> READ_LOCATION_n, while codeword 3 will be accessed through
>> >> READ_LOCATION_LAST_CW_n.
>> >> "
>> >> >> When I read my own sentence, I feel that there is something wrong.
>> >> If there are only 4 codewords, I guess a QPIC v2 is able to use
>> >> READ_LOCATION_3 or READ_LOCATION_LAST_CW_0 interchangeably. Isn't it?
>> >> >> I guess the point of having these "last_cw_n" registers is to support
>> >> up to 8 codewords, am I wrong? If this the case, the current patch
>> >> completely fails doing that I don't get the point of such change.
>> >
>> > This register is only use to read last code word.
>> >
>> > I have address all the comments from all the previous sub sequent
>> > patches and pushed
>> > all patches in only one series.
>> >
>> > Please check.
>> 
>>   The registers READ_LOCATION & READ_LOCATION_LAST are not associated 
>> with number of code words.
>>   These two registers are used to access the location inside a code 
>> word.
> 
> Ok. Can you please explain what is a location then? Or point me to a
> datasheet that explains it.

   The location is the position inside a code word.

> 
> Bottom line question: why having READ_LOCATION_0, _1,... an
> READ_LOCATION_LAST_0, _1, etc?

  READ_LOCATION_0, _1,... are used to extract multiple chunks from a code 
word.

  e.g If we wanted to extract first 100 bytes from a code word then 
(0...99) READ_LOCATION_0 will be configured.
      if we wanted to extract next 100 bytes (100...199) then 
READ_LOCATION_1 will be configured.

      same way for last code word READ_LOCATION_LAST_0, _1, will be used.


   Below is the mapping example for a 2K page size.

  
<---------------------2048------------------------------------------------><------64---------->2111
  
_______________________________________________________________________________________________
|                                                                        
   |   |               |
|                                                                        
   |   |               |
|                                                                        
   |   |               |
|                                                                        
   |   |               |
|__________________________________________________________________________|___|_______________|
                                                                          
       2048-bytes
                                                                          
       factory BBM


One code word:

              1-byte BBM       7-bytes ECC
______________________________________
|            |  |            |   |    |
|            |  |            |   |    |
|            |  |            |   |    |
|            |  |            |   |    |
|            |  |            |   |    |
|____________|__|____________|___|____|
  <-----------512 bytes------->    4-bytes spare
              data


  
<-------------------------------------2048-------------------------------------------------->2047<------64---------->2111
  
____________________________________________________________________________________________________________________
|                                                                        
                      |   |             |    |
|                                                                        
                      |   |             |    |
|                                                                        
                      |   |             |    |
|                                                                        
                      |   |             |    |
|_____________________________________________________________________________________________|___|_____________|____|
                                                                          
                             |   |
                                                                          
                             |   |
                                                                          
                             |   |<-----mapping
                                                                          
                             |   |
                                                                          
                             |   |
  
____________________________________________________________________________________________________|___|______
|                      |                           |                     
           |                            |
|                      |                           |                     
           |                            |
|                      |                           |                     
           |                            |
|                      |                           |                     
           |                            |
|                      |                           |                     
           |                            |
|______________________|___________________________|_______________________________|____________________________|
<-------CW1-----------><----------CW2-------------><-----------CW3----------------><----------CW4--------------->
                      /                             \
                     /                                \
                   /                                     \
                 /                                         \
               /                                             \
              /                                                 \
            /                                                      \
          /                                                            \
         
_________________________________________________________________ \___
        |                                                                 
     |
        |                                                                 
     |
        |                                                                 
     |
        |                                                                 
     |
        |                                                                 
     |
        |                                                                 
     |
        |<--read_location_0-->   <---read_location_1-->  
<--read_location_n-->|                                                   
               |
        
|_____________________________________________________________________|



So in QPIC V2 onwards to access last code word same way we have to use 
read_location_last_0,1,2..3 etc.


> 
>> So whether we are having 4 code words
>>   or 8 code words it doesn't matter. If we wanted access the location 
>> within normal code word we have to
>>   use READ_LOCATION register and if we wanted to access location in 
>> last code word then we have to use
>>   READ_LOCATION_LAST.
>> >
>> >> >>> Signed-off-by: Md Sadre Alam <mdalam@codeaurora.org>
> 
> Thanks,
> Miquèl
