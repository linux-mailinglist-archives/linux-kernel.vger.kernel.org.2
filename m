Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0A2396A16
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 01:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbhEaXcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 19:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbhEaXcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 19:32:51 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0432C061574;
        Mon, 31 May 2021 16:31:09 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id q7so18879386lfr.6;
        Mon, 31 May 2021 16:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=loyE3+d7FYs23NduGEVaC782juL8FWsQQtV+t3+5j50=;
        b=Poiv2s5leW/4RP3f27MJl6yFji3tzgViyv1TmxfnE3krNssphlw+LfgDeuon5gBD+t
         /weoy0UUEH2QUg+gZw2jcTTLMDtbImTFs2OBbpsTSVLkQM+vbpTpimZdORfjsLo4GfbG
         dILEa/qD0Hf3cfsaPdyuuKIA8JKUSiY+CC83NM5TfdEnzm/2bX37NYv7c7pOBXDTuxg3
         4mJQrHEnb47exTNP3yBa3ipDtaR16DxXcs4mhi9nEO8MgK+wYdj9pyuRLPVCLByc/b0S
         h8jWmxubEun+cG/723z+X5rRoyRcXTmb75xA0o0Vqjgp1WePCbpdtWxoN+SRAF/IrJh3
         uQeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=loyE3+d7FYs23NduGEVaC782juL8FWsQQtV+t3+5j50=;
        b=EBwhDuKD5jQOsRXio2TYtfuMdYIDLGc8eS+W7WRAodhFRt1gNjFrP7lTNERChlpUKs
         CpTJRJ7vtSiel9JwFT/3ZNUZ5yhe7beoZz8/OKRr7IjiNfgyrQU2zJriDn0FdZTgD7vR
         TXE5100ZiMUGa4VWdkCMZcH8TVxUh4H07AoMjTfAJ86IQR8aaNC7l5SVx/ZP+6WczHrL
         MR/otuYRXAAGCi5vNWIuvOGwIYm9SdNqOZX+7TVghaUODsjF37RYyIxo0Kys2v59sNz/
         ChNSdcCl8F+3Yq+7mQrpM96jwT7jcEEiMS8e4oNQsEkgytJtid1Y/7XG0tjaCvNCLUL6
         Kr0A==
X-Gm-Message-State: AOAM533/c0VObTIykpdndzX1ar5W+FllPNOzRGac93vhHcgo4xh8JOzJ
        vRHH7uLIBxXu2DHSI2kOq4+5Cjp8zfmcDxmE
X-Google-Smtp-Source: ABdhPJwnA8j6xRyHkYDJ9foRgXek1Hj/snPmxQlRbMF8LXmObkXIi2uOyMyQDrkLUoF54NEzWk5G3g==
X-Received: by 2002:a19:f714:: with SMTP id z20mr11668757lfe.526.1622503867943;
        Mon, 31 May 2021 16:31:07 -0700 (PDT)
Received: from [192.168.1.68] ([91.77.167.245])
        by smtp.gmail.com with ESMTPSA id n6sm13423lji.20.2021.05.31.16.31.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 May 2021 16:31:07 -0700 (PDT)
Subject: Re: docs: Convert the Speakup guide to rst
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        speakup@linux-speakup.org, corbet@lwn.net,
        gregkh@linuxfoundation.org, grandmaster@al2klimov.de,
        rdunlap@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210531215737.8431-1-igormtorrente@gmail.com>
 <20210531220754.h4ep2dj65wl6hejf@begin>
From:   Alexander Epaneshnikov <aarnaarn2@gmail.com>
Message-ID: <97a067af-4d55-42ba-f45b-297e9ce79a1a@gmail.com>
Date:   Tue, 1 Jun 2021 02:31:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210531220754.h4ep2dj65wl6hejf@begin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


01.06.2021 01:07, Samuel Thibault пишет:
> Hello,
>
> Adding the speakup list in the loop.
>
> Igor Matheus Andrade Torrente wrote:
>> Modify some parts of the text and add the necessary formatting to leverage
>> the rst features. Including links, code-blocks, bullet lists, etc.
>>
>> Also, adds a table of contents at the beginning and a section to the
>> license.
>>
>> This change helps integrate this documentation to the rest of the rst
>> documentation.
> Mmm, I'm unsure how the result is readable with the speakup screen
> reader itself. I have attached the result, could people on the speakup
> mailing list check how well it goes? If it significantly degrades
> readability, we'll have to reject the move to rst formatting, since in
> the end it's people who use the speakup screen reader who need to be
> able to read this document.
>
I think this is a great change. to be honest - I myself thought to do it 
a few months ago.

As for readability, rst is a rather minimalistic format, so it is 
convenient to perceive it even in a raw format, and the advantages of 
using it, in my opinion, outweigh all the non-conveniences that I do not 
observe.


> Samuel


Alexander

