Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC9039CD47
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 06:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbhFFE5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 00:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhFFE5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 00:57:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBBAC061766
        for <linux-kernel@vger.kernel.org>; Sat,  5 Jun 2021 21:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=m8efXfv/g60YfxuT1WW2/BIIYMXVtE0OiuXsdrqW2X4=; b=xi8e+t7yVzQ7FriOfy4ou9ggJW
        Vg0C/rw+Gh5m4hPry+lNW0MLsdX/quQVjElq9j1L6kAcPLotxEflMOKI5fhm0jmLngT3oQ4X2aN6M
        vkt8Nm2LQsPrjLQISJtCHrEhnVe4XZBrv4l4hnIQiG8rQyfr7r6HBN/3uOzeTJFtq9EKCwg7fEUc6
        fk53hS8W9sTlosJjArKwF9OWLWVx4G/tN6oZvv7SF3LAX2R891WvxMcXs8P1QCEkrPGPh05M/Y7Pw
        PMJXre9UGjZxb0cKOFLGTy0t8TWal6G+z2oFJu4y0Kg8M4hh3oBHdeA31NRvvvMcN3zNvAkBLAnaQ
        PKLVZYrA==;
Received: from [2601:1c0:6280:3f0::bd57]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lpkof-00HRQF-Er; Sun, 06 Jun 2021 04:55:17 +0000
Subject: Re: drivers/input/misc/iqs626a.c:1645:12: warning: stack frame size
 of 2560 bytes in function 'iqs626_probe'
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        kernel test robot <lkp@intel.com>
Cc:     Jeff LaBundy <jeff@labundy.com>, kbuild-all@lists.01.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
References: <202106061241.dpaJ49Wc-lkp@intel.com>
 <YLxSgsTrnFSUP4Fq@google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <365f58ae-d6c5-c9b3-631b-7e9266e91db5@infradead.org>
Date:   Sat, 5 Jun 2021 21:55:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YLxSgsTrnFSUP4Fq@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/5/21 9:43 PM, Dmitry Torokhov wrote:
> On Sun, Jun 06, 2021 at 12:37:43PM +0800, kernel test robot wrote:
>> Hi Jeff,
>>
>> FYI, the error/warning still remains.
> 
> I have no idea how it happens... 
> 
>>> 1645	static int iqs626_probe(struct i2c_client *client)
>>   1646	{
>>   1647		struct iqs626_ver_info ver_info;
> 
> This is 4 bytes.
> 
>>   1648		struct iqs626_private *iqs626;
> 
> This is 4 or 8.
> 
>>   1649		int error;
> 
> And another 4. And that is it. The bloat must be coming from elsewhere.

In my experience, this stack usage comes from a compiler deciding to
inline some called function(s) that has(have) more stack usage...

Aha, I see that Paul just referred another stack frame size report to
a commit that uses 'noinline' for some called function(s):

https://lore.kernel.org/lkml/20210606044926.GJ4397@paulmck-ThinkPad-P17-Gen-1/T/#m4a6ab160a5d9d974cf9ac524836a6292d73128e2


>>   1650	
>>   1651		iqs626 = devm_kzalloc(&client->dev, sizeof(*iqs626), GFP_KERNEL);
>>   1652		if (!iqs626)
>>   1653			return -ENOMEM;
>>   1654	
>>   1655		i2c_set_clientdata(client, iqs626);
>>   1656		iqs626->client = client;
>>   1657	
>>   1658		iqs626->regmap = devm_regmap_init_i2c(client, &iqs626_regmap_config);
>>   1659		if (IS_ERR(iqs626->regmap)) {
>>   1660			error = PTR_ERR(iqs626->regmap);
>>   1661			dev_err(&client->dev, "Failed to initialize register map: %d\n",
>>   1662				error);
>>   1663			return error;
>>   1664		}
>>   1665	
>>   1666		init_completion(&iqs626->ati_done);
>>   1667	
>>   1668		error = regmap_raw_read(iqs626->regmap, IQS626_VER_INFO, &ver_info,
>>   1669					sizeof(ver_info));
>>   1670		if (error)
>>   1671			return error;
>>   1672	
>>   1673		if (ver_info.prod_num != IQS626_VER_INFO_PROD_NUM) {
>>   1674			dev_err(&client->dev, "Unrecognized product number: 0x%02X\n",
>>   1675				ver_info.prod_num);
>>   1676			return -EINVAL;
>>   1677		}
>>   1678	
>>   1679		error = iqs626_parse_prop(iqs626);
>>   1680		if (error)
>>   1681			return error;
>>   1682	
>>   1683		error = iqs626_input_init(iqs626);
>>   1684		if (error)
>>   1685			return error;
>>   1686	
>>   1687		error = devm_request_threaded_irq(&client->dev, client->irq,
>>   1688						  NULL, iqs626_irq, IRQF_ONESHOT,
>>   1689						  client->name, iqs626);
>>   1690		if (error) {
>>   1691			dev_err(&client->dev, "Failed to request IRQ: %d\n", error);
>>   1692			return error;
>>   1693		}
>>   1694	
>>   1695		if (!wait_for_completion_timeout(&iqs626->ati_done,
>>   1696						 msecs_to_jiffies(2000))) {
>>   1697			dev_err(&client->dev, "Failed to complete ATI\n");
>>   1698			return -ETIMEDOUT;
>>   1699		}
>>   1700	
>>   1701		/*
>>   1702		 * The keypad may include one or more switches and is not registered
>>   1703		 * until ATI is complete and the initial switch states are read.
>>   1704		 */
>>   1705		error = input_register_device(iqs626->keypad);
>>   1706		if (error)
>>   1707			dev_err(&client->dev, "Failed to register keypad: %d\n", error);
>>   1708	
>>   1709		return error;
>>   1710	}
>>   1711	
> 
> Thanks.
> 


-- 
~Randy

