Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85BA638F42A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 22:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbhEXUUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 16:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233305AbhEXUUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 16:20:17 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B6EC061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 13:18:48 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id l11-20020a05600c4f0bb029017a7cd488f5so8945084wmq.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 13:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NlwVCabGoPck/wrCZD7PPdJ/y1DjIzEwmwDqz8gfG9c=;
        b=LUc2SHgU8Vxmj0GUHhNAAjIiFNPu+XsqpIqXs/4GsV3UWu6V0ouMk7GSz1jiFqWWMk
         Lz24WZ0hW0ZJlqaG/YInQeIjIA0JSvaCZvJPheuBmE5Be2HQjnryqp/YT1LotoBkTaea
         bG5Iu3I53+wPAqai+tbxDEIZklV0ULswgy8AhOfVu3DeRaV1Cslcf4m2eDUyw+0TSusy
         ey9zwlr4El/iv3asQqNTayndmd94jHrFoigNxoE81dcWwvS1aNygVvi5IM7Tg0VHF8QQ
         rwmGciieAjqYUcYYxwQpT8Wx+3J9VhdkSFa53Anm/JS8SJL+8kCWgRiHnme+9SEIyAot
         3iNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NlwVCabGoPck/wrCZD7PPdJ/y1DjIzEwmwDqz8gfG9c=;
        b=oHBuTuLKJWck2M1TwZkxnASu+x+/UiPFylXpH8J0n1VhMMqR2NOeYFnrEyvZms6Pv9
         ztUD1x9cg4FfFp7BHNf/Y99MNdwfq6l2sKiQ+sXdzcuRIAjLhiwQD+yxh8qGTkSgSp7u
         +7LQO2W25gju+hr/AAbuHPDcSjK33WmPA0xSMkr5OoWVG4rOsdt2FcZuk8pFhSDx6GIl
         vcp44PYNZK/5bRtkbouDlqsmHEOffo+10a1ejYFEhyaiHTU+WrPwPohxVB3E8DID784u
         fN5sEQaGRMVFKb7kkQS6ZqWt0m+mqCx7xxIo8QoWU1KBA+LmGu15Z5UERxoecWoL2njV
         3zoQ==
X-Gm-Message-State: AOAM532h8M3BEXpfG2vzvW4F6FpY6qZ/QERYrJwJNjPeXqBlvv+1VESy
        1MfMCdzJXcUNnUx3+hysq4mSq0rebko=
X-Google-Smtp-Source: ABdhPJwTXCXFkrGPDp4v9ZJGLjUDHatD/JsxX+HzCFRRo5nVS7Ds25a32QuP5K3ELw0lI9I1rfqXbA==
X-Received: by 2002:a1c:1d50:: with SMTP id d77mr639083wmd.7.1621887527149;
        Mon, 24 May 2021 13:18:47 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f38:4600:8954:39a5:6045:cd0c? (p200300ea8f384600895439a56045cd0c.dip0.t-ipconnect.de. [2003:ea:8f38:4600:8954:39a5:6045:cd0c])
        by smtp.googlemail.com with ESMTPSA id y3sm13123755wrh.28.2021.05.24.13.18.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 13:18:46 -0700 (PDT)
Subject: [PATCH 04/13] eeprom: ee1004: Remove usage of i2c_adapter_id in
 adapter comparison
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <bd8439bc-3a6f-fd52-5fd1-bf9782061612@gmail.com>
Message-ID: <99a3f94d-e7ca-e01d-6a78-81e109fde086@gmail.com>
Date:   Mon, 24 May 2021 22:11:31 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <bd8439bc-3a6f-fd52-5fd1-bf9782061612@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can compare the adapter pointers directly instead of using
i2c_adapter_id().

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/misc/eeprom/ee1004.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/misc/eeprom/ee1004.c b/drivers/misc/eeprom/ee1004.c
index 2824dba76..b991ab250 100644
--- a/drivers/misc/eeprom/ee1004.c
+++ b/drivers/misc/eeprom/ee1004.c
@@ -199,8 +199,7 @@ static int ee1004_probe(struct i2c_client *client,
 				goto err_clients;
 			}
 		}
-	} else if (i2c_adapter_id(client->adapter) !=
-		   i2c_adapter_id(ee1004_set_page[0]->adapter)) {
+	} else if (client->adapter != ee1004_set_page[0]->adapter) {
 		dev_err(&client->dev,
 			"Driver only supports devices on a single I2C bus\n");
 		err = -EOPNOTSUPP;
-- 
2.31.1


