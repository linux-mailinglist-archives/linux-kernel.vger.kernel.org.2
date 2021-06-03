Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FADA39A1B8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 14:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbhFCNBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 09:01:23 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:40845 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbhFCNBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 09:01:22 -0400
Received: by mail-ed1-f54.google.com with SMTP id t3so6986694edc.7
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 05:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=S32qhgXw6lhcBac72fW5aifr88ZTXgBqkSLyW4FBSRE=;
        b=aDfm993CvwBzKEU6AMF3NjjBBTCq3pYbIDf+HDoVgTqBJ5UrcUk/OuIlcxTYXL1loC
         TjdpT6ASpEN6RgFQTG5jrJggb5OUNheVMZjleXGXQtwdLmJqtFEwdg8WS8cSTDfM27vX
         rdDT/0PJl6TnTWvPQQsH7JX16wXJ6a8pqDJz9VyrS8fHhtVOMi4NzxF4ai/Wm2wr1UYJ
         JQilApDLYXx2/ePzQix7V+ngwWD9t3pUvHIamB20DG+ZMMmN5ce3+AwsGDGPRlJ0ZJQr
         xCTgCsTDQCFIrHZX3gbGw8v+QC5otgxdnbsD17u27A7ZinB+VpB8g++j3n+WllPD6acs
         WaDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S32qhgXw6lhcBac72fW5aifr88ZTXgBqkSLyW4FBSRE=;
        b=ps5AmHF8hfFB86LhsVTHh3sTGuOu7sItyUQfOFrtYs4E/6J0ccm8/9EUSMiZNrhXGp
         ymRgVAUGnlu/z4aHl+0d0bf8UksFhWR+L5beFKT90eEBlpaEpSAUGBBpRYjgQV6peI/W
         gQPlYmUKSl6j2nyeDNLbkFh7TcruP0VSCu4FHJhqDqR4nSHJCXj+TqkzC2A/R1yI5uIt
         ucMD8t0k9npar9Xzw8IySsH+z2rrrTHVI+INLsRzJ1WH+A8+TJABzTLukCDqWK84Y8h1
         K0nPyhu4O8keIerVOOzfLBBx52jyiGR76W3Fjv22yEf4mRch4daVhkZamATFqhKIYaDH
         CLag==
X-Gm-Message-State: AOAM531eCYYHZbfCsOvD3UPGy6NKZAf5VcUIiIPT0rCFhcbdK+tllH4o
        ah7LmbxucWOovcPNe6F9/9ctHA==
X-Google-Smtp-Source: ABdhPJzmI3KvAOVc3eQ2Z1TXrXwjtBqFKOhH08L/qt7QjcYkxgy6UMrK5D0Kj9lBamgyA8IQJBPzrw==
X-Received: by 2002:aa7:dc12:: with SMTP id b18mr43396617edu.52.1622725116707;
        Thu, 03 Jun 2021 05:58:36 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id ho32sm1423106ejc.82.2021.06.03.05.58.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jun 2021 05:58:36 -0700 (PDT)
Subject: Re: [PATCH v2 2/4] ASoC: codecs: wcd: add multi button Headset
 detection support
To:     Mark Brown <broonie@kernel.org>
Cc:     robh@kernel.org, devicetree@vger.kernel.org, perex@perex.cz,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com
References: <20210524110700.27077-1-srinivas.kandagatla@linaro.org>
 <20210524110700.27077-3-srinivas.kandagatla@linaro.org>
 <20210603124455.GE4257@sirena.org.uk>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <676a583f-1bed-f837-3013-ffec7bfd36e1@linaro.org>
Date:   Thu, 3 Jun 2021 13:58:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210603124455.GE4257@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/06/2021 13:44, Mark Brown wrote:
> On Mon, May 24, 2021 at 12:06:58PM +0100, Srinivas Kandagatla wrote:
> 
>> +		break;
>> +	default:
>> +		break;
>> +	}
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(wcd_mbhc_event_notify);
> 
> Why is this not EXPORT_SYMBOL_GPL?  Same for the other symbols that are
> exported, between ASoC and regmap I'm not clear that there's anything
> useful that is usable from non-GPL code...

This was not intentional, will fix this in next version.
> 
>> +	/* Report insertion */
>> +	if (jack_type == SND_JACK_HEADPHONE)
>> +		mbhc->current_plug = MBHC_PLUG_TYPE_HEADPHONE;
>> +	else if (jack_type == SND_JACK_HEADSET) {
>> +		mbhc->current_plug = MBHC_PLUG_TYPE_HEADSET;
>> +		mbhc->jiffies_atreport = jiffies;
>> +	} else if (jack_type == SND_JACK_LINEOUT)
>> +		mbhc->current_plug = MBHC_PLUG_TYPE_HIGH_HPH;
> 
> This would be more idiomatically written as a switch statement.

I agree, I did try to keep it mostly in switch case, looks like I missed 
this one. Will change this in next spin.

--srini
> 
