Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2598E44B90B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 23:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243582AbhKIWzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 17:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243533AbhKIWxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 17:53:16 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A66C0F26F1
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 14:23:03 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id z2-20020a9d71c2000000b0055c6a7d08b8so917331otj.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 14:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PgvfvNdwSI/3ph2NDnZGZVBMBhLt3hGukHq2mKYVk4E=;
        b=ezGw9H7bK2e/s/4uure9G6i0ebK2VdicuchuQBo0XrMhltr4yLF4uioTnD7PUtSme0
         OePrOFZy2xKznFmRa4kWryPPqSDr5KsA3FHmWvPnhzn9VGOr/5/sCVsV/b48g58sZG5Y
         LdGvmusJLsiDg78lbyLvDdTWzbI35WNVFVM4ialFj7jcKKOcZKQd308uyj0GomRNPo5u
         XqaD370mJ5NKpFFmzdUhTiqzyL3riw7Uo7hYGZjzRMdR4eaMbWfB9t/4m2hFHbzw1+WL
         ahXbPCs1rFJ3HXqJzf6XeOso0kdfvJyF4mVwiHwpKiKF9Kbxb7+LLq5Na8bZLQBd7KGi
         ENHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PgvfvNdwSI/3ph2NDnZGZVBMBhLt3hGukHq2mKYVk4E=;
        b=qHGmgwtbYEqvm7XhaEXyb4WTt9zXnLbIIRGHrkCDvryGUgOvVVaMW8saNarZdsLMbk
         9m43oKTInF5haPgvCq0CR6+yGeJrr2Xd2JNqx7piC8+JEDMXnxhQ5pvt8LKTeWKxoooV
         BR5lbVcFtDMEm9UEDup3wUjj2AvwI8bsZqHXCZ9B8NWwTx4Rs9KUqCNXT3jKFK4f/Sbb
         tGSV2JNeK6wXl5+R8fdt452tms1P/UAqPDLwv3bhbIJB19fn6g/IQXa1u1nU3MemfB7K
         gQpOh94KREyTEq4fqR44F1yL3UJOsmfjTdceVU3hPvhdEW1Xps+H5jrJL5NRARDAkt3k
         sukA==
X-Gm-Message-State: AOAM533rsHR/ek/UK/b9zvVGIan81AS/wDLsdjca8Ga6u6sy9ZTV/h6r
        7l3jY3w2hu918GDuCLmoycjm1MePcPjOExn34wDXzg==
X-Google-Smtp-Source: ABdhPJzm3G0CFDoatPM1xAySmN9ryiR6N5sit39Y1Pb5dB8zXLzT9ztTe9fQor4ppdDUgnGjTWOFVjbFNCkeAX5UGds=
X-Received: by 2002:a9d:ed6:: with SMTP id 80mr8697308otj.35.1636496583272;
 Tue, 09 Nov 2021 14:23:03 -0800 (PST)
MIME-Version: 1.0
References: <20211109164650.2233507-1-robh@kernel.org>
In-Reply-To: <20211109164650.2233507-1-robh@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 9 Nov 2021 23:22:51 +0100
Message-ID: <CACRpkdYuX5zfJrywx0kWWJJk2A963kzzVGvFrGJciUuGjh7XGw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Fix Arm Ltd board node name collisions
To:     Rob Herring <robh@kernel.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Sudeep Holla <Sudeep.Holla@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Guenter Roeck <linux@roeck-us.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 9, 2021 at 5:46 PM Rob Herring <robh@kernel.org> wrote:

> This does break DT ABI compatibility which is partially mitigated if
> these changes are backported to stable. The alternative is reverting the
> referenced DT changes and coming up with different node names without
> unit-addresses. Ultimately, ABI issues are platform maintainers'
> decision, not mine.

I don't mind breaking the ABI for these boards since everyone I
know rebuild the DT with the kernel and boot. I don't know if
other users flash it though, so check what Sudeep says.

Yours,
Linus Walleij
