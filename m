Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09B52406FEF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 18:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbhIJQuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 12:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhIJQuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 12:50:20 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66802C061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 09:49:09 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id oc9so1750287pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 09:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=D73TCouYpmB9xTDq2w7pwNMpCZ26H76q6mSoWgYbZp4=;
        b=F43ZYCKmMprzrgdMer2LY0t1FWeggf1klI3wE4zuw9KgzxKPLwSUcLq68QagbKqcgS
         u0VbgQi7BC2XMZyYslXV24N/ciEdhGbIWfqgfBseRd38ZrP3eI+7SJQEnI7GqKfZAaMR
         q3hAwgZMiyBr1umfujg7FKciNwjoq9o3Kz4iYclfulVhUX17jd5SNphe0VrlITtTVsVW
         HE+x2l7uYN/EbTrEXl/4rvuTn+YC7CDq8oNL6h4+X/3iuWGqQxRBG5c7NbJ/aB9xrlcG
         0baweGLp/SP2nzj136hFGOJp8b880iaDG5mCLzvw2VbpcuC0YZ5UUv9hapNxd/tmnKKQ
         nNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D73TCouYpmB9xTDq2w7pwNMpCZ26H76q6mSoWgYbZp4=;
        b=ZDsaxywWvQJlqSUkTPLJ+onJzPTodjTTaol9JUZQrESNXeXIbM//3PjgWDM2UO1jzU
         H7I/avwngerfyBudPqCzMS0yvkzKiXATqBHwLs+N5OqIxwUOjF5r6LHmvplWc90KKKKJ
         gH7/GClXf5JTIA8578+cqIK8Q/VGmaxiLDackZO7AcaqY5Bzqq4F+HIy60vPCt2IZ7pp
         JuOegMXHWjEzw+MPxMHtLOIlPejSqWV+h7uSFJMjutJu+US4UUZ9jvYIfA+kePYiDVzx
         f/hGV4QEqdcrVnyf3nyqTHk3mHFm1e2FyOg7szXUqueJTbh+11tj4XXu79Fb6cPuoAWy
         t0nw==
X-Gm-Message-State: AOAM532PZ9QBPPFMvvTWMtQjOFXEfGay2WG3s9wSWZfmTWy0jD/fH3a9
        3oANSUxZoTeCL9nNO9Vqhv9cTZq+pOpeVw==
X-Google-Smtp-Source: ABdhPJw+XLEN+3FBF3KioB9P2490DQ0c/LCiYAWPjGRvjicH0jMd3fzKEg//lH4Jt+EWTnL0EVQeGg==
X-Received: by 2002:a17:90a:1991:: with SMTP id 17mr10627798pji.149.1631292548500;
        Fri, 10 Sep 2021 09:49:08 -0700 (PDT)
Received: from [192.168.1.6] ([117.98.200.228])
        by smtp.gmail.com with ESMTPSA id v190sm5537113pfv.166.2021.09.10.09.49.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Sep 2021 09:49:08 -0700 (PDT)
Cc:     saurav.girepunje@hotmail.com, Larry.Finger@lwfinger.net,
        florian.c.schilhabel@googlemail.com, gregkh@linuxfoundation.org,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: rtl8712: Move similar execution in to a
 function.
To:     Dan Carpenter <dan.carpenter@oracle.com>
References: <YTsXXxtQn7QN6nIm@user> <20210910090045.GD7203@kadam>
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
Message-ID: <a31836c3-6999-339b-32f8-5f7d7f7e5b27@gmail.com>
Date:   Fri, 10 Sep 2021 22:19:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210910090045.GD7203@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/09/21 2:30 pm, Dan Carpenter wrote:
> 
> On Fri, Sep 10, 2021 at 01:59:19PM +0530, Saurav Girepunje wrote:
>> In rtl8712_cmd.c function read_macreg_hdl,write_macreg_hdl,write_bbreg_hdl
>> and write_rfreg_hdl all are having same execution.
> 
> I get what you're trying to do, because this code is bad and duplicative
> but this is not the right fix.
> 
> Let's take read_macreg_hdl() as an example.
> 
> Look at how it's called:
> 
>     215          switch (pcmd->cmdcode) {
>     216          case GEN_CMD_CODE(_Read_MACREG):
>     217                  read_macreg_hdl(padapter, (u8 *)pcmd);
>     218                  pcmd_r = pcmd;
>     219                  break;
> 
> Then look at how it's implemented:
> 
>     120  static u8 read_macreg_hdl(struct _adapter *padapter, u8 *pbuf)
>     121  {
>     122          void (*pcmd_callback)(struct _adapter *dev, struct cmd_obj      *pcmd);
>     123          struct cmd_obj *pcmd  = (struct cmd_obj *)pbuf;
>     124
>     125          /*  invoke cmd->callback function */
>     126          pcmd_callback = cmd_callback[pcmd->cmdcode].callback;
> 
> So pcmd->cmdcode is GEN_CMD_CODE(_Read_MACREG).  We look that up in the
> cmd_callback[] array and it is:
> 
>          {GEN_CMD_CODE(_Read_MACREG), NULL}, /*0*/
> 
>     127          if (!pcmd_callback)
>     128                  r8712_free_cmd_obj(pcmd);
> 
> So now we no that "pcmd_callback" is NULL meaning it will free "pcmd".
> And if you remember in the caller it does "pcmd_r = pcmd;" but "pcmd"
> is freed so that's going to lead to a use after free in r8712_cmd_thread().
> It's garbage and the patch doesn't really help.

One more thought here after the

     127          if (!pcmd_callback)
     128                  r8712_free_cmd_obj(pcmd);

r8712_free_cmd_obj(pcmd); we could do  pcmd = NULL; so in the caller 
when it will do "pcmd_r = pcmd;" it is actually making NULL to pcmd_r. 
On r8712_cmd_thread there is check for pcmd is NULL or not before 
execution on pcmd.

pcmd = cmd_hdl_filter(padapter, pcmd);
	if (pcmd) { /* if pcmd != NULL, cmd will be handled by f/w */

Please let me know you thought on this dan.

> 
> The right way to fix it is to get rid of the cmd_callback[] array.
> 
>     129          else
>     130                  pcmd_callback(padapter, pcmd);
>     131          return H2C_SUCCESS;
>     132  }
> 
> Getting rid of the cmd_callback[] array looks like this.  In
> read_rfreg_hdl() we know that the callback is r8712_getbbrfreg_cmdrsp_callback()
> so we can call that directly.
> 
> diff --git a/drivers/staging/rtl8712/rtl8712_cmd.c b/drivers/staging/rtl8712/rtl8712_cmd.c
> index e9294e1ed06e..51a6abb27d41 100644
> --- a/drivers/staging/rtl8712/rtl8712_cmd.c
> +++ b/drivers/staging/rtl8712/rtl8712_cmd.c
> @@ -174,11 +174,7 @@ static u8 read_rfreg_hdl(struct _adapter *padapter, u8 *pbuf)
>   
>   	if (pcmd->rsp && pcmd->rspsz > 0)
>   		memcpy(pcmd->rsp, (u8 *)&val, pcmd->rspsz);
> -	pcmd_callback = cmd_callback[pcmd->cmdcode].callback;
> -	if (!pcmd_callback)
> -		r8712_free_cmd_obj(pcmd);
> -	else
> -		pcmd_callback(padapter, pcmd);
> +	r8712_getbbrfreg_cmdrsp_callback(padapter, pcmd);
>   	return H2C_SUCCESS;
>   }
>   
> 
> regards,
> dan carpenter
> 

Thanks Dan for review.

Regards,
Saurav Girepunje
