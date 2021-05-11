Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A27C37AA89
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 17:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbhEKPW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 11:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbhEKPWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 11:22:23 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4970AC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 08:21:17 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id b21so9214442pft.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 08:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=V4LMkvrniJAvXU5xBJtPWHipHjdbSyBWhYEiZ+dOod0=;
        b=y4/MogwDmaORtiOLwmXGVcCfVM0eb+52pG4AdHLjv5KE5RBUJET+oKZl2pvuxXOHlk
         LLryLjnhfquSTGLYfA1kdDzV37qrFBQP6sF121xXPeKIjVaame/IW8MXvsEkVOyYuSvV
         Qp5JuQpg/OFsYLOJmYd+Sokowdahqc8Wr+zCTMRJk/wcigaE3LWMQhWyMxKqBQPFdxq2
         FKKCTmCf7iAyWjxknBb5tyrtVJ8WDU8/sIoJjR5MEKPk0foLgLzLTt9ANKOJIYTeCw2Z
         SlDaw1t7FRtafqC2YXckhVoj7PVtBefsDz9ve/C77nPKfTGL2Cfwxh0qY1tD5TObSE4n
         kKFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V4LMkvrniJAvXU5xBJtPWHipHjdbSyBWhYEiZ+dOod0=;
        b=rXQQFNtVLE6DKjOx+6RLnQ25SYvyquANvtFSHFimy9sQiLRTTNHOABqKg7+KSf60ih
         FmuQFExwMYhqkCgPAkSQvQNLd67L/cUG4hAcXH0lpnky/5Am5B9f7tTd+qD22+B2I+hY
         Fy/u71LdCPHuP5HcXeAEAKSwJUEZX4ujumqpju6R9BVOXbQYmqf57w6UhFPx3NI9ZePk
         pRopVprRzfbinmKvaKl7uJ0/9P4KUqirYwmfQKtgvTLaxwXOgCLGnlzgmO8sFuqZeTsU
         50OGkSHYRI2i4lhBJddSl7mYJcR3STYbn1HGBprLQvGs1Q4VUG65I2+UiKLRvGdb1Drf
         kkUg==
X-Gm-Message-State: AOAM531ban4lIr5kcaznSZkL8658W/b8bF9lldM1XCpR5t8p9rF9qex2
        9UcTATwpww/TI6dl9m22ffJJ1zfUujLstw==
X-Google-Smtp-Source: ABdhPJxN0Um6faHA1gCmqjavnQ6o8dzaaki7KNEEljFxMpvN8az3x681fvXJa8AgcZP2A/WSLcqHmw==
X-Received: by 2002:a63:4f4a:: with SMTP id p10mr31279585pgl.432.1620746476541;
        Tue, 11 May 2021 08:21:16 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id o4sm14004075pfk.15.2021.05.11.08.21.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 May 2021 08:21:15 -0700 (PDT)
Subject: Re: [PATCH 1/5] docs: cdrom-standard.rst: get rid of uneeded UTF-8
 chars
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
References: <cover.1620744606.git.mchehab+huawei@kernel.org>
 <79c3f482da17ea48d69b6e6ad1b7fb102b9dd7bf.1620744606.git.mchehab+huawei@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <11b486e5-f663-e530-7b70-84563a92fb02@kernel.dk>
Date:   Tue, 11 May 2021 09:21:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <79c3f482da17ea48d69b6e6ad1b7fb102b9dd7bf.1620744606.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/21 9:01 AM, Mauro Carvalho Chehab wrote:
> This file was converted from a LaTeX one. The conversion used
> some UTF-8 characters at the literal blocks. Replace them
> by normal ASCII characters.

Acked-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

