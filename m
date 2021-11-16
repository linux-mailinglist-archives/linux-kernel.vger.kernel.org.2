Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8614529E5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 06:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235466AbhKPFlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 00:41:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235364AbhKPFlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 00:41:10 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A0FC0EC8E1;
        Mon, 15 Nov 2021 18:58:40 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id x131so16748959pfc.12;
        Mon, 15 Nov 2021 18:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7xJyceCwnTp5WWpRcEMQwaxzznJ9LbCDIFxPGA0GsOU=;
        b=O6HqemF+hZLRFMRVLyLsvbXNxHXQ92M95vr8nVPUBSLL9JrTeFM4wYJAfWFjDgroKS
         RPqOnf1OyTGxSqZMhoLhH99F6rnjUc4ok9JBWx8Pj83/r23bWeb3ZSAzJiH0LIFysUcU
         1ZPjZ2lRKapGLTZmbnFMrFdOFkdk3Mjyr0TKpScFvA/+fHhnNvgz65xBhZSIaPqyXOJU
         5I4djq734KyGA6STUfstxj/3F7w0ivk7GankPRWEzW8tHOLdHVgHgHGITeLMwErERXCH
         g6hP4yUW6j0Im6VK67Wi+71zXkmv7WVgjMDsF8kTX7BkM0tdCoLzY4GVjKuc02Z4OHr0
         8lSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7xJyceCwnTp5WWpRcEMQwaxzznJ9LbCDIFxPGA0GsOU=;
        b=IaADv3KApyjUiYZAEWNrGa5cbAoSUaw1KMAv84jVdM0KaBDFmIs0OJJ1/g7xlMXmED
         I+nmhJ5uoNDDL3C/UXDzK+b5WtK9V3fWHC0yv/73Cykq4xMYwG5hwdRkx8EW7jwZ0hNR
         Kpi4Rxcvd2OPv0Vc6br+3Wn2Ad2xaZD3MX80bu0zMixZfEmtRwjO6sXP52uj4wVRxmHx
         ZcdZI86ZCcZIB3C7bqG/0N3Ndsqge8wPv/3ALtHKltqN55FjIIlLQtSLs0DZvXnka/8Z
         bKNKlaDgmD8q1CBfPtRfS+Rpo+nSqahFJFVu1bMtAjc7AYUrBvzrqcs2ESufiOCIujvA
         APeg==
X-Gm-Message-State: AOAM530GCKRXNCaOpYDlOx9PycFly/hnwkwxOIeaXEfcEfcw+YFaWmVO
        4AaA3rgp7BWQ1UY0cs6IzhDN/xGVUUE=
X-Google-Smtp-Source: ABdhPJylo814/wyoZJZmJWUBYOtJ1heHX8jvPHhnHVMuPyrf//yoad0eMoYVtYDaGjuNzfPEEQ5mfQ==
X-Received: by 2002:aa7:8717:0:b0:4a2:967c:96b with SMTP id b23-20020aa78717000000b004a2967c096bmr19158419pfo.14.1637031520058;
        Mon, 15 Nov 2021 18:58:40 -0800 (PST)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id mu4sm632768pjb.8.2021.11.15.18.58.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Nov 2021 18:58:39 -0800 (PST)
Subject: Re: [PATCH] docs: Update Sphinx requirements
From:   Akira Yokosawa <akiyks@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <2c704ddd-2da2-138b-4928-890e92b66f9f@gmail.com>
 <875ystn40s.fsf@meer.lwn.net>
 <550fe790-b18d-f882-4c70-477b596facc7@gmail.com>
Message-ID: <e75633f9-3228-dd8f-d8d1-42f8b8046c9e@gmail.com>
Date:   Tue, 16 Nov 2021 11:58:36 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <550fe790-b18d-f882-4c70-477b596facc7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Nov 2021 10:37:31 +0900
Akira Yokosawa wrote:
> On Mon, 15 Nov 2021 02:48:19 -0700
> Jonathan Corbet wrote:
>> Akira Yokosawa <akiyks@gmail.com> writes:
>>
>>> Subject: [PATCH] docs: Update Sphinx requirements
>>>
>>> Commit f546ff0c0c07 ("Move our minimum Sphinx version to 1.7") raised
>>> the minimum version to 1.7.
>>>
>>> For pdfdocs, sphinx_pre_install says:
>>>
>>>     note: If you want pdf, you need at least Sphinx 2.4.4.
>>>
>>> , and current requirements.txt installs Sphinx 2.4.4.
>>>
>>> Update Sphinx versions mentioned in docs and remove a note on earlier
>>> Sphinx versions.
>>
>> It may be time to consider raising the minimum sphinx version
>> overall...
> 
> There is one thing we need to address (you might well be aware of).
> 
> Our Documentation/conf.py is not compatible for hrmldocs with
> the combination sphinx_rtd_theme 1.0.0 and Sphinx >= 3.0.
> This issue is the same as the one reported at:
>     https://github.com/readthedocs/sphinx_rtd_theme/issues/1240
>     "No stylesheet after upgrading to 1.0.0"
> 
> I tried the fix suggested there (html_css_files option),
> and a stylesheet can be generated.
> But the resulting html pages look quite different from the one
> you see at https://www.kernel.org/doc/html/latest/ with the sans
> font for text and distracting look of monospaced strings.
> 
> You can see a screenshot of such a page at
>     https://fars.ee/nkkZ

Having looked at https://sphinx-themes.org/sample-sites/sphinx-rtd-theme/,
I'm wondering if the screenshot above is exactly what you'd
expect by using the theme in the first place.

Hmm??

        Thanks, Akira

> 
> I guess there should be some knobs of Sphinx for customizing
> the style, but have not figured them out.
> 
> Thoughts?
> 
>         Thanks, Akira
> 
>>              meanwhile, though, I've applied this, thanks. 
>>
>> jon
>>
