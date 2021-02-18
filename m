Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60DB331EF90
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 20:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234231AbhBRTSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 14:18:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234896AbhBRR6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 12:58:00 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195E9C061788
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 09:57:19 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d15so1665140plh.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 09:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=81POtabBJq2eGay3CWaGmtWfFPlaZit9yIcsKoLK2/Q=;
        b=QKYfgB0HnzU+tWc/4DVgPNH7Rth0slQWqPwDkgDdTO0LK+vIkQfF2f9+wVbf8foC0R
         LBhpMrOM1DFGngp/TBrCqUHKCWE1gvy3/R9y8PMLISnspBffYrvLWLEeqv/L9Kf7DE/Y
         IcR/Tr1ZCeMg4LtkEFoisYVa48mlhHxbICDZ8d0ZUPP2DjsMAjZKqSZ1GeOvtaHbbV4+
         2eS4kWGiQemyzlH5UGy/q9R/vAiw8mepC1AscCZJ6kF7ksi5IkDBHINDZnJWotg6cslA
         JwAerRrGgfPILXJrGy2APnt+PCu7JH1qjGXBtGlGt2nVU1UCfVJj3Muy6/Nd4BH39v00
         0joA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=81POtabBJq2eGay3CWaGmtWfFPlaZit9yIcsKoLK2/Q=;
        b=WM7TnDlgLPfRQi86m0o/64MgQChcSjBpCqKTibvaz0+eZaEpW5VVD9ITyQIKLHUsqG
         PbGEv/gVnW4dX0iPb0QK2F99+KV8Tq5+cBG6xGqrgxDXw9xZwoTtVCpgzQ9fB1cYrqym
         X08wn1i3M5BXfCdUfbpOFXJR7i7OdtrGSVVAvhi1wGvYQSMcy83Tf2RzoqMQ8K/QcEWV
         oN8BuwGRa8+6vjpynx8xmEMkTKlr6m+VSFXQZKv8knRWT3s0F5mi1qnUpT1QnEH21qYA
         d56+jfYoipGmM8U6CJsCvz+24JYS/5Lsbh0IkkngPiBKBupOQJOb4xRQWYd+7jbclDm0
         14WA==
X-Gm-Message-State: AOAM533Luq2w4MDS7zqEbJg1v+FeRHZKMh9QoV3dsa5trXgpNTyumBPH
        R8QyaFaolxC3YbDQ+l09jao=
X-Google-Smtp-Source: ABdhPJwuARrrorQEqtQKTdxh98p1fMtZ/By5+gozKvlT4EfI+fzpz3Ab6TKErQ95MJR88GvTnyItjQ==
X-Received: by 2002:a17:902:70c6:b029:df:d62a:8c69 with SMTP id l6-20020a17090270c6b02900dfd62a8c69mr5045245plt.20.1613671038511;
        Thu, 18 Feb 2021 09:57:18 -0800 (PST)
Received: from [10.230.29.30] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id c26sm7945056pfj.183.2021.02.18.09.57.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Feb 2021 09:57:18 -0800 (PST)
Subject: Re: 5.10 LTS Kernel: 2 or 6 years?
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Sasha Levin <sashal@kernel.org>,
        Scott Branden <scott.branden@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <ef30af4d-2081-305d-cd63-cb74da819a6d@broadcom.com>
 <YA/E1bHRmZb50MlS@kroah.com>
 <8cf503db-ac4c-a546-13c0-aac6da5c073b@broadcom.com>
 <YBBkplRxzzmPYKC+@kroah.com> <YCzknUTDytY8gRA8@kroah.com>
 <c731b65a-e118-9d37-79d1-d0face334fc4@broadcom.com>
 <20210218165104.GC2013@sasha-vm>
 <00b9e2fb-d818-58d6-edae-4dbd6aa814f7@gmail.com> <YC6ptKgsMh20tmu6@kroah.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <f9a466e8-99aa-ddb0-de2e-d17b66cb64f7@gmail.com>
Date:   Thu, 18 Feb 2021 09:57:16 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YC6ptKgsMh20tmu6@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/18/2021 9:53 AM, Greg Kroah-Hartman wrote:
> On Thu, Feb 18, 2021 at 09:21:13AM -0800, Florian Fainelli wrote:
>> As a company, we are most likely shooting ourselves in the foot by not
>> having a point of coordination with the Linux Foundation and key people
>> like you, Greg and other participants in the stable kernel.
> 
> What does the LF have to do with this?

I did not know whether the commitment/plan to use a given LTS kernel had
to be funneled through the Linux Foundation and then down to you, but I
am happy that this can be done publicly via a mailing list instead.

> 
> We are here, on the mailing lists, working with everyone.  Just test the
> -rc releases we make and let us know if they work or not for you, it's
> not a lot of "coordination" needed at all.
> 
> Otherwise, if no one is saying that they are going to need these for 6
> years and are willing to use it in their project (i.e. and test it),
> there's no need for us to maintain it for that long, right?

Right, that is straight forward, works for me!
-- 
Florian
