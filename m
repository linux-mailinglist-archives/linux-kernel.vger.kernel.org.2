Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5905544701B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Nov 2021 20:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234913AbhKFTaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Nov 2021 15:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbhKFTaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Nov 2021 15:30:17 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DE3C061714
        for <linux-kernel@vger.kernel.org>; Sat,  6 Nov 2021 12:27:36 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id i9so12916628ilu.8
        for <linux-kernel@vger.kernel.org>; Sat, 06 Nov 2021 12:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=g6dCQa8LHOVQsABsddtajlBRunqB4Uil1VxpOE1O+8o=;
        b=WQ0ToyOVPQKgfjBZCSwYr33XbhHdGzbxGU1+nJMORZhGLxFREBEmqbIYd+ED+nlxb6
         2veZSghDoUU7BUZvzuXbxh995TLYSql2kYGJqx+tHHsCRhuvvcgGnAaziIXXYOjiQVXZ
         AfLp6vv2WIjt1r/ulOUITH8ELwysH0qADzQHRiUyfk9rM/Eu0+JvgZJ0O9jIwPx5Irh4
         JbVz882LaSloBhoytyDuMAA6xTAWNET3Oo40hzDHtdpyGsiXlR2A1Vyidn9J7YbbaRFF
         jzFqW2ZrGzJE4GmUk6rnJXYihA5NjB1WPYz0dCI/ddQhcqMCpe3sDwmrRlbMjCkaKq1J
         0vAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=g6dCQa8LHOVQsABsddtajlBRunqB4Uil1VxpOE1O+8o=;
        b=hgi5wyrPrVbopt6QVhAFGFT2LhSC4GbzuFC09yRKKTRgNxExWGIsVPW6RZvO8MuBvr
         BZCyl6p/s3R7g7kb9PnaHaGr00srs0DkeCGvzRCcPhcX0byqZMWHCfxD0EEh/Z1GPLaC
         2/i2FrafbCTCpVz2H9VpdqlstDGN/QK2/9gbZUYHmU+bYhBA3JmKd6Zzc/ivzz0cA5p3
         bBlLHSvPeQ8moaW7yVJIzaQIi782/IpzLv4n04RHqRXcOKVKQaHCAUZzAiiTzJ6Hu7nZ
         P82lczUYvCbd6v8rQM29FPk6n+UcbNySe+XkUnRYGnaPN/l3NDk1KZkSuCMHfN3/MxD0
         q3Rw==
X-Gm-Message-State: AOAM5320xsp8JNOiBHH2rzOLQlSFCfMVvOPi4nJIb2gH+5ByMspmFEe1
        W/ZPE+k6z73bbucDMgGSvWopyA==
X-Google-Smtp-Source: ABdhPJwYAg9h7KdgsD0GqlyFP6YqfXCbbo9reZ4XcToNIbXicMp8ZQjys1oQD+6Jn5aMStdiUw6FQA==
X-Received: by 2002:a92:d411:: with SMTP id q17mr31461470ilm.116.1636226855303;
        Sat, 06 Nov 2021 12:27:35 -0700 (PDT)
Received: from [127.0.1.1] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id c12sm6560928ils.31.2021.11.06.12.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 12:27:34 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-block@vger.kernel.org, noreply@ellerman.id.au,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211106185549.1578444-1-geert@linux-m68k.org>
References: <20211106185549.1578444-1-geert@linux-m68k.org>
Subject: Re: [PATCH -next] ataflop: Add missing semicolon to return statement
Message-Id: <163622685463.267869.14813196810807657315.b4-ty@kernel.dk>
Date:   Sat, 06 Nov 2021 13:27:34 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Nov 2021 19:55:49 +0100, Geert Uytterhoeven wrote:
>     drivers/block/ataflop.c: In function ‘ataflop_probe’:
>     drivers/block/ataflop.c:2023:2: error: expected expression before ‘if’
>      2023 |  if (ataflop_alloc_disk(drive, type))
> 	  |  ^~
>     drivers/block/ataflop.c:2023:2: error: ‘return’ with a value, in function returning void [-Werror=return-type]
>     drivers/block/ataflop.c:2011:13: note: declared here
>      2011 | static void ataflop_probe(dev_t dev)
> 	  |             ^~~~~~~~~~~~~
> 
> [...]

Applied, thanks!

[1/1] ataflop: Add missing semicolon to return statement
      commit: 38987a872b313e72f7a64e91ec0b8084eaec0f10

Best regards,
-- 
Jens Axboe


