Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99DEB3405D1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 13:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbhCRMo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 08:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbhCRMoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 08:44:07 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FEF2C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 05:44:07 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id hq27so3711307ejc.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 05:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=60m7zfvASukTWP0DzkRp5rJmsSI9XBM2J1e30q6mvIA=;
        b=YMJQ7pTNw2uJTzM6kcuImCz+VsaWCuJYkK6XkbgNpzWQ6VBk1pgChKEsG2Wk3R8D54
         hxAj2sP52yG6jYmH7cjRwxooUtzUAeZGH++zNrIoticB9iWSlM20EgRzoM/z0y34Buth
         j9l6GELMyHC6w94CCGlcmQPD7ynybOcRot6BE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=60m7zfvASukTWP0DzkRp5rJmsSI9XBM2J1e30q6mvIA=;
        b=HdHZ1UX+RNjtGKDG5fmjvgS6Ee40V9pBej60fDVR6esAz48rYmZD6kDDV79tmpH0Ic
         olqtELVbP50NPJUZWjs4z4jc0WBP2vzKRVUG2moAKwXC8NHso52lqcMfEj4b0dtCBVGb
         KUHA5uQFqFvxoNIsZUCOzFQGpuE7Yy7y8MC//AixzUNdF0zh95AutZUt0mFIwvVJ+4ZN
         F4pKJ7GPIZC76qixCpAHn0/Yi022aaoTC2ndBxRiTsdXbSC3jDB+cf2eqNdqwU6EkcKb
         C4QHtE428CC/OwKCkEXdPs/9chITiNw+0fWMXAy9F2AGL2L5vFcH8Q2FUdqogaKm0tR8
         ltEg==
X-Gm-Message-State: AOAM532fZrAhcGTwhPykQFxQUBvXHFcst5hYZr03wOLPwF2PwVRM39bO
        SP4K80wtVNoQSNqPeBXORLNwqbhQCjPERA==
X-Google-Smtp-Source: ABdhPJxk+OWLI2MU6PB44ppFaoSsCKO43kMB1ZcwAfnKk+qgkBAHa/mSkig4f5XsZyjWs6e+wV3NGA==
X-Received: by 2002:a17:907:76c7:: with SMTP id kf7mr40082241ejc.470.1616071445913;
        Thu, 18 Mar 2021 05:44:05 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id b18sm1795175ejb.77.2021.03.18.05.44.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Mar 2021 05:44:05 -0700 (PDT)
Subject: Re: [PATCH 1/2] devtmpfs: fix placement of complete() call
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
References: <20210312103027.2701413-1-linux@rasmusvillemoes.dk>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <b9db4269-2e7e-76ec-4f54-e871d3798d45@rasmusvillemoes.dk>
Date:   Thu, 18 Mar 2021 13:44:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210312103027.2701413-1-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03/2021 11.30, Rasmus Villemoes wrote:
> Calling complete() from within the __init function is wrong -
> theoretically, the init process could proceed all the way to freeing
> the init mem before the devtmpfsd thread gets to execute the return
> instruction in devtmpfs_setup().

Greg, ping? Also for the other one.
