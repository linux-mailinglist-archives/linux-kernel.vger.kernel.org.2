Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 454A0313D98
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 19:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235772AbhBHSdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234334AbhBHQRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 11:17:45 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F14C061788
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 08:17:05 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id h12so1580580wrw.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 08:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aaBKMnRXM76VUB0Qoag8JdTNr4XL1er0J91Eb9Bg540=;
        b=Q5o5BVqtOKxv7+VCMcZ+h49qvYsbkLeOdPqyKzh5GM6YlClJ8vu9nBRgsVjFH+4H4/
         taXKbqrMQeXZeT/dTOKtXZpmnkhXbdAuHDe9w+yyMIQrex0yXzC6asrXkQ6SjqD0Lcyp
         KOjhaxgALsRTgUQ4LXiHinQOIy8PjEBbz1mqvEoDHhxcanjVWNOPo36Bn3R1z+m2MkLT
         /HqwDeJyqgMsE31cTha3KDGuxjTjwohjmi/iQI0BSlsE/4lliOn9Vytbr5hyqb+4Qxb6
         ldcw+UtBoKgdj8VRbMpxhrYUqqHQ0CDQ8YYcGAo1zcVCgQgQiOQ1DAuta0JSXgCtB3P8
         VsUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aaBKMnRXM76VUB0Qoag8JdTNr4XL1er0J91Eb9Bg540=;
        b=FiE11i0pMTFbrYEaxyVYrxsdxLbJ6XZuWh2glVOQ24rL2AhsclNWieHmppycJJoxWt
         B7uBZ2Bb6KBbhPp8W0mX4HhSqQ+DfAJT9EO5TWa0KC9SAYLPZboMexFNaS8t4FfU9Cxg
         ph7JsXz2mTIhIc9ruM29HiXxyzGLfHHLK56EdJpzS0+5hDkmZAwFH4pe8NkQVWyEbWQv
         pv+I5yF5C+XqB9H7lyYl2bG7MkhLnALBcHVS+d+AjDIH+D6ha6MfW4mDHokIYXscZrFA
         +e4c6/DEY1n9Rikmm3cen/u+RCOzWotMaPtMdMJmB31wqyHYZyf+3Ia43Zv5MWhPFgaq
         deyA==
X-Gm-Message-State: AOAM532WXGHzTBtdd/ES3Diwp2+sgPHvT0Tj5/XtIPe7N7zGJ9eqGjbv
        o4N91w2K7Z5VMLZbPj/9+cCf4w==
X-Google-Smtp-Source: ABdhPJxnnCQSjQogvNvpcKbraMOutlLvkJdfzRF8nhXIrYaq59QP+GzyEZfiWFITnEnwC6L5Tnfxpg==
X-Received: by 2002:adf:fc8a:: with SMTP id g10mr21425065wrr.189.1612801024340;
        Mon, 08 Feb 2021 08:17:04 -0800 (PST)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id q24sm20742143wmq.24.2021.02.08.08.17.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Feb 2021 08:17:03 -0800 (PST)
Subject: Re: [PATCH v2 2/7] ASoC: codec: lpass-rx-macro: add support for lpass
 rx macro
To:     Mark Brown <broonie@kernel.org>
Cc:     perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org
References: <20210208141719.23305-1-srinivas.kandagatla@linaro.org>
 <20210208141719.23305-3-srinivas.kandagatla@linaro.org>
 <20210208160830.GI8645@sirena.org.uk>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <1397a895-c205-ae1a-5319-28cfacaa4ecb@linaro.org>
Date:   Mon, 8 Feb 2021 16:17:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210208160830.GI8645@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/02/2021 16:08, Mark Brown wrote:
>> +	SOC_SINGLE_EXT("RX_Softclip Enable", SND_SOC_NOPM, 0, 1, 0,
>> +		     rx_macro_soft_clip_enable_get,
>> +		     rx_macro_soft_clip_enable_put),
>> +	SOC_SINGLE_EXT("AUX_HPF Enable", SND_SOC_NOPM, 0, 1, 0,
>> +			rx_macro_aux_hpf_mode_get,
>> +			rx_macro_aux_hpf_mode_put),
> These are simple on/off controls so should end in Switch AFAICT.

Yes it makes sense!
> Otherwise this looks good.
Thanks, will fix this and send a new version!

--srini
