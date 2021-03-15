Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5A333AF8C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 11:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbhCOKFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 06:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbhCOKFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 06:05:03 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC87CC061574
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 03:05:02 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id y16so8364492wrw.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 03:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8SMiahey8v4BV8lToy6R2QEYE5blVKIxUsXSY4XKVRQ=;
        b=inE43yh5mxV2P8ekxS9v30Ff7VpTHlXC3ZjGUi1QDZ7nvdwPXd1Pg3DfXspYVOqh5T
         w75/Df4puJBkXNBhzHVJw1veurtp9RIKxzlmFK9EZCopSo5WjhgpfyhYbWBo/7dCNJzE
         +jZp4ek4nU+VTf9AS+ULq6g1ERI3ClvKHn8VllyeBcgSDTApgaIX9nIRIghpnt1QTnQe
         2eZl9H4kktV3Dbv0t239yPxofr+dsCvCwgsC/g97ukmq0VJ7WyIVr7z8dK9pc+rMVxEY
         G5fefnzN50DQ9wUmLf2HNX7AnX9K6OV0lWzwtP23Uc+/XoZsR6XChfPLO1YKJZh0KC/8
         L8eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8SMiahey8v4BV8lToy6R2QEYE5blVKIxUsXSY4XKVRQ=;
        b=MyzZGxDpHtjQfpTMgbtipqdCOyW4q+ogRau7gzsR7frH+GzWRpGi2YpzkNcUpeNt9j
         rb3LqelrHPeGjVEYMBr2Syqatz0oDr7ns7anuOIVifIx+6943yyCex9BzKTTb19KqtRF
         s6F+aYzh3O9FcuwHMzSreYfPVUIoRDAbDn0jCnJk3hPtGyjirNYDSe3fUyZ4zL5XtcNG
         rBxxRiUvX540w3w5LzryTZCSdjz24Qqp9HN1H9tChH9kQ7KYofQTKVE8GKK7DIVhoY/J
         3MMtTteCpz7GCuq0hD12SV2cJcb3YrQeP7b1hH5+jb5/3xBqDMHAZf06p45sXsl5QVHR
         Xpag==
X-Gm-Message-State: AOAM532BL1rB+MuK0DWZWbxK5SOjJL+pGuqUbRbp95D6zOOGJZhS97GY
        pnwHUod8vYsk9+dKodCIMcO1lQ==
X-Google-Smtp-Source: ABdhPJx7Dtu9ZS9xqeYGJ2GbicmlaYaRmGAHNW4y1Jny+wn05eTed91yW2P8HTmYZ5pXC1gUShoDnQ==
X-Received: by 2002:a5d:5492:: with SMTP id h18mr27037131wrv.340.1615802701475;
        Mon, 15 Mar 2021 03:05:01 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id g11sm17704589wrw.89.2021.03.15.03.05.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Mar 2021 03:05:01 -0700 (PDT)
Subject: Re: [PATCH 1/7] ASoC: dt-bindings: wcd938x: add bindings for wcd938x
To:     Mark Brown <broonie@kernel.org>
Cc:     perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com
References: <20210311173416.25219-1-srinivas.kandagatla@linaro.org>
 <20210311173416.25219-2-srinivas.kandagatla@linaro.org>
 <20210312152143.GH5348@sirena.org.uk>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <b68f9c7b-7c44-9a98-01bf-ee1fa8d5ee3a@linaro.org>
Date:   Mon, 15 Mar 2021 10:05:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210312152143.GH5348@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your feedback,

On 12/03/2021 15:21, Mark Brown wrote:
> On Thu, Mar 11, 2021 at 05:34:10PM +0000, Srinivas Kandagatla wrote:
> 
>> +  qcom,mbhc-hphl-switch:
>> +    description: Indicates that HPHL switch type is normally closed!
>> +    type: boolean
>> +
>> +  qcom,mbhc-ground-switch:
>> +    description: Indicates that Headset Gound switch type is normally closed!
>> +    type: boolean
> 
> Why do these descriptions have exclamation marks?

This was not intentional, will remove those instances in next version.

Thanks,
srini
> 
