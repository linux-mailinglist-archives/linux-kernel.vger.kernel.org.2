Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE1B44BA41
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 03:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhKJCWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 21:22:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbhKJCWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 21:22:50 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334F9C061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 18:20:04 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id e144so1061537iof.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 18:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=EiumqE+Ob9nsD9TYsj1dDHr7J2bIG9X/FfUb/ar7UDE=;
        b=jspmo3wRnpx6hbPV7ChuoOQHhcKCxLk8deJA01bg2zNwZ/x/M9zSUktS1mUSi2qjfn
         5iKm76sYxys/g/AfBdSaemBAjfzzgmIToWGYFNugmXA/XhPLQ0HQ702AtZHWH4PN0GiD
         c72eFmY4I4lNhaEL1LDAt2yQhAPDVlfnOJ2y7WRnUKxaUhXyJ48PDMByx573GezMrDws
         k3Il5YoBWyhpzDAlwUoolnJYArT26R8qB0XzLkSgXkeiZY8OFyzTkR1Iz2SQp2WXkL1n
         p8BnAcKlXPzuwzkrPIQMU9vC7iauUSfNioWovilZdgmUNWyFMyicP1pbE4XaKEI87nKk
         K7VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=EiumqE+Ob9nsD9TYsj1dDHr7J2bIG9X/FfUb/ar7UDE=;
        b=J5/jkfX9bLyQGFmVQSFqN7LY+biADC5bTOkfAMO6/IIBktJBeJOLLvahA79MG3epA0
         awqgJV/kVCiaodNZN2rF/mT+rwyu9Pqo4rD+qf7QNUkmW/9uMcSeI8uMUvqrS9UfkXX2
         XuslQ1GnZJxaHrgwGYVxgQ93xJfP6eWwrUMbaxcpJz39DSwIpQQLeL9+6Hj7/U0/xS+S
         w0yW2Qvg+S3xxvE5SMlqcSi26c3Y0t+cv/7x30iricGGoe/PRAPLXi+vyiB60ZeH1nJ5
         /QKeLsjCETUv0etGL3MGJhWpG0XFnH29k8LmFL4B6wug48+FYpah2DhVX83QFTX973NW
         Xr6w==
X-Gm-Message-State: AOAM531OgGUO5J4uYJXabxDbfCF2UWN24pjjI1taQqaJLcx9eIZ8/R9p
        UW4BpFRvmhs1bAPLrSTl/I3Qww==
X-Google-Smtp-Source: ABdhPJxCYdPwkwFrjv8kpwwmEdgGB+jihMacG3QvY0FHXqEbpAKwrDkSQdkGJJ3Rd/BM9OgkpTVKXA==
X-Received: by 2002:a05:6602:2d43:: with SMTP id d3mr8332758iow.6.1636510803494;
        Tue, 09 Nov 2021 18:20:03 -0800 (PST)
Received: from [127.0.1.1] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id g7sm12663643ild.87.2021.11.09.18.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 18:20:03 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     hch@infradead.org, jack@suse.cz, tj@kernel.org, hare@suse.de,
        Luis Chamberlain <mcgrof@kernel.org>, ming.lei@redhat.com
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
In-Reply-To: <20211110002949.999380-1-mcgrof@kernel.org>
References: <20211110002949.999380-1-mcgrof@kernel.org>
Subject: Re: [PATCH] block: add __must_check for *add_disk*() callers
Message-Id: <163651080191.12234.4824381787720799712.b4-ty@kernel.dk>
Date:   Tue, 09 Nov 2021 19:20:01 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Nov 2021 16:29:49 -0800, Luis Chamberlain wrote:
> Now that we have done a spring cleaning on all drivers and added
> error checking / handling, let's keep it that way and ensure
> no new drivers fail to stick with it.
> 
> 

Applied, thanks!

[1/1] block: add __must_check for *add_disk*() callers
      commit: 278167fd2f8ffe679351605fe03e29ff3ab8db18

Best regards,
-- 
Jens Axboe


