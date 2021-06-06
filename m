Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7151139CD03
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 06:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbhFFEqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 00:46:55 -0400
Received: from mail-pg1-f179.google.com ([209.85.215.179]:35758 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhFFEqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 00:46:54 -0400
Received: by mail-pg1-f179.google.com with SMTP id o9so8396965pgd.2
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jun 2021 21:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+KVe90NeyctxVwuF8XHr4AKJs2tGi2oHSqe5fPaA9Os=;
        b=UkYBESVSBOOgxDcZVf2Bnm2jZiFJw26648OetL7S4b7jYDdI9F6aJaHgnr2TNFWmmA
         VBoz18rvYlsfuM5r21G5i8Zw6bpxjlGlnOpkPXE1SailzA06Tg6UA6jp7+9yrpR783S+
         u9NAn1ZqBGELlEyN6r3Z6fOIDXd5b6uD5tehJ2uTAcU1q+zt/578Ii+J3Z77uCODLuJm
         pP9Y+lxF9yCmDZXAIeshXMmhhyAWX4U3co1IrCsJR1HScplm6APfcyrCaJJSmZAb9o8D
         pPPCH/smEle7q5KyjuiTBRMXRktTiH3givRfCXba2Up8IoHtQOYqikDqQU47TxjAtSFp
         6Cgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+KVe90NeyctxVwuF8XHr4AKJs2tGi2oHSqe5fPaA9Os=;
        b=sYcWeoBmXuYYGPRFTgu91Im4/giPVnYgZtEt1wAhkjspAqoiVgB1IEPqvuoF3IDEK+
         LKnOVD90O36CYsOhIuLq9t0jiLx8ceacuTABJ+HJAkYY5JJDMxafIQdSMoYoIexaqPDB
         xW+kZwpvkYOtcuiOWUiR1S0+SQiEd8QTR3a5wNDzkRS75/bTMpk+kTUG+DmnR05jxdnI
         MjKNDaaxA772vVL4uhYAGBRbF/YIt1WE50ATCzBnGfoNUoe/lJdnR7ldh8VKMo1XrnDL
         8UJH+Ap6scZ3wfXm7bTmBIcci8J2Mq+CRJbqhYEqECk+w2SFvbzJ4/oYnzc30qJosqif
         NNWQ==
X-Gm-Message-State: AOAM530plYuf4gXUYBEP4QjsiDlEfjx+NMVapp9afqjDT1suxlUb9wBT
        u2FDVnUWwZXptFSvkdBm+1k=
X-Google-Smtp-Source: ABdhPJxAQKjYi0EvXtU744uvM/EP0HiqjDINQhd7hjEqLvnzy2ajkJuHV/KOdcQqCmqZvJkUAvqbqg==
X-Received: by 2002:a63:5760:: with SMTP id h32mr12154766pgm.367.1622954630072;
        Sat, 05 Jun 2021 21:43:50 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:5762:ab6a:6802:ef65])
        by smtp.gmail.com with ESMTPSA id d18sm5329324pgm.93.2021.06.05.21.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jun 2021 21:43:48 -0700 (PDT)
Date:   Sat, 5 Jun 2021 21:43:46 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Jeff LaBundy <jeff@labundy.com>, kbuild-all@lists.01.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: drivers/input/misc/iqs626a.c:1645:12: warning: stack frame size
 of 2560 bytes in function 'iqs626_probe'
Message-ID: <YLxSgsTrnFSUP4Fq@google.com>
References: <202106061241.dpaJ49Wc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202106061241.dpaJ49Wc-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 06, 2021 at 12:37:43PM +0800, kernel test robot wrote:
> Hi Jeff,
> 
> FYI, the error/warning still remains.

I have no idea how it happens... 

> > 1645	static int iqs626_probe(struct i2c_client *client)
>   1646	{
>   1647		struct iqs626_ver_info ver_info;

This is 4 bytes.

>   1648		struct iqs626_private *iqs626;

This is 4 or 8.

>   1649		int error;

And another 4. And that is it. The bloat must be coming from elsewhere.

>   1650	
>   1651		iqs626 = devm_kzalloc(&client->dev, sizeof(*iqs626), GFP_KERNEL);
>   1652		if (!iqs626)
>   1653			return -ENOMEM;
>   1654	
>   1655		i2c_set_clientdata(client, iqs626);
>   1656		iqs626->client = client;
>   1657	
>   1658		iqs626->regmap = devm_regmap_init_i2c(client, &iqs626_regmap_config);
>   1659		if (IS_ERR(iqs626->regmap)) {
>   1660			error = PTR_ERR(iqs626->regmap);
>   1661			dev_err(&client->dev, "Failed to initialize register map: %d\n",
>   1662				error);
>   1663			return error;
>   1664		}
>   1665	
>   1666		init_completion(&iqs626->ati_done);
>   1667	
>   1668		error = regmap_raw_read(iqs626->regmap, IQS626_VER_INFO, &ver_info,
>   1669					sizeof(ver_info));
>   1670		if (error)
>   1671			return error;
>   1672	
>   1673		if (ver_info.prod_num != IQS626_VER_INFO_PROD_NUM) {
>   1674			dev_err(&client->dev, "Unrecognized product number: 0x%02X\n",
>   1675				ver_info.prod_num);
>   1676			return -EINVAL;
>   1677		}
>   1678	
>   1679		error = iqs626_parse_prop(iqs626);
>   1680		if (error)
>   1681			return error;
>   1682	
>   1683		error = iqs626_input_init(iqs626);
>   1684		if (error)
>   1685			return error;
>   1686	
>   1687		error = devm_request_threaded_irq(&client->dev, client->irq,
>   1688						  NULL, iqs626_irq, IRQF_ONESHOT,
>   1689						  client->name, iqs626);
>   1690		if (error) {
>   1691			dev_err(&client->dev, "Failed to request IRQ: %d\n", error);
>   1692			return error;
>   1693		}
>   1694	
>   1695		if (!wait_for_completion_timeout(&iqs626->ati_done,
>   1696						 msecs_to_jiffies(2000))) {
>   1697			dev_err(&client->dev, "Failed to complete ATI\n");
>   1698			return -ETIMEDOUT;
>   1699		}
>   1700	
>   1701		/*
>   1702		 * The keypad may include one or more switches and is not registered
>   1703		 * until ATI is complete and the initial switch states are read.
>   1704		 */
>   1705		error = input_register_device(iqs626->keypad);
>   1706		if (error)
>   1707			dev_err(&client->dev, "Failed to register keypad: %d\n", error);
>   1708	
>   1709		return error;
>   1710	}
>   1711	

Thanks.

-- 
Dmitry
