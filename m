Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D36E239FA40
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 17:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbhFHPXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 11:23:33 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:47020 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbhFHPX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 11:23:29 -0400
Received: by mail-wr1-f45.google.com with SMTP id a11so20143343wrt.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 08:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KMZoeM4tw0htYY4QWpAC+ev8zaiQVRwGUrBB7esHPik=;
        b=PpTPauAERRjBh68cUEvmQNnKdOcUUlbri6ZAm2HwfiSjlYibi9w6TZ/rMb91W4oQ66
         sHH9gOxASpdZfk/Y0nFhWUNZdaOuEkG/tPNmim7T89626VfyYp8dT9pf38atshqjtZDo
         4jOTX8oQizbVYJoZUUBU9RTh5EQgVMoalzO5xWkTYR3Uxm01PO4seuVVfLmoDNuyO3mh
         EHv+aBMKOsW3nGFdohprs4b3Xna1uKJq8oOFyhehTz2ax5proeuN5saE/04Yn0BvaJgY
         MJGNlrw9YdYPctZmFvsYz5eXtE4/O4s/C3sezz9re7qbGTgryrp7oY8lXR80gCOoV+hZ
         A6ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KMZoeM4tw0htYY4QWpAC+ev8zaiQVRwGUrBB7esHPik=;
        b=YYPaJY2FRhg76KitWnVzLLM/nG/Q/joH2nJDvjJNbwG682E9nLFwOln8l3hecp5mb9
         oEZki8FX6ieKgJt1Z3uYD9ExT0zkxgHjxFRwcXf5xF0gG4p4DmAoHDmhIK1uTaa8xIWM
         eyPKIizQn1a4ZGROo3Gqxnmy/N5svb/FjmDE9T96x8WJMp9nMrKD8wkupvXGsL9Z6Vs5
         qXYGrXvNnVdwKwyKHcOkIQgO7BUGDdYNRxLPAlZG/3geJTkd5Cy58F4Y/fzjoxZOnd65
         Yetmg/ey8TIFsg2NSqHJw4nRhxBYjH0Z/wWOjRXMyaaur36yO1YTSjZzk6Vc46SVc2SV
         3m+w==
X-Gm-Message-State: AOAM532D9ellfz0Y23JivWz3e/K/4yEMFdVu8KiRIlU6ZGqsJgXYeobC
        VYYqgq+yVgMcoVSqgGjHn4BiwA==
X-Google-Smtp-Source: ABdhPJxC82LsQQVwkWI8GVVxhjHkvMS5AzTGBd/sGHtaEic4jOy4D4GSdfgNGucNLArxxfT8qrF8oQ==
X-Received: by 2002:a5d:6acf:: with SMTP id u15mr23596492wrw.262.1623165627367;
        Tue, 08 Jun 2021 08:20:27 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id i2sm17456251wmo.40.2021.06.08.08.20.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jun 2021 08:20:26 -0700 (PDT)
Subject: Re: [PATCH v8 3/9] ASoC: codecs: wcd938x: add basic driver
To:     Mark Brown <broonie@kernel.org>
Cc:     robh@kernel.org, devicetree@vger.kernel.org, perex@perex.cz,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com
References: <20210601113158.16085-1-srinivas.kandagatla@linaro.org>
 <20210601113158.16085-4-srinivas.kandagatla@linaro.org>
 <20210608141209.GF4200@sirena.org.uk>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <a6ce009c-0946-fab5-3452-9ef2e2b6c79d@linaro.org>
Date:   Tue, 8 Jun 2021 16:20:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210608141209.GF4200@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/06/2021 15:12, Mark Brown wrote:
> On Tue, Jun 01, 2021 at 12:31:52PM +0100, Srinivas Kandagatla wrote:
>> This patch adds basic SoundWire codec driver to support for
>> WCD938X TX and RX devices.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   sound/soc/codecs/Kconfig   |    4 +
>>   sound/soc/codecs/Makefile  |    2 +
> 
> It would have been nicer to add the Kconfig and Makefile changes last
> for the benefit of bisection.

I agree, will do that in next version.

--srini
> 
