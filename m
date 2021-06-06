Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14A8D39CD4F
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 06:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbhFFFBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 01:01:15 -0400
Received: from mail-pj1-f43.google.com ([209.85.216.43]:43848 "EHLO
        mail-pj1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbhFFFBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 01:01:14 -0400
Received: by mail-pj1-f43.google.com with SMTP id l10-20020a17090a150ab0290162974722f2so8361539pja.2
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jun 2021 21:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wc+pP4mJ8gC7Kc4Xkh4LOwsnF8sQMgUoyidPnbH7K5A=;
        b=Bt5YGf7PbGBx/bhgTNToF/kXluW1/3mRZ4bLzJeuAVf9UfUvCUodXfai0KWwgeycDd
         tppQ7vrn7FYVxUxBVPkEUAD3gAmfC70b4PUbl3vgrNi2Fpax4HDEyPiZswKFm3P3ECvV
         Fjud3h4fQWb80lVNrVOqfDwGXMXwjFUQVZYenX9c83ugQCeMqVF7Uze5ccDxE4z29brt
         ok0FEGuT10R9Gm2lIhHxTqg+xdq1gOPfmu7igFPrhdQOzyIosMKBWdbksSHvCHcwTGKX
         AVMFqE7DbKb12Dmi5df/v36ALJTT1uYF56gNCZXNrk5tT13weFCIJ+UjssxW/b2Ko8Mb
         OOAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wc+pP4mJ8gC7Kc4Xkh4LOwsnF8sQMgUoyidPnbH7K5A=;
        b=RUUcM8I5d3KiGoWkZLcAOurcQOrR87OXpzeRcn/zcp4LxnbQosyzAighNn/K8DuRw/
         Y0lRn2RqAqtwBa8UPVIIOLA3Heid9VyZtrUIB0AdQf0yMzAUK1ppRGGiD9Meiivz+p0K
         zXgZD4tRuV4p4jlPDzHOinjiKECIFG0wYiBgOT0YyqhU5dudq5cfqfHhxpJ0OYlKmHmn
         6yeN9syTSLye8yw96Jin3thiIAvZBSF9Rgv5KLJe+8LM58XObnBYAo7FpKtLDyQcOBHF
         UV8xlzLA1bypsDvgcJYKjogfwOCcV0BZ1Nh3tI7FzKaIozwebRlBvFXdIO2/5wimeZdI
         WWEg==
X-Gm-Message-State: AOAM531318aFOk/VvW5htwn298gF2rMKWBoxMoANkO47vKeKSMCXlr/d
        1CRSgfCYCtjcEJxybCgT5vs=
X-Google-Smtp-Source: ABdhPJwMKIEqBSeP0EPL43WKaZSWoGMEOrkL3WEd+e12W2zfRREDrh5l1GFzPsAXLXapbBM9WvIy2A==
X-Received: by 2002:a17:902:e20a:b029:109:ed31:ad68 with SMTP id u10-20020a170902e20ab0290109ed31ad68mr11902806plb.33.1622955505080;
        Sat, 05 Jun 2021 21:58:25 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:5762:ab6a:6802:ef65])
        by smtp.gmail.com with ESMTPSA id c11sm8347714pjr.32.2021.06.05.21.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jun 2021 21:58:24 -0700 (PDT)
Date:   Sat, 5 Jun 2021 21:58:21 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     kernel test robot <lkp@intel.com>, Jeff LaBundy <jeff@labundy.com>,
        kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: drivers/input/misc/iqs626a.c:1645:12: warning: stack frame size
 of 2560 bytes in function 'iqs626_probe'
Message-ID: <YLxV7cyZ5Mh2WoXA@google.com>
References: <202106061241.dpaJ49Wc-lkp@intel.com>
 <YLxSgsTrnFSUP4Fq@google.com>
 <365f58ae-d6c5-c9b3-631b-7e9266e91db5@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <365f58ae-d6c5-c9b3-631b-7e9266e91db5@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 05, 2021 at 09:55:14PM -0700, Randy Dunlap wrote:
> On 6/5/21 9:43 PM, Dmitry Torokhov wrote:
> > On Sun, Jun 06, 2021 at 12:37:43PM +0800, kernel test robot wrote:
> >> Hi Jeff,
> >>
> >> FYI, the error/warning still remains.
> > 
> > I have no idea how it happens... 
> > 
> >>> 1645	static int iqs626_probe(struct i2c_client *client)
> >>   1646	{
> >>   1647		struct iqs626_ver_info ver_info;
> > 
> > This is 4 bytes.
> > 
> >>   1648		struct iqs626_private *iqs626;
> > 
> > This is 4 or 8.
> > 
> >>   1649		int error;
> > 
> > And another 4. And that is it. The bloat must be coming from elsewhere.
> 
> In my experience, this stack usage comes from a compiler deciding to
> inline some called function(s) that has(have) more stack usage...

Right, however from the driver's perspective there is nothing that can
be done here.

> 
> Aha, I see that Paul just referred another stack frame size report to
> a commit that uses 'noinline' for some called function(s):
> 
> https://lore.kernel.org/lkml/20210606044926.GJ4397@paulmck-ThinkPad-P17-Gen-1/T/#m4a6ab160a5d9d974cf9ac524836a6292d73128e2
> 
> 
> >>   1650	
> >>   1651		iqs626 = devm_kzalloc(&client->dev, sizeof(*iqs626), GFP_KERNEL);
> >>   1652		if (!iqs626)
> >>   1653			return -ENOMEM;
> >>   1654	
> >>   1655		i2c_set_clientdata(client, iqs626);
> >>   1656		iqs626->client = client;
> >>   1657	
> >>   1658		iqs626->regmap = devm_regmap_init_i2c(client, &iqs626_regmap_config);
> >>   1659		if (IS_ERR(iqs626->regmap)) {
> >>   1660			error = PTR_ERR(iqs626->regmap);
> >>   1661			dev_err(&client->dev, "Failed to initialize register map: %d\n",
> >>   1662				error);
> >>   1663			return error;
> >>   1664		}
> >>   1665	
> >>   1666		init_completion(&iqs626->ati_done);
> >>   1667	
> >>   1668		error = regmap_raw_read(iqs626->regmap, IQS626_VER_INFO, &ver_info,
> >>   1669					sizeof(ver_info));
> >>   1670		if (error)
> >>   1671			return error;
> >>   1672	
> >>   1673		if (ver_info.prod_num != IQS626_VER_INFO_PROD_NUM) {
> >>   1674			dev_err(&client->dev, "Unrecognized product number: 0x%02X\n",
> >>   1675				ver_info.prod_num);
> >>   1676			return -EINVAL;
> >>   1677		}
> >>   1678	
> >>   1679		error = iqs626_parse_prop(iqs626);
> >>   1680		if (error)
> >>   1681			return error;
> >>   1682	
> >>   1683		error = iqs626_input_init(iqs626);
> >>   1684		if (error)
> >>   1685			return error;
> >>   1686	
> >>   1687		error = devm_request_threaded_irq(&client->dev, client->irq,
> >>   1688						  NULL, iqs626_irq, IRQF_ONESHOT,
> >>   1689						  client->name, iqs626);
> >>   1690		if (error) {
> >>   1691			dev_err(&client->dev, "Failed to request IRQ: %d\n", error);
> >>   1692			return error;
> >>   1693		}
> >>   1694	
> >>   1695		if (!wait_for_completion_timeout(&iqs626->ati_done,
> >>   1696						 msecs_to_jiffies(2000))) {
> >>   1697			dev_err(&client->dev, "Failed to complete ATI\n");
> >>   1698			return -ETIMEDOUT;
> >>   1699		}
> >>   1700	
> >>   1701		/*
> >>   1702		 * The keypad may include one or more switches and is not registered
> >>   1703		 * until ATI is complete and the initial switch states are read.
> >>   1704		 */
> >>   1705		error = input_register_device(iqs626->keypad);
> >>   1706		if (error)
> >>   1707			dev_err(&client->dev, "Failed to register keypad: %d\n", error);
> >>   1708	
> >>   1709		return error;
> >>   1710	}
> >>   1711	
> > 
> > Thanks.
> > 
> 
> 
> -- 
> ~Randy
> 

-- 
Dmitry
