Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0923F9B50
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 17:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241780AbhH0PBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 11:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbhH0PBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 11:01:08 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7413AC061757
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 08:00:19 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id q39so9838205oiw.12
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 08:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sT/hAVYHeCPn8/fKGQ1DHiSzcrL6MJiSLnVodARb2Q8=;
        b=HjBpLuj/UoUOlO6hFvtAFVToOBaUi7QqxzC/nQDwVsoEsqXtXFY5vPd/PaNv+LfyR9
         69fkrXuHRqEpHr5tgbriPozBS/yOzCyJEq6Y2MSc93QuJ+Uj4NrIzT8HbR1I4dGqalcx
         A55Jdwt8bGXtI5DtN5THjvMOd2KuvwnXWtmv4KbqAgss2abuROzmgFG+ytllVPWy2cid
         WYDC/0FFXy0MDjp6F1h1Y9/oVMhBU2XjNXOsG0NmrDhUHUt0HgsdVXJFAaK1VIWgBPwc
         Ti1Dr55ZtF/MazuiHilp7FQ0NkNA0iPANXKZ1gS6VLj+djSG19TeKHX9XSbWp56S8r+X
         CkoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sT/hAVYHeCPn8/fKGQ1DHiSzcrL6MJiSLnVodARb2Q8=;
        b=W3aE8K3I6KjiKxbuQSScKSw2VCK2/GCTNU6+fIBx1ti/wM9cF+85PQ6FuNKCvX/nhe
         3qgzH0dJAG0zosIVwqmXlOp1o3qsKgDMDRHmC5q9gAZiAir1GzmvxemSlE11iCMzhVNN
         KAhx8p0KJP4Ga5cclNvD7YhmYk8JEVRtja/SO4R4EwxkGi9HU6K9z5pV+d/ojUN70qGW
         1PqRwrPItMzLe8nfhOISvTp2LueMweTZhh/sjNGQGCr8SUgzyIFjhht4vPCJ2++iw6/D
         a1yP2MfuEkYDmPtbW4VLfdldeI8rF1Cyh2DIDFRb+27CeCdyC/0m8vYE9WIoe3TYAVVJ
         WGFg==
X-Gm-Message-State: AOAM531nkGg9dD8GRNPmaoT8Dh7M9jc0rd6DnELieEp9Kn4BTG4/J36K
        LbC7WUQ3aGkW16SbCr388+Q=
X-Google-Smtp-Source: ABdhPJyu07+t3J1QHJc05g5iW4JLWt5tqlj0fzuN2ahTLzdFoMEm7/4Pp0qXheDgfx0Tq4v4IfFO8Q==
X-Received: by 2002:a05:6808:a09:: with SMTP id n9mr14831598oij.67.1630076418892;
        Fri, 27 Aug 2021 08:00:18 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-1023.res6.spectrum.com (2603-8090-2005-39b3-0000-0000-0000-1023.res6.spectrum.com. [2603:8090:2005:39b3::1023])
        by smtp.gmail.com with ESMTPSA id y66sm1431987oia.12.2021.08.27.08.00.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Aug 2021 08:00:18 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: [PATCH v3] staging: r8188eu: Provide a TODO file for this driver
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        gregkh@linuxfoundation.org, phil@philpotter.co.uk,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20210827100813.18610-1-fmdefrancesco@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <a6265f77-cc21-878e-4980-272202fa5415@lwfinger.net>
Date:   Fri, 27 Aug 2021 10:00:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210827100813.18610-1-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/21 5:08 AM, Fabio M. De Francesco wrote:
> +* Switch to use LIB80211.
> +* Switch to use MAC80211.

You totally ignored my comment of yesterday!!!!! The driver will be converted to 
use CFG80211 - not eirher of those you quote, unless you are planning to convert 
to use mac80211. I am not.

Larry

