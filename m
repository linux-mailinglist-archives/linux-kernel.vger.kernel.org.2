Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3A4F41986E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 18:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235404AbhI0QD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 12:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235395AbhI0QDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 12:03:25 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A0CC061714
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 09:01:47 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id d18so23330727iof.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 09:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zWfRCgwbUCMt3VegiZe9H7fVuP1dOdTHuI0eCNUmEN0=;
        b=QziNJYCuQMNqedzOinM32sdAbqa01glxy7+EzSlsqgBGsBvODyEK11802a0pi5uFiC
         a2LHCgEGfyQPIeS8x7HsHUzkW6fV3WZ+v14ZjUIQTY3H4z5pqOk/GQlzNFygN42VfOCi
         QEX0vRox3xnZ8wGoKeufREp1TTNsRRS+Y3L4WYmJbrCxBQPVIHjUyhwqhYjQhjqWgh3W
         2iFAHheblRcWTomnmyKey9wf8Z1JoBooRmVvQ2g4CAFzrnecsA8KXVK8fg8JuoP5YalY
         msSKiNZtQjrGn2kT9lL6BZhwW3GdH0hP8jZ+f85C7xhWhVL/Ef7vRCxWLG5f+KjqlDWl
         +hsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zWfRCgwbUCMt3VegiZe9H7fVuP1dOdTHuI0eCNUmEN0=;
        b=kjIxfhCTpfJl+7k6vUA/tGw84Ic9HqMzGztjycPURYzAEQRwuaF2c0EXYs0Uv4/IRS
         HUQtLIwDIwMN/a/2nWWzozN0fQUYLxEBONYJQ5sRYJvJbLAzLYyEpUG1v4UeNW9v6xs2
         1Wb82vWohk1pjfoAoG+kXwOAZna+1eMvgp1GSShwl3hdcPvR7Y5ELiUIOYNSRQuKuKLw
         oZfBLIJIql8SZfeaZPNHTiIT9/QyR5gMPM7E0F5DQuMGjP8GI81tpFAIWE5KFlmDsNca
         qw+qEQHIMnkAOi/+lLIhN6cGvRyLfYlnXab8cLGLxn8cDQcHWgpoCYNVzoLFYG3Elzvj
         s7ng==
X-Gm-Message-State: AOAM532C7qGFsIDLS19PKGlTBwq0csO1+cAkvOlyWeQ5db0+Bon5HERQ
        lNoiuYzn9wQGlGjp0nl6vG/H6WPOtToobth4kDQ=
X-Google-Smtp-Source: ABdhPJwcefBo7p2+Pn59Tw6UOi3NrLcs/OaXxOLZYzH1Zi5emr9WEu/pbmgphL8ZJSpts0+Ytnfntw==
X-Received: by 2002:a5d:9c56:: with SMTP id 22mr376327iof.10.1632758506974;
        Mon, 27 Sep 2021 09:01:46 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id e13sm8898444iod.36.2021.09.27.09.01.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 09:01:46 -0700 (PDT)
Subject: Re: [PATCHv2] nvme: add command id quirk for apple controllers
To:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, sagi@grimberg.me,
        linux-kernel@vger.kernel.org, Sven Peter <sven@svenpeter.dev>,
        Orlando Chamberlain <redecorating@protonmail.com>,
        Aditya Garg <gargaditya08@live.com>
References: <20210927154306.387437-1-kbusch@kernel.org>
 <20210927154812.GA9730@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <31eb3b40-d3e9-d35e-5a3d-1a2199ef2dc5@kernel.dk>
Date:   Mon, 27 Sep 2021 10:01:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210927154812.GA9730@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/21 9:48 AM, Christoph Hellwig wrote:
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Jens, given that you're on the thread, do you want to pick this up
> directly to reduce the patch queue latency?

Sure, applied.

-- 
Jens Axboe

