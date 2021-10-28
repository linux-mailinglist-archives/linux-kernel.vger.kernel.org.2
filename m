Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9754F43DA11
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 06:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbhJ1EGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 00:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbhJ1EF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 00:05:56 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED17FC061570;
        Wed, 27 Oct 2021 21:03:29 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id w193so6562454oie.1;
        Wed, 27 Oct 2021 21:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=S6lpuP4txG3Zyi23T7AGq3oAlRNM/MD8E5LDniLzV7Y=;
        b=QIKRU9PE94pBYIm3aw9kQI7OcvN1DKaDAiGIshNCHnhPvZZNDgei4wFzIarfT/7aEd
         H/CsU/nNCkszvaOtv644Lz4qIwVWE13pOZZAexhyX5k1KLVMmnVWd/O5UFhtFfJ/X2xt
         9XSKfa9s3MJ/sfVrdtpuY1jPWCXZyPGHZnvIFDc52/Cz6t4UL3mknDa+NhQ2hoea7XoI
         8bT/qzQtbQblfmQUFTJB1r9d7WgGRgQELFiDQ33Rh3SkU8lCB4P2lo5d3qcxA6AkbO1p
         vGuvOyPfpgGhvyqYPaRuIknl18MVFoQbA6xPxfBspQvP2rssSl6gZTKW7ylL9Qy4Ccm5
         9nNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S6lpuP4txG3Zyi23T7AGq3oAlRNM/MD8E5LDniLzV7Y=;
        b=M/jU/eJ/wVjHj16WhFb3BO/Abd/D4wCznZhle4fIdExpzUjhkr77C8Mul+Q0xxpiEz
         /VLZJH4ZA8mSRT95mbl9JCvXhXfVA0Ydu5wWbYVx7Sozkjok686DR++HD1rMyKm7D/A7
         JNpmb52GnEc6nEx6L/z0kcq4qT123OLO5fwFMn7ONuziiQi2Zm0WnUDlj1alBGTHsRyU
         KWpqILqZCaElXp5lEjDRtthwsk2NcB1O3OVH+MOrJcpUj4xVZISRbu/pm9AI5apOt+64
         4wC5vx2N2XYJw9nL8Ew1qUPUwxF89ndcMFSmwBVwGa/3Omd7tNOqrJFeSaUL5rsF9Bc1
         kxsw==
X-Gm-Message-State: AOAM532SVT3PHq5HQlQQ/BVwnl5Q1KkccT0qNJFWFfoeYr/OtUhRYudZ
        Fgsiycxt4H/cny8KBVo4AcrXr6VnH4w=
X-Google-Smtp-Source: ABdhPJw0upXWjARnJdyFIvbTnrY8XpG4oJxOcTFCjBlaf+eyxUZo00EfLsHNphtHPV2Wm5DbuCYm3Q==
X-Received: by 2002:a05:6808:b38:: with SMTP id t24mr7077100oij.20.1635393809012;
        Wed, 27 Oct 2021 21:03:29 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e9sm670727otr.25.2021.10.27.21.03.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Oct 2021 21:03:28 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [EXTERNAL] Re: Potential issue with smb word operations for
 tmp461 device in tmp401 driver
To:     "Wilson, David T. (GSFC-5870)" <david.wilson@nasa.gov>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
References: <SA1PR09MB7440BF952778F0DB8138747DE7B99@SA1PR09MB7440.namprd09.prod.outlook.com>
 <7f334e4c-0e71-2005-854f-c2d4e068ef85@roeck-us.net>
 <SA1PR09MB74408633E36AE3C97B4D2CA7E7BD9@SA1PR09MB7440.namprd09.prod.outlook.com>
 <3923f61f-031c-f293-dfbd-8db7efbce2cb@roeck-us.net>
 <SA1PR09MB7440DE6CE6882186ECDE3401E7BE9@SA1PR09MB7440.namprd09.prod.outlook.com>
 <8485a422-31b2-6d9f-516c-29d60fd13490@roeck-us.net>
 <SA1PR09MB74400C313FFCCEAE32A4C565E7869@SA1PR09MB7440.namprd09.prod.outlook.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <066daeec-a2dc-8a7b-f74a-0c4c94e42880@roeck-us.net>
Date:   Wed, 27 Oct 2021 21:03:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <SA1PR09MB74400C313FFCCEAE32A4C565E7869@SA1PR09MB7440.namprd09.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 10/27/21 6:54 PM, Wilson, David T. (GSFC-5870) wrote:
> Hi Guenter,
> 
> Like last time, I updated several files in my platform's v5.4 files and applied your three patches.
>>From what I can tell, I'm having no problems with the tmp461's basic support in the modified lm90 driver.
> 
> Thanks again for looking into this,

Thanks a lot for testing!

Guenter
