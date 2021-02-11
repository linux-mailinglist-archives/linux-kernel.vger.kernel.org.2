Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3D0B319324
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 20:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbhBKTcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 14:32:06 -0500
Received: from mail29.static.mailgun.info ([104.130.122.29]:47729 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229873AbhBKTcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 14:32:02 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1613071902; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=XGJQvy9vglXLQ+epQAjyXyaHaGPS9ccTR8kWxCegrDQ=;
 b=O+hOEEldWkHtugntzeameRsgKzhsvwIVjrok64jeVDZxWtULBr9DqCEcWkoO4ipDcHL764tt
 jndm/aVDvX9/GEvjLTwgvDEkunxgfhPNIUVsIL0EuHadKPSOqGLEaNEaSccgqrY4x7Kc1UtX
 t808NXeAnTc2h8We+4rNE2LrrI4=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 602585e9e4842e9128f6b86e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 11 Feb 2021 19:30:49
 GMT
Sender: mdalam=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 05125C43463; Thu, 11 Feb 2021 19:30:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mdalam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0CEADC433CA;
        Thu, 11 Feb 2021 19:30:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 12 Feb 2021 01:00:47 +0530
From:   mdalam@codeaurora.org
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        boris.brezillon@collabora.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, vigneshr@ti.com,
        sricharan@codeaurora.org
Subject: Re: [PATCH V4] mtd: rawnand: qcom: update last code word register
In-Reply-To: <20210211150759.506f3463@xps13>
References: <1611869959-5109-1-git-send-email-mdalam@codeaurora.org>
 <20210210090144.GE19226@work> <20210211150759.506f3463@xps13>
Message-ID: <fe43b382fd48d7fb494dd66a4b5ac80a@codeaurora.org>
X-Sender: mdalam@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-11 19:37, Miquel Raynal wrote:
> Hello,
> 
> Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote on Wed,
> 10 Feb 2021 14:31:44 +0530:
> 
>> On Fri, Jan 29, 2021 at 03:09:19AM +0530, Md Sadre Alam wrote:
>> > From QPIC version 2.0 onwards new register got added to
>> > read last codeword. This change will add the READ_LOCATION_LAST_CW_n
>> > register.
>> >
>> > For first three code word READ_LOCATION_n register will be
>> > use.For last code word READ_LOCATION_LAST_CW_n register will be
>> > use.
> 
> Sorry for the late notice, I think the patch is fine but if you don't
> mind I would like to propose a small change that should simplify your
> patch a lot, see below.
> 
>> >
>> > Signed-off-by: Md Sadre Alam <mdalam@codeaurora.org>
>> 
>> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>> 
>> Thanks,
>> Mani
>> 
>> > ---
>> > [V4]
>> >  * Modified condition for nandc_set_read_loc_last() in qcom_nandc_read_cw_raw().
>> >  * Added one additional argument "last_cw" to the function config_nand_cw_read()
>> >    to handle last code word condition.
>> >  * Changed total number of last code word register "NAND_READ_LOCATION_LAST_CW_0" to 4
>> >    while doing code word configuration.
>> >  drivers/mtd/nand/raw/qcom_nandc.c | 110 +++++++++++++++++++++++++++++---------
>> >  1 file changed, 84 insertions(+), 26 deletions(-)
>> >
>> > diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
>> > index 667e4bf..9484be8 100644
>> > --- a/drivers/mtd/nand/raw/qcom_nandc.c
>> > +++ b/drivers/mtd/nand/raw/qcom_nandc.c
>> > @@ -48,6 +48,10 @@
>> >  #define	NAND_READ_LOCATION_1		0xf24
>> >  #define	NAND_READ_LOCATION_2		0xf28
>> >  #define	NAND_READ_LOCATION_3		0xf2c
>> > +#define	NAND_READ_LOCATION_LAST_CW_0	0xf40
>> > +#define	NAND_READ_LOCATION_LAST_CW_1	0xf44
>> > +#define	NAND_READ_LOCATION_LAST_CW_2	0xf48
>> > +#define	NAND_READ_LOCATION_LAST_CW_3	0xf4c
>> >
>> >  /* dummy register offsets, used by write_reg_dma */
>> >  #define	NAND_DEV_CMD1_RESTORE		0xdead
>> > @@ -187,6 +191,12 @@ nandc_set_reg(nandc, NAND_READ_LOCATION_##reg,			\
>> >  	      ((size) << READ_LOCATION_SIZE) |			\
>> >  	      ((is_last) << READ_LOCATION_LAST))
>> >
>> > +#define nandc_set_read_loc_last(nandc, reg, offset, size, is_last)	\
>> > +nandc_set_reg(nandc, NAND_READ_LOCATION_LAST_CW_##reg,			\
>> > +	      ((offset) << READ_LOCATION_OFFSET) |		\
>> > +	      ((size) << READ_LOCATION_SIZE) |			\
>> > +	      ((is_last) << READ_LOCATION_LAST))
>> > +
> 
> You could rename the macro nandc_set_read_loc() into
> nandc_set_read_loc_first() or anything else that make sense, then have
> a helper which does:
> 
> nandc_set_read_loc()
> {
> 	if (condition for first)
> 		return nandc_set_read_loc_first();
> 	else
> 		return nandc_set_read_loc_last();
> }
> 

   Yes this is more precise way & simplify the patch a lot.
   But for this i have to change these two macro as a function.

   nandc_set_read_loc() & nandc_set_read_loc_last().

   Since for last code word register we are using Token Pasting 
Operator##.

   So if i am implementing like the below.

   /* helper to configure location register values */
   static void nandc_set_read_loc(struct qcom_nand_controller *nandc, int 
reg,
                   int offset, int size, int is_last, bool last_cw)
   {
           if (last_cw)
                   return nandc_set_read_loc_last(nandc, reg, offset, 
size, is_last);
           else
                   return nandc_set_read_loc_first(nandc, reg, offset, 
size, is_last);
  }

   So here for macro expansion reg should be a value not a variable else 
it will be expended like
   NAND_READ_LOCATION_LAST_CW_reg instead of 
NAND_READ_LOCATION_LAST_CW_0,1,2,3 etc.

  the call for nandc_set_read_loc() as nandc_set_read_loc(nandc, 0, 
read_loc, data_size1, 0, true); ---> for last code word.
  nandc_set_read_loc(nandc, 0, read_loc, data_size1, 0, false); ---> for 
first three code wrod.


  So is this ok for you to convert these two macro into function ?

> And in the rest of your patch you won't have to touch anything else.
> 
> Thanks,
> Miquèl
