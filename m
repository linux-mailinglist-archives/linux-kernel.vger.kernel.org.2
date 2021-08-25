Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF3363F72BE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 12:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239037AbhHYKOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 06:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237193AbhHYKOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 06:14:44 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7170C061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 03:13:58 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id s3so42646900ljp.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 03:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JS8C6fS8XkmAAsadcB8zqjJCFkYRlN9Um96y+mbS8Cc=;
        b=Zoyz2GPzJxE/cLWDh9w/GrlJZh3XxMTY/o3rSVVq9xbHcltHeoAC3+1iMyYDpgXNbK
         U5QCwqHLyfONIKqL/5QWp8JtiZRRIKJpFKDPGc7ZHebsVwXCcJxW8r9wTQYqq2SBUPIJ
         31YUgpMEUuHq44jzK3Xg6Wf5aWzLz8Zc42HUzbRF9F4BScxyKjK+K6WRA8e6dgg7Uddm
         ++6CGWf+7K1pDuJr0yKos6h5tJAIWuH3K3Y+fSYhUSYNenimIzAAPam5MeA2b627PqQX
         Ooej31HsLeL2p1FYtI2uPK5lnkBttE6vwDexNbEVRTiXqibtGd4m+voyYONF1IHA6Ghd
         uluQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JS8C6fS8XkmAAsadcB8zqjJCFkYRlN9Um96y+mbS8Cc=;
        b=Z+IWmeYgudZAc9Mdxz9OtYLFqV7c552yaKGldvoROC7YKYPnc5dQQbAyn0UtPSKRXQ
         UdCIqQxa7udvUzW8kRbcPcC5m7E1nEXIJ6awinCrwwcm7VrBlNz7jc1zpuEyMtUw9pVO
         OzifrGbbQKq1/JA3rUg49H7L0QNa1O9Kz9ubDd4zxeQuY+XXhOQlyL+AiEZSl3gCabG4
         0IqIjuGL8a4M+S1hyAd2kzEzwUsDKtBAy9sDM0qvHKgxFy+Tbr7iGUAvQcvIm5SKBHSQ
         qcbqV5zLzfASSczRiAVv67TdRQHsRajawfBsct+mv31NfjSK/XQQAXZagWO2KnjhrMqw
         cciQ==
X-Gm-Message-State: AOAM533jBQrjpF3vOiQYTXU5f0rhVwq6DAnByuXAf6NYa8eFV5uFJKf0
        VYtI3/LHM87nDfTnJIploRl+rmQolZ3evw==
X-Google-Smtp-Source: ABdhPJzsRVopFPxrJm6WyComBRD3ag5rvATMX7m9T9++0GxomEUsZExl2Lfn4lE42mnJ6kKInbkP0w==
X-Received: by 2002:a05:651c:1186:: with SMTP id w6mr8434327ljo.50.1629886437077;
        Wed, 25 Aug 2021 03:13:57 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.66.127])
        by smtp.gmail.com with ESMTPSA id d24sm2219522lfs.80.2021.08.25.03.13.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 03:13:56 -0700 (PDT)
Subject: Re: [PATCH v3 4/6] staging: r8188eu: add error handling of rtw_read16
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1629789580.git.paskripkin@gmail.com>
 <1665728.ljvk3MsED4@localhost.localdomain>
 <ab20fcd7-69a8-0530-7770-0e309178b0f0@gmail.com>
 <2227654.mbYB7oqmoa@localhost.localdomain>
 <794dfd94-fe88-43ac-c4ec-9ff7df9db6de@gmail.com>
 <20210825100647.GS1931@kadam>
From:   Pavel Skripkin <paskripkin@gmail.com>
Message-ID: <3396277b-6d80-b621-0ef0-71de7d581602@gmail.com>
Date:   Wed, 25 Aug 2021 13:13:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210825100647.GS1931@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/25/21 1:06 PM, Dan Carpenter wrote:
> On Wed, Aug 25, 2021 at 12:55:37PM +0300, Pavel Skripkin wrote:
>> The main problem, that no one knows who is the "old". Greg can take patches
>> in any order he wants
> 
> Patches are always taken in first come first serve.
> 


Ok, but if pending patch needs new version, then it will be taken at the 
end?

Here is the situation we have:

	I have the patch series based on old function behavior, it was
	posted first

	Then Fabio posted refactoring of the function and it changes
	return values.


Both series are pending right now and made on top of staging-next 
branch. Who needs to rebase? I think, applying these series as-is can 
broke the driver, since error handling will be broken





With regards,
Pavel Skripkin
