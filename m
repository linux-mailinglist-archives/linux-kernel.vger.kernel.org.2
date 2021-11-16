Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA93045292B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 05:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241047AbhKPEg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 23:36:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240016AbhKPEgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 23:36:50 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70830C219381;
        Mon, 15 Nov 2021 17:37:37 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id t21so15986656plr.6;
        Mon, 15 Nov 2021 17:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5giEjXmFz5wVNw4jTGQLtnYcBIEt2xUkApnMbyHyBfE=;
        b=YnTyUJ0mN5pZKCVFRp3lOKtS23GA5iSeP+PdfC3fnB5s64f4z+nYvqQvFxsC0LcuBE
         IaYPTdXFiKztP785jsKenmZuEN4WV7xBrTw4fSEWbTs9iStW07+MlsQh5Yg4VRuiDqgQ
         ngGNz/ImmiqiCl+9mNQCETcerwdnNtIKHoP7mgCAntK4KB+lUCwCFP68iQM7Da1riJp7
         uO8otg8eocqFZZLJzhDYhCcCE41+Rc3b5L88DuWtFHM86hHjDWWMjTXE2yjzZi1Iak++
         c5eBiqqoDHq/E3z0UyN2NM9x7NAVb9yxGWG68yZ1MoQe72rJOwDvbWPEh1C2ALytRdQp
         ax/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5giEjXmFz5wVNw4jTGQLtnYcBIEt2xUkApnMbyHyBfE=;
        b=aOCsRBSXEoxBXqbIO1iemGjghWBCfJR6f3uqCv+23ULfdYFj7+eii1Rnj6TNImn3su
         l99v6a9X5Gdf4+4uZmJ9gFM3Cc4DxBQHY68m7P+TGMIxrH5aFz5Y7E0wJYKzaRbWzHte
         ZKr9V8it+CeEKIWZxfVg7qMPFDoLWPgNzjkiwZPi7RSL/tCdr6q2JD7Ozz/C1WYnMesA
         t7RrbhESUpfWy4N5muLD3XD645YcoXiamTnAUfxa3BtXVLsi5STReqtvIkU108htjvX1
         qUR/4J+2VO1usnNue/p6uqwf0dQl8UOYJrlI1jQKaQ2Sd2LvFc9dOTpwDmD7QjZUQjt/
         adUA==
X-Gm-Message-State: AOAM5311Z4puQazS6Gm4poHqgv9LEy07VLUYn84izJyEICbCgEQIcMYC
        wnsHKRv6MwhxEGXLyvU4VgWhvNDTO2Q=
X-Google-Smtp-Source: ABdhPJzjv43rOd/qgrJTCbShy+/xS7YfXJVRITn+oLyvCMoVD0IoooCVrsLBYmdDF4idNmav6yilBQ==
X-Received: by 2002:a17:902:c78a:b0:142:1b7a:930 with SMTP id w10-20020a170902c78a00b001421b7a0930mr40969098pla.8.1637026656267;
        Mon, 15 Nov 2021 17:37:36 -0800 (PST)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id v19sm484427pju.32.2021.11.15.17.37.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Nov 2021 17:37:35 -0800 (PST)
Subject: Re: [PATCH] docs: Update Sphinx requirements
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <2c704ddd-2da2-138b-4928-890e92b66f9f@gmail.com>
 <875ystn40s.fsf@meer.lwn.net>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <550fe790-b18d-f882-4c70-477b596facc7@gmail.com>
Date:   Tue, 16 Nov 2021 10:37:31 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <875ystn40s.fsf@meer.lwn.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Nov 2021 02:48:19 -0700
Jonathan Corbet wrote:
> Akira Yokosawa <akiyks@gmail.com> writes:
> 
>> Subject: [PATCH] docs: Update Sphinx requirements
>>
>> Commit f546ff0c0c07 ("Move our minimum Sphinx version to 1.7") raised
>> the minimum version to 1.7.
>>
>> For pdfdocs, sphinx_pre_install says:
>>
>>     note: If you want pdf, you need at least Sphinx 2.4.4.
>>
>> , and current requirements.txt installs Sphinx 2.4.4.
>>
>> Update Sphinx versions mentioned in docs and remove a note on earlier
>> Sphinx versions.
> 
> It may be time to consider raising the minimum sphinx version
> overall...

There is one thing we need to address (you might well be aware of).

Our Documentation/conf.py is not compatible for hrmldocs with
the combination sphinx_rtd_theme 1.0.0 and Sphinx >= 3.0.
This issue is the same as the one reported at:
    https://github.com/readthedocs/sphinx_rtd_theme/issues/1240
    "No stylesheet after upgrading to 1.0.0"

I tried the fix suggested there (html_css_files option),
and a stylesheet can be generated.
But the resulting html pages look quite different from the one
you see at https://www.kernel.org/doc/html/latest/ with the sans
font for text and distracting look of monospaced strings.

You can see a screenshot of such a page at
    https://fars.ee/nkkZ

I guess there should be some knobs of Sphinx for customizing
the style, but have not figured them out.

Thoughts?

        Thanks, Akira

>              meanwhile, though, I've applied this, thanks. 
> 
> jon
> 
