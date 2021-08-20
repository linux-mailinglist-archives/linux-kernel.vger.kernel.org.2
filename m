Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D30763F34E5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 22:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238571AbhHTUBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 16:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236881AbhHTUBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 16:01:46 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F91C061575;
        Fri, 20 Aug 2021 13:01:08 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id o2so10269102pgr.9;
        Fri, 20 Aug 2021 13:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VAPLeL95cvR7Whf9ALnhPYk6NtL3h94n5y8Oq/nUt84=;
        b=fjBCTLrjs8RvT3Hqx+Q7mrfyF2+LuDwZwZ8mAn2Oto1KTAFE/bmwGBp6YoVFRcnUbX
         0m0KhtYZxZzUd7ERjKdXQbeXrKCmMmFbfLu9AhyNnlZkWvW2VMGENNjEv+fuVN4z7xW0
         z49Pl3P0BTMAe/IMAyPu6m/0rGHJPMNMMwVUmxTxz13w2r7XlmuvN0m4xG0ZHmNDvvEe
         AZ9zqSgSSN4h5ajdDvYGjWDP0mkO8YL4r1V8CRQN9A79q5rxc9h9q9qKkCAVsznL3aRk
         2WNcfunPpHVobcxwhOgAFaG03hamqB7lXJcwdxDjJ+JoEhDCjqjYVFVnaxKyzN4OOmnu
         sYTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VAPLeL95cvR7Whf9ALnhPYk6NtL3h94n5y8Oq/nUt84=;
        b=n9rgECl3iFZE9wOiGli9ixwq7WkypDgqa3DG4XNHHFrRxzfYM14yFM0avRDYetx03t
         oH2j+E7Xb7AP7LWhYYFEpuipIEfA5ssTtuA6oKIh9Gj4GSa0tutu37RHfdFsBcdT4XO0
         V5QZnXb0WY0wHiftNyFGbaMHqUS4O9GXno3Tbxh/sjYCJZCIK4uvt54AIAT34apqNAar
         5l0kvZ+cxVmLcHcrOheRdaRbdy9e8zxH/gcYLZwZpvxH2w2tTIVe7rAyRXYlgpATUFWa
         o69znoqOIixisE1TSNVoWTJS1VCYGe9fhsRSHMIxVM8mgdLg4e6UcNr15FCZMiX4YRzO
         TUnw==
X-Gm-Message-State: AOAM5315tRoYqEuMmhSpFQCD1+MVm9gx7Wdn6KHmXsktvPQXNPxYszNI
        rUWqYyLIkhzfdA4gQTMKOsymt+M1JpvIrQ==
X-Google-Smtp-Source: ABdhPJxf3HNffkzj9n+lMr2VW/k/K+E9J1Sz3H5Qcr9U8xc5g40sIlLTxi6UuwtVD/VmxrkjG4G9CA==
X-Received: by 2002:a63:e756:: with SMTP id j22mr19824123pgk.362.1629489667264;
        Fri, 20 Aug 2021 13:01:07 -0700 (PDT)
Received: from [10.230.32.55] ([192.19.148.250])
        by smtp.gmail.com with ESMTPSA id t15sm9163102pgi.80.2021.08.20.13.01.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Aug 2021 13:01:06 -0700 (PDT)
Subject: Re: [PATCH 1/2] usb: bdc: Fix an error handling path in 'bdc_probe()'
 when no suitable DMA config is available
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        alcooperx@gmail.com, balbi@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <0c5910979f39225d5d8fe68c9ab1c147c68ddee1.1629314734.git.christophe.jaillet@wanadoo.fr>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <813a98b6-6e8e-87ad-c908-062d2801c386@gmail.com>
Date:   Fri, 20 Aug 2021 22:01:01 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <0c5910979f39225d5d8fe68c9ab1c147c68ddee1.1629314734.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/18/2021 9:32 PM, Christophe JAILLET wrote:
> If no suitable DMA configuration is available, a previous 'bdc_phy_init()'
> call must be undone by a corresponding 'bdc_phy_exit()' call.
> 
> Branch to the existing error handling path instead of returning
> directly.
> 
> Fixes: cc29d4f67757 ("usb: bdc: Add support for USB phy")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
