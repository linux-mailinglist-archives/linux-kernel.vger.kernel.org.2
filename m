Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40F054364CF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 16:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbhJUO5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 10:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbhJUO5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 10:57:18 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35CCC061348
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 07:55:02 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id t4so1179542oie.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 07:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=xaeLphVFaU9zgdd3pdvOfGpM7qBlrk6tW8cVYaP7+pA=;
        b=cK1RKNXM5ZFhZbyAqtWDQCBhey58RKamun2XeooJN3Yb0UrSNWxbZTEf+xA6CUn8qx
         pV4OAzcg5hp9fUh8uwt28w2zm5gjFQfHT2hzDz7XP8E8xNkKBgTlyGT6g7SRr/n7n3gC
         fCpW9ivKhSzdtVLBMxwAKSwIBN9iNGClUYol2P0Ko30SCr44P44rMnsZpKGzO61VY1yR
         E4ELhp/EiNmyJNtr5ovA/Qh8Ph47nq9AWWUPbq9EjLZDSyvhQXrbDjEWQWpjFVsjHVFV
         IDn/1amFY8bqtEUlFM5EUzXLat/IFqqteY4Olc7jHFvGxFVeWvS8du3Ne1Pd98LPiDmZ
         JebQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=xaeLphVFaU9zgdd3pdvOfGpM7qBlrk6tW8cVYaP7+pA=;
        b=ZNOEAidFYkkFHMLCC6I0mzVeIraIlNAOHPYEQU1iOi7vuVmnNOAXwke3tv9sDsbneM
         6dp0L4eb87Qd6EAqPeGDJtA/tBMeiYfOVKBrMhx0KvutE/kHsFUVQBR2/ZsKoSwd/d0Y
         F9Vd6YYNQaNxBP5WwRZZO9ZW1xs2zvUIPIQz6e0BotRFyQ9+goiquP3ZtMRIv87Btpaz
         yCT4YeAPICdL0HgiWUlBpdC1yAxigcmfzhLccHYahz17Ctx9YXJ6E+ck89HT2X0RR4Io
         KAjjKV7ITCjJpFLvtINZW0XgOYea7axynt21gS2YcMKTcthfIPcwU2OtPHdfSjRNSeTk
         jpXQ==
X-Gm-Message-State: AOAM533zP3SiwgR0szQXty2W0xQmI/7ekOLNJ2a1r/9DMpJOHt0LBMRQ
        xPBFBEjKLGof4tzOgf3Zdg8Y3g==
X-Google-Smtp-Source: ABdhPJwJEehkhY3iqZBKNcYo99B/U9lJfjG0S+9vWNyL4/YR7KNY3jU1LFWlySYYQhLJa2i3u6BZRg==
X-Received: by 2002:aca:6c2:: with SMTP id 185mr4773346oig.31.1634828102368;
        Thu, 21 Oct 2021 07:55:02 -0700 (PDT)
Received: from [127.0.1.1] ([2600:380:783a:c43c:af64:c142:4db7:63ac])
        by smtp.gmail.com with ESMTPSA id 38sm1076833oti.13.2021.10.21.07.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 07:55:02 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     justin@coraid.com, cgel.zte@gmail.com
Cc:     Zeal Robot <zealci@zte.com.cn>, linux-kernel@vger.kernel.org,
        Ye Guojin <ye.guojin@zte.com.cn>, linux-block@vger.kernel.org
In-Reply-To: <20211021064931.1047687-1-ye.guojin@zte.com.cn>
References: <20211021064931.1047687-1-ye.guojin@zte.com.cn>
Subject: Re: [PATCH] block: aoe: fixup coccinelle warnings
Message-Id: <163482810153.48889.3111143939235558208.b4-ty@kernel.dk>
Date:   Thu, 21 Oct 2021 08:55:01 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Oct 2021 06:49:31 +0000, cgel.zte@gmail.com wrote:
> From: Ye Guojin <ye.guojin@zte.com.cn>
> 
> coccicheck complains about the use of snprintf() in sysfs show
> functions:
> WARNING  use scnprintf or sprintf
> 
> Use sysfs_emit instead of scnprintf or sprintf makes more sense.
> 
> [...]

Applied, thanks!

[1/1] block: aoe: fixup coccinelle warnings
      commit: ff06ed7e815ccd3f80cfd4d5dd30687bc722e871

Best regards,
-- 
Jens Axboe


